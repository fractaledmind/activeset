# frozen_string_literal: true

require 'spec_helper'
require 'ostruct'

module FunctionalApproach
  def call(obj, signal)
    obj.public_send(signal)
  end

  def compare(lhs, op, rhs)
    lhs.send(op, rhs)
  end

  def enumerate(enumerable, signal) #&block
    enumerable.public_send(signal) { |i| yield(i) }
  end

  def comparison(obj, instruction, value)
    operator_re = /\((.*?)\)/
    return compare(obj, '==', value) unless instruction
    operator = instruction[operator_re, 1] || '=='
    instruction = instruction.to_s.sub(operator_re, '') if instruction =~ operator_re
    tokens = instruction.to_s.split('.').reject(&:blank?)

    if tokens.last&.end_with?('*')
      almost_obj = tokens[0..-2].reduce(obj) { |memo, signal| call(memo, signal) }
      signal = tokens.last == '*' ? 'itself' : tokens.last.sub('*', '')
      return compare(call(call(almost_obj, signal), value), operator, true)
    end

    compare(
      tokens.reduce(obj) { |memo, signal| call(memo, signal) },
      operator,
      value
    )
  end

  def parse(obj, instruction, value)
    enumerator_re = /\[(.*?)\]/

    if instruction =~ enumerator_re
      instruction_to_enumerable,
      enumerate_signal,
      enumerate_instruction = instruction.split(enumerator_re)

      enumerable = instruction_to_enumerable.split('.')
                                            .reduce(obj) { |memo, signal| call(memo, signal) }
      enumerate(enumerable, enumerate_signal) { |i| comparison(i, enumerate_instruction, value) }
    else
      comparison(obj, instruction, value)
    end
  end
end

# RSpec.describe 'Filter syntax experiment' do
#   let(:results) { enumerate(set, :select) { |i| parse(i, instruction, value) } }

#   describe 'set of scalar values' do
#     let(:set) { [1, 2, 3] }

#     context '{ itself: 1 }' do
#       let(:instruction) { :itself }
#       let(:value) { 1 }

#       it { expect(results).to eq [1] }
#     end

#     context '{ itself(>): 1 }' do
#       let(:instruction) { 'itself(>)' }
#       let(:value) { 1 }

#       it { expect(results).to eq [2, 3] }
#     end

#     context '{ itself*: :odd? }' do
#       let(:instruction) { 'itself*' }
#       let(:value) { :odd? }

#       it { expect(results).to eq [1, 3] }
#     end
#   end

#   describe 'set of objects with scalar attributes' do
#     let(:one) { OpenStruct.new(i: 1) }
#     let(:two) { OpenStruct.new(i: 2) }
#     let(:three) { OpenStruct.new(i: 3) }
#     let(:set) { [one, two, three] }

#     context '{ i: 1 }' do
#       let(:instruction) { :i }
#       let(:value) { 1 }

#       it { expect(results).to eq [one] }
#     end

#     context '{ i(>): 1 }' do
#       let(:instruction) { 'i(>)' }
#       let(:value) { 1 }

#       it { expect(results).to eq [two, three] }
#     end

#     context '{ i*: :odd? }' do
#       let(:instruction) { 'i*' }
#       let(:value) { :odd? }

#       it { expect(results).to eq [one, three] }
#     end
#   end

#   describe 'set of nested objects with scalar attributes' do
#     let(:one) { OpenStruct.new(o: OpenStruct.new(i: 1)) }
#     let(:two) { OpenStruct.new(o: OpenStruct.new(i: 2)) }
#     let(:three) { OpenStruct.new(o: OpenStruct.new(i: 3)) }
#     let(:set) { [one, two, three] }

#     context '{ o.i: 1 }' do
#       let(:instruction) { 'o.i' }
#       let(:value) { 1 }

#       it { expect(results).to eq [one] }
#     end

#     context '{ o.i(>): 1 }' do
#       let(:instruction) { 'o.i(>)' }
#       let(:value) { 1 }

#       it { expect(results).to eq [two, three] }
#     end

#     context '{ o.i*: :odd? }' do
#       let(:instruction) { 'o.i*' }
#       let(:value) { :odd? }

#       it { expect(results).to eq [one, three] }
#     end
#   end

#   describe 'set of nested objects with to_many association' do
#     let(:odds) { OpenStruct.new(m: [1, 3, 5]) }
#     let(:evens) { OpenStruct.new(m: [2, 4, 6]) }
#     let(:mixed) { OpenStruct.new(m: [1, 2, 3]) }
#     let(:set) { [odds, evens, mixed] }

#     context '{ m[all?]: 1 }' do
#       let(:instruction) { 'm[all?]' }
#       let(:value) { 1 }

#       it { expect(results).to eq [] }
#     end

#     context '{ m[any?]: 1 }' do
#       let(:instruction) { 'm[any?]' }
#       let(:value) { 1 }

#       it { expect(results).to eq [odds, mixed] }
#     end

#     context '{ m[all?]*: :odd? }' do
#       let(:instruction) { 'm[all?]*' }
#       let(:value) { :odd? }

#       it { expect(results).to eq [odds] }
#     end

#     context '{ m[any?]*: :even? }' do
#       let(:instruction) { 'm[any?]*' }
#       let(:value) { :even? }

#       it { expect(results).to eq [evens, mixed] }
#     end

#     context '{ m[any?](>): 4 }' do
#       let(:instruction) { 'm[any?](>)' }
#       let(:value) { 4 }

#       it { expect(results).to eq [odds, evens] }
#     end

#     context '{ m[any?].itself: 1 }' do
#       let(:instruction) { 'm[any?].itself' }
#       let(:value) { 1 }

#       it { expect(results).to eq [odds, mixed] }
#     end

#     context '{ m[any?].itself(>): 5 }' do
#       let(:instruction) { 'm[any?].itself(>)' }
#       let(:value) { 5 }

#       it { expect(results).to eq [evens] }
#     end

#     context '{ m[any?].itself*: :odd? }' do
#       let(:instruction) { 'm[any?].itself*' }
#       let(:value) { :odd? }

#       it { expect(results).to eq [odds, mixed] }
#     end

#     context '{ m[all?].itself*: :odd? }' do
#       let(:instruction) { 'm[all?].itself*' }
#       let(:value) { :odd? }

#       it { expect(results).to eq [odds] }
#     end
#   end
# end
