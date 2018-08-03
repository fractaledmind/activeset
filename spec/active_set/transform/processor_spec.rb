# frozen_string_literal: true

require 'spec_helper'
require 'ostruct'

RSpec.describe ActiveSet::Processor::Transform do
  let(:foo) { OpenStruct.new(key: 'foo', association: OpenStruct.new(key: 'oof')) }
  let(:bar) { OpenStruct.new(key: 'bar', association: OpenStruct.new(key: 'rab')) }
  let(:baz) { OpenStruct.new(key: 'baz', association: OpenStruct.new(key: 'zab')) }
  let(:set) { [foo, bar, baz] }

  let(:processor) { described_class.new(set, instructions) }

  describe '#process' do
    subject { processor.process }

    let(:instructions) do
      {
        format: format,
        columns: columns
      }
    end

    context 'when exporting to CSV' do
      let(:format) { 'csv' }

      context 'when value is nil' do
        context 'when key present' do
          context 'when one column' do
            let(:columns) do
              [
                { key: 'Name' }
              ]
            end

            let(:expected_csv) do
              ::CSV.generate do |output|
                output << %w[Name]
                set.each do |_|
                  output << %w[—]
                end
              end
            end

            it { should eq expected_csv }
          end

          context 'when multiple columns' do
            let(:columns) do
              [
                { key: 'Name' },
                { key: 'Assoc' }
              ]
            end

            let(:expected_csv) do
              ::CSV.generate do |output|
                output << %w[Name Assoc]
                set.each do |_|
                  output << %w[— —]
                end
              end
            end

            it { should eq expected_csv }
          end
        end

        context 'when key is not present' do
          context 'when one column' do
            let(:columns) do
              [
                {}
              ]
            end

            let(:expected_csv) do
              ::CSV.generate do |output|
                output << ['']
                set.each do |_|
                  output << %w[—]
                end
              end
            end

            it { should eq expected_csv }
          end

          context 'when multiple columns' do
            let(:columns) do
              [
                {},
                {}
              ]
            end

            let(:expected_csv) do
              ::CSV.generate do |output|
                output << ['', '']
                set.each do |_|
                  output << %w[— —]
                end
              end
            end

            it { should eq expected_csv }
          end
        end
      end

      context 'when value is keypath' do
        context 'when key present' do
          context 'when one column' do
            let(:columns) do
              [
                { key: 'Name',
                  value: 'key' }
              ]
            end

            let(:expected_csv) do
              ::CSV.generate do |output|
                output << %w[Name]
                set.each do |item|
                  output << [item.key]
                end
              end
            end

            it { should eq expected_csv }
          end

          context 'when multiple columns' do
            let(:columns) do
              [
                { key: 'Name',
                  value: 'key' },
                { key: 'Assoc',
                  value: 'association.key' }
              ]
            end

            let(:expected_csv) do
              ::CSV.generate do |output|
                output << %w[Name Assoc]
                set.each do |item|
                  output << [item.key, item.association.key]
                end
              end
            end

            it { should eq expected_csv }
          end
        end

        context 'when key is not present' do
          context 'when one column' do
            let(:columns) do
              [
                { value: 'key' }
              ]
            end

            let(:expected_csv) do
              ::CSV.generate do |output|
                output << %w[Key]
                set.each do |item|
                  output << [item.key]
                end
              end
            end

            it { should eq expected_csv }
          end

          context 'when multiple columns' do
            let(:columns) do
              [
                { value: 'key' },
                { value: 'association.key' }
              ]
            end

            let(:expected_csv) do
              ::CSV.generate do |output|
                output << ['Key', 'Association Key']
                set.each do |item|
                  output << [item.key, item.association.key]
                end
              end
            end

            it { should eq expected_csv }
          end
        end
      end

      context 'when value is Proc' do
        context 'when key present' do
          context 'when one column' do
            let(:columns) do
              [
                { key: 'Name',
                  value: ->(item) { item.key.reverse } }
              ]
            end

            let(:expected_csv) do
              ::CSV.generate do |output|
                output << %w[Name]
                set.each do |item|
                  output << [item.key.reverse]
                end
              end
            end

            it { should eq expected_csv }
          end

          context 'when multiple columns' do
            let(:columns) do
              [
                { key: 'Name',
                  value: ->(item) { item.key.reverse } },
                { key: 'Assoc',
                  value: ->(item) { item.association.key.upcase } }
              ]
            end

            let(:expected_csv) do
              ::CSV.generate do |output|
                output << %w[Name Assoc]
                set.each do |item|
                  output << [item.key.reverse, item.association.key.upcase]
                end
              end
            end

            it { should eq expected_csv }
          end
        end

        # DON'T DO THIS.
        # THIS WILL RESULT IN ABSURD COLUMN NAMES.
        # IF VALUE IF PROC, SUPPLY THE KEY
        # context 'when key is not present' do
        # end
      end
    end
  end
end
