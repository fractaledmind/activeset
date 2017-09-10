# frozen_string_literal: true

ActiveRecord::Schema.define do
  create_table :widgets, force: true do |t|
    t.integer     :quantity
    t.string      :color
    t.text        :description
    t.date        :ship_by
    t.boolean     :shipped
    t.references  :customer,    null: false
    t.timestamps                null: false
  end

  create_table :customers, force: true do |t|
    t.string      :name
    t.date        :birthdate
    t.references  :state,       null: false
    t.timestamps                null: false
  end

  create_table :states, force: true do |t|
    t.string      :name
    t.float       :latitude
    t.timestamps                null: false
  end

  create_table :sources, force: true do |t|
    t.string      :name
    t.references  :widget,      null: false
    t.timestamps                null: false
  end
end
