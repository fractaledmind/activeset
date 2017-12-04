# frozen_string_literal: true

syntaxes = {
  'attribute': 'value',
  'attribute*': 'predicate',
  'attribute(operator)': 'value',
  'association.attribute': 'value',
  'association.attribute*': 'predicate',
  'association.attribute(operator)': 'value',
  'associations[enumerator]': 'value',
  'associations[enumerator]*': 'predicate',
  'associations[enumerator](operator)': 'value',
  'associations[enumerator].attribute': 'value',
  'associations[enumerator].attribute*': 'predicate',
  'associations[enumerator].attribute(operator)': 'value'
}

signal      = 'STRING'
operator    = 'LPAREN signal RPAREN'
enumerator  = 'LBRACKET signal RBRACKET'
accessor    = 'signal (CONNECTOR signal)*'
comparitor  = 'accessor (operator | PREDICATOR)*'
expression  = 'accessor enumerator* comparitor*'

class Token
  attr_reader :type, :value

  def initialize(type, value)
    @type = type
    @value = value
  end
end

class Lexer
  include Enumerable

  def initialize(input)
    @input = input.to_s
    @position = 0
    @current_char = @input[@position]
  end

  def each
    return enum_for(:each) unless block_given?

    until @current_char.nil?
      case @current_char
      when '.'
        yield connector
      when '*'
        yield predicator
      when '('
        yield lparen
      when ')'
        yield rparen
      when '['
        yield lbracket
      when ']'
        yield rbracket
      else
        yield string
      end
    end
  end

  private

  def advance
    @position += 1
    @current_char = if (@position + 1) > @input.size
                      nil
                    else
                      @input[@position]
                    end
  end

  def string
    result = ''

    until %w[( ) [ ] . *].include?(@current_char) || @current_char.nil?
      result += @current_char
      advance
    end

    Token.new(:STRING, result)
  end

  def predicator
    advance
    Token.new(:PREDICATOR, '*')
  end

  def connector
    advance
    Token.new(:CONNECTOR, '.')
  end

  def lparen
    advance
    Token.new(:LPAREN, '(')
  end

  def lbracket
    advance
    Token.new(:LBRACKET, '[')
  end

  def rparen
    advance
    Token.new(:RPAREN, ')')
  end

  def rbracket
    advance
    Token.new(:RBRACKET, ']')
  end
end

class Operand
  def initialize(operand)
    @operand = operand
  end

  def visit
    @operand
  end

  class Object < Operand
  end

  class Signal < Operand
  end

  class Enumerable < Operand
  end

  class Executable
    attr_accessor :args

    def initialize(operand, *args)
      @operand = operand
      @args = args
    end

    def visit
      @operand.call(*@args)
    end
  end
end

module Operation
  class Access
    def initialize(object_operand, signal_operand)
      @object_operand = object_operand
      @signal_operand = signal_operand
    end

    def visit
      object.public_send(signal)
    end

    private

    def object
      @object_operand.visit
    end

    def signal
      @signal_operand.visit
    end
  end

  class Compare
    def initialize(left_object_operand, operator_signal_operand, right_object_operand)
      @left_object_operand = left_object_operand
      @operator_signal_operand = operator_signal_operand
      @right_object_operand = right_object_operand
    end

    def visit
      left.public_send(operator, right)
    end

    private

    def left
      @left_object_operand.visit
    end

    def right
      @right_object_operand.visit
    end

    def operator
      @operator_signal_operand.visit
    end
  end

  class Enumerate
    def initialize(enumerable_object_operand, signal_operand, executable_operand)
      @enumerable_object_operand = enumerable_object_operand
      @signal_operand = signal_operand
      @executable_operand = executable_operand
    end

    def visit
      enumerable.public_send(signal) { |i| executable(i) }
    end

    private

    def enumerable
      @enumerable_object_operand.visit
    end

    def signal
      @signal_operand.visit
    end

    def executable(item)
      @executable_operand.args = item
      @executable_operand.visit
    end
  end
end

class Parser
  def initialize(lexer)
    @stream = lexer.each
    @current_token = @stream.next
  end

  def parse
    signal
  end

  private

  def eat(token_type)
    fail unless @current_token.type == token_type

    begin
      @current_token = @stream.next
    rescue StopIteration
    end
  end

  # expression : accessor enumerator* comparitor*
  def expression
  end

  # accessor : signal (CONNECTOR accessor)*
  def accessor
    node = signal
    while @current_token.type == :CONNECTOR
      eat(:CONNECTOR)
      node = Operation::Access.new(node, accessor)
    end
    node
  end

  # enumerator : LBRACKET signal RBRACKET
  def enumerator
  end

  # comparitor : accessor (operator | PREDICATOR)*
  def comparitor
    node = accessor
  end

  # operator : LPAREN signal RPAREN
  def operator
    eat(:LPAREN)
    node = signal
    eat(:RPAREN)
    node
  end

  # signal : STRING
  def signal
    token = @current_token
    eat(:STRING)
    Operand::Signal.new(token.value)
  end

  def connector
  end
end

class Interpreter
end

Lexer.new('attribute').tokens
# => [Signal('attribute')]

Lexer.new('attribute*').tokens
# => [Signal('attribute'), Asterisk('*')]

Lexer.new('attribute(operator)').tokens
# => [Signal('attribute'), LParen('('), Signal('operator'), RParen(')')]

Lexer.new('association.attribute(operator)').tokens
# => [Signal('association'), Dot('.'), Signal('attribute'), LParen('('), Signal('operator'), RParen(')')]

Lexer.new('association.associations[iterator]').tokens
# => [Signal('association'), Dot('.'), Signal('associations'), LBracket('['), Signal('iterator'), RBracket(']')]

Lexer.new('association.associations[iterator](operator)').tokens
# => [Signal('association'), Dot('.'), Signal('associations'), LBracket('['), Signal('iterator'), RBracket(']'), LParen('('), Signal('operator'), RParen(')')]

Lexer.new('association.associations[iterator].attribute').tokens
# => [Signal('association'), Dot('.'), Signal('associations'), LBracket('['), Signal('iterator'), RBracket(']'), Dot('.'), Signal('attribute')]

Lexer.new('association.associations[iterator].attribute(operator)').tokens
# => [Signal('association'), Dot('.'), Signal('associations'), LBracket('['), Signal('iterator'), RBracket(']'), Dot('.'), Signal('attribute'), LParen('('), Signal('operator'), RParen(')')]

class Letter < OpenStruct
end

letters = ('a'..'z').to_a.map.with_index { |l, i| Letter.new(string: l, integer: i) }
letters.each do |letter|
  paired_letter = letters[25 - letter.integer]
  next_letter_integer = letter.integer + 1
  next_letter = next_letter_integer <= 25 ? letters[next_letter_integer] : letters[next_letter_integer - 26]
  prev_letter_integer = letter.integer - 1
  prev_letter = prev_letter_integer >= 0 ? letters[prev_letter_integer] : letters[prev_letter_integer + 26]
  shared_letters = [
    next_letter,
    prev_letter
  ]

  letter.to_one = paired_letter
  letter.to_many = shared_letters
end
