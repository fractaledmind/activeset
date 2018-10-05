# frozen_string_literal: true

require 'spec_helper'

RSpec.describe '#throws?' do
  it { expect(throws?(StandardError) { raise }).to be true }
  it { expect(throws?(NameError) { raise NameError }).to be true }
  it { expect(throws?(NoMethodError) { raise NameError }).to be false }
  it { expect(throws?(StandardError) { nil }).to be false }
end
