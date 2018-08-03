# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ActiveSet::Processor::Filter::ActiveRecordAdapter do
  include_context 'for active record sets'

  let(:adapter) { described_class.new(active_record_set, instruction) }
  let(:instruction) { ActiveSet::Instructions::Entry.new(keypath, value) }

  describe '#process with :integer type attribute value' do
    subject { adapter.process[:set] }

    context 'on the base object' do
      before(:each) do
        foo.tap { |foo| foo.integer = 1 }.tap(&:save)
        bar.tap { |bar| bar.integer = 2 }.tap(&:save)
      end

      context 'with default == operator' do
        let(:keypath) { [:integer] }

        context 'and the value matches' do
          let(:value) { foo.integer }

          it { expect(subject.map(&:id)).to eq [foo.id] }
        end

        context 'and the value does not matches' do
          let(:value) { -1 }

          it { expect(subject.map(&:id)).to eq [] }
        end
      end

      context 'with default > operator' do
        let(:keypath) { ['integer(>)'] }

        context 'and the value matches' do
          context 'the lesser' do
            let(:value) { foo.integer }

            it { expect(subject.map(&:id)).to eq [bar.id] }
          end

          context 'the greater' do
            let(:value) { bar.integer }

            it { expect(subject.map(&:id)).to eq [] }
          end
        end

        context 'and the value does not match any' do
          let(:value) { 100 }

          it { expect(subject.map(&:id)).to eq [] }
        end

        context 'and the value matches all' do
          let(:value) { -1 }

          it { expect(subject.map(&:id)).to eq [foo.id, bar.id] }
        end
      end

      context 'with default < operator' do
        let(:keypath) { ['integer(<)'] }

        context 'and the value matches' do
          context 'the lesser' do
            let(:value) { foo.integer }

            it { expect(subject.map(&:id)).to eq [] }
          end

          context 'the greater' do
            let(:value) { bar.integer }

            it { expect(subject.map(&:id)).to eq [foo.id] }
          end
        end

        context 'and the value does not match any' do
          let(:value) { -1 }

          it { expect(subject.map(&:id)).to eq [] }
        end

        context 'and the value matches all' do
          let(:value) { 100 }

          it { expect(subject.map(&:id)).to eq [foo.id, bar.id] }
        end
      end

      context 'with default >= operator' do
        let(:keypath) { ['integer(>=)'] }

        context 'and the value matches' do
          context 'the lesser' do
            let(:value) { foo.integer }

            it { expect(subject.map(&:id)).to eq [foo.id, bar.id] }
          end

          context 'the greater' do
            let(:value) { bar.integer }

            it { expect(subject.map(&:id)).to eq [bar.id] }
          end
        end

        context 'and the value does not match any' do
          let(:value) { 100 }

          it { expect(subject.map(&:id)).to eq [] }
        end

        context 'and the value matches all' do
          let(:value) { -1 }

          it { expect(subject.map(&:id)).to eq [foo.id, bar.id] }
        end
      end

      context 'with default <= operator' do
        let(:keypath) { ['integer(<=)'] }

        context 'and the value matches' do
          context 'the lesser' do
            let(:value) { foo.integer }

            it { expect(subject.map(&:id)).to eq [foo.id] }
          end

          context 'the greater' do
            let(:value) { bar.integer }

            it { expect(subject.map(&:id)).to eq [foo.id, bar.id] }
          end
        end

        context 'and the value does not match any' do
          let(:value) { -1 }

          it { expect(subject.map(&:id)).to eq [] }
        end

        context 'and the value matches all' do
          let(:value) { 100 }

          it { expect(subject.map(&:id)).to eq [foo.id, bar.id] }
        end
      end
    end

    context 'on an associated object' do
      before(:each) do
        foo.assoc.tap { |foo_assoc| foo_assoc.integer = 1 }.tap(&:save)
        bar.assoc.tap { |bar_assoc| bar_assoc.integer = 2 }.tap(&:save)
      end

      context 'with default == operator' do
        let(:keypath) { %w[assoc integer] }

        context 'and the value matches' do
          let(:value) { foo.assoc.integer }

          it { expect(subject.map(&:id)).to eq [foo.id] }
        end

        context 'and the value does not matches' do
          let(:value) { -1 }

          it { expect(subject.map(&:id)).to eq [] }
        end
      end

      context 'with default > operator' do
        let(:keypath) { %w[assoc integer(>)] }

        context 'and the value matches' do
          context 'the lesser' do
            let(:value) { foo.assoc.integer }

            it { expect(subject.map(&:id)).to eq [bar.id] }
          end

          context 'the greater' do
            let(:value) { bar.assoc.integer }

            it { expect(subject.map(&:id)).to eq [] }
          end
        end

        context 'and the value does not match any' do
          let(:value) { 100 }

          it { expect(subject.map(&:id)).to eq [] }
        end

        context 'and the value matches all' do
          let(:value) { -1 }

          it { expect(subject.map(&:id)).to eq [foo.id, bar.id] }
        end
      end

      context 'with default < operator' do
        let(:keypath) { %w[assoc integer(<)] }

        context 'and the value matches' do
          context 'the lesser' do
            let(:value) { foo.assoc.integer }

            it { expect(subject.map(&:id)).to eq [] }
          end

          context 'the greater' do
            let(:value) { bar.assoc.integer }

            it { expect(subject.map(&:id)).to eq [foo.id] }
          end
        end

        context 'and the value does not match any' do
          let(:value) { -1 }

          it { expect(subject.map(&:id)).to eq [] }
        end

        context 'and the value matches all' do
          let(:value) { 100 }

          it { expect(subject.map(&:id)).to eq [foo.id, bar.id] }
        end
      end

      context 'with default >= operator' do
        let(:keypath) { %w[assoc integer(>=)] }

        context 'and the value matches' do
          context 'the lesser' do
            let(:value) { foo.assoc.integer }

            it { expect(subject.map(&:id)).to eq [foo.id, bar.id] }
          end

          context 'the greater' do
            let(:value) { bar.assoc.integer }

            it { expect(subject.map(&:id)).to eq [bar.id] }
          end
        end

        context 'and the value does not match any' do
          let(:value) { 100 }

          it { expect(subject.map(&:id)).to eq [] }
        end

        context 'and the value matches all' do
          let(:value) { -1 }

          it { expect(subject.map(&:id)).to eq [foo.id, bar.id] }
        end
      end

      context 'with default <= operator' do
        let(:keypath) { %w[assoc integer(<=)] }

        context 'and the value matches' do
          context 'the lesser' do
            let(:value) { foo.assoc.integer }

            it { expect(subject.map(&:id)).to eq [foo.id] }
          end

          context 'the greater' do
            let(:value) { bar.assoc.integer }

            it { expect(subject.map(&:id)).to eq [foo.id, bar.id] }
          end
        end

        context 'and the value does not match any' do
          let(:value) { -1 }

          it { expect(subject.map(&:id)).to eq [] }
        end

        context 'and the value matches all' do
          let(:value) { 100 }

          it { expect(subject.map(&:id)).to eq [foo.id, bar.id] }
        end
      end
    end
  end
end
