# frozen_string_literal: true

require 'spec_helper'
require 'ostruct'

RSpec.describe ActiveSet::Processor::Sort do
  let(:processor) { described_class.new(set, filter_structure) }

  context 'when set is Enumerable' do
    let(:set) do
      [
        OpenStruct.new(s: 'a', i: 1, r: OpenStruct.new(s: 'ra', i: 9)),
        OpenStruct.new(s: 'a', i: 2, r: OpenStruct.new(s: 'ra', i: 8)),
        OpenStruct.new(s: 'z', i: 1, r: OpenStruct.new(s: 'rz', i: 9)),
        OpenStruct.new(s: 'z', i: 2, r: OpenStruct.new(s: 'rz', i: 8)),
        OpenStruct.new(s: 'A', i: 1, r: OpenStruct.new(s: 'rA', i: 9)),
        OpenStruct.new(s: 'A', i: 2, r: OpenStruct.new(s: 'rA', i: 8)),
        OpenStruct.new(s: 'Z', i: 1, r: OpenStruct.new(s: 'rZ', i: 9)),
        OpenStruct.new(s: 'Z', i: 2, r: OpenStruct.new(s: 'rZ', i: 8))
      ]
    end

    describe '#process' do
      subject { processor.process }

      context 'on local attributes' do
        context 'with a single column query' do
          context 'string field ASC CASE-SENSITIVE' do
            let(:filter_structure) do
              { s: :asc }
            end

            it { expect(subject).to be_a Array }
            it { expect(subject.map { |x| [x.s] })
                   .to eq [['A'], ['A'], ['Z'], ['Z'], ['a'], ['a'], ['z'], ['z']] }
          end

          context 'string field DESC CASE-SENSITIVE' do
            let(:filter_structure) do
              { s: :desc }
            end

            it { expect(subject).to be_a Array }
            it { expect(subject.map { |x| [x.s] })
                   .to eq [['z'], ['z'], ['a'], ['a'], ['Z'], ['Z'], ['A'], ['A']] }
          end

          context 'string field ASC CASE-INSENSITIVE' do
            let(:filter_structure) do
              { 's(i)': :asc }
            end

            it { expect(subject).to be_a Array }
            it { expect(subject.map { |x| [x.s] })
                   .to eq [['a'], ['a'], ['A'], ['A'], ['Z'], ['Z'], ['z'], ['z']] }
          end

          context 'string field DESC CASE-INSENSITIVE' do
            let(:filter_structure) do
              { 's(i)': :desc }
            end

            it { expect(subject).to be_a Array }
            it { expect(subject.map { |x| [x.s] })
                   .to eq [['z'], ['z'], ['Z'], ['Z'], ['A'], ['a'], ['a'], ['A']] }
          end
        end

        context 'with a multi-column query' do
          context 'string field ASC CASE-SENSITIVE and integer field ASC' do
            let(:filter_structure) do
              { s: :asc, i: :asc }
            end

            it { expect(subject).to be_a Array }
            it { expect(subject.map { |x| [x.s, x.i] })
                   .to eq [['A', 1], ['A', 2], ['Z', 1], ['Z', 2], ['a', 1], ['a', 2], ['z', 1], ['z', 2]] }
          end

          context 'string field ASC CASE-SENSITIVE and integer field DESC' do
            let(:filter_structure) do
              { s: :asc, i: :desc }
            end

            it { expect(subject).to be_a Array }
            it { expect(subject.map { |x| [x.s, x.i] })
                   .to eq [['A', 2], ['A', 1], ['Z', 2], ['Z', 1], ['a', 2], ['a', 1], ['z', 2], ['z', 1]] }
          end

          context 'string field DESC CASE-INSENSITIVE and integer field ASC' do
            let(:filter_structure) do
              { 's(i)': :desc, i: :asc }
            end

            it { expect(subject).to be_a Array }
            it { expect(subject.map { |x| [x.s, x.i] })
                   .to eq [['Z', 1], ['z', 1], ['Z', 2], ['z', 2], ['A', 1], ['a', 1], ['A', 2], ['a', 2]] }
          end

          context 'string field DESC CASE-INSENSITIVE and integer field DESC' do
            let(:filter_structure) do
              { 's(i)': :desc, i: :desc }
            end

            it { expect(subject).to be_a Array }
            it { expect(subject.map { |x| [x.s, x.i] })
                   .to eq [['Z', 2], ['z', 2], ['Z', 1], ['z', 1], ['a', 2], ['A', 2], ['A', 1], ['a', 1]] }
          end
        end
      end

      context 'on association attributes' do
        context 'with a single column query' do
          context 'string field ASC CASE-SENSITIVE' do
            let(:filter_structure) do
              { 'r.s': :asc }
            end

            it { expect(subject).to be_a Array }
            it { expect(subject.map { |x| [x.r.s] })
                   .to eq [['rA'], ['rA'], ['rZ'], ['rZ'], ['ra'], ['ra'], ['rz'], ['rz']] }
          end

          context 'string field DESC CASE-SENSITIVE' do
            let(:filter_structure) do
              { 'r.s': :desc }
            end

            it { expect(subject).to be_a Array }
            it { expect(subject.map { |x| [x.r.s] })
                   .to eq [['rz'], ['rz'], ['ra'], ['ra'], ['rZ'], ['rZ'], ['rA'], ['rA']] }
          end

          context 'string field ASC CASE-INSENSITIVE' do
            let(:filter_structure) do
              { 'r.s(i)': :asc }
            end

            it { expect(subject).to be_a Array }
            it { expect(subject.map { |x| [x.r.s] })
                   .to eq [['ra'], ['ra'], ['rA'], ['rA'], ['rZ'], ['rZ'], ['rz'], ['rz']] }
          end

          context 'string field DESC CASE-INSENSITIVE' do
            let(:filter_structure) do
              { 'r.s(i)': :desc }
            end

            it { expect(subject).to be_a Array }
            it { expect(subject.map { |x| [x.r.s] })
                   .to eq [['rz'], ['rz'], ['rZ'], ['rZ'], ['rA'], ['ra'], ['ra'], ['rA']] }
          end
        end

        context 'with a multi-column query' do
          context 'string field ASC CASE-SENSITIVE and integer field ASC' do
            let(:filter_structure) do
              { 'r.s': :asc, 'r.i': :asc }
            end

            it { expect(subject).to be_a Array }
            it { expect(subject.map { |x| [x.r.s, x.r.i] })
                   .to eq [['rA', 8], ['rA', 9], ['rZ', 8], ['rZ', 9], ['ra', 8], ['ra', 9], ['rz', 8], ['rz', 9]] }
          end

          context 'string field ASC CASE-SENSITIVE and integer field DESC' do
            let(:filter_structure) do
              { 'r.s': :asc, 'r.i': :desc }
            end

            it { expect(subject).to be_a Array }
            it { expect(subject.map { |x| [x.r.s, x.r.i] })
                   .to eq [['rA', 9], ['rA', 8], ['rZ', 9], ['rZ', 8], ['ra', 9], ['ra', 8], ['rz', 9], ['rz', 8]] }
          end

          context 'string field DESC CASE-INSENSITIVE and integer field ASC' do
            let(:filter_structure) do
              { 'r.s(i)': :desc, 'r.i': :asc }
            end

            it { expect(subject).to be_a Array }
            it { expect(subject.map { |x| [x.r.s, x.r.i] })
                   .to eq [['rZ', 8], ['rz', 8], ['rZ', 9], ['rz', 9], ['ra', 8], ['rA', 8], ['rA', 9], ['ra', 9]] }
          end

          context 'string field DESC CASE-INSENSITIVE and integer field DESC' do
            let(:filter_structure) do
              { 'r.s(i)': :desc, 'r.i': :desc }
            end

            it { expect(subject).to be_a Array }
            it { expect(subject.map { |x| [x.r.s, x.r.i] })
                   .to eq [['rZ', 9], ['rz', 9], ['rZ', 8], ['rz', 8], ['rA', 9], ['ra', 9], ['rA', 8], ['ra', 8]] }
          end
        end
      end
    end
  end

  context 'when set is ActiveRecord::Relation' do
    # include_context 'for active record sets'

    before(:each) do
      FactoryGirl.create(:foo, string: 'a', integer: 1,
                         assoc: FactoryGirl.create(:assoc, string: 'ra', integer: 9))
      FactoryGirl.create(:foo, string: 'a', integer: 2,
                         assoc: FactoryGirl.create(:assoc, string: 'ra', integer: 8))
      FactoryGirl.create(:foo, string: 'z', integer: 1,
                         assoc: FactoryGirl.create(:assoc, string: 'rz', integer: 9))
      FactoryGirl.create(:foo, string: 'z', integer: 2,
                         assoc: FactoryGirl.create(:assoc, string: 'rz', integer: 8))
      FactoryGirl.create(:foo, string: 'A', integer: 1,
                         assoc: FactoryGirl.create(:assoc, string: 'rA', integer: 9))
      FactoryGirl.create(:foo, string: 'A', integer: 2,
                         assoc: FactoryGirl.create(:assoc, string: 'rA', integer: 8))
      FactoryGirl.create(:foo, string: 'Z', integer: 1,
                         assoc: FactoryGirl.create(:assoc, string: 'rZ', integer: 9))
      FactoryGirl.create(:foo, string: 'Z', integer: 2,
                         assoc: FactoryGirl.create(:assoc, string: 'rZ', integer: 8))
    end

    let(:set) { Foo.all }

    describe '#process' do
      subject { processor.process }

      context 'on local attributes' do
        context 'with a single column query' do
          context 'string field ASC CASE-SENSITIVE' do
            let(:filter_structure) do
              { string: :asc }
            end

            it { expect(subject).to be_a ActiveRecord::Relation }
            it { expect(subject.map { |x| [x.string] })
                   .to eq [['A'], ['A'], ['Z'], ['Z'], ['a'], ['a'], ['z'], ['z']] }
          end

          context 'string field DESC CASE-SENSITIVE' do
            let(:filter_structure) do
              { string: :desc }
            end

            it { expect(subject).to be_a ActiveRecord::Relation }
            it { expect(subject.map { |x| [x.string] })
                   .to eq [['z'], ['z'], ['a'], ['a'], ['Z'], ['Z'], ['A'], ['A']] }
          end

          context 'string field ASC CASE-INSENSITIVE' do
            let(:filter_structure) do
              { 'string(i)': :asc }
            end

            it { expect(subject).to be_a ActiveRecord::Relation }
            it { expect(subject.map { |x| [x.string] })
                   .to eq [['a'], ['a'], ['A'], ['A'], ['z'], ['z'], ['Z'], ['Z']] }
          end

          context 'string field DESC CASE-INSENSITIVE' do
            let(:filter_structure) do
              { 'string(i)': :desc }
            end

            it { expect(subject).to be_a ActiveRecord::Relation }
            it { expect(subject.map { |x| [x.string] })
                   .to eq [['z'], ['z'], ['Z'], ['Z'], ['a'], ['a'], ['A'], ['A']] }
          end
        end

        context 'with a multi-column query' do
          context 'string field ASC CASE-SENSITIVE and integer field ASC' do
            let(:filter_structure) do
              { string: :asc, integer: :asc }
            end

            it { expect(subject).to be_a ActiveRecord::Relation }
            it { expect(subject.map { |x| [x.string, x.integer] })
                   .to eq [['a', 1], ['z', 1], ['A', 1], ['Z', 1], ['a', 2], ['z', 2], ['A', 2], ['Z', 2]] }
          end

          context 'string field ASC CASE-SENSITIVE and integer field DESC' do
            let(:filter_structure) do
              { string: :asc, integer: :desc }
            end

            it { expect(subject).to be_a ActiveRecord::Relation }
            it { expect(subject.map { |x| [x.string, x.integer] })
                   .to eq [['a', 2], ['z', 2], ['A', 2], ['Z', 2], ['a', 1], ['z', 1], ['A', 1], ['Z', 1]] }
          end

          context 'string field DESC CASE-INSENSITIVE and integer field ASC' do
            let(:filter_structure) do
              { 'string(i)': :desc, integer: :asc }
            end

            it { expect(subject).to be_a ActiveRecord::Relation }
            it { expect(subject.map { |x| [x.string, x.integer] })
                   .to eq [['a', 1], ['z', 1], ['A', 1], ['Z', 1], ['a', 2], ['z', 2], ['A', 2], ['Z', 2]] }
          end

          context 'string field DESC CASE-INSENSITIVE and integer field DESC' do
            let(:filter_structure) do
              { 'string(i)': :desc, integer: :desc }
            end

            it { expect(subject).to be_a ActiveRecord::Relation }
            it { expect(subject.map { |x| [x.string, x.integer] })
                   .to eq [['a', 2], ['z', 2], ['A', 2], ['Z', 2], ['a', 1], ['z', 1], ['A', 1], ['Z', 1]] }
          end
        end
      end

      context 'on association attributes' do
        context 'with a single column query' do
          context 'string field ASC CASE-SENSITIVE' do
            let(:filter_structure) do
              { 'assoc.string': :asc }
            end

            it { expect(subject).to be_a ActiveRecord::Relation }
            it { expect(subject.map { |x| [x.assoc.string] })
                   .to eq [['rA'], ['rA'], ['rZ'], ['rZ'], ['ra'], ['ra'], ['rz'], ['rz']] }
          end

          context 'string field DESC CASE-SENSITIVE' do
            let(:filter_structure) do
              { 'assoc.string': :desc }
            end

            it { expect(subject).to be_a ActiveRecord::Relation }
            it { expect(subject.map { |x| [x.assoc.string] })
                   .to eq [['rz'], ['rz'], ['ra'], ['ra'], ['rZ'], ['rZ'], ['rA'], ['rA']] }
          end

          context 'string field ASC CASE-INSENSITIVE' do
            let(:filter_structure) do
              { 'assoc.string(i)': :asc }
            end

            it { expect(subject).to be_a ActiveRecord::Relation }
            it { expect(subject.map { |x| [x.assoc.string] })
                   .to eq [['ra'], ['ra'], ['rA'], ['rA'], ['rz'], ['rz'], ['rZ'], ['rZ']] }
          end

          context 'string field DESC CASE-INSENSITIVE' do
            let(:filter_structure) do
              { 'assoc.string(i)': :desc }
            end

            it { expect(subject).to be_a ActiveRecord::Relation }
            it { expect(subject.map { |x| [x.assoc.string] })
                   .to eq [['rz'], ['rz'], ['rZ'], ['rZ'], ['ra'], ['ra'], ['rA'], ['rA']] }
          end
        end

        context 'with a multi-column query' do
          context 'string field ASC CASE-SENSITIVE and integer field ASC' do
            let(:filter_structure) do
              { 'assoc.string': :asc, 'assoc.integer': :asc }
            end

            it { expect(subject).to be_a ActiveRecord::Relation }
            it { expect(subject.map { |x| [x.assoc.string, x.assoc.integer] })
                   .to eq [['ra', 8], ['rz', 8], ['rA', 8], ['rZ', 8], ['ra', 9], ['rz', 9], ['rA', 9], ['rZ', 9]] }
          end

          context 'string field ASC CASE-SENSITIVE and integer field DESC' do
            let(:filter_structure) do
              { 'assoc.string': :asc, 'assoc.integer': :desc }
            end

            it { expect(subject).to be_a ActiveRecord::Relation }
            it { expect(subject.map { |x| [x.assoc.string, x.assoc.integer] })
                   .to eq [['ra', 9], ['rz', 9], ['rA', 9], ['rZ', 9], ['ra', 8], ['rz', 8], ['rA', 8], ['rZ', 8]] }
          end

          context 'string field DESC CASE-INSENSITIVE and integer field ASC' do
            let(:filter_structure) do
              { 'assoc.string(i)': :desc, 'assoc.integer': :asc }
            end

            it { expect(subject).to be_a ActiveRecord::Relation }
            it { expect(subject.map { |x| [x.assoc.string, x.assoc.integer] })
                   .to eq [['ra', 8], ['rz', 8], ['rA', 8], ['rZ', 8], ['ra', 9], ['rz', 9], ['rA', 9], ['rZ', 9]] }
          end

          context 'string field DESC CASE-INSENSITIVE and integer field DESC' do
            let(:filter_structure) do
              { 'assoc.string(i)': :desc, 'assoc.integer': :desc }
            end

            it { expect(subject).to be_a ActiveRecord::Relation }
            it { expect(subject.map { |x| [x.assoc.string, x.assoc.integer] })
                   .to eq [['ra', 9], ['rz', 9], ['rA', 9], ['rZ', 9], ['ra', 8], ['rz', 8], ['rA', 8], ['rZ', 8]] }
          end
        end
      end
    end
  end
end
