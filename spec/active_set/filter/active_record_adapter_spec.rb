# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ActiveSet::FilterProcessor::ActiveRecordAdapter do
  include_context 'for active record sets'

  let(:adapter) { described_class.new(keypath, value) }

  describe '#process' do
    subject { adapter.process(active_record_set) }

    context 'when the keypath' do
      context 'is a base attribute' do
        context ':binary type' do
          context 'and the value matches' do
            let(:keypath) { [:binary] }
            let(:value) { foo.binary }

            it { expect(subject.map(&:id)).to eq [foo.id] }
          end

          context 'and the value does not matches' do
            let(:keypath) { [:binary] }
            let(:value) { '___' }

            it { should eq [] }
          end
        end

        context ':boolean type' do
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

        context ':date type' do
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

        context ':datetime type' do
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

        context ':decimal type' do
          context 'and the value matches' do
            let(:keypath) { [:decimal] }
            let(:value) { foo.decimal }

            it { expect(subject.map(&:id)).to eq [foo.id] }
          end

          context 'and the value does not matches' do
            let(:keypath) { [:decimal] }
            let(:value) { '___' }

            it { should eq [] }
          end
        end

        context ':float type' do
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

        context ':integer type' do
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

        context ':string type' do
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

        context ':text type' do
          context 'and the value matches' do
            let(:keypath) { [:text] }
            let(:value) { foo.text }

            it { expect(subject.map(&:id)).to eq [foo.id] }
          end

          context 'and the value does not matches' do
            let(:keypath) { [:text] }
            let(:value) { '___' }

            it { should eq [] }
          end
        end
      end

      context 'is an association\'s attribute' do
        context ':binary type' do
          context 'and the value matches' do
            let(:keypath) { %i[assoc binary] }
            let(:value) { foo.assoc.binary }

            it { expect(subject.map(&:id)).to eq [foo.id] }
          end

          context 'and the value does not matches' do
            let(:keypath) { %i[assoc binary] }
            let(:value) { '___' }

            it { should eq [] }
          end
        end

        context ':boolean type' do
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

        context ':date type' do
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

        context ':datetime type' do
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

        context ':decimal type' do
          context 'and the value matches' do
            let(:keypath) { %i[assoc decimal] }
            let(:value) { foo.assoc.decimal }

            it { expect(subject.map(&:id)).to eq [foo.id] }
          end

          context 'and the value does not matches' do
            let(:keypath) { %i[assoc decimal] }
            let(:value) { '___' }

            it { should eq [] }
          end
        end

        context ':float type' do
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

        context ':integer type' do
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

        context ':string type' do
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

        context ':text type' do
          context 'and the value matches' do
            let(:keypath) { %i[assoc text] }
            let(:value) { foo.assoc.text }

            it { expect(subject.map(&:id)).to eq [foo.id] }
          end

          context 'and the value does not matches' do
            let(:keypath) { %i[assoc text] }
            let(:value) { '___' }

            it { should eq [] }
          end
        end
      end
    end
  end
end
