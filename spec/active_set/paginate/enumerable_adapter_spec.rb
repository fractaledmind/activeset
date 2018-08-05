# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ActiveSet::Processor::Paginate::EnumerableAdapter do
  include_context 'for enumerable sets'

  let(:adapter) { described_class.new(enumerable_set, instructions) }
  let(:instructions) { ActiveSet::Instructions.new(page: page, size: size) }

  subject { adapter.process }

  context 'when page size is smaller than set size' do
    let(:size) { 1 }

    context 'when on first page' do
      let(:page) { 1 }

      it { expect(subject.pluck(:id)).to eq [foo.id] }
    end

    context 'when on last page' do
      let(:page) { 2 }

      it { expect(subject.pluck(:id)).to eq [bar.id] }
    end

    context 'when on irrational page' do
      let(:page) { 10 }

      it { expect(subject.pluck(:id)).to eq [] }
    end
  end

  context 'when page size is equal to set size' do
    let(:size) { enumerable_set.count }

    context 'when on only page' do
      let(:page) { 1 }

      it { expect(subject.pluck(:id)).to eq [foo.id, bar.id] }
    end

    context 'when on irrational page' do
      let(:page) { 10 }

      it { expect(subject.pluck(:id)).to eq [] }
    end
  end

  context 'when page size is greater than set size' do
    let(:size) { enumerable_set.count + 1 }

    context 'when on only page' do
      let(:page) { 1 }

      it { expect(subject.pluck(:id)).to eq [foo.id, bar.id] }
    end

    context 'when on irrational page' do
      let(:page) { 10 }

      it { expect(subject.pluck(:id)).to eq [] }
    end
  end
end
