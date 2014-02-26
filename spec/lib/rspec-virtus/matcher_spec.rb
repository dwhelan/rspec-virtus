require 'spec_helper'
require 'virtus'

describe RSpec::Virtus::Matcher do
  let(:instance) { described_class.new(attribute_name, type) }
  let(:type) { nil }
  let(:attribute_name) { :the_attribute }

  class DummyVirtus
    include Virtus.model

    attribute :the_attribute, String
    attribute :the_array_attribute, Array[String]
  end

  describe '#matches?' do
    subject { instance.matches?(actual) }
    let(:actual) { DummyVirtus.new }

    context 'successful match on attribute name' do
      it 'returns true' do
        expect(subject).to eql(true)
      end
    end

    context 'successful match on attribute name and type' do
      let(:type) { String }

      it 'returns true' do
        expect(subject).to eql(true)
      end
    end

    context 'successful match on attribute name, type and member_type' do
      let(:attribute_name) { :the_array_attribute }
      let(:type) { Array[String] }

      it 'returns true' do
        expect(subject).to eql(true)
      end
    end

    context 'unsuccessful match on attribute name' do
      let(:attribute_name) { :something_else }

      it 'returns false' do
        expect(subject).to eql(false)
      end
    end

    context 'unsuccessful match on attribute name and type' do
      let(:attribute_name) { :something_else }
      let(:type) { Integer }

      it 'returns false' do
        expect(subject).to eql(false)
      end
    end

    context 'unsuccessful match on attribute name, type and member_type' do
      let(:attribute_name) { :the_array_attribute }
      let(:type) { Array[Integer] }

      it 'returns false' do
        expect(subject).to eql(false)
      end
    end
  end

  describe '#failure_message' do
    subject { instance.negative_failure_message }

    it 'tells you which attribute failed' do
      expect(subject).to include(attribute_name.to_s)
    end
  end

  describe '#negative_failure_message' do
    subject { instance.negative_failure_message }

    it 'tells you which attribute failed' do
      expect(subject).to include(attribute_name.to_s)
    end
  end
end
