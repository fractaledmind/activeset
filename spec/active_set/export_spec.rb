# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ActiveSet do
  before(:all) do
    @foo_1 = FactoryBot.create(:foo, assoc: FactoryBot.create(:assoc))
    @foo_2 = FactoryBot.create(:foo, assoc: FactoryBot.create(:assoc))
    @foo_3 = FactoryBot.create(:foo, assoc: FactoryBot.create(:assoc))
  end
  after(:all) { Foo.delete_all }

  describe '#export' do
    context 'with ActiveRecord collection' do
      before(:all) { @active_set = ActiveSet.new(Foo.all) }
      let(:result) { @active_set.export(instructions) }

      context "{ format: :csv, columns: [{}] }" do
        let(:instructions) do
          { format: :csv,
            columns: [
              {  }
            ] }
        end
        let(:expected_csv) do
          ::CSV.generate do |output|
            output << ['']
            @active_set.each do |_|
              output << %w[—]
            end
          end
        end

        it { expect(result).to eq expected_csv }
      end

      context "{ format: :csv, columns: [{}, {}] }" do
        let(:instructions) do
          { format: :csv,
            columns: [
              {  },
              {  }
            ] }
        end
        let(:expected_csv) do
          ::CSV.generate do |output|
            output << ['', '']
            @active_set.each do |_|
              output << %w[— —]
            end
          end
        end

        it { expect(result).to eq expected_csv }
      end

      context "{ format: :csv, columns: [{key: 'ID'}] }" do
        let(:instructions) do
          { format: :csv,
            columns: [
              { key: 'ID' }
            ] }
        end
        let(:expected_csv) do
          ::CSV.generate do |output|
            output << %w[ID]
            @active_set.each do |_|
              output << %w[—]
            end
          end
        end

        it { expect(result).to eq expected_csv }
      end

      context "{ format: :csv, columns: [{key: 'ID'}, {key: 'Assoc'}] }" do
        let(:instructions) do
          { format: :csv,
            columns: [
              { key: 'ID' },
              { key: 'Assoc' }
            ] }
        end
        let(:expected_csv) do
          ::CSV.generate do |output|
            output << %w[ID Assoc]
            @active_set.each do |_|
              output << %w[— —]
            end
          end
        end

        it { expect(result).to eq expected_csv }
      end

      context "{ format: :csv, columns: [{value: 'id'}] }" do
        let(:instructions) do
          { format: :csv,
            columns: [
              { value: 'id' }
            ] }
        end
        let(:expected_csv) do
          ::CSV.generate do |output|
            output << %w[Id]
            @active_set.each do |item|
              output << [item.id]
            end
          end
        end

        it { expect(result).to eq expected_csv }
      end

      context "{ format: :csv, columns: [{value: 'id'}, {value: 'assoc.string'}] }" do
        let(:instructions) do
          { format: :csv,
            columns: [
              { value: 'id' },
              { value: 'assoc.string' }
            ] }
        end
        let(:expected_csv) do
          ::CSV.generate do |output|
            output << ['Id', 'String']
            @active_set.each do |item|
              output << [item.id, item.assoc.string]
            end
          end
        end

        it { expect(result).to eq expected_csv }
      end

      context "{ format: :csv, columns: [{key: 'ID', value: 'id'}] }" do
        let(:instructions) do
          { format: :csv,
            columns: [
              { key: 'ID',
                value: 'id' }
            ] }
        end
        let(:expected_csv) do
          ::CSV.generate do |output|
            output << %w[ID]
            @active_set.each do |item|
              output << [item.id]
            end
          end
        end

        it { expect(result).to eq expected_csv }
      end

      context "{ format: :csv, columns: [{key: 'ID', value: 'id'}, {key: 'Assoc', value: 'assoc.string'}] }" do
        let(:instructions) do
          { format: :csv,
            columns: [
              { key: 'ID',
                value: 'id' },
              { key: 'Assoc',
                value: 'assoc.string' }
            ] }
        end
        let(:expected_csv) do
          ::CSV.generate do |output|
            output << %w[ID Assoc]
            @active_set.each do |item|
              output << [item.id, item.assoc.string]
            end
          end
        end

        it { expect(result).to eq expected_csv }
      end

      context "{ format: :csv, columns: [{key: 'ID', value: ->(item) { item.id * 2 }}] }" do
        let(:instructions) do
          { format: :csv,
            columns: [
              { key: 'ID',
                value: ->(item) { item.id * 2 } }
            ] }
        end
        let(:expected_csv) do
          ::CSV.generate do |output|
            output << %w[ID]
            @active_set.each do |item|
              output << [(item.id * 2)]
            end
          end
        end

        it { expect(result).to eq expected_csv }
      end

      context "{ format: :csv, columns: [{key: 'ID', value: ->(item) { item.id * 2 }}, {key: 'Assoc', value: ->(item) { item.assoc.string.upcase }}] }" do
        let(:instructions) do
          { format: :csv,
            columns: [
              { key: 'ID',
                value: ->(item) { item.id * 2 } },
              { key: 'Assoc',
                value: ->(item) { item.assoc.string.upcase } }
            ] }
        end
        let(:expected_csv) do
          ::CSV.generate do |output|
            output << %w[ID Assoc]
            @active_set.each do |item|
              output << [(item.id * 2), item.assoc.string.upcase]
            end
          end
        end

        it { expect(result).to eq expected_csv }
      end
    end

    context 'with Enumerable collection' do
    end
  end
end
