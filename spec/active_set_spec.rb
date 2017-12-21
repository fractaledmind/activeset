# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ActiveSet do
  it 'has a version number' do
    expect(ActiveSet::VERSION).not_to be nil
  end

  context 'as a Decorator of the set it is initialized with' do
    describe 'a Set' do
      it { expect(ActiveSet.new(Set.new)).to respond_to :superset? }
    end

    describe 'an Array' do
      it { expect(ActiveSet.new([])).to respond_to :index }
    end

    it 'extends Enumberable' do
      expect(ActiveSet.new([])).to respond_to :each
    end
  end

  context '#filter' do
    let(:set) { [1, 2, 3] }
    let(:active_set) { ActiveSet.new(set) }
    let(:filtered_set) { active_set.filter(filter_instructions) }
    let(:filter_instructions) { { itself: 1 } }

    it 'resets the set\'s total_count' do
      expect(filtered_set.total_count).to eq 1
    end
  end

  context '#sort' do
    let(:set) { [1, 2, 3] }
    let(:active_set) { ActiveSet.new(set) }
    let(:sorted_set) { active_set.sort(sort_instructions) }
    let(:sort_instructions) { { itself: :asc } }

    it 'does not reset the set\'s total_count' do
      expect(sorted_set.total_count).to eq set.count
    end
  end

  context '#paginate' do
    let(:set) { [1, 2, 3] }
    let(:active_set) { ActiveSet.new(set) }
    let(:paginated_set) { active_set.paginate(paginate_instructions) }
    let(:paginate_instructions) { { page: 1, size: 1 } }

    it 'does not reset the set\'s total_count' do
      expect(paginated_set.total_count).to eq set.count
    end
  end
end
