# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ActiveSet::Processor::Filter::EnumerableAdapter do
  include_context 'for enumerable sets'

  let(:adapter) { described_class.new(enumerable_set, instructions) }
  let(:instructions) { ActiveSet::Instructions.new(keypath => value) }

  describe '#process with BigNum type attribute value' do
    subject { adapter.process }

    context 'on the base object' do
      before(:each) do
        foo.bignum = 2**64
        bar.bignum = 3**64
      end

      context 'with default == operator' do
        let(:keypath) { [:bignum] }

        context 'and the value matches' do
          let(:value) { foo.bignum }

          it { expect(subject.map(&:id)).to eq [foo.id] }
        end

        context 'and the value does not matches' do
          let(:value) { 3**65 }

          it { expect(subject.map(&:id)).to eq [] }
        end
      end

      context 'with default > operator' do
        let(:keypath) { ['bignum(>)'] }

        context 'and the value matches' do
          context 'the lesser' do
            let(:value) { foo.bignum }

            it { expect(subject.map(&:id)).to eq [bar.id] }
          end

          context 'the greater' do
            let(:value) { bar.bignum }

            it { expect(subject.map(&:id)).to eq [] }
          end
        end

        context 'and the value does not match any' do
          let(:value) { 3**65 }

          it { expect(subject.map(&:id)).to eq [] }
        end

        context 'and the value matches all' do
          let(:value) { 2**63 }

          it { expect(subject.map(&:id)).to eq [foo.id, bar.id] }
        end
      end

      context 'with default < operator' do
        let(:keypath) { ['bignum(<)'] }

        context 'and the value matches' do
          context 'the lesser' do
            let(:value) { foo.bignum }

            it { expect(subject.map(&:id)).to eq [] }
          end

          context 'the greater' do
            let(:value) { bar.bignum }

            it { expect(subject.map(&:id)).to eq [foo.id] }
          end
        end

        context 'and the value does not match any' do
          let(:value) { 2**63 }

          it { expect(subject.map(&:id)).to eq [] }
        end

        context 'and the value matches all' do
          let(:value) { 3**65 }

          it { expect(subject.map(&:id)).to eq [foo.id, bar.id] }
        end
      end

      context 'with default >= operator' do
        let(:keypath) { ['bignum(>=)'] }

        context 'and the value matches' do
          context 'the lesser' do
            let(:value) { foo.bignum }

            it { expect(subject.map(&:id)).to eq [foo.id, bar.id] }
          end

          context 'the greater' do
            let(:value) { bar.bignum }

            it { expect(subject.map(&:id)).to eq [bar.id] }
          end
        end

        context 'and the value does not match any' do
          let(:value) { 3**65 }

          it { expect(subject.map(&:id)).to eq [] }
        end

        context 'and the value matches all' do
          let(:value) { 2**63 }

          it { expect(subject.map(&:id)).to eq [foo.id, bar.id] }
        end
      end

      context 'with default <= operator' do
        let(:keypath) { ['bignum(<=)'] }

        context 'and the value matches' do
          context 'the lesser' do
            let(:value) { foo.bignum }

            it { expect(subject.map(&:id)).to eq [foo.id] }
          end

          context 'the greater' do
            let(:value) { bar.bignum }

            it { expect(subject.map(&:id)).to eq [foo.id, bar.id] }
          end
        end

        context 'and the value does not match any' do
          let(:value) { 2**63 }

          it { expect(subject.map(&:id)).to eq [] }
        end

        context 'and the value matches all' do
          let(:value) { 3**65 }

          it { expect(subject.map(&:id)).to eq [foo.id, bar.id] }
        end
      end
    end

    context 'on an associated object' do
      before(:each) do
        foo.assoc.bignum = 2**64
        bar.assoc.bignum = 3**64
      end

      context 'with default == operator' do
        let(:keypath) { %w[assoc bignum] }

        context 'and the value matches' do
          let(:value) { foo.assoc.bignum }

          it { expect(subject.map(&:id)).to eq [foo.id] }
        end

        context 'and the value does not matches' do
          let(:value) { 3**65 }

          it { expect(subject.map(&:id)).to eq [] }
        end
      end

      context 'with default > operator' do
        let(:keypath) { %w[assoc bignum(>)] }

        context 'and the value matches' do
          context 'the lesser' do
            let(:value) { foo.assoc.bignum }

            it { expect(subject.map(&:id)).to eq [bar.id] }
          end

          context 'the greater' do
            let(:value) { bar.assoc.bignum }

            it { expect(subject.map(&:id)).to eq [] }
          end
        end

        context 'and the value does not match any' do
          let(:value) { 3**65 }

          it { expect(subject.map(&:id)).to eq [] }
        end

        context 'and the value matches all' do
          let(:value) { 2**63 }

          it { expect(subject.map(&:id)).to eq [foo.id, bar.id] }
        end
      end

      context 'with default < operator' do
        let(:keypath) { %w[assoc bignum(<)] }

        context 'and the value matches' do
          context 'the lesser' do
            let(:value) { foo.assoc.bignum }

            it { expect(subject.map(&:id)).to eq [] }
          end

          context 'the greater' do
            let(:value) { bar.assoc.bignum }

            it { expect(subject.map(&:id)).to eq [foo.id] }
          end
        end

        context 'and the value does not match any' do
          let(:value) { 2**63 }

          it { expect(subject.map(&:id)).to eq [] }
        end

        context 'and the value matches all' do
          let(:value) { 3**65 }

          it { expect(subject.map(&:id)).to eq [foo.id, bar.id] }
        end
      end

      context 'with default >= operator' do
        let(:keypath) { %w[assoc bignum(>=)] }

        context 'and the value matches' do
          context 'the lesser' do
            let(:value) { foo.assoc.bignum }

            it { expect(subject.map(&:id)).to eq [foo.id, bar.id] }
          end

          context 'the greater' do
            let(:value) { bar.assoc.bignum }

            it { expect(subject.map(&:id)).to eq [bar.id] }
          end
        end

        context 'and the value does not match any' do
          let(:value) { 3**65 }

          it { expect(subject.map(&:id)).to eq [] }
        end

        context 'and the value matches all' do
          let(:value) { 2**63 }

          it { expect(subject.map(&:id)).to eq [foo.id, bar.id] }
        end
      end

      context 'with default <= operator' do
        let(:keypath) { %w[assoc bignum(<=)] }

        context 'and the value matches' do
          context 'the lesser' do
            let(:value) { foo.assoc.bignum }

            it { expect(subject.map(&:id)).to eq [foo.id] }
          end

          context 'the greater' do
            let(:value) { bar.assoc.bignum }

            it { expect(subject.map(&:id)).to eq [foo.id, bar.id] }
          end
        end

        context 'and the value does not match any' do
          let(:value) { 2**63 }

          it { expect(subject.map(&:id)).to eq [] }
        end

        context 'and the value matches all' do
          let(:value) { 3**65 }

          it { expect(subject.map(&:id)).to eq [foo.id, bar.id] }
        end
      end
    end
  end
end
