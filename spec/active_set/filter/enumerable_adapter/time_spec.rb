# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ActiveSet::Processor::Filter::EnumerableAdapter do
  include_context 'for enumerable sets'

  let(:adapter) { described_class.new(enumerable_set, instructions) }
  let(:instructions) { ActiveSet::Instructions.new(keypath => value) }

  describe '#process with Time type attribute value' do
    subject { adapter.process }

    context 'is a base attribute' do
      before(:each) do
        foo.time = 1.day.from_now.to_time
        bar.time = 1.day.ago.to_time
      end

      context 'with default == operator' do
        let(:keypath) { [:time] }

        context 'and the value matches' do
          let(:value) { foo.time }

          it { expect(subject.map(&:id)).to eq [foo.id] }
        end

        context 'and the value does not matches' do
          let(:value) { Date.new }

          it { expect(subject.map(&:id)).to eq [] }
        end
      end

      context 'with default > operator' do
        let(:keypath) { ['time(>)'] }

        context 'and the value matches' do
          context 'the lesser' do
            let(:value) { foo.time }

            it { expect(subject.map(&:id)).to eq [] }
          end

          context 'the greater' do
            let(:value) { bar.time }

            it { expect(subject.map(&:id)).to eq [foo.id] }
          end
        end

        context 'and the value does not match any' do
          let(:value) { 1.year.from_now.to_time }

          it { expect(subject.map(&:id)).to eq [] }
        end

        context 'and the value matches all' do
          let(:value) { 1.year.ago.to_time }

          it { expect(subject.map(&:id)).to eq [foo.id, bar.id] }
        end
      end

      context 'with default < operator' do
        let(:keypath) { ['time(<)'] }

        context 'and the value matches' do
          context 'the lesser' do
            let(:value) { foo.time }

            it { expect(subject.map(&:id)).to eq [bar.id] }
          end

          context 'the greater' do
            let(:value) { bar.time }

            it { expect(subject.map(&:id)).to eq [] }
          end
        end

        context 'and the value does not match any' do
          let(:value) { 1.year.ago.to_time }

          it { expect(subject.map(&:id)).to eq [] }
        end

        context 'and the value matches all' do
          let(:value) { 1.year.from_now.to_time }

          it { expect(subject.map(&:id)).to eq [foo.id, bar.id] }
        end
      end

      context 'with default >= operator' do
        let(:keypath) { ['time(>=)'] }

        context 'and the value matches' do
          context 'the lesser' do
            let(:value) { foo.time }

            it { expect(subject.map(&:id)).to eq [foo.id] }
          end

          context 'the greater' do
            let(:value) { bar.time }

            it { expect(subject.map(&:id)).to eq [foo.id, bar.id] }
          end
        end

        context 'and the value does not match any' do
          let(:value) { 1.year.from_now.to_time }

          it { expect(subject.map(&:id)).to eq [] }
        end

        context 'and the value matches all' do
          let(:value) { 1.year.ago.to_time }

          it { expect(subject.map(&:id)).to eq [foo.id, bar.id] }
        end
      end

      context 'with default <= operator' do
        let(:keypath) { ['time(<=)'] }

        context 'and the value matches' do
          context 'the lesser' do
            let(:value) { foo.time }

            it { expect(subject.map(&:id)).to eq [foo.id, bar.id] }
          end

          context 'the greater' do
            let(:value) { bar.time }

            it { expect(subject.map(&:id)).to eq [bar.id] }
          end
        end

        context 'and the value does not match any' do
          let(:value) { 1.year.ago.to_time }

          it { expect(subject.map(&:id)).to eq [] }
        end

        context 'and the value matches all' do
          let(:value) { 1.year.from_now.to_time }

          it { expect(subject.map(&:id)).to eq [foo.id, bar.id] }
        end
      end
    end

    context 'on an associated object' do
      before(:each) do
        foo.assoc.time = 1.day.from_now.to_time
        bar.assoc.time = 1.day.ago.to_time
      end

      context 'with default == operator' do
        let(:keypath) { %w[assoc time] }

        context 'and the value matches' do
          let(:value) { foo.assoc.time }

          it { expect(subject.map(&:id)).to eq [foo.id] }
        end

        context 'and the value does not matches' do
          let(:value) { Date.new }

          it { expect(subject.map(&:id)).to eq [] }
        end
      end

      context 'with default > operator' do
        let(:keypath) { %w[assoc time(>)] }

        context 'and the value matches' do
          context 'the lesser' do
            let(:value) { foo.assoc.time }

            it { expect(subject.map(&:id)).to eq [] }
          end

          context 'the greater' do
            let(:value) { bar.assoc.time }

            it { expect(subject.map(&:id)).to eq [foo.id] }
          end
        end

        context 'and the value does not match any' do
          let(:value) { 1.year.from_now.to_time }

          it { expect(subject.map(&:id)).to eq [] }
        end

        context 'and the value matches all' do
          let(:value) { 1.year.ago.to_time }

          it { expect(subject.map(&:id)).to eq [foo.id, bar.id] }
        end
      end

      context 'with default < operator' do
        let(:keypath) { %w[assoc time(<)] }

        context 'and the value matches' do
          context 'the lesser' do
            let(:value) { foo.assoc.time }

            it { expect(subject.map(&:id)).to eq [bar.id] }
          end

          context 'the greater' do
            let(:value) { bar.assoc.time }

            it { expect(subject.map(&:id)).to eq [] }
          end
        end

        context 'and the value does not match any' do
          let(:value) { 1.year.ago.to_time }

          it { expect(subject.map(&:id)).to eq [] }
        end

        context 'and the value matches all' do
          let(:value) { 1.year.from_now.to_time }

          it { expect(subject.map(&:id)).to eq [foo.id, bar.id] }
        end
      end

      context 'with default >= operator' do
        let(:keypath) { %w[assoc time(>=)] }

        context 'and the value matches' do
          context 'the lesser' do
            let(:value) { foo.assoc.time }

            it { expect(subject.map(&:id)).to eq [foo.id] }
          end

          context 'the greater' do
            let(:value) { bar.assoc.time }

            it { expect(subject.map(&:id)).to eq [foo.id, bar.id] }
          end
        end

        context 'and the value does not match any' do
          let(:value) { 1.year.from_now.to_time }

          it { expect(subject.map(&:id)).to eq [] }
        end

        context 'and the value matches all' do
          let(:value) { 1.year.ago.to_time }

          it { expect(subject.map(&:id)).to eq [foo.id, bar.id] }
        end
      end

      context 'with default <= operator' do
        let(:keypath) { %w[assoc time(<=)] }

        context 'and the value matches' do
          context 'the lesser' do
            let(:value) { foo.assoc.time }

            it { expect(subject.map(&:id)).to eq [foo.id, bar.id] }
          end

          context 'the greater' do
            let(:value) { bar.assoc.time }

            it { expect(subject.map(&:id)).to eq [bar.id] }
          end
        end

        context 'and the value does not match any' do
          let(:value) { 1.year.ago.to_time }

          it { expect(subject.map(&:id)).to eq [] }
        end

        context 'and the value matches all' do
          let(:value) { 1.year.from_now.to_time }

          it { expect(subject.map(&:id)).to eq [foo.id, bar.id] }
        end
      end
    end
  end
end
