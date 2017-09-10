# frozen_string_literal: true

require 'spec_helper'
require 'ostruct'

RSpec.describe ActiveSet::FilterProcessor do
  let(:processor) { described_class.new(set, filter_structure) }

  context 'when set is simple Enumerable' do
    let(:foo) do
      OpenStruct.new(key: 'foo',
                     date_on: 1.day.from_now,
                     association: OpenStruct.new(key: 'oof'))
    end
    let(:bar) { OpenStruct.new(key: 'bar', association: OpenStruct.new(key: 'rab')) }
    let(:baz) { OpenStruct.new(key: 'baz', association: OpenStruct.new(key: 'zab')) }
    let(:set) { [foo, bar, baz] }

    describe '#process' do
      subject { processor.process }

      context 'with attributes on the base resource' do
        context 'when value matches' do
          let(:filter_structure) { { key: bar.key } }

          it { should eq [bar] }
        end

        context 'when value doesn\'t match' do
          let(:filter_structure) { { key: '___' } }

          it { should eq [] }
        end

        context 'with a typecast-able value' do
          let(:filter_structure) { { date_on: foo.date_on.to_date.to_s } }

          it { should eq [foo] }
        end
      end

      context 'with attributes on an associated resource' do
        context 'when value matches' do
          let(:filter_structure) { { association: { key: foo.association.key } } }

          it { should eq [foo] }
        end

        context 'when value doesn\'t match' do
          let(:filter_structure) { { association: { key: '___' } } }

          it { should eq [] }
        end

        context 'when path doesn\'t make sense' do
          let(:filter_structure) { { no: { sense: '___' } } }

          it { should eq [] }
        end
      end
    end
  end

  context 'when set is ActiveRecord::Relation' do
    before(:each) { FactoryGirl.create_list(:widget, 4) }
    let(:set) { Widget.all }

    describe '#process' do
      subject { processor.process }

      context 'with attributes on the base resource' do
        context 'when value matches' do
          let(:resource) { set.first }
          let(:filter_structure) { { color: resource.color } }
          let(:expected_result) { Widget.where(color: resource.color) }

          it { expect(subject.map(&:id)).to eq expected_result.map(&:id) }
        end

        context 'when value doesn\'t match' do
          let(:filter_structure) { { color: '___' } }

          it { should eq [] }
        end
      end

      context 'with attributes on an associated resource' do
        context 'when value matches' do
          let(:association) { set.last.customer }
          let(:filter_structure) { { customer: { name: association.name } } }
          let(:expected_result) { Widget.joins(:customer).where(customers: { name: association.name }) }

          it { expect(subject.map(&:id)).to eq expected_result.map(&:id) }
        end

        context 'when value doesn\'t match' do
          let(:filter_structure) { { customer: { name: '___' } } }

          it { should eq [] }
        end

        context 'when path doesn\'t make sense' do
          let(:filter_structure) { { no: { sense: '___' } } }

          it { should eq [] }
        end
      end
    end
  end
end
