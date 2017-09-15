# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ActiveSet::FilterProcessor::ActiveRecordAdapter do
  include_context 'for active record sets'

  let(:adapter) { described_class.new(keypath, value) }

  describe '#process with :string type attribute value' do
    subject { adapter.process(active_record_set) }

    context 'on the base object' do
      before(:each) do
        foo.tap { |foo| foo.string = 'aaa' }.tap(&:save)
        bar.tap { |bar| bar.string = 'zzz' }.tap(&:save)
      end

      context 'with default == operator' do
        let(:keypath) { [:string] }

        context 'and the value matches' do
          let(:value) { foo.string }

          it { expect(subject.map(&:id)).to eq [foo.id] }
        end

        context 'and the value does not match' do
          let(:value) { '___' }

          it { expect(subject.map(&:id)).to eq [] }
        end
      end

      context 'with default > operator' do
        let(:keypath) { ['string(>)'] }

        context 'and the value matches' do
          context 'the lesser' do
            let(:value) { foo.string }

            it { expect(subject.map(&:id)).to eq [bar.id] }
          end

          context 'the greater' do
            let(:value) { bar.string }

            it { expect(subject.map(&:id)).to eq [] }
          end
        end

        context 'and the value does not match any' do
          let(:value) { '~~~' }

          it { expect(subject.map(&:id)).to eq [] }
        end

        context 'and the value matches all' do
          let(:value) { '___' }

          it { expect(subject.map(&:id)).to eq [foo.id, bar.id] }
        end
      end

      context 'with default < operator' do
        let(:keypath) { ['string(<)'] }

        context 'and the value matches' do
          context 'the lesser' do
            let(:value) { foo.string }

            it { expect(subject.map(&:id)).to eq [] }
          end

          context 'the greater' do
            let(:value) { bar.string }

            it { expect(subject.map(&:id)).to eq [foo.id] }
          end
        end

        context 'and the value does not match any' do
          let(:value) { '___' }

          it { expect(subject.map(&:id)).to eq [] }
        end

        context 'and the value matches all' do
          let(:value) { '~~~' }

          it { expect(subject.map(&:id)).to eq [foo.id, bar.id] }
        end
      end

      context 'with default >= operator' do
        let(:keypath) { ['string(>=)'] }

        context 'and the value matches' do
          context 'the lesser' do
            let(:value) { foo.string }

            it { expect(subject.map(&:id)).to eq [foo.id, bar.id] }
          end

          context 'the greater' do
            let(:value) { bar.string }

            it { expect(subject.map(&:id)).to eq [bar.id] }
          end
        end

        context 'and the value does not match any' do
          let(:value) { '~~~' }

          it { expect(subject.map(&:id)).to eq [] }
        end

        context 'and the value matches all' do
          let(:value) { '___' }

          it { expect(subject.map(&:id)).to eq [foo.id, bar.id] }
        end
      end

      context 'with default <= operator' do
        let(:keypath) { ['string(<=)'] }

        context 'and the value matches' do
          context 'the lesser' do
            let(:value) { foo.string }

            it { expect(subject.map(&:id)).to eq [foo.id] }
          end

          context 'the greater' do
            let(:value) { bar.string }

            it { expect(subject.map(&:id)).to eq [foo.id, bar.id] }
          end
        end

        context 'and the value does not match any' do
          let(:value) { '___' }

          it { expect(subject.map(&:id)).to eq [] }
        end

        context 'and the value matches all' do
          let(:value) { '~~~' }

          it { expect(subject.map(&:id)).to eq [foo.id, bar.id] }
        end
      end
    end

    context 'on an associated object' do
      before(:each) do
        foo.assoc.tap { |foo_assoc| foo_assoc.string = 'aaa' }.tap(&:save)
        bar.assoc.tap { |bar_assoc| bar_assoc.string = 'zzz' }.tap(&:save)
      end

      context 'with default == operator' do
        let(:keypath) { %w[assoc string] }

        context 'and the value matches' do
          let(:value) { foo.assoc.string }

          it { expect(subject.map(&:id)).to eq [foo.id] }
        end

        context 'and the value does not match' do
          let(:value) { '___' }

          it { expect(subject.map(&:id)).to eq [] }
        end
      end

      context 'with default > operator' do
        let(:keypath) { %w[assoc string(>)] }

        context 'and the value matches' do
          context 'the lesser' do
            let(:value) { foo.assoc.string }

            it { expect(subject.map(&:id)).to eq [bar.id] }
          end

          context 'the greater' do
            let(:value) { bar.assoc.string }

            it { expect(subject.map(&:id)).to eq [] }
          end
        end

        context 'and the value does not match any' do
          let(:value) { '~~~' }

          it { expect(subject.map(&:id)).to eq [] }
        end

        context 'and the value matches all' do
          let(:value) { '___' }

          it { expect(subject.map(&:id)).to eq [foo.id, bar.id] }
        end
      end

      context 'with default < operator' do
        let(:keypath) { %w[assoc string(<)] }

        context 'and the value matches' do
          context 'the lesser' do
            let(:value) { foo.assoc.string }

            it { expect(subject.map(&:id)).to eq [] }
          end

          context 'the greater' do
            let(:value) { bar.assoc.string }

            it { expect(subject.map(&:id)).to eq [foo.id] }
          end
        end

        context 'and the value does not match any' do
          let(:value) { '___' }

          it { expect(subject.map(&:id)).to eq [] }
        end

        context 'and the value matches all' do
          let(:value) { '~~~' }

          it { expect(subject.map(&:id)).to eq [foo.id, bar.id] }
        end
      end

      context 'with default >= operator' do
        let(:keypath) { %w[assoc string(>=)] }

        context 'and the value matches' do
          context 'the lesser' do
            let(:value) { foo.assoc.string }

            it { expect(subject.map(&:id)).to eq [foo.id, bar.id] }
          end

          context 'the greater' do
            let(:value) { bar.assoc.string }

            it { expect(subject.map(&:id)).to eq [bar.id] }
          end
        end

        context 'and the value does not match any' do
          let(:value) { '~~~' }

          it { expect(subject.map(&:id)).to eq [] }
        end

        context 'and the value matches all' do
          let(:value) { '___' }

          it { expect(subject.map(&:id)).to eq [foo.id, bar.id] }
        end
      end

      context 'with default <= operator' do
        let(:keypath) { %w[assoc string(<=)] }

        context 'and the value matches' do
          context 'the lesser' do
            let(:value) { foo.assoc.string }

            it { expect(subject.map(&:id)).to eq [foo.id] }
          end

          context 'the greater' do
            let(:value) { bar.assoc.string }

            it { expect(subject.map(&:id)).to eq [foo.id, bar.id] }
          end
        end

        context 'and the value does not match any' do
          let(:value) { '___' }

          it { expect(subject.map(&:id)).to eq [] }
        end

        context 'and the value matches all' do
          let(:value) { '~~~' }

          it { expect(subject.map(&:id)).to eq [foo.id, bar.id] }
        end
      end
    end
  end
end
