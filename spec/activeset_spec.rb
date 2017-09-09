# frozen_string_literal: true

require 'spec_helper'
require 'ostruct'

RSpec.describe ActiveSet do
  let(:foo) { OpenStruct.new(key: 'foo', association: OpenStruct.new(key: 'oof')) }
  let(:bar) { OpenStruct.new(key: 'bar', association: OpenStruct.new(key: 'rab')) }
  let(:baz) { OpenStruct.new(key: 'baz', association: OpenStruct.new(key: 'zab')) }
  let(:set) { [foo, bar, baz] }
  let(:active_set) { ActiveSet.new set }

  it 'has a version number' do
    expect(ActiveSet::VERSION).not_to be nil
  end

  describe 'filtering' do
    context 'by attributes on the base resource' do
      it { expect(active_set.filter(key: 'bar')).to eq [bar] }
      it { expect(active_set.filter(key: 'val')).to eq ActiveSet.new([]) }
    end

    context 'by attributes on an associated resource' do
      it { expect(active_set.filter(association: { key: 'zab' })).to eq [baz] }
      it { expect(active_set.filter(association: { key: 'val' })).to eq ActiveSet.new([]) }
    end
  end

  describe 'sorting' do
    context 'by attributes on the base resource' do
      it { expect(active_set.sort(key: :asc)).to eq [bar, baz, foo] }
      it { expect(active_set.sort(key: :desc)).to eq ActiveSet.new([foo, baz, bar]) }
    end

    context 'by attributes on an associated resource' do
      it { expect(active_set.sort(association: { key: :asc })).to eq [foo, bar, baz] }
      it { expect(active_set.sort(association: { key: :desc })).to eq ActiveSet.new([baz, bar, foo]) }
    end
  end

  describe 'paginating' do
    it { expect(active_set.paginate(page: 1, size: 1)).to eq ActiveSet.new([foo]) }
    it { expect(active_set.paginate(page: 1, size: 2)).to eq [foo, bar] }
    it { expect(active_set.paginate(page: 2, size: 1)).to eq [bar] }
    it { expect(active_set.paginate(page: 2, size: 2)).to eq [baz] }
    it { expect(active_set.paginate(page: 10, size: 2)).to eq [baz] }
    it { expect(active_set.paginate(page: 10)).to eq ActiveSet.new([foo, bar, baz]) }
  end
end
