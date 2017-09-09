# frozen_string_literal: true

require 'spec_helper'
require 'ostruct'

RSpec.describe ActiveSet do
  let(:foo) { OpenStruct.new(key: 'foo') }
  let(:bar) { OpenStruct.new(key: 'bar') }
  let(:baz) { OpenStruct.new(key: 'baz') }
  let(:set) { [foo, bar, baz] }
  let(:active_set) { ActiveSet.new set }

  it 'has a version number' do
    expect(ActiveSet::VERSION).not_to be nil
  end

  describe 'filtering' do
    it { expect(active_set.filter(key: 'bar')).to eq [bar] }
    it { expect(active_set.filter(key: 'val')).to eq [] }
  end

  describe 'sorting' do
    it { expect(active_set.sort(key: :asc)).to eq [bar, baz, foo] }
    it { expect(active_set.sort(key: :desc)).to eq [foo, baz, bar] }
  end

  describe 'paginating' do
    it { expect(active_set.paginate(page: 1, size: 1)).to eq [foo] }
    it { expect(active_set.paginate(page: 1, size: 2)).to eq [foo, bar] }
    it { expect(active_set.paginate(page: 2, size: 1)).to eq [bar] }
    it { expect(active_set.paginate(page: 2, size: 2)).to eq [baz] }
    it { expect(active_set.paginate(page: 10, size: 2)).to eq [baz] }
    it { expect(active_set.paginate(page: 10)).to eq [foo, bar, baz] }
  end
end
