module RSpec
  module Virtus
    class Matcher
      def initialize(attribute_name)
        @attribute_name = attribute_name
        @options = {}
      end

      def of_type(type, options={})
        @options[:type] = type
        @options[:member_type] = options.delete(:member_type)
        self
      end

      def matches?(instance)
        @subject = instance.class
        attribute_exists? && type_correct?
      end

      def failure_message
        "expected #{@attribute_name} to be defined"
      end

      def negative_failure_message
        "expected #{@attribute_name} not to be defined"
      end

      private

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
        if @options[:member_type]
          attribute_type == @options[:type] && member_type == @options[:member_type]
        elsif @options[:type]
          attribute_type == @options[:type]
        else
          true
        end
      end
    end
  end
end
