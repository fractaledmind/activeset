require_relative './attribute_instruction'

class ColumnInstruction
  def initialize(instructions_hash, item)
    @instructions_hash = instructions_hash.symbolize_keys
    @item = item
  end

  def key
    return @instructions_hash[:key] if @instructions_hash.key? :key
    titleized = attribute_instruction.keypath.map(&:titleize).join(' ')
    return titleized unless attribute_instruction.attribute
    attribute_resource = attribute_instruction.resource_for(item: @item)
    return titleized unless attribute_resource
    return titleized unless attribute_resource.class.respond_to?(:human_attribute_name)

    attribute_resource.class.human_attribute_name(attribute_instruction.attribute)
  end

  def value
    return default unless @instructions_hash.key?(:value)
    return @instructions_hash[:value].call(@item) if @instructions_hash[:value]&.respond_to? :call

    attribute_instruction.value_for(item: @item)
  end

  private

  def attribute_instruction
    AttributeInstruction.new(@instructions_hash[:value], nil)
  end

  def default
    return @instructions_hash[:default] if @instructions_hash.key? :default

    '—'
  end
end
