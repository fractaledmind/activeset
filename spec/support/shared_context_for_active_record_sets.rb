# frozen_string_literal: true

require 'spec_helper'

RSpec.shared_context 'for active record sets' do
  let!(:foo) do
    FactoryBot.create(:foo,
      boolean: true,
      assoc: FactoryBot.create(:assoc, boolean: true)
    )
  end
  let!(:bar) do
    FactoryBot.create(:foo,
      boolean: false,
      assoc: FactoryBot.create(:assoc, boolean: false)
    )
  end

  let(:active_record_set) { Foo.all }
end
