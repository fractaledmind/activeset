# frozen_string_literal: true

require 'spec_helper'
require 'ostruct'

RSpec.describe ActiveSet::SortProcessor do
  let(:processor) { described_class.new(set, sort_structure) }

  context 'when set is simple Enumerable' do
    let(:foo) { OpenStruct.new(key: 'foo', association: OpenStruct.new(key: 'oof')) }
    let(:bar) { OpenStruct.new(key: 'bar', association: OpenStruct.new(key: 'rab')) }
    let(:baz) { OpenStruct.new(key: 'baz', association: OpenStruct.new(key: 'zab')) }
    let(:set) { [foo, bar, baz] }

    describe '#process' do
      subject { processor.process }

      context 'with attributes on the base resource' do
        context 'when direction is ASC' do
          let(:sort_structure) { { key: :asc } }

          it { should eq [bar, baz, foo] }
        end

        context 'when direction is DESC' do
          let(:sort_structure) { { key: 'desc' } }

          it { should eq [foo, baz, bar] }
        end
      end

      context 'with attributes on an associated resource' do
        context 'when direction is ASC' do
          let(:sort_structure) { { association: { key: 'asc' } } }

          it { should eq [foo, bar, baz] }
        end

        context 'when direction is DESC' do
          let(:sort_structure) { { association: { key: :desc } } }

          it { should eq [baz, bar, foo] }
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
        context 'when direction is ASC' do
          let(:sort_structure) { { ship_by: :asc } }
          let(:expected_result) { Widget.order(ship_by: :asc) }

          it { expect(subject.map(&:id)).to eq expected_result.map(&:id) }
        end

        context 'when direction is DESC' do
          let(:sort_structure) { { ship_by: 'desc' } }
          let(:expected_result) { Widget.order(ship_by: 'desc') }

          it { expect(subject.map(&:id)).to eq expected_result.map(&:id) }
        end
      end

      context 'with attributes on an associated resource' do
        context 'when direction is ASC' do
          let(:sort_structure) { { customer: { name: 'asc' } } }
          let(:expected_result) { Widget.joins(:customer).merge(Customer.order(name: 'asc')) }

          it { expect(subject.map(&:id)).to eq expected_result.map(&:id) }
        end

        context 'when direction is DESC' do
          let(:sort_structure) { { customer: { name: :desc } } }
          let(:expected_result) { Widget.joins(:customer).merge(Customer.order(name: :desc)) }

          it { expect(subject.map(&:id)).to eq expected_result.map(&:id) }
        end
      end
    end
  end
end
