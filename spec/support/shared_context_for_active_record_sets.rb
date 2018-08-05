# frozen_string_literal: true

require 'spec_helper'

RSpec.shared_context 'for active record sets' do
  let!(:foo) do
    FactoryGirl.create(:foo,
      boolean: true,
      assoc: FactoryGirl.create(:assoc, boolean: true)
    )
  end
  let!(:bar) do
    FactoryGirl.create(:foo,
      boolean: false,
      assoc: FactoryGirl.create(:assoc, boolean: false)
    )
  end

  let(:active_record_set) { Foo.all }
end
