# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ActiveSet::Processor::Filter::ActiveRecordAdapter do
  include_context 'for active record sets'

  let(:adapter) { described_class.new(active_record_set, instructions) }
  let(:instructions) { ActiveSet::Instructions.new(keypath => value) }

  describe '#process with :float type attribute value' do
    subject { adapter.process }

    context 'on the base object' do
      before(:each) do
        foo.tap { |foo| foo.float = 1.11 }.tap(&:save)
        bar.tap { |bar| bar.float = 2.22 }.tap(&:save)
      end

      context 'with default == operator' do
        let(:keypath) { [:float] }

        context 'and the value matches' do
          let(:value) { foo.float }

          it { expect(subject.map(&:id)).to eq [foo.id] }
        end

        context 'and the value does not matches' do
          let(:value) { -1.00 }

          it { expect(subject.map(&:id)).to eq [] }
        end
      end

      context 'with default > operator' do
        let(:keypath) { ['float(>)'] }

        context 'and the value matches' do
          context 'the lesser' do
            let(:value) { foo.float }

            it { expect(subject.map(&:id)).to eq [bar.id] }
          end

          context 'the greater' do
            let(:value) { bar.float }

            it { expect(subject.map(&:id)).to eq [] }
          end
        end

        context 'and the value does not match any' do
          let(:value) { 100.00 }

          it { expect(subject.map(&:id)).to eq [] }
        end

        context 'and the value matches all' do
          let(:value) { -1.00 }

          it { expect(subject.map(&:id)).to eq [foo.id, bar.id] }
        end
      end

      context 'with default < operator' do
        let(:keypath) { ['float(<)'] }

        context 'and the value matches' do
          context 'the lesser' do
            let(:value) { foo.float }

            it { expect(subject.map(&:id)).to eq [] }
          end

          context 'the greater' do
            let(:value) { bar.float }

            it { expect(subject.map(&:id)).to eq [foo.id] }
          end
        end

        context 'and the value does not match any' do
          let(:value) { -1.00 }

          it { expect(subject.map(&:id)).to eq [] }
        end

        context 'and the value matches all' do
          let(:value) { 100.00 }

          it { expect(subject.map(&:id)).to eq [foo.id, bar.id] }
        end
      end

      context 'with default >= operator' do
        let(:keypath) { ['float(>=)'] }

        context 'and the value matches' do
          context 'the lesser' do
            let(:value) { foo.float }

            it { expect(subject.map(&:id)).to eq [foo.id, bar.id] }
          end

          context 'the greater' do
            let(:value) { bar.float }

            it { expect(subject.map(&:id)).to eq [bar.id] }
          end
        end

        context 'and the value does not match any' do
          let(:value) { 100.00 }

          it { expect(subject.map(&:id)).to eq [] }
        end

        context 'and the value matches all' do
          let(:value) { -1.00 }

          it { expect(subject.map(&:id)).to eq [foo.id, bar.id] }
        end
      end

      context 'with default <= operator' do
        let(:keypath) { ['float(<=)'] }

        context 'and the value matches' do
          context 'the lesser' do
            let(:value) { foo.float }

            it { expect(subject.map(&:id)).to eq [foo.id] }
          end

          context 'the greater' do
            let(:value) { bar.float }

            it { expect(subject.map(&:id)).to eq [foo.id, bar.id] }
          end
        end

        context 'and the value does not match any' do
          let(:value) { -1.00 }

          it { expect(subject.map(&:id)).to eq [] }
        end

        context 'and the value matches all' do
          let(:value) { 100.00 }

          it { expect(subject.map(&:id)).to eq [foo.id, bar.id] }
        end
      end
    end

    context 'on an associated object' do
      before(:each) do
        foo.assoc.tap { |foo_assoc| foo_assoc.float = 1.11 }.tap(&:save)
        bar.assoc.tap { |bar_assoc| bar_assoc.float = 2.22 }.tap(&:save)
      end

      context 'with default == operator' do
        let(:keypath) { %w[assoc float] }

        context 'and the value matches' do
          let(:value) { foo.assoc.float }

          it { expect(subject.map(&:id)).to eq [foo.id] }
        end

        context 'and the value does not matches' do
          let(:value) { -1.00 }

          it { expect(subject.map(&:id)).to eq [] }
        end
      end

      context 'with default > operator' do
        let(:keypath) { %w[assoc float(>)] }

        context 'and the value matches' do
          context 'the lesser' do
            let(:value) { foo.assoc.float }

            it { expect(subject.map(&:id)).to eq [bar.id] }
          end

          context 'the greater' do
            let(:value) { bar.assoc.float }

            it { expect(subject.map(&:id)).to eq [] }
          end
        end

        context 'and the value does not match any' do
          let(:value) { 100.00 }

          it { expect(subject.map(&:id)).to eq [] }
        end

        context 'and the value matches all' do
          let(:value) { -1.00 }

          it { expect(subject.map(&:id)).to eq [foo.id, bar.id] }
        end
      end

      context 'with default < operator' do
        let(:keypath) { %w[assoc float(<)] }

        context 'and the value matches' do
          context 'the lesser' do
            let(:value) { foo.assoc.float }

            it { expect(subject.map(&:id)).to eq [] }
          end

          context 'the greater' do
            let(:value) { bar.assoc.float }

            it { expect(subject.map(&:id)).to eq [foo.id] }
          end
        end

        context 'and the value does not match any' do
          let(:value) { -1.00 }

          it { expect(subject.map(&:id)).to eq [] }
        end

        context 'and the value matches all' do
          let(:value) { 100.00 }

          it { expect(subject.map(&:id)).to eq [foo.id, bar.id] }
        end
      end

      context 'with default >= operator' do
        let(:keypath) { %w[assoc float(>=)] }

        context 'and the value matches' do
          context 'the lesser' do
            let(:value) { foo.assoc.float }

            it { expect(subject.map(&:id)).to eq [foo.id, bar.id] }
          end

          context 'the greater' do
            let(:value) { bar.assoc.float }

            it { expect(subject.map(&:id)).to eq [bar.id] }
          end
        end

        context 'and the value does not match any' do
          let(:value) { 100.00 }

          it { expect(subject.map(&:id)).to eq [] }
        end

        context 'and the value matches all' do
          let(:value) { -1.00 }

          it { expect(subject.map(&:id)).to eq [foo.id, bar.id] }
        end
      end

      context 'with default <= operator' do
        let(:keypath) { %w[assoc float(<=)] }

        context 'and the value matches' do
          context 'the lesser' do
            let(:value) { foo.assoc.float }

            it { expect(subject.map(&:id)).to eq [foo.id] }
          end

          context 'the greater' do
            let(:value) { bar.assoc.float }

            it { expect(subject.map(&:id)).to eq [foo.id, bar.id] }
          end
        end

        context 'and the value does not match any' do
          let(:value) { -1.00 }

          it { expect(subject.map(&:id)).to eq [] }
        end

        context 'and the value matches all' do
          let(:value) { 100.00 }

          it { expect(subject.map(&:id)).to eq [foo.id, bar.id] }
        end
      end
    end
  end
end
