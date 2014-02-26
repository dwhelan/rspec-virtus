module RSpec
  module Virtus
    class Matcher
      def initialize(attribute_name, type)
        @attribute_name = attribute_name
        @options = { type: type }
        @type = type
      end

      def matches?(instance)
        @subject = instance.class
        attribute_exists? && type_correct?
      end

      def description
        "have attribute #{@attribute_name}#{@options[:type] ? ", #{@options[:type]}" : ""}"
      end

      def failure_message
        "should #{description}"
      end

      def negative_failure_message
        "should not #{description}"
      end

      private

      attr_reader :type

      def attribute
        @subject.attribute_set[@attribute_name]
      end

      def member_type
        attribute.member_type.primitive
      end

      def attribute_type
        attribute.primitive
      end

      def attribute_exists?
        attribute != nil
      end

      def type_correct?
        if type.is_a?(Array)
          attribute_type == Array && member_type == type[0]
        elsif type
          attribute_type == type
        else
          true
        end
      end
    end
  end
end
