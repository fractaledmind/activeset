# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Hash do
  describe '#flatten_keys' do
    context 'with a nested hash' do
      let(:subject) do
        {
          a: 'a',
          b: {
            c: 'c',
            d: {
              e: 'e'
            }
          }
        }
      end
      let(:result) do
        {
          [:a] => 'a',
          %i[b c] => 'c',
          %i[b d e] => 'e'
        }
      end
      it 'returns a flat hash with array keys' do
        expect(subject.flatten_keys).to eq(result)
      end
      it 'does\'t mutate the subject' do
        subject.flatten_keys
        expect(subject).not_to eq(result)
      end
    end
    context 'with an empty hash' do
      let(:subject) do
        {}
      end
      let(:result) do
        {}
      end
      it 'returns a flat hash with array keys' do
        expect(subject.flatten_keys).to eq(result)
      end
    end
    context 'with a flat hash' do
      let(:subject) do
        {
          a: 'a',
          b: 'b'
        }
      end
      let(:result) do
        {
          [:a] => 'a',
          [:b] => 'b'
        }
      end
      it 'returns a flat hash with array keys' do
        expect(subject.flatten_keys).to eq(result)
      end
      it 'does\'t mutate the subject' do
        subject.flatten_keys
        expect(subject).not_to eq(result)
      end
    end
  end

  describe '#flatten_keys!' do
    context 'with a nested hash' do
      let(:subject) do
        {
          a: 'a',
          b: {
            c: 'c',
            d: {
              e: 'e'
            }
          }
        }
      end
      let(:result) do
        {
          [:a] => 'a',
          %i[b c] => 'c',
          %i[b d e] => 'e'
        }
      end
      it 'returns a flat hash with array keys' do
        expect(subject.flatten_keys!).to eq(result)
      end
      it 'does mutate the subject' do
        subject.flatten_keys!
        expect(subject).to eq(result)
      end
    end
    context 'with an empty hash' do
      let(:subject) do
        {}
      end
      let(:result) do
        {}
      end
      it 'returns a flat hash with array keys' do
        expect(subject.flatten_keys!).to eq(result)
      end
    end
    context 'with a flat hash' do
      let(:subject) do
        {
          a: 'a',
          b: 'b'
        }
      end
      let(:result) do
        {
          [:a] => 'a',
          [:b] => 'b'
        }
      end
      it 'returns a flat hash with array keys' do
        expect(subject.flatten_keys!).to eq(result)
      end
      it 'does mutate the subject' do
        subject.flatten_keys!
        expect(subject).to eq(result)
      end
    end
  end
end
