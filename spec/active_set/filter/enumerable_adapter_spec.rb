# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ActiveSet::FilterProcessor::EnumerableAdapter do
  include_context 'for enumerable sets'

  let(:adapter) { described_class.new(keypath, value) }

  describe '#process' do
    subject { adapter.process(enumerable_set) }

    context 'when the keypath' do
      context 'is a base attribute' do
        context 'String type' do
          context 'and the value matches' do
            let(:keypath) { [:string] }
            let(:value) { foo.string }

            it { expect(subject.map(&:id)).to eq [foo.id] }
          end

          context 'and the value does not matches' do
            let(:keypath) { [:string] }
            let(:value) { '___' }

            it { should eq [] }
          end
        end

        context 'Symbol type' do
          context 'and the value matches' do
            let(:keypath) { [:symbol] }
            let(:value) { foo.symbol }

            it { expect(subject.map(&:id)).to eq [foo.id] }
          end

          context 'and the value does not matches' do
            let(:keypath) { [:symbol] }
            let(:value) { '___' }

            it { should eq [] }
          end
        end

        context 'Date type' do
          context 'and the value matches' do
            let(:keypath) { [:date] }
            let(:value) { foo.date }

            it { expect(subject.map(&:id)).to eq [foo.id] }
          end

          context 'and the value does not matches' do
            let(:keypath) { [:date] }
            let(:value) { '___' }

            it { should eq [] }
          end
        end

        context 'DateTime type' do
          context 'and the value matches' do
            let(:keypath) { [:datetime] }
            let(:value) { foo.datetime }

            it { expect(subject.map(&:id)).to eq [foo.id] }
          end

          context 'and the value does not matches' do
            let(:keypath) { [:datetime] }
            let(:value) { '___' }

            it { should eq [] }
          end
        end

        context 'Time type' do
          context 'and the value matches' do
            let(:keypath) { [:time] }
            let(:value) { foo.time }

            it { expect(subject.map(&:id)).to eq [foo.id] }
          end

          context 'and the value does not matches' do
            let(:keypath) { [:time] }
            let(:value) { '___' }

            it { should eq [] }
          end
        end

        context 'Integer type' do
          context 'and the value matches' do
            let(:keypath) { [:integer] }
            let(:value) { foo.integer }

            it { expect(subject.map(&:id)).to eq [foo.id] }
          end

          context 'and the value does not matches' do
            let(:keypath) { [:integer] }
            let(:value) { '___' }

            it { should eq [] }
          end
        end

        context 'Float type' do
          context 'and the value matches' do
            let(:keypath) { [:float] }
            let(:value) { foo.float }

            it { expect(subject.map(&:id)).to eq [foo.id] }
          end

          context 'and the value does not matches' do
            let(:keypath) { [:float] }
            let(:value) { '___' }

            it { should eq [] }
          end
        end

        context 'Bignum type' do
          context 'and the value matches' do
            let(:keypath) { [:bignum] }
            let(:value) { foo.bignum }

            it { expect(subject.map(&:id)).to eq [foo.id] }
          end

          context 'and the value does not matches' do
            let(:keypath) { [:bignum] }
            let(:value) { '___' }

            it { should eq [] }
          end
        end

        context 'Boolean type' do
          context 'and the value matches' do
            let(:keypath) { [:boolean] }
            let(:value) { foo.boolean }

            it { expect(subject.map(&:id)).to eq [foo.id] }
          end

          context 'and the value does not matches' do
            let(:keypath) { [:boolean] }
            let(:value) { '___' }

            it { should eq [] }
          end
        end

        context 'Nil type' do
          context 'and the value matches' do
            let(:keypath) { [:nil] }
            let(:value) { nil }

            it { expect(subject.map(&:id)).to eq [foo.id] }
          end

          context 'and the value does not matches' do
            let(:keypath) { [:nil] }
            let(:value) { '___' }

            it { should eq [] }
          end
        end
      end

      context 'is an assoc\'s attribute' do
        context 'String type' do
          context 'and the value matches' do
            let(:keypath) { %i[assoc string] }
            let(:value) { foo.assoc.string }

            it { expect(subject.map(&:id)).to eq [foo.id] }
          end

          context 'and the value does not matches' do
            let(:keypath) { %i[assoc string] }
            let(:value) { '___' }

            it { should eq [] }
          end
        end

        context 'Symbol type' do
          context 'and the value matches' do
            let(:keypath) { %i[assoc symbol] }
            let(:value) { foo.assoc.symbol }

            it { expect(subject.map(&:id)).to eq [foo.id] }
          end

          context 'and the value does not matches' do
            let(:keypath) { %i[assoc symbol] }
            let(:value) { '___' }

            it { should eq [] }
          end
        end

        context 'Date type' do
          context 'and the value matches' do
            let(:keypath) { %i[assoc date] }
            let(:value) { foo.assoc.date }

            it { expect(subject.map(&:id)).to eq [foo.id] }
          end

          context 'and the value does not matches' do
            let(:keypath) { %i[assoc date] }
            let(:value) { '___' }

            it { should eq [] }
          end
        end

        context 'DateTime type' do
          context 'and the value matches' do
            let(:keypath) { %i[assoc datetime] }
            let(:value) { foo.assoc.datetime }

            it { expect(subject.map(&:id)).to eq [foo.id] }
          end

          context 'and the value does not matches' do
            let(:keypath) { %i[assoc datetime] }
            let(:value) { '___' }

            it { should eq [] }
          end
        end

        context 'Time type' do
          context 'and the value matches' do
            let(:keypath) { %i[assoc time] }
            let(:value) { foo.assoc.time }

            it { expect(subject.map(&:id)).to eq [foo.id] }
          end

          context 'and the value does not matches' do
            let(:keypath) { %i[assoc time] }
            let(:value) { '___' }

            it { should eq [] }
          end
        end

        context 'Integer type' do
          context 'and the value matches' do
            let(:keypath) { %i[assoc integer] }
            let(:value) { foo.assoc.integer }

            it { expect(subject.map(&:id)).to eq [foo.id] }
          end

          context 'and the value does not matches' do
            let(:keypath) { %i[assoc integer] }
            let(:value) { '___' }

            it { should eq [] }
          end
        end

        context 'Float type' do
          context 'and the value matches' do
            let(:keypath) { %i[assoc float] }
            let(:value) { foo.assoc.float }

            it { expect(subject.map(&:id)).to eq [foo.id] }
          end

          context 'and the value does not matches' do
            let(:keypath) { %i[assoc float] }
            let(:value) { '___' }

            it { should eq [] }
          end
        end

        context 'Bignum type' do
          context 'and the value matches' do
            let(:keypath) { %i[assoc bignum] }
            let(:value) { foo.assoc.bignum }

            it { expect(subject.map(&:id)).to eq [foo.id] }
          end

          context 'and the value does not matches' do
            let(:keypath) { %i[assoc bignum] }
            let(:value) { '___' }

            it { should eq [] }
          end
        end

        context 'Boolean type' do
          context 'and the value matches' do
            let(:keypath) { %i[assoc boolean] }
            let(:value) { foo.assoc.boolean }

            it { expect(subject.map(&:id)).to eq [foo.id] }
          end

          context 'and the value does not matches' do
            let(:keypath) { %i[assoc boolean] }
            let(:value) { '___' }

            it { should eq [] }
          end
        end

        context 'Nil type' do
          context 'and the value matches' do
            let(:keypath) { %i[assoc nil] }
            let(:value) { nil }

            it { should eq [bar] }
          end

          context 'and the value does not matches' do
            let(:keypath) { %i[assoc nil] }
            let(:value) { '___' }

            it { should eq [] }
          end
        end
      end
    end
  end
end
