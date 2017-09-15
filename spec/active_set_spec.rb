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
end
