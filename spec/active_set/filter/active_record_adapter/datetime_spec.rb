# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ActiveSet::FilterProcessor::ActiveRecordAdapter do
  include_context 'for active record sets'

  let(:adapter) { described_class.new(instruction) }
  let(:instruction) { ActiveSet::Instructions::Entry.new(keypath, value) }

  describe '#process with :datetime type attribute value' do
    subject { adapter.process(active_record_set) }

    context 'on the base object' do
      before(:each) do
        foo.tap { |foo| foo.datetime = 1.day.from_now.to_datetime }.tap(&:save)
        bar.tap { |bar| bar.datetime = 1.day.ago.to_datetime }.tap(&:save)
      end

      context 'with default == operator' do
        let(:keypath) { [:datetime] }

        context 'and the value matches' do
          let(:value) { foo.datetime }

          it { expect(subject.map(&:id)).to eq [foo.id] }
        end

        context 'and the value does not matches' do
          let(:value) { Date.new }

          it { expect(subject.map(&:id)).to eq [] }
        end
      end

      context 'with default > operator' do
        let(:keypath) { ['datetime(>)'] }

        context 'and the value matches' do
          context 'the lesser' do
            let(:value) { foo.datetime }

            it { expect(subject.map(&:id)).to eq [] }
          end

          context 'the greater' do
            let(:value) { bar.datetime }

            it { expect(subject.map(&:id)).to eq [foo.id] }
          end
        end

        context 'and the value does not match any' do
          let(:value) { 1.year.from_now.to_datetime }

          it { expect(subject.map(&:id)).to eq [] }
        end

        context 'and the value matches all' do
          let(:value) { 1.year.ago.to_datetime }

          it { expect(subject.map(&:id)).to eq [foo.id, bar.id] }
        end
      end

      context 'with default < operator' do
        let(:keypath) { ['datetime(<)'] }

        context 'and the value matches' do
          context 'the lesser' do
            let(:value) { foo.datetime }

            it { expect(subject.map(&:id)).to eq [bar.id] }
          end

          context 'the greater' do
            let(:value) { bar.datetime }

            it { expect(subject.map(&:id)).to eq [] }
          end
        end

        context 'and the value does not match any' do
          let(:value) { 1.year.ago.to_datetime }

          it { expect(subject.map(&:id)).to eq [] }
        end

        context 'and the value matches all' do
          let(:value) { 1.year.from_now.to_datetime }

          it { expect(subject.map(&:id)).to eq [foo.id, bar.id] }
        end
      end

      context 'with default >= operator' do
        let(:keypath) { ['datetime(>=)'] }

        context 'and the value matches' do
          context 'the lesser' do
            let(:value) { foo.datetime }

            it { expect(subject.map(&:id)).to eq [foo.id] }
          end

          context 'the greater' do
            let(:value) { bar.datetime }

            it { expect(subject.map(&:id)).to eq [foo.id, bar.id] }
          end
        end

        context 'and the value does not match any' do
          let(:value) { 1.year.from_now.to_datetime }

          it { expect(subject.map(&:id)).to eq [] }
        end

        context 'and the value matches all' do
          let(:value) { 1.year.ago.to_datetime }

          it { expect(subject.map(&:id)).to eq [foo.id, bar.id] }
        end
      end

      context 'with default <= operator' do
        let(:keypath) { ['datetime(<=)'] }

        context 'and the value matches' do
          context 'the lesser' do
            let(:value) { foo.datetime }

            it { expect(subject.map(&:id)).to eq [foo.id, bar.id] }
          end

          context 'the greater' do
            let(:value) { bar.datetime }

            it { expect(subject.map(&:id)).to eq [bar.id] }
          end
        end

        context 'and the value does not match any' do
          let(:value) { 1.year.ago.to_datetime }

          it { expect(subject.map(&:id)).to eq [] }
        end

        context 'and the value matches all' do
          let(:value) { 1.year.from_now.to_datetime }

          it { expect(subject.map(&:id)).to eq [foo.id, bar.id] }
        end
      end
    end

    context 'on an associated object' do
      before(:each) do
        foo.assoc.tap { |foo_assoc| foo_assoc.datetime = 1.day.from_now.to_datetime }.tap(&:save)
        bar.assoc.tap { |bar_assoc| bar_assoc.datetime = 1.day.ago.to_datetime }.tap(&:save)
      end

      context 'with default == operator' do
        let(:keypath) { %w[assoc datetime] }

        context 'and the value matches' do
          let(:value) { foo.assoc.datetime }

          it { expect(subject.map(&:id)).to eq [foo.id] }
        end

        context 'and the value does not matches' do
          let(:value) { Date.new }

          it { expect(subject.map(&:id)).to eq [] }
        end
      end

      context 'with default > operator' do
        let(:keypath) { %w[assoc datetime(>)] }

        context 'and the value matches' do
          context 'the lesser' do
            let(:value) { foo.assoc.datetime }

            it { expect(subject.map(&:id)).to eq [] }
          end

          context 'the greater' do
            let(:value) { bar.assoc.datetime }

            it { expect(subject.map(&:id)).to eq [foo.id] }
          end
        end

        context 'and the value does not match any' do
          let(:value) { 1.year.from_now.to_datetime }

          it { expect(subject.map(&:id)).to eq [] }
        end

        context 'and the value matches all' do
          let(:value) { 1.year.ago.to_datetime }

          it { expect(subject.map(&:id)).to eq [foo.id, bar.id] }
        end
      end

      context 'with default < operator' do
        let(:keypath) { %w[assoc datetime(<)] }

        context 'and the value matches' do
          context 'the lesser' do
            let(:value) { foo.assoc.datetime }

            it { expect(subject.map(&:id)).to eq [bar.id] }
          end

          context 'the greater' do
            let(:value) { bar.assoc.datetime }

            it { expect(subject.map(&:id)).to eq [] }
          end
        end

        context 'and the value does not match any' do
          let(:value) { 1.year.ago.to_datetime }

          it { expect(subject.map(&:id)).to eq [] }
        end

        context 'and the value matches all' do
          let(:value) { 1.year.from_now.to_datetime }

          it { expect(subject.map(&:id)).to eq [foo.id, bar.id] }
        end
      end

      context 'with default >= operator' do
        let(:keypath) { %w[assoc datetime(>=)] }

        context 'and the value matches' do
          context 'the lesser' do
            let(:value) { foo.assoc.datetime }

            it { expect(subject.map(&:id)).to eq [foo.id] }
          end

          context 'the greater' do
            let(:value) { bar.assoc.datetime }

            it { expect(subject.map(&:id)).to eq [foo.id, bar.id] }
          end
        end

        context 'and the value does not match any' do
          let(:value) { 1.year.from_now.to_datetime }

          it { expect(subject.map(&:id)).to eq [] }
        end

        context 'and the value matches all' do
          let(:value) { 1.year.ago.to_datetime }

          it { expect(subject.map(&:id)).to eq [foo.id, bar.id] }
        end
      end

      context 'with default <= operator' do
        let(:keypath) { %w[assoc datetime(<=)] }

        context 'and the value matches' do
          context 'the lesser' do
            let(:value) { foo.assoc.datetime }

            it { expect(subject.map(&:id)).to eq [foo.id, bar.id] }
          end

          context 'the greater' do
            let(:value) { bar.assoc.datetime }

            it { expect(subject.map(&:id)).to eq [bar.id] }
          end
        end

        context 'and the value does not match any' do
          let(:value) { 1.year.ago.to_datetime }

          it { expect(subject.map(&:id)).to eq [] }
        end

        context 'and the value matches all' do
          let(:value) { 1.year.from_now.to_datetime }

          it { expect(subject.map(&:id)).to eq [foo.id, bar.id] }
        end
      end
    end
  end
end
