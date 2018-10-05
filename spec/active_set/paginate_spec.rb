# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ActiveSet do
  before(:all) do
    @foo_1 = FactoryGirl.create(:foo, assoc: FactoryGirl.create(:assoc))
    @foo_2 = FactoryGirl.create(:foo, assoc: FactoryGirl.create(:assoc))
    @foo_3 = FactoryGirl.create(:foo, assoc: FactoryGirl.create(:assoc))
  end
  after(:all) { Foo.delete_all }

  describe '#paginate' do
    context 'with ActiveRecord collection' do
      before(:all) { @active_set = ActiveSet.new(Foo.all) }
      let(:result) { @active_set.paginate(instructions) }

      context '{ page: 1, size: 1 }' do
        let(:instructions) { { page: 1, size: 1 } }

        it { expect(result.map(&:id)).to eq [@foo_1.id] }
      end

      context '{ page: 2, size: 1 }' do
        let(:instructions) { { page: 2, size: 1 } }

        it { expect(result.map(&:id)).to eq [@foo_2.id] }
      end

      context '{ page: 10, size: 1 }' do
        let(:instructions) { { page: 10, size: 1 } }

        it { expect(result.map(&:id)).to eq [] }
      end

      context '{ page: 1, size: 2 }' do
        let(:instructions) { { page: 1, size: 2 } }

        it { expect(result.map(&:id)).to eq [@foo_1.id, @foo_2.id] }
      end

      context '{ page: 2, size: 2 }' do
        let(:instructions) { { page: 2, size: 2 } }

        it { expect(result.map(&:id)).to eq [@foo_3.id] }
      end

      context '{ page: 10, size: 2 }' do
        let(:instructions) { { page: 10, size: 2 } }

        it { expect(result.map(&:id)).to eq [] }
      end

      context '{ page: 1, size: 3 }' do
        let(:instructions) { { page: 1, size: 3 } }

        it { expect(result.map(&:id)).to eq [@foo_1.id, @foo_2.id, @foo_3.id] }
      end

      context '{ page: 10, size: 3 }' do
        let(:instructions) { { page: 10, size: 3 } }

        it { expect(result.map(&:id)).to eq [] }
      end

      context '{ page: 1, size: 5 }' do
        let(:instructions) { { page: 1, size: 5 } }

        it { expect(result.map(&:id)).to eq [@foo_1.id, @foo_2.id, @foo_3.id] }
      end

      context '{ page: 10, size: 5 }' do
        let(:instructions) { { page: 10, size: 5 } }

        it { expect(result.map(&:id)).to eq [] }
      end
    end

    context 'with Enumerable collection' do
      before(:all) { @active_set = ActiveSet.new(Foo.all.to_a) }
      let(:result) { @active_set.paginate(instructions) }

      context '{ page: 1, size: 1 }' do
        let(:instructions) { { page: 1, size: 1 } }

        it { expect(result.map(&:id)).to eq [@foo_1.id] }
      end

      context '{ page: 2, size: 1 }' do
        let(:instructions) { { page: 2, size: 1 } }

        it { expect(result.map(&:id)).to eq [@foo_2.id] }
      end

      context '{ page: 10, size: 1 }' do
        let(:instructions) { { page: 10, size: 1 } }

        it { expect(result.map(&:id)).to eq [] }
      end

      context '{ page: 1, size: 2 }' do
        let(:instructions) { { page: 1, size: 2 } }

        it { expect(result.map(&:id)).to eq [@foo_1.id, @foo_2.id] }
      end

      context '{ page: 2, size: 2 }' do
        let(:instructions) { { page: 2, size: 2 } }

        it { expect(result.map(&:id)).to eq [@foo_3.id] }
      end

      context '{ page: 10, size: 2 }' do
        let(:instructions) { { page: 10, size: 2 } }

        it { expect(result.map(&:id)).to eq [] }
      end

      context '{ page: 1, size: 3 }' do
        let(:instructions) { { page: 1, size: 3 } }

        it { expect(result.map(&:id)).to eq [@foo_1.id, @foo_2.id, @foo_3.id] }
      end

      context '{ page: 10, size: 3 }' do
        let(:instructions) { { page: 10, size: 3 } }

        it { expect(result.map(&:id)).to eq [] }
      end

      context '{ page: 1, size: 5 }' do
        let(:instructions) { { page: 1, size: 5 } }

        it { expect(result.map(&:id)).to eq [@foo_1.id, @foo_2.id, @foo_3.id] }
      end

      context '{ page: 10, size: 5 }' do
        let(:instructions) { { page: 10, size: 5 } }

        it { expect(result.map(&:id)).to eq [] }
      end
    end
  end
end
