# frozen_string_literal: true

module Structure
  class Value
    attr_reader :raw

    def initialize(value)
      @raw = value
    end

    def cast(to:)
      adapters.map do |adapter|
        value = adapter.new(@raw, to).process
        return value unless value.nil?
      end.compact.first || @raw
    end

    private

    def adapters
      [ActiveModelAdapter, PlainRubyAdapter]
    end

    class PlainRubyAdapter
      def initialize(raw, target)
        @raw = raw
        @target = target
      end

      def process
        return @raw if @raw.is_a? @target
        possible_values.find { |v| v.is_a? @target }
      end

      private

      def possible_values
        possible_typecasters.map { |m| typecast(m) }
                            .compact
      end

      def possible_typecasters
        @possible_typecasters ||= String.instance_methods
                                        .map(&:to_s)
                                        .select { |m| m.starts_with? 'to_' }
                                        .reject { |m| %[to_v8].include? m }
      end

      def typecast(method_name)
        @raw.send(method_name)
      rescue
        nil
      end
    end

    class ActiveModelAdapter
      require 'active_model/type'

      def initialize(raw, target)
        @raw = raw
        @target = target
      end

      def process
        return @raw if @raw.is_a? @target
        # ActiveModel::Type::Boolean is too expansive in its casting; will get false positives
        return to_bool if @target.eql?(TrueClass) || @target.eql?(FalseClass)
        possible_values.find { |v| v.is_a? @target }
      end

      private

      def to_bool
        return @raw if @raw.is_a?(TrueClass) || @raw.is_a?(FalseClass)
        return true if %w[true yes 1 t].include? @raw.to_s.downcase
        return false if %w[false no 0 f].include? @raw.to_s.downcase
        @raw
      end

      def possible_values
        possible_typecasters.map { |m| typecast(m, @raw) }
      end

      def possible_typecasters
        @possible_typecasters ||= ActiveModel::Type.constants
                                                   .map(&:to_s)
                                                   .select { |t| can_typecast?(t) }
                                                   .map { |t| init_typecaster(t) }
                                                   .compact
      end

      def typecast(to_type, value)
        return to_type.type_cast(value) if to_type.respond_to? :type_cast
        to_type.cast(value)
      end

      def can_typecast?(const_name)
        typecasting_class = ActiveModel::Type.const_get(const_name)
        typecasting_class.instance_methods.include?(:cast) ||
          typecasting_class.instance_methods.include?(:type_cast)
      end

      def init_typecaster(const_name)
        ActiveModel::Type.const_get(const_name).new
      rescue
        nil
      end
    end
  end
end
