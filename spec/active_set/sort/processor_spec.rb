# frozen_string_literal: true

require 'spec_helper'
require 'ostruct'

RSpec.describe ActiveSet::Processor::Sort do
  let(:processor) { described_class.new(set, filter_structure) }

  context 'when set is Enumerable' do
    let(:set) do
      [
        OpenStruct.new(s: 'a', i: 1),
        OpenStruct.new(s: 'a', i: 2),
        OpenStruct.new(s: 'z', i: 1),
        OpenStruct.new(s: 'z', i: 2)
      ]
    end

    describe '#process' do
      subject { processor.process }
      let(:hashed_result) { subject.map(&:to_h) }

      context 'with a single column query' do
        context 'string field ASC' do
          let(:filter_structure) do
            { s: :asc }
          end

          it { expect(hashed_result)
                 .to eq [{s: 'a', i: 1}, {s: 'a', i: 2}, {s: 'z', i: 1}, {s: 'z', i: 2}] }
        end

        context 'string field DESC' do
          let(:filter_structure) do
            { s: :desc }
          end

          it { expect(hashed_result)
                 .to eq [{s: 'z', i: 1}, {s: 'z', i: 2}, {s: 'a', i: 1}, {s: 'a', i: 2}] }
        end

        context 'integer field ASC' do
          let(:filter_structure) do
            { i: :asc }
          end

          it { expect(hashed_result)
                 .to eq [{s: 'a', i: 1}, {s: 'z', i: 1},  {s: 'a', i: 2}, {s: 'z', i: 2}] }
        end

        context 'integer field DESC' do
          let(:filter_structure) do
            { i: :desc }
          end

          it { expect(hashed_result)
                 .to eq [{s: 'a', i: 2}, {s: 'z', i: 2}, {s: 'a', i: 1}, {s: 'z', i: 1}] }
        end
      end

      context 'with a multi-column query' do
        context 'string field ASC and integer field ASC' do
          let(:filter_structure) do
            { s: :asc, i: :asc }
          end

          it { expect(hashed_result)
                 .to eq [{s: 'a', i: 1}, {s: 'a', i: 2}, {s: 'z', i: 1}, {s: 'z', i: 2}] }
        end

        context 'string field ASC and integer field DESC' do
          let(:filter_structure) do
            { s: :asc, i: :desc }
          end

          it { expect(hashed_result)
                 .to eq [{s: 'a', i: 2}, {s: 'a', i: 1}, {s: 'z', i: 2}, {s: 'z', i: 1}] }
        end

        context 'string field DESC and integer field ASC' do
          let(:filter_structure) do
            { s: :desc, i: :asc }
          end

          it { expect(hashed_result)
                 .to eq [{s: 'z', i: 1}, {s: 'z', i: 2}, {s: 'a', i: 1}, {s: 'a', i: 2}] }
        end

        context 'string field DESC and integer field DESC' do
          let(:filter_structure) do
            { s: :desc, i: :desc }
          end

          it { expect(hashed_result)
                 .to eq [{s: 'z', i: 2}, {s: 'z', i: 1}, {s: 'a', i: 2}, {s: 'a', i: 1}] }
        end
      end

      context 'when case-sensitivity matters' do
        let(:set) do
          [
            OpenStruct.new(s: 'a', i: 1),
            OpenStruct.new(s: 'A', i: 2),
            OpenStruct.new(s: 'z', i: 1),
            OpenStruct.new(s: 'Z', i: 2)
          ]
        end

        context 'with a multi-column query CASE-SENSITIVE' do
          context 'string field ASC and integer field ASC' do
            let(:filter_structure) do
              { s: :asc, i: :asc }
            end

            it { expect(hashed_result)
                   .to eq [{s: 'A', i: 2}, {s: 'Z', i: 2}, {s: 'a', i: 1}, {s: 'z', i: 1}] }
          end

          context 'string field ASC and integer field DESC' do
            let(:filter_structure) do
              { s: :asc, i: :desc }
            end

            it { expect(hashed_result)
                   .to eq [{s: 'A', i: 2}, {s: 'Z', i: 2}, {s: 'a', i: 1}, {s: 'z', i: 1}] }
          end

          context 'string field DESC and integer field ASC' do
            let(:filter_structure) do
              { s: :desc, i: :asc }
            end

            it { expect(hashed_result)
                   .to eq [{s: 'z', i: 1}, {s: 'a', i: 1}, {s: 'Z', i: 2}, {s: 'A', i: 2}] }
          end

          context 'string field DESC and integer field DESC' do
            let(:filter_structure) do
              { s: :desc, i: :desc }
            end

            it { expect(hashed_result)
                   .to eq [{s: 'z', i: 1}, {s: 'a', i: 1}, {s: 'Z', i: 2}, {s: 'A', i: 2}] }
          end
        end

        context 'with a multi-column query CASE-INSENSITIVE' do
          context 'string field ASC and integer field ASC' do
            let(:filter_structure) do
              { 's(i)': :asc, i: :asc }
            end

            it { expect(hashed_result)
                   .to eq [{s: 'a', i: 1}, {s: 'A', i: 2}, {s: 'z', i: 1}, {s: 'Z', i: 2}] }
          end

          context 'string field ASC and integer field DESC' do
            let(:filter_structure) do
              { 's(i)': :asc, i: :desc }
            end

            it { expect(hashed_result)
                   .to eq [{s: 'A', i: 2}, {s: 'a', i: 1}, {s: 'Z', i: 2}, {s: 'z', i: 1}] }
          end

          context 'string field DESC and integer field ASC' do
            let(:filter_structure) do
              { 's(i)': :desc, i: :asc }
            end

            it { expect(hashed_result)
                   .to eq [{s: 'z', i: 1}, {s: 'Z', i: 2}, {s: 'a', i: 1}, {s: 'A', i: 2}] }
          end

          context 'string field DESC and integer field DESC' do
            let(:filter_structure) do
              { 's(i)': :desc, i: :desc }
            end

            it { expect(hashed_result)
                   .to eq [{s: 'Z', i: 2}, {s: 'z', i: 1}, {s: 'A', i: 2}, {s: 'a', i: 1}] }
          end
        end
      end
    end
  end

  context 'when set is ActiveRecord::Relation' do
    include_context 'for active record sets'

    before(:each) do
      foo.tap { |foo| foo.string = 'aaa' }.tap(&:save)
      bar.tap { |bar| bar.string = 'ZZZ' }.tap(&:save)
      foo.assoc.tap { |foo_assoc| foo_assoc.string = 'aaa' }.tap(&:save)
      bar.assoc.tap { |bar_assoc| bar_assoc.string = 'ZZZ' }.tap(&:save)
    end

    let(:set) { active_record_set }

    describe '#process' do
      subject { processor.process }

      context 'with a complex query' do
        context 'both ASC and both case-sensitive' do
          let(:filter_structure) do
            {
              string: :asc,
              assoc: {
                string: :asc
              }
            }
          end

          it { expect(subject.map(&:id)).to eq [bar.id, foo.id] }
        end

        context 'both ASC and both case-insensitive' do
          let(:filter_structure) do
            {
              'string(i)': :asc,
              assoc: {
                'string(i)': :asc
              }
            }
          end

          it { expect(subject.map(&:id)).to eq [foo.id, bar.id] }
        end

        context 'one ASC and one DESC and both case-sensitive' do
          let(:filter_structure) do
            {
              'string(i)': :asc,
              assoc: {
                'string(i)': :desc
              }
            }
          end

          it { expect(subject.map(&:id)).to eq [foo.id, bar.id] }
        end

        context 'one ASC and one DESC and both case-insensitive' do
          let(:filter_structure) do
            {
              'string(i)': :asc,
              assoc: {
                'string(i)': :desc
              }
            }
          end

          it { expect(subject.map(&:id)).to eq [foo.id, bar.id] }
        end
      end
    end
  end
end
