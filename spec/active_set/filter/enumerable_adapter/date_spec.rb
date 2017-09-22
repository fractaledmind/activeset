# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ActiveSet::FilterProcessor::EnumerableAdapter do
  include_context 'for enumerable sets'

  let(:adapter) { described_class.new(enumerable_set, instruction) }
  let(:instruction) { ActiveSet::Instructions::Entry.new(keypath, value) }

  describe '#process with Date type attribute value' do
    subject { adapter.process[:set] }

    context 'on the base object' do
      before(:each) do
        foo.date = 1.day.from_now.to_date
        bar.date = 1.day.ago.to_date
      end

      context 'with default == operator' do
        let(:keypath) { [:date] }

        context 'and the value matches' do
          let(:value) { foo.date }

          it { expect(subject.map(&:id)).to eq [foo.id] }
        end

        context 'and the value does not matches' do
          let(:value) { Date.new }

          it { expect(subject.map(&:id)).to eq [] }
        end
      end

      context 'with default > operator' do
        let(:keypath) { ['date(>)'] }

        context 'and the value matches' do
          context 'the greater' do
            let(:value) { foo.date }

            it { expect(subject.map(&:id)).to eq [] }
          end

          context 'the lesser' do
            let(:value) { bar.date }

            it { expect(subject.map(&:id)).to eq [foo.id] }
          end
        end

        context 'and the value does not match any' do
          let(:value) { 1.year.from_now.to_date }

          it { expect(subject.map(&:id)).to eq [] }
        end

        context 'and the value matches all' do
          let(:value) { 1.year.ago.to_date }

          it { expect(subject.map(&:id)).to eq [foo.id, bar.id] }
        end
      end

      context 'with default < operator' do
        let(:keypath) { ['date(<)'] }

        context 'and the value matches' do
          context 'the greater' do
            let(:value) { foo.date }

            it { expect(subject.map(&:id)).to eq [bar.id] }
          end

          context 'the lesser' do
            let(:value) { bar.date }

            it { expect(subject.map(&:id)).to eq [] }
          end
        end

        context 'and the value does not match any' do
          let(:value) { 1.year.ago.to_date }

          it { expect(subject.map(&:id)).to eq [] }
        end

        context 'and the value matches all' do
          let(:value) { 1.year.from_now.to_date }

          it { expect(subject.map(&:id)).to eq [foo.id, bar.id] }
        end
      end

      context 'with default >= operator' do
        let(:keypath) { ['date(>=)'] }

        context 'and the value matches' do
          context 'the greater' do
            let(:value) { foo.date }

            it { expect(subject.map(&:id)).to eq [foo.id] }
          end

          context 'the lesser' do
            let(:value) { bar.date }

            it { expect(subject.map(&:id)).to eq [foo.id, bar.id] }
          end
        end

        context 'and the value does not match any' do
          let(:value) { 1.year.from_now.to_date }

          it { expect(subject.map(&:id)).to eq [] }
        end

        context 'and the value matches all' do
          let(:value) { 1.year.ago.to_date }

          it { expect(subject.map(&:id)).to eq [foo.id, bar.id] }
        end
      end

      context 'with default <= operator' do
        let(:keypath) { ['date(<=)'] }

        context 'and the value matches' do
          context 'the greater' do
            let(:value) { foo.date }

            it { expect(subject.map(&:id)).to eq [foo.id, bar.id] }
          end

          context 'the lesser' do
            let(:value) { bar.date }

            it { expect(subject.map(&:id)).to eq [bar.id] }
          end
        end

        context 'and the value does not match any' do
          let(:value) { 1.year.ago.to_date }

          it { expect(subject.map(&:id)).to eq [] }
        end

        context 'and the value matches all' do
          let(:value) { 1.year.from_now.to_date }

          it { expect(subject.map(&:id)).to eq [foo.id, bar.id] }
        end
      end
    end

    context 'on an associated object' do
      before(:each) do
        foo.assoc.date = 1.day.from_now.to_date
        bar.assoc.date = 1.day.ago.to_date
      end

      context 'with default == operator' do
        let(:keypath) { %w[assoc date] }

        context 'and the value matches' do
          let(:value) { foo.assoc.date }

          it { expect(subject.map(&:id)).to eq [foo.id] }
        end

        context 'and the value does not matches' do
          let(:value) { Date.new }

          it { expect(subject.map(&:id)).to eq [] }
        end
      end

      context 'with default > operator' do
        let(:keypath) { %w[assoc date(>)] }

        context 'and the value matches' do
          context 'the greater' do
            let(:value) { foo.assoc.date }

            it { expect(subject.map(&:id)).to eq [] }
          end

          context 'the lesser' do
            let(:value) { bar.assoc.date }

            it { expect(subject.map(&:id)).to eq [foo.id] }
          end
        end

        context 'and the value does not match any' do
          let(:value) { 1.year.from_now.to_date }

          it { expect(subject.map(&:id)).to eq [] }
        end

        context 'and the value matches all' do
          let(:value) { 1.year.ago.to_date }

          it { expect(subject.map(&:id)).to eq [foo.id, bar.id] }
        end
      end

      context 'with default < operator' do
        let(:keypath) { %w[assoc date(<)] }

        context 'and the value matches' do
          context 'the greater' do
            let(:value) { foo.assoc.date }

            it { expect(subject.map(&:id)).to eq [bar.id] }
          end

          context 'the lesser' do
            let(:value) { bar.assoc.date }

            it { expect(subject.map(&:id)).to eq [] }
          end
        end

        context 'and the value does not match any' do
          let(:value) { 1.year.ago.to_date }

          it { expect(subject.map(&:id)).to eq [] }
        end

        context 'and the value matches all' do
          let(:value) { 1.year.from_now.to_date }

          it { expect(subject.map(&:id)).to eq [foo.id, bar.id] }
        end
      end

      context 'with default >= operator' do
        let(:keypath) { %w[assoc date(>=)] }

        context 'and the value matches' do
          context 'the greater' do
            let(:value) { foo.assoc.date }

            it { expect(subject.map(&:id)).to eq [foo.id] }
          end

          context 'the lesser' do
            let(:value) { bar.assoc.date }

            it { expect(subject.map(&:id)).to eq [foo.id, bar.id] }
          end
        end

        context 'and the value does not match any' do
          let(:value) { 1.year.from_now.to_date }

          it { expect(subject.map(&:id)).to eq [] }
        end

        context 'and the value matches all' do
          let(:value) { 1.year.ago.to_date }

          it { expect(subject.map(&:id)).to eq [foo.id, bar.id] }
        end
      end

      context 'with default <= operator' do
        let(:keypath) { %w[assoc date(<=)] }

        context 'and the value matches' do
          context 'the greater' do
            let(:value) { foo.assoc.date }

            it { expect(subject.map(&:id)).to eq [foo.id, bar.id] }
          end

          context 'the lesser' do
            let(:value) { bar.assoc.date }

            it { expect(subject.map(&:id)).to eq [bar.id] }
          end
        end

        context 'and the value does not match any' do
          let(:value) { 1.year.ago.to_date }

          it { expect(subject.map(&:id)).to eq [] }
        end

        context 'and the value matches all' do
          let(:value) { 1.year.from_now.to_date }

          it { expect(subject.map(&:id)).to eq [foo.id, bar.id] }
        end
      end
    end
  end
end
