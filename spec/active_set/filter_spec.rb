# frozen_string_literal: true

require 'spec_helper'

RSpec.shared_examples 'a successful filter' do
  it { expect(result.map(&:id)).to eq [matching_item.id] }
end

RSpec.describe ActiveSet do
  before(:all) do
    @foo_1 = FactoryGirl.create(:foo, assoc: FactoryGirl.create(:assoc))
    @foo_2 = FactoryGirl.create(:foo, assoc: FactoryGirl.create(:assoc))
    @active_set = ActiveSet.new(Foo.all)
  end
  after(:all) { Foo.delete_all }

  describe '#filter' do
    let(:result) { @active_set.filter(instructions) }

    context 'with BINARY type' do
      context 'matching @foo_1' do
        let(:matching_item) { @foo_1 }

        context '{ binary: }' do
          let(:instructions) do
            { 'binary': matching_item.binary }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_binary: }' do
          let(:instructions) do
            { 'computed_binary': matching_item.computed_binary }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ binary:, computed_binary: }' do
          let(:instructions) do
            { 'binary': matching_item.binary, 'computed_binary': matching_item.computed_binary }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { binary: } }' do
          let(:instructions) do
            { assoc: { 'binary': matching_item.assoc.binary } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_binary: } }' do
          let(:instructions) do
            { assoc: { 'computed_binary': matching_item.assoc.computed_binary } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { binary:, computed_binary: } }' do
          let(:instructions) do
            { assoc: { 'binary': matching_item.assoc.binary, 'computed_binary': matching_item.assoc.computed_binary } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ binary:, assoc: { binary: } }' do
          let(:instructions) do
            { 'binary': matching_item.binary,
              assoc: { 'binary': matching_item.assoc.binary } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ binary:, assoc: { computed_binary: } }' do
          let(:instructions) do
            { 'binary': matching_item.binary,
              assoc: { 'computed_binary': matching_item.assoc.computed_binary } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_binary:, assoc: { binary: } }' do
          let(:instructions) do
            { 'computed_binary': matching_item.computed_binary,
              assoc: { 'binary': matching_item.assoc.binary } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_binary:, assoc: { computed_binary: } }' do
          let(:instructions) do
            { 'computed_binary': matching_item.computed_binary,
              assoc: { 'computed_binary': matching_item.assoc.computed_binary } }
          end

          it_behaves_like 'a successful filter'
        end
      end

      context 'matching @foo_2' do
        let(:matching_item) { @foo_2 }

        context '{ binary: }' do
          let(:instructions) do
            { 'binary': matching_item.binary }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_binary: }' do
          let(:instructions) do
            { 'computed_binary': matching_item.computed_binary }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ binary:, computed_binary: }' do
          let(:instructions) do
            { 'binary': matching_item.binary, 'computed_binary': matching_item.computed_binary }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { binary: } }' do
          let(:instructions) do
            { assoc: { 'binary': matching_item.assoc.binary } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_binary: } }' do
          let(:instructions) do
            { assoc: { 'computed_binary': matching_item.assoc.computed_binary } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { binary:, computed_binary: } }' do
          let(:instructions) do
            { assoc: { 'binary': matching_item.assoc.binary, 'computed_binary': matching_item.assoc.computed_binary } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ binary:, assoc: { binary: } }' do
          let(:instructions) do
            { 'binary': matching_item.binary,
              assoc: { 'binary': matching_item.assoc.binary } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ binary:, assoc: { computed_binary: } }' do
          let(:instructions) do
            { 'binary': matching_item.binary,
              assoc: { 'computed_binary': matching_item.assoc.computed_binary } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_binary:, assoc: { binary: } }' do
          let(:instructions) do
            { 'computed_binary': matching_item.computed_binary,
              assoc: { 'binary': matching_item.assoc.binary } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_binary:, assoc: { computed_binary: } }' do
          let(:instructions) do
            { 'computed_binary': matching_item.computed_binary,
              assoc: { 'computed_binary': matching_item.assoc.computed_binary } }
          end

          it_behaves_like 'a successful filter'
        end
      end
    end

    context 'with BOOLEAN type' do
      context 'matching @foo_1' do
        let(:matching_item) { @foo_1 }

        context '{ boolean: }' do
          let(:instructions) do
            { 'boolean': matching_item.boolean }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_boolean: }' do
          let(:instructions) do
            { 'computed_boolean': matching_item.computed_boolean }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ boolean:, computed_boolean: }' do
          let(:instructions) do
            { 'boolean': matching_item.boolean, 'computed_boolean': matching_item.computed_boolean }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { boolean: } }' do
          let(:instructions) do
            { assoc: { 'boolean': matching_item.assoc.boolean } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_boolean: } }' do
          let(:instructions) do
            { assoc: { 'computed_boolean': matching_item.assoc.computed_boolean } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { boolean:, computed_boolean: } }' do
          let(:instructions) do
            { assoc: { 'boolean': matching_item.assoc.boolean, 'computed_boolean': matching_item.assoc.computed_boolean } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ boolean:, assoc: { boolean: } }' do
          let(:instructions) do
            { 'boolean': matching_item.boolean,
              assoc: { 'boolean': matching_item.assoc.boolean } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ boolean:, assoc: { computed_boolean: } }' do
          let(:instructions) do
            { 'boolean': matching_item.boolean,
              assoc: { 'computed_boolean': matching_item.assoc.computed_boolean } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_boolean:, assoc: { boolean: } }' do
          let(:instructions) do
            { 'computed_boolean': matching_item.computed_boolean,
              assoc: { 'boolean': matching_item.assoc.boolean } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_boolean:, assoc: { computed_boolean: } }' do
          let(:instructions) do
            { 'computed_boolean': matching_item.computed_boolean,
              assoc: { 'computed_boolean': matching_item.assoc.computed_boolean } }
          end

          it_behaves_like 'a successful filter'
        end
      end

      context 'matching @foo_2' do
        let(:matching_item) { @foo_2 }

        context '{ boolean: }' do
          let(:instructions) do
            { 'boolean': matching_item.boolean }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_boolean: }' do
          let(:instructions) do
            { 'computed_boolean': matching_item.computed_boolean }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ boolean:, computed_boolean: }' do
          let(:instructions) do
            { 'boolean': matching_item.boolean, 'computed_boolean': matching_item.computed_boolean }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { boolean: } }' do
          let(:instructions) do
            { assoc: { 'boolean': matching_item.assoc.boolean } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_boolean: } }' do
          let(:instructions) do
            { assoc: { 'computed_boolean': matching_item.assoc.computed_boolean } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { boolean:, computed_boolean: } }' do
          let(:instructions) do
            { assoc: { 'boolean': matching_item.assoc.boolean, 'computed_boolean': matching_item.assoc.computed_boolean } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ boolean:, assoc: { boolean: } }' do
          let(:instructions) do
            { 'boolean': matching_item.boolean,
              assoc: { 'boolean': matching_item.assoc.boolean } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ boolean:, assoc: { computed_boolean: } }' do
          let(:instructions) do
            { 'boolean': matching_item.boolean,
              assoc: { 'computed_boolean': matching_item.assoc.computed_boolean } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_boolean:, assoc: { boolean: } }' do
          let(:instructions) do
            { 'computed_boolean': matching_item.computed_boolean,
              assoc: { 'boolean': matching_item.assoc.boolean } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_boolean:, assoc: { computed_boolean: } }' do
          let(:instructions) do
            { 'computed_boolean': matching_item.computed_boolean,
              assoc: { 'computed_boolean': matching_item.assoc.computed_boolean } }
          end

          it_behaves_like 'a successful filter'
        end
      end
    end

    context 'with DATE type' do
      context 'matching @foo_1' do
        let(:matching_item) { @foo_1 }

        context '{ date: }' do
          let(:instructions) do
            { 'date': matching_item.date }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_date: }' do
          let(:instructions) do
            { 'computed_date': matching_item.computed_date }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ date:, computed_date: }' do
          let(:instructions) do
            { 'date': matching_item.date, 'computed_date': matching_item.computed_date }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { date: } }' do
          let(:instructions) do
            { assoc: { 'date': matching_item.assoc.date } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_date: } }' do
          let(:instructions) do
            { assoc: { 'computed_date': matching_item.assoc.computed_date } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { date:, computed_date: } }' do
          let(:instructions) do
            { assoc: { 'date': matching_item.assoc.date, 'computed_date': matching_item.assoc.computed_date } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ date:, assoc: { date: } }' do
          let(:instructions) do
            { 'date': matching_item.date,
              assoc: { 'date': matching_item.assoc.date } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ date:, assoc: { computed_date: } }' do
          let(:instructions) do
            { 'date': matching_item.date,
              assoc: { 'computed_date': matching_item.assoc.computed_date } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_date:, assoc: { date: } }' do
          let(:instructions) do
            { 'computed_date': matching_item.computed_date,
              assoc: { 'date': matching_item.assoc.date } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_date:, assoc: { computed_date: } }' do
          let(:instructions) do
            { 'computed_date': matching_item.computed_date,
              assoc: { 'computed_date': matching_item.assoc.computed_date } }
          end

          it_behaves_like 'a successful filter'
        end
      end

      context 'matching @foo_2' do
        let(:matching_item) { @foo_2 }

        context '{ date: }' do
          let(:instructions) do
            { 'date': matching_item.date }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_date: }' do
          let(:instructions) do
            { 'computed_date': matching_item.computed_date }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ date:, computed_date: }' do
          let(:instructions) do
            { 'date': matching_item.date, 'computed_date': matching_item.computed_date }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { date: } }' do
          let(:instructions) do
            { assoc: { 'date': matching_item.assoc.date } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_date: } }' do
          let(:instructions) do
            { assoc: { 'computed_date': matching_item.assoc.computed_date } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { date:, computed_date: } }' do
          let(:instructions) do
            { assoc: { 'date': matching_item.assoc.date, 'computed_date': matching_item.assoc.computed_date } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ date:, assoc: { date: } }' do
          let(:instructions) do
            { 'date': matching_item.date,
              assoc: { 'date': matching_item.assoc.date } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ date:, assoc: { computed_date: } }' do
          let(:instructions) do
            { 'date': matching_item.date,
              assoc: { 'computed_date': matching_item.assoc.computed_date } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_date:, assoc: { date: } }' do
          let(:instructions) do
            { 'computed_date': matching_item.computed_date,
              assoc: { 'date': matching_item.assoc.date } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_date:, assoc: { computed_date: } }' do
          let(:instructions) do
            { 'computed_date': matching_item.computed_date,
              assoc: { 'computed_date': matching_item.assoc.computed_date } }
          end

          it_behaves_like 'a successful filter'
        end
      end
    end

    context 'with DATETIME type' do
      context 'matching @foo_1' do
        let(:matching_item) { @foo_1 }

        context '{ datetime: }' do
          let(:instructions) do
            { 'datetime': matching_item.datetime }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_datetime: }' do
          let(:instructions) do
            { 'computed_datetime': matching_item.computed_datetime }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ datetime:, computed_datetime: }' do
          let(:instructions) do
            { 'datetime': matching_item.datetime, 'computed_datetime': matching_item.computed_datetime }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { datetime: } }' do
          let(:instructions) do
            { assoc: { 'datetime': matching_item.assoc.datetime } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_datetime: } }' do
          let(:instructions) do
            { assoc: { 'computed_datetime': matching_item.assoc.computed_datetime } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { datetime:, computed_datetime: } }' do
          let(:instructions) do
            { assoc: { 'datetime': matching_item.assoc.datetime, 'computed_datetime': matching_item.assoc.computed_datetime } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ datetime:, assoc: { datetime: } }' do
          let(:instructions) do
            { 'datetime': matching_item.datetime,
              assoc: { 'datetime': matching_item.assoc.datetime } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ datetime:, assoc: { computed_datetime: } }' do
          let(:instructions) do
            { 'datetime': matching_item.datetime,
              assoc: { 'computed_datetime': matching_item.assoc.computed_datetime } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_datetime:, assoc: { datetime: } }' do
          let(:instructions) do
            { 'computed_datetime': matching_item.computed_datetime,
              assoc: { 'datetime': matching_item.assoc.datetime } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_datetime:, assoc: { computed_datetime: } }' do
          let(:instructions) do
            { 'computed_datetime': matching_item.computed_datetime,
              assoc: { 'computed_datetime': matching_item.assoc.computed_datetime } }
          end

          it_behaves_like 'a successful filter'
        end
      end

      context 'matching @foo_2' do
        let(:matching_item) { @foo_2 }

        context '{ datetime: }' do
          let(:instructions) do
            { 'datetime': matching_item.datetime }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_datetime: }' do
          let(:instructions) do
            { 'computed_datetime': matching_item.computed_datetime }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ datetime:, computed_datetime: }' do
          let(:instructions) do
            { 'datetime': matching_item.datetime, 'computed_datetime': matching_item.computed_datetime }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { datetime: } }' do
          let(:instructions) do
            { assoc: { 'datetime': matching_item.assoc.datetime } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_datetime: } }' do
          let(:instructions) do
            { assoc: { 'computed_datetime': matching_item.assoc.computed_datetime } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { datetime:, computed_datetime: } }' do
          let(:instructions) do
            { assoc: { 'datetime': matching_item.assoc.datetime, 'computed_datetime': matching_item.assoc.computed_datetime } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ datetime:, assoc: { datetime: } }' do
          let(:instructions) do
            { 'datetime': matching_item.datetime,
              assoc: { 'datetime': matching_item.assoc.datetime } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ datetime:, assoc: { computed_datetime: } }' do
          let(:instructions) do
            { 'datetime': matching_item.datetime,
              assoc: { 'computed_datetime': matching_item.assoc.computed_datetime } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_datetime:, assoc: { datetime: } }' do
          let(:instructions) do
            { 'computed_datetime': matching_item.computed_datetime,
              assoc: { 'datetime': matching_item.assoc.datetime } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_datetime:, assoc: { computed_datetime: } }' do
          let(:instructions) do
            { 'computed_datetime': matching_item.computed_datetime,
              assoc: { 'computed_datetime': matching_item.assoc.computed_datetime } }
          end

          it_behaves_like 'a successful filter'
        end
      end
    end

    context 'with DECIMAL type' do
      context 'matching @foo_1' do
        let(:matching_item) { @foo_1 }

        context '{ decimal: }' do
          let(:instructions) do
            { 'decimal': matching_item.decimal }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_decimal: }' do
          let(:instructions) do
            { 'computed_decimal': matching_item.computed_decimal }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ decimal:, computed_decimal: }' do
          let(:instructions) do
            { 'decimal': matching_item.decimal, 'computed_decimal': matching_item.computed_decimal }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { decimal: } }' do
          let(:instructions) do
            { assoc: { 'decimal': matching_item.assoc.decimal } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_decimal: } }' do
          let(:instructions) do
            { assoc: { 'computed_decimal': matching_item.assoc.computed_decimal } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { decimal:, computed_decimal: } }' do
          let(:instructions) do
            { assoc: { 'decimal': matching_item.assoc.decimal, 'computed_decimal': matching_item.assoc.computed_decimal } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ decimal:, assoc: { decimal: } }' do
          let(:instructions) do
            { 'decimal': matching_item.decimal,
              assoc: { 'decimal': matching_item.assoc.decimal } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ decimal:, assoc: { computed_decimal: } }' do
          let(:instructions) do
            { 'decimal': matching_item.decimal,
              assoc: { 'computed_decimal': matching_item.assoc.computed_decimal } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_decimal:, assoc: { decimal: } }' do
          let(:instructions) do
            { 'computed_decimal': matching_item.computed_decimal,
              assoc: { 'decimal': matching_item.assoc.decimal } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_decimal:, assoc: { computed_decimal: } }' do
          let(:instructions) do
            { 'computed_decimal': matching_item.computed_decimal,
              assoc: { 'computed_decimal': matching_item.assoc.computed_decimal } }
          end

          it_behaves_like 'a successful filter'
        end
      end

      context 'matching @foo_2' do
        let(:matching_item) { @foo_2 }

        context '{ decimal: }' do
          let(:instructions) do
            { 'decimal': matching_item.decimal }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_decimal: }' do
          let(:instructions) do
            { 'computed_decimal': matching_item.computed_decimal }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ decimal:, computed_decimal: }' do
          let(:instructions) do
            { 'decimal': matching_item.decimal, 'computed_decimal': matching_item.computed_decimal }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { decimal: } }' do
          let(:instructions) do
            { assoc: { 'decimal': matching_item.assoc.decimal } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_decimal: } }' do
          let(:instructions) do
            { assoc: { 'computed_decimal': matching_item.assoc.computed_decimal } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { decimal:, computed_decimal: } }' do
          let(:instructions) do
            { assoc: { 'decimal': matching_item.assoc.decimal, 'computed_decimal': matching_item.assoc.computed_decimal } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ decimal:, assoc: { decimal: } }' do
          let(:instructions) do
            { 'decimal': matching_item.decimal,
              assoc: { 'decimal': matching_item.assoc.decimal } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ decimal:, assoc: { computed_decimal: } }' do
          let(:instructions) do
            { 'decimal': matching_item.decimal,
              assoc: { 'computed_decimal': matching_item.assoc.computed_decimal } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_decimal:, assoc: { decimal: } }' do
          let(:instructions) do
            { 'computed_decimal': matching_item.computed_decimal,
              assoc: { 'decimal': matching_item.assoc.decimal } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_decimal:, assoc: { computed_decimal: } }' do
          let(:instructions) do
            { 'computed_decimal': matching_item.computed_decimal,
              assoc: { 'computed_decimal': matching_item.assoc.computed_decimal } }
          end

          it_behaves_like 'a successful filter'
        end
      end
    end

    context 'with FLOAT type' do
      context 'matching @foo_1' do
        let(:matching_item) { @foo_1 }

        context '{ float: }' do
          let(:instructions) do
            { 'float': matching_item.float }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_float: }' do
          let(:instructions) do
            { 'computed_float': matching_item.computed_float }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ float:, computed_float: }' do
          let(:instructions) do
            { 'float': matching_item.float, 'computed_float': matching_item.computed_float }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { float: } }' do
          let(:instructions) do
            { assoc: { 'float': matching_item.assoc.float } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_float: } }' do
          let(:instructions) do
            { assoc: { 'computed_float': matching_item.assoc.computed_float } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { float:, computed_float: } }' do
          let(:instructions) do
            { assoc: { 'float': matching_item.assoc.float, 'computed_float': matching_item.assoc.computed_float } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ float:, assoc: { float: } }' do
          let(:instructions) do
            { 'float': matching_item.float,
              assoc: { 'float': matching_item.assoc.float } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ float:, assoc: { computed_float: } }' do
          let(:instructions) do
            { 'float': matching_item.float,
              assoc: { 'computed_float': matching_item.assoc.computed_float } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_float:, assoc: { float: } }' do
          let(:instructions) do
            { 'computed_float': matching_item.computed_float,
              assoc: { 'float': matching_item.assoc.float } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_float:, assoc: { computed_float: } }' do
          let(:instructions) do
            { 'computed_float': matching_item.computed_float,
              assoc: { 'computed_float': matching_item.assoc.computed_float } }
          end

          it_behaves_like 'a successful filter'
        end
      end

      context 'matching @foo_2' do
        let(:matching_item) { @foo_2 }

        context '{ float: }' do
          let(:instructions) do
            { 'float': matching_item.float }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_float: }' do
          let(:instructions) do
            { 'computed_float': matching_item.computed_float }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ float:, computed_float: }' do
          let(:instructions) do
            { 'float': matching_item.float, 'computed_float': matching_item.computed_float }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { float: } }' do
          let(:instructions) do
            { assoc: { 'float': matching_item.assoc.float } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_float: } }' do
          let(:instructions) do
            { assoc: { 'computed_float': matching_item.assoc.computed_float } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { float:, computed_float: } }' do
          let(:instructions) do
            { assoc: { 'float': matching_item.assoc.float, 'computed_float': matching_item.assoc.computed_float } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ float:, assoc: { float: } }' do
          let(:instructions) do
            { 'float': matching_item.float,
              assoc: { 'float': matching_item.assoc.float } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ float:, assoc: { computed_float: } }' do
          let(:instructions) do
            { 'float': matching_item.float,
              assoc: { 'computed_float': matching_item.assoc.computed_float } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_float:, assoc: { float: } }' do
          let(:instructions) do
            { 'computed_float': matching_item.computed_float,
              assoc: { 'float': matching_item.assoc.float } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_float:, assoc: { computed_float: } }' do
          let(:instructions) do
            { 'computed_float': matching_item.computed_float,
              assoc: { 'computed_float': matching_item.assoc.computed_float } }
          end

          it_behaves_like 'a successful filter'
        end
      end
    end

    context 'with INTEGER type' do
      context 'matching @foo_1' do
        let(:matching_item) { @foo_1 }

        context '{ integer: }' do
          let(:instructions) do
            { 'integer': matching_item.integer }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_integer: }' do
          let(:instructions) do
            { 'computed_integer': matching_item.computed_integer }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ integer:, computed_integer: }' do
          let(:instructions) do
            { 'integer': matching_item.integer, 'computed_integer': matching_item.computed_integer }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { integer: } }' do
          let(:instructions) do
            { assoc: { 'integer': matching_item.assoc.integer } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_integer: } }' do
          let(:instructions) do
            { assoc: { 'computed_integer': matching_item.assoc.computed_integer } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { integer:, computed_integer: } }' do
          let(:instructions) do
            { assoc: { 'integer': matching_item.assoc.integer, 'computed_integer': matching_item.assoc.computed_integer } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ integer:, assoc: { integer: } }' do
          let(:instructions) do
            { 'integer': matching_item.integer,
              assoc: { 'integer': matching_item.assoc.integer } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ integer:, assoc: { computed_integer: } }' do
          let(:instructions) do
            { 'integer': matching_item.integer,
              assoc: { 'computed_integer': matching_item.assoc.computed_integer } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_integer:, assoc: { integer: } }' do
          let(:instructions) do
            { 'computed_integer': matching_item.computed_integer,
              assoc: { 'integer': matching_item.assoc.integer } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_integer:, assoc: { computed_integer: } }' do
          let(:instructions) do
            { 'computed_integer': matching_item.computed_integer,
              assoc: { 'computed_integer': matching_item.assoc.computed_integer } }
          end

          it_behaves_like 'a successful filter'
        end
      end

      context 'matching @foo_2' do
        let(:matching_item) { @foo_2 }

        context '{ integer: }' do
          let(:instructions) do
            { 'integer': matching_item.integer }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_integer: }' do
          let(:instructions) do
            { 'computed_integer': matching_item.computed_integer }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ integer:, computed_integer: }' do
          let(:instructions) do
            { 'integer': matching_item.integer, 'computed_integer': matching_item.computed_integer }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { integer: } }' do
          let(:instructions) do
            { assoc: { 'integer': matching_item.assoc.integer } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_integer: } }' do
          let(:instructions) do
            { assoc: { 'computed_integer': matching_item.assoc.computed_integer } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { integer:, computed_integer: } }' do
          let(:instructions) do
            { assoc: { 'integer': matching_item.assoc.integer, 'computed_integer': matching_item.assoc.computed_integer } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ integer:, assoc: { integer: } }' do
          let(:instructions) do
            { 'integer': matching_item.integer,
              assoc: { 'integer': matching_item.assoc.integer } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ integer:, assoc: { computed_integer: } }' do
          let(:instructions) do
            { 'integer': matching_item.integer,
              assoc: { 'computed_integer': matching_item.assoc.computed_integer } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_integer:, assoc: { integer: } }' do
          let(:instructions) do
            { 'computed_integer': matching_item.computed_integer,
              assoc: { 'integer': matching_item.assoc.integer } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_integer:, assoc: { computed_integer: } }' do
          let(:instructions) do
            { 'computed_integer': matching_item.computed_integer,
              assoc: { 'computed_integer': matching_item.assoc.computed_integer } }
          end

          it_behaves_like 'a successful filter'
        end
      end
    end

    context 'with STRING type' do
      context 'matching @foo_1' do
        let(:matching_item) { @foo_1 }

        context '{ string: }' do
          let(:instructions) do
            { 'string': matching_item.string }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_string: }' do
          let(:instructions) do
            { 'computed_string': matching_item.computed_string }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ string:, computed_string: }' do
          let(:instructions) do
            { 'string': matching_item.string, 'computed_string': matching_item.computed_string }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { string: } }' do
          let(:instructions) do
            { assoc: { 'string': matching_item.assoc.string } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_string: } }' do
          let(:instructions) do
            { assoc: { 'computed_string': matching_item.assoc.computed_string } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { string:, computed_string: } }' do
          let(:instructions) do
            { assoc: { 'string': matching_item.assoc.string, 'computed_string': matching_item.assoc.computed_string } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ string:, assoc: { string: } }' do
          let(:instructions) do
            { 'string': matching_item.string,
              assoc: { 'string': matching_item.assoc.string } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ string:, assoc: { computed_string: } }' do
          let(:instructions) do
            { 'string': matching_item.string,
              assoc: { 'computed_string': matching_item.assoc.computed_string } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_string:, assoc: { string: } }' do
          let(:instructions) do
            { 'computed_string': matching_item.computed_string,
              assoc: { 'string': matching_item.assoc.string } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_string:, assoc: { computed_string: } }' do
          let(:instructions) do
            { 'computed_string': matching_item.computed_string,
              assoc: { 'computed_string': matching_item.assoc.computed_string } }
          end

          it_behaves_like 'a successful filter'
        end
      end

      context 'matching @foo_2' do
        let(:matching_item) { @foo_2 }

        context '{ string: }' do
          let(:instructions) do
            { 'string': matching_item.string }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_string: }' do
          let(:instructions) do
            { 'computed_string': matching_item.computed_string }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ string:, computed_string: }' do
          let(:instructions) do
            { 'string': matching_item.string, 'computed_string': matching_item.computed_string }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { string: } }' do
          let(:instructions) do
            { assoc: { 'string': matching_item.assoc.string } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_string: } }' do
          let(:instructions) do
            { assoc: { 'computed_string': matching_item.assoc.computed_string } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { string:, computed_string: } }' do
          let(:instructions) do
            { assoc: { 'string': matching_item.assoc.string, 'computed_string': matching_item.assoc.computed_string } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ string:, assoc: { string: } }' do
          let(:instructions) do
            { 'string': matching_item.string,
              assoc: { 'string': matching_item.assoc.string } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ string:, assoc: { computed_string: } }' do
          let(:instructions) do
            { 'string': matching_item.string,
              assoc: { 'computed_string': matching_item.assoc.computed_string } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_string:, assoc: { string: } }' do
          let(:instructions) do
            { 'computed_string': matching_item.computed_string,
              assoc: { 'string': matching_item.assoc.string } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_string:, assoc: { computed_string: } }' do
          let(:instructions) do
            { 'computed_string': matching_item.computed_string,
              assoc: { 'computed_string': matching_item.assoc.computed_string } }
          end

          it_behaves_like 'a successful filter'
        end
      end
    end

    context 'with TEXT type' do
      context 'matching @foo_1' do
        let(:matching_item) { @foo_1 }

        context '{ text: }' do
          let(:instructions) do
            { 'text': matching_item.text }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_text: }' do
          let(:instructions) do
            { 'computed_text': matching_item.computed_text }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ text:, computed_text: }' do
          let(:instructions) do
            { 'text': matching_item.text, 'computed_text': matching_item.computed_text }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { text: } }' do
          let(:instructions) do
            { assoc: { 'text': matching_item.assoc.text } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_text: } }' do
          let(:instructions) do
            { assoc: { 'computed_text': matching_item.assoc.computed_text } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { text:, computed_text: } }' do
          let(:instructions) do
            { assoc: { 'text': matching_item.assoc.text, 'computed_text': matching_item.assoc.computed_text } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ text:, assoc: { text: } }' do
          let(:instructions) do
            { 'text': matching_item.text,
              assoc: { 'text': matching_item.assoc.text } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ text:, assoc: { computed_text: } }' do
          let(:instructions) do
            { 'text': matching_item.text,
              assoc: { 'computed_text': matching_item.assoc.computed_text } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_text:, assoc: { text: } }' do
          let(:instructions) do
            { 'computed_text': matching_item.computed_text,
              assoc: { 'text': matching_item.assoc.text } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_text:, assoc: { computed_text: } }' do
          let(:instructions) do
            { 'computed_text': matching_item.computed_text,
              assoc: { 'computed_text': matching_item.assoc.computed_text } }
          end

          it_behaves_like 'a successful filter'
        end
      end

      context 'matching @foo_2' do
        let(:matching_item) { @foo_2 }

        context '{ text: }' do
          let(:instructions) do
            { 'text': matching_item.text }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_text: }' do
          let(:instructions) do
            { 'computed_text': matching_item.computed_text }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ text:, computed_text: }' do
          let(:instructions) do
            { 'text': matching_item.text, 'computed_text': matching_item.computed_text }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { text: } }' do
          let(:instructions) do
            { assoc: { 'text': matching_item.assoc.text } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_text: } }' do
          let(:instructions) do
            { assoc: { 'computed_text': matching_item.assoc.computed_text } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { text:, computed_text: } }' do
          let(:instructions) do
            { assoc: { 'text': matching_item.assoc.text, 'computed_text': matching_item.assoc.computed_text } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ text:, assoc: { text: } }' do
          let(:instructions) do
            { 'text': matching_item.text,
              assoc: { 'text': matching_item.assoc.text } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ text:, assoc: { computed_text: } }' do
          let(:instructions) do
            { 'text': matching_item.text,
              assoc: { 'computed_text': matching_item.assoc.computed_text } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_text:, assoc: { text: } }' do
          let(:instructions) do
            { 'computed_text': matching_item.computed_text,
              assoc: { 'text': matching_item.assoc.text } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_text:, assoc: { computed_text: } }' do
          let(:instructions) do
            { 'computed_text': matching_item.computed_text,
              assoc: { 'computed_text': matching_item.assoc.computed_text } }
          end

          it_behaves_like 'a successful filter'
        end
      end
    end

    context 'with TIME type' do
      context 'matching @foo_1' do
        let(:matching_item) { @foo_1 }

        context '{ time: }' do
          let(:instructions) do
            { 'time': matching_item.time }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_time: }' do
          let(:instructions) do
            { 'computed_time': matching_item.computed_time }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ time:, computed_time: }' do
          let(:instructions) do
            { 'time': matching_item.time, 'computed_time': matching_item.computed_time }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { time: } }' do
          let(:instructions) do
            { assoc: { 'time': matching_item.assoc.time } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_time: } }' do
          let(:instructions) do
            { assoc: { 'computed_time': matching_item.assoc.computed_time } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { time:, computed_time: } }' do
          let(:instructions) do
            { assoc: { 'time': matching_item.assoc.time, 'computed_time': matching_item.assoc.computed_time } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ time:, assoc: { time: } }' do
          let(:instructions) do
            { 'time': matching_item.time,
              assoc: { 'time': matching_item.assoc.time } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ time:, assoc: { computed_time: } }' do
          let(:instructions) do
            { 'time': matching_item.time,
              assoc: { 'computed_time': matching_item.assoc.computed_time } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_time:, assoc: { time: } }' do
          let(:instructions) do
            { 'computed_time': matching_item.computed_time,
              assoc: { 'time': matching_item.assoc.time } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_time:, assoc: { computed_time: } }' do
          let(:instructions) do
            { 'computed_time': matching_item.computed_time,
              assoc: { 'computed_time': matching_item.assoc.computed_time } }
          end

          it_behaves_like 'a successful filter'
        end
      end

      context 'matching @foo_2' do
        let(:matching_item) { @foo_2 }

        context '{ time: }' do
          let(:instructions) do
            { 'time': matching_item.time }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_time: }' do
          let(:instructions) do
            { 'computed_time': matching_item.computed_time }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ time:, computed_time: }' do
          let(:instructions) do
            { 'time': matching_item.time, 'computed_time': matching_item.computed_time }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { time: } }' do
          let(:instructions) do
            { assoc: { 'time': matching_item.assoc.time } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_time: } }' do
          let(:instructions) do
            { assoc: { 'computed_time': matching_item.assoc.computed_time } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { time:, computed_time: } }' do
          let(:instructions) do
            { assoc: { 'time': matching_item.assoc.time, 'computed_time': matching_item.assoc.computed_time } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ time:, assoc: { time: } }' do
          let(:instructions) do
            { 'time': matching_item.time,
              assoc: { 'time': matching_item.assoc.time } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ time:, assoc: { computed_time: } }' do
          let(:instructions) do
            { 'time': matching_item.time,
              assoc: { 'computed_time': matching_item.assoc.computed_time } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_time:, assoc: { time: } }' do
          let(:instructions) do
            { 'computed_time': matching_item.computed_time,
              assoc: { 'time': matching_item.assoc.time } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_time:, assoc: { computed_time: } }' do
          let(:instructions) do
            { 'computed_time': matching_item.computed_time,
              assoc: { 'computed_time': matching_item.assoc.computed_time } }
          end

          it_behaves_like 'a successful filter'
        end
      end
    end

    # --------------------------------------------------------------------------

    context 'with BINARY and BOOLEAN type' do
      context 'matching @foo_1' do
        let(:matching_item) { @foo_1 }

        context '{ binary:, boolean: }' do
          let(:instructions) do
            { 'binary': matching_item.binary, 'boolean': matching_item.boolean }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_binary:, computed_boolean: }' do
          let(:instructions) do
            { 'computed_binary': matching_item.computed_binary, 'computed_boolean': matching_item.computed_boolean }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ binary:, computed_boolean: }' do
          let(:instructions) do
            { 'binary': matching_item.binary, 'computed_boolean': matching_item.computed_boolean }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_binary:, boolean: }' do
          let(:instructions) do
            { 'computed_binary': matching_item.computed_binary, 'boolean': matching_item.boolean }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { binary:, boolean: } }' do
          let(:instructions) do
            { assoc: { 'binary': matching_item.assoc.binary, 'boolean': matching_item.assoc.boolean } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_binary:, computed_boolean: } }' do
          let(:instructions) do
            { assoc: { 'computed_binary': matching_item.assoc.computed_binary, 'computed_boolean': matching_item.assoc.computed_boolean } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { binary:, computed_boolean: } }' do
          let(:instructions) do
            { assoc: { 'binary': matching_item.assoc.binary, 'computed_boolean': matching_item.assoc.computed_boolean } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_binary:, boolean: } }' do
          let(:instructions) do
            { assoc: { 'computed_binary': matching_item.assoc.computed_binary, 'boolean': matching_item.assoc.boolean } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ binary:, assoc: { boolean: } }' do
          let(:instructions) do
            { 'binary': matching_item.binary, assoc: { 'boolean': matching_item.assoc.boolean } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { binary: }, boolean: }' do
          let(:instructions) do
            { assoc: { 'binary': matching_item.assoc.binary }, 'boolean': matching_item.boolean }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ binary:, assoc: { computed_boolean: } }' do
          let(:instructions) do
            { 'binary': matching_item.binary, assoc: { 'computed_boolean': matching_item.assoc.computed_boolean } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { binary: }, computed_boolean: }' do
          let(:instructions) do
            { assoc: { 'binary': matching_item.assoc.binary }, 'computed_boolean': matching_item.computed_boolean }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_binary:, assoc: { boolean: } }' do
          let(:instructions) do
            { 'computed_binary': matching_item.computed_binary, assoc: { 'boolean': matching_item.assoc.boolean } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_binary: }, boolean: }' do
          let(:instructions) do
            { assoc: { 'computed_binary': matching_item.assoc.computed_binary }, 'boolean': matching_item.boolean }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_binary:, assoc: { computed_boolean: } }' do
          let(:instructions) do
            { 'computed_binary': matching_item.computed_binary, assoc: { 'computed_boolean': matching_item.assoc.computed_boolean } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_binary: }, computed_boolean: }' do
          let(:instructions) do
            { assoc: { 'computed_binary': matching_item.assoc.computed_binary }, 'computed_boolean': matching_item.computed_boolean }
          end

          it_behaves_like 'a successful filter'
        end
      end

      context 'matching @foo_2' do
        let(:matching_item) { @foo_2 }

        context '{ binary:, boolean: }' do
          let(:instructions) do
            { 'binary': matching_item.binary, 'boolean': matching_item.boolean }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_binary:, computed_boolean: }' do
          let(:instructions) do
            { 'computed_binary': matching_item.computed_binary, 'computed_boolean': matching_item.computed_boolean }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ binary:, computed_boolean: }' do
          let(:instructions) do
            { 'binary': matching_item.binary, 'computed_boolean': matching_item.computed_boolean }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_binary:, boolean: }' do
          let(:instructions) do
            { 'computed_binary': matching_item.computed_binary, 'boolean': matching_item.boolean }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { binary:, boolean: } }' do
          let(:instructions) do
            { assoc: { 'binary': matching_item.assoc.binary, 'boolean': matching_item.assoc.boolean } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_binary:, computed_boolean: } }' do
          let(:instructions) do
            { assoc: { 'computed_binary': matching_item.assoc.computed_binary, 'computed_boolean': matching_item.assoc.computed_boolean } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { binary:, computed_boolean: } }' do
          let(:instructions) do
            { assoc: { 'binary': matching_item.assoc.binary, 'computed_boolean': matching_item.assoc.computed_boolean } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_binary:, boolean: } }' do
          let(:instructions) do
            { assoc: { 'computed_binary': matching_item.assoc.computed_binary, 'boolean': matching_item.assoc.boolean } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ binary:, assoc: { boolean: } }' do
          let(:instructions) do
            { 'binary': matching_item.binary, assoc: { 'boolean': matching_item.assoc.boolean } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { binary: }, boolean: }' do
          let(:instructions) do
            { assoc: { 'binary': matching_item.assoc.binary }, 'boolean': matching_item.boolean }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ binary:, assoc: { computed_boolean: } }' do
          let(:instructions) do
            { 'binary': matching_item.binary, assoc: { 'computed_boolean': matching_item.assoc.computed_boolean } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { binary: }, computed_boolean: }' do
          let(:instructions) do
            { assoc: { 'binary': matching_item.assoc.binary }, 'computed_boolean': matching_item.computed_boolean }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_binary:, assoc: { boolean: } }' do
          let(:instructions) do
            { 'computed_binary': matching_item.computed_binary, assoc: { 'boolean': matching_item.assoc.boolean } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_binary: }, boolean: }' do
          let(:instructions) do
            { assoc: { 'computed_binary': matching_item.assoc.computed_binary }, 'boolean': matching_item.boolean }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_binary:, assoc: { computed_boolean: } }' do
          let(:instructions) do
            { 'computed_binary': matching_item.computed_binary, assoc: { 'computed_boolean': matching_item.assoc.computed_boolean } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_binary: }, computed_boolean: }' do
          let(:instructions) do
            { assoc: { 'computed_binary': matching_item.assoc.computed_binary }, 'computed_boolean': matching_item.computed_boolean }
          end

          it_behaves_like 'a successful filter'
        end
      end
    end

    context 'with BINARY and DATE type' do
      context 'matching @foo_1' do
        let(:matching_item) { @foo_1 }

        context '{ binary:, date: }' do
          let(:instructions) do
            { 'binary': matching_item.binary, 'date': matching_item.date }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_binary:, computed_date: }' do
          let(:instructions) do
            { 'computed_binary': matching_item.computed_binary, 'computed_date': matching_item.computed_date }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ binary:, computed_date: }' do
          let(:instructions) do
            { 'binary': matching_item.binary, 'computed_date': matching_item.computed_date }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_binary:, date: }' do
          let(:instructions) do
            { 'computed_binary': matching_item.computed_binary, 'date': matching_item.date }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { binary:, date: } }' do
          let(:instructions) do
            { assoc: { 'binary': matching_item.assoc.binary, 'date': matching_item.assoc.date } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_binary:, computed_date: } }' do
          let(:instructions) do
            { assoc: { 'computed_binary': matching_item.assoc.computed_binary, 'computed_date': matching_item.assoc.computed_date } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { binary:, computed_date: } }' do
          let(:instructions) do
            { assoc: { 'binary': matching_item.assoc.binary, 'computed_date': matching_item.assoc.computed_date } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_binary:, date: } }' do
          let(:instructions) do
            { assoc: { 'computed_binary': matching_item.assoc.computed_binary, 'date': matching_item.assoc.date } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ binary:, assoc: { date: } }' do
          let(:instructions) do
            { 'binary': matching_item.binary, assoc: { 'date': matching_item.assoc.date } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { binary: }, date: }' do
          let(:instructions) do
            { assoc: { 'binary': matching_item.assoc.binary }, 'date': matching_item.date }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ binary:, assoc: { computed_date: } }' do
          let(:instructions) do
            { 'binary': matching_item.binary, assoc: { 'computed_date': matching_item.assoc.computed_date } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { binary: }, computed_date: }' do
          let(:instructions) do
            { assoc: { 'binary': matching_item.assoc.binary }, 'computed_date': matching_item.computed_date }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_binary:, assoc: { date: } }' do
          let(:instructions) do
            { 'computed_binary': matching_item.computed_binary, assoc: { 'date': matching_item.assoc.date } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_binary: }, date: }' do
          let(:instructions) do
            { assoc: { 'computed_binary': matching_item.assoc.computed_binary }, 'date': matching_item.date }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_binary:, assoc: { computed_date: } }' do
          let(:instructions) do
            { 'computed_binary': matching_item.computed_binary, assoc: { 'computed_date': matching_item.assoc.computed_date } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_binary: }, computed_date: }' do
          let(:instructions) do
            { assoc: { 'computed_binary': matching_item.assoc.computed_binary }, 'computed_date': matching_item.computed_date }
          end

          it_behaves_like 'a successful filter'
        end
      end

      context 'matching @foo_2' do
        let(:matching_item) { @foo_2 }

        context '{ binary:, date: }' do
          let(:instructions) do
            { 'binary': matching_item.binary, 'date': matching_item.date }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_binary:, computed_date: }' do
          let(:instructions) do
            { 'computed_binary': matching_item.computed_binary, 'computed_date': matching_item.computed_date }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ binary:, computed_date: }' do
          let(:instructions) do
            { 'binary': matching_item.binary, 'computed_date': matching_item.computed_date }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_binary:, date: }' do
          let(:instructions) do
            { 'computed_binary': matching_item.computed_binary, 'date': matching_item.date }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { binary:, date: } }' do
          let(:instructions) do
            { assoc: { 'binary': matching_item.assoc.binary, 'date': matching_item.assoc.date } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_binary:, computed_date: } }' do
          let(:instructions) do
            { assoc: { 'computed_binary': matching_item.assoc.computed_binary, 'computed_date': matching_item.assoc.computed_date } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { binary:, computed_date: } }' do
          let(:instructions) do
            { assoc: { 'binary': matching_item.assoc.binary, 'computed_date': matching_item.assoc.computed_date } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_binary:, date: } }' do
          let(:instructions) do
            { assoc: { 'computed_binary': matching_item.assoc.computed_binary, 'date': matching_item.assoc.date } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ binary:, assoc: { date: } }' do
          let(:instructions) do
            { 'binary': matching_item.binary, assoc: { 'date': matching_item.assoc.date } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { binary: }, date: }' do
          let(:instructions) do
            { assoc: { 'binary': matching_item.assoc.binary }, 'date': matching_item.date }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ binary:, assoc: { computed_date: } }' do
          let(:instructions) do
            { 'binary': matching_item.binary, assoc: { 'computed_date': matching_item.assoc.computed_date } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { binary: }, computed_date: }' do
          let(:instructions) do
            { assoc: { 'binary': matching_item.assoc.binary }, 'computed_date': matching_item.computed_date }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_binary:, assoc: { date: } }' do
          let(:instructions) do
            { 'computed_binary': matching_item.computed_binary, assoc: { 'date': matching_item.assoc.date } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_binary: }, date: }' do
          let(:instructions) do
            { assoc: { 'computed_binary': matching_item.assoc.computed_binary }, 'date': matching_item.date }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_binary:, assoc: { computed_date: } }' do
          let(:instructions) do
            { 'computed_binary': matching_item.computed_binary, assoc: { 'computed_date': matching_item.assoc.computed_date } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_binary: }, computed_date: }' do
          let(:instructions) do
            { assoc: { 'computed_binary': matching_item.assoc.computed_binary }, 'computed_date': matching_item.computed_date }
          end

          it_behaves_like 'a successful filter'
        end
      end
    end

    context 'with BINARY and DATETIME type' do
      context 'matching @foo_1' do
        let(:matching_item) { @foo_1 }

        context '{ binary:, datetime: }' do
          let(:instructions) do
            { 'binary': matching_item.binary, 'datetime': matching_item.datetime }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_binary:, computed_datetime: }' do
          let(:instructions) do
            { 'computed_binary': matching_item.computed_binary, 'computed_datetime': matching_item.computed_datetime }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ binary:, computed_datetime: }' do
          let(:instructions) do
            { 'binary': matching_item.binary, 'computed_datetime': matching_item.computed_datetime }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_binary:, datetime: }' do
          let(:instructions) do
            { 'computed_binary': matching_item.computed_binary, 'datetime': matching_item.datetime }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { binary:, datetime: } }' do
          let(:instructions) do
            { assoc: { 'binary': matching_item.assoc.binary, 'datetime': matching_item.assoc.datetime } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_binary:, computed_datetime: } }' do
          let(:instructions) do
            { assoc: { 'computed_binary': matching_item.assoc.computed_binary, 'computed_datetime': matching_item.assoc.computed_datetime } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { binary:, computed_datetime: } }' do
          let(:instructions) do
            { assoc: { 'binary': matching_item.assoc.binary, 'computed_datetime': matching_item.assoc.computed_datetime } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_binary:, datetime: } }' do
          let(:instructions) do
            { assoc: { 'computed_binary': matching_item.assoc.computed_binary, 'datetime': matching_item.assoc.datetime } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ binary:, assoc: { datetime: } }' do
          let(:instructions) do
            { 'binary': matching_item.binary, assoc: { 'datetime': matching_item.assoc.datetime } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { binary: }, datetime: }' do
          let(:instructions) do
            { assoc: { 'binary': matching_item.assoc.binary }, 'datetime': matching_item.datetime }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ binary:, assoc: { computed_datetime: } }' do
          let(:instructions) do
            { 'binary': matching_item.binary, assoc: { 'computed_datetime': matching_item.assoc.computed_datetime } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { binary: }, computed_datetime: }' do
          let(:instructions) do
            { assoc: { 'binary': matching_item.assoc.binary }, 'computed_datetime': matching_item.computed_datetime }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_binary:, assoc: { datetime: } }' do
          let(:instructions) do
            { 'computed_binary': matching_item.computed_binary, assoc: { 'datetime': matching_item.assoc.datetime } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_binary: }, datetime: }' do
          let(:instructions) do
            { assoc: { 'computed_binary': matching_item.assoc.computed_binary }, 'datetime': matching_item.datetime }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_binary:, assoc: { computed_datetime: } }' do
          let(:instructions) do
            { 'computed_binary': matching_item.computed_binary, assoc: { 'computed_datetime': matching_item.assoc.computed_datetime } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_binary: }, computed_datetime: }' do
          let(:instructions) do
            { assoc: { 'computed_binary': matching_item.assoc.computed_binary }, 'computed_datetime': matching_item.computed_datetime }
          end

          it_behaves_like 'a successful filter'
        end
      end

      context 'matching @foo_2' do
        let(:matching_item) { @foo_2 }

        context '{ binary:, datetime: }' do
          let(:instructions) do
            { 'binary': matching_item.binary, 'datetime': matching_item.datetime }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_binary:, computed_datetime: }' do
          let(:instructions) do
            { 'computed_binary': matching_item.computed_binary, 'computed_datetime': matching_item.computed_datetime }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ binary:, computed_datetime: }' do
          let(:instructions) do
            { 'binary': matching_item.binary, 'computed_datetime': matching_item.computed_datetime }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_binary:, datetime: }' do
          let(:instructions) do
            { 'computed_binary': matching_item.computed_binary, 'datetime': matching_item.datetime }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { binary:, datetime: } }' do
          let(:instructions) do
            { assoc: { 'binary': matching_item.assoc.binary, 'datetime': matching_item.assoc.datetime } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_binary:, computed_datetime: } }' do
          let(:instructions) do
            { assoc: { 'computed_binary': matching_item.assoc.computed_binary, 'computed_datetime': matching_item.assoc.computed_datetime } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { binary:, computed_datetime: } }' do
          let(:instructions) do
            { assoc: { 'binary': matching_item.assoc.binary, 'computed_datetime': matching_item.assoc.computed_datetime } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_binary:, datetime: } }' do
          let(:instructions) do
            { assoc: { 'computed_binary': matching_item.assoc.computed_binary, 'datetime': matching_item.assoc.datetime } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ binary:, assoc: { datetime: } }' do
          let(:instructions) do
            { 'binary': matching_item.binary, assoc: { 'datetime': matching_item.assoc.datetime } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { binary: }, datetime: }' do
          let(:instructions) do
            { assoc: { 'binary': matching_item.assoc.binary }, 'datetime': matching_item.datetime }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ binary:, assoc: { computed_datetime: } }' do
          let(:instructions) do
            { 'binary': matching_item.binary, assoc: { 'computed_datetime': matching_item.assoc.computed_datetime } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { binary: }, computed_datetime: }' do
          let(:instructions) do
            { assoc: { 'binary': matching_item.assoc.binary }, 'computed_datetime': matching_item.computed_datetime }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_binary:, assoc: { datetime: } }' do
          let(:instructions) do
            { 'computed_binary': matching_item.computed_binary, assoc: { 'datetime': matching_item.assoc.datetime } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_binary: }, datetime: }' do
          let(:instructions) do
            { assoc: { 'computed_binary': matching_item.assoc.computed_binary }, 'datetime': matching_item.datetime }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_binary:, assoc: { computed_datetime: } }' do
          let(:instructions) do
            { 'computed_binary': matching_item.computed_binary, assoc: { 'computed_datetime': matching_item.assoc.computed_datetime } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_binary: }, computed_datetime: }' do
          let(:instructions) do
            { assoc: { 'computed_binary': matching_item.assoc.computed_binary }, 'computed_datetime': matching_item.computed_datetime }
          end

          it_behaves_like 'a successful filter'
        end
      end
    end

    context 'with BINARY and DECIMAL type' do
      context 'matching @foo_1' do
        let(:matching_item) { @foo_1 }

        context '{ binary:, decimal: }' do
          let(:instructions) do
            { 'binary': matching_item.binary, 'decimal': matching_item.decimal }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_binary:, computed_decimal: }' do
          let(:instructions) do
            { 'computed_binary': matching_item.computed_binary, 'computed_decimal': matching_item.computed_decimal }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ binary:, computed_decimal: }' do
          let(:instructions) do
            { 'binary': matching_item.binary, 'computed_decimal': matching_item.computed_decimal }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_binary:, decimal: }' do
          let(:instructions) do
            { 'computed_binary': matching_item.computed_binary, 'decimal': matching_item.decimal }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { binary:, decimal: } }' do
          let(:instructions) do
            { assoc: { 'binary': matching_item.assoc.binary, 'decimal': matching_item.assoc.decimal } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_binary:, computed_decimal: } }' do
          let(:instructions) do
            { assoc: { 'computed_binary': matching_item.assoc.computed_binary, 'computed_decimal': matching_item.assoc.computed_decimal } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { binary:, computed_decimal: } }' do
          let(:instructions) do
            { assoc: { 'binary': matching_item.assoc.binary, 'computed_decimal': matching_item.assoc.computed_decimal } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_binary:, decimal: } }' do
          let(:instructions) do
            { assoc: { 'computed_binary': matching_item.assoc.computed_binary, 'decimal': matching_item.assoc.decimal } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ binary:, assoc: { decimal: } }' do
          let(:instructions) do
            { 'binary': matching_item.binary, assoc: { 'decimal': matching_item.assoc.decimal } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { binary: }, decimal: }' do
          let(:instructions) do
            { assoc: { 'binary': matching_item.assoc.binary }, 'decimal': matching_item.decimal }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ binary:, assoc: { computed_decimal: } }' do
          let(:instructions) do
            { 'binary': matching_item.binary, assoc: { 'computed_decimal': matching_item.assoc.computed_decimal } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { binary: }, computed_decimal: }' do
          let(:instructions) do
            { assoc: { 'binary': matching_item.assoc.binary }, 'computed_decimal': matching_item.computed_decimal }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_binary:, assoc: { decimal: } }' do
          let(:instructions) do
            { 'computed_binary': matching_item.computed_binary, assoc: { 'decimal': matching_item.assoc.decimal } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_binary: }, decimal: }' do
          let(:instructions) do
            { assoc: { 'computed_binary': matching_item.assoc.computed_binary }, 'decimal': matching_item.decimal }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_binary:, assoc: { computed_decimal: } }' do
          let(:instructions) do
            { 'computed_binary': matching_item.computed_binary, assoc: { 'computed_decimal': matching_item.assoc.computed_decimal } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_binary: }, computed_decimal: }' do
          let(:instructions) do
            { assoc: { 'computed_binary': matching_item.assoc.computed_binary }, 'computed_decimal': matching_item.computed_decimal }
          end

          it_behaves_like 'a successful filter'
        end
      end

      context 'matching @foo_2' do
        let(:matching_item) { @foo_2 }

        context '{ binary:, decimal: }' do
          let(:instructions) do
            { 'binary': matching_item.binary, 'decimal': matching_item.decimal }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_binary:, computed_decimal: }' do
          let(:instructions) do
            { 'computed_binary': matching_item.computed_binary, 'computed_decimal': matching_item.computed_decimal }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ binary:, computed_decimal: }' do
          let(:instructions) do
            { 'binary': matching_item.binary, 'computed_decimal': matching_item.computed_decimal }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_binary:, decimal: }' do
          let(:instructions) do
            { 'computed_binary': matching_item.computed_binary, 'decimal': matching_item.decimal }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { binary:, decimal: } }' do
          let(:instructions) do
            { assoc: { 'binary': matching_item.assoc.binary, 'decimal': matching_item.assoc.decimal } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_binary:, computed_decimal: } }' do
          let(:instructions) do
            { assoc: { 'computed_binary': matching_item.assoc.computed_binary, 'computed_decimal': matching_item.assoc.computed_decimal } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { binary:, computed_decimal: } }' do
          let(:instructions) do
            { assoc: { 'binary': matching_item.assoc.binary, 'computed_decimal': matching_item.assoc.computed_decimal } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_binary:, decimal: } }' do
          let(:instructions) do
            { assoc: { 'computed_binary': matching_item.assoc.computed_binary, 'decimal': matching_item.assoc.decimal } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ binary:, assoc: { decimal: } }' do
          let(:instructions) do
            { 'binary': matching_item.binary, assoc: { 'decimal': matching_item.assoc.decimal } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { binary: }, decimal: }' do
          let(:instructions) do
            { assoc: { 'binary': matching_item.assoc.binary }, 'decimal': matching_item.decimal }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ binary:, assoc: { computed_decimal: } }' do
          let(:instructions) do
            { 'binary': matching_item.binary, assoc: { 'computed_decimal': matching_item.assoc.computed_decimal } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { binary: }, computed_decimal: }' do
          let(:instructions) do
            { assoc: { 'binary': matching_item.assoc.binary }, 'computed_decimal': matching_item.computed_decimal }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_binary:, assoc: { decimal: } }' do
          let(:instructions) do
            { 'computed_binary': matching_item.computed_binary, assoc: { 'decimal': matching_item.assoc.decimal } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_binary: }, decimal: }' do
          let(:instructions) do
            { assoc: { 'computed_binary': matching_item.assoc.computed_binary }, 'decimal': matching_item.decimal }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_binary:, assoc: { computed_decimal: } }' do
          let(:instructions) do
            { 'computed_binary': matching_item.computed_binary, assoc: { 'computed_decimal': matching_item.assoc.computed_decimal } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_binary: }, computed_decimal: }' do
          let(:instructions) do
            { assoc: { 'computed_binary': matching_item.assoc.computed_binary }, 'computed_decimal': matching_item.computed_decimal }
          end

          it_behaves_like 'a successful filter'
        end
      end
    end

    context 'with BINARY and FLOAT type' do
      context 'matching @foo_1' do
        let(:matching_item) { @foo_1 }

        context '{ binary:, float: }' do
          let(:instructions) do
            { 'binary': matching_item.binary, 'float': matching_item.float }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_binary:, computed_float: }' do
          let(:instructions) do
            { 'computed_binary': matching_item.computed_binary, 'computed_float': matching_item.computed_float }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ binary:, computed_float: }' do
          let(:instructions) do
            { 'binary': matching_item.binary, 'computed_float': matching_item.computed_float }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_binary:, float: }' do
          let(:instructions) do
            { 'computed_binary': matching_item.computed_binary, 'float': matching_item.float }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { binary:, float: } }' do
          let(:instructions) do
            { assoc: { 'binary': matching_item.assoc.binary, 'float': matching_item.assoc.float } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_binary:, computed_float: } }' do
          let(:instructions) do
            { assoc: { 'computed_binary': matching_item.assoc.computed_binary, 'computed_float': matching_item.assoc.computed_float } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { binary:, computed_float: } }' do
          let(:instructions) do
            { assoc: { 'binary': matching_item.assoc.binary, 'computed_float': matching_item.assoc.computed_float } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_binary:, float: } }' do
          let(:instructions) do
            { assoc: { 'computed_binary': matching_item.assoc.computed_binary, 'float': matching_item.assoc.float } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ binary:, assoc: { float: } }' do
          let(:instructions) do
            { 'binary': matching_item.binary, assoc: { 'float': matching_item.assoc.float } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { binary: }, float: }' do
          let(:instructions) do
            { assoc: { 'binary': matching_item.assoc.binary }, 'float': matching_item.float }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ binary:, assoc: { computed_float: } }' do
          let(:instructions) do
            { 'binary': matching_item.binary, assoc: { 'computed_float': matching_item.assoc.computed_float } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { binary: }, computed_float: }' do
          let(:instructions) do
            { assoc: { 'binary': matching_item.assoc.binary }, 'computed_float': matching_item.computed_float }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_binary:, assoc: { float: } }' do
          let(:instructions) do
            { 'computed_binary': matching_item.computed_binary, assoc: { 'float': matching_item.assoc.float } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_binary: }, float: }' do
          let(:instructions) do
            { assoc: { 'computed_binary': matching_item.assoc.computed_binary }, 'float': matching_item.float }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_binary:, assoc: { computed_float: } }' do
          let(:instructions) do
            { 'computed_binary': matching_item.computed_binary, assoc: { 'computed_float': matching_item.assoc.computed_float } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_binary: }, computed_float: }' do
          let(:instructions) do
            { assoc: { 'computed_binary': matching_item.assoc.computed_binary }, 'computed_float': matching_item.computed_float }
          end

          it_behaves_like 'a successful filter'
        end
      end

      context 'matching @foo_2' do
        let(:matching_item) { @foo_2 }

        context '{ binary:, float: }' do
          let(:instructions) do
            { 'binary': matching_item.binary, 'float': matching_item.float }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_binary:, computed_float: }' do
          let(:instructions) do
            { 'computed_binary': matching_item.computed_binary, 'computed_float': matching_item.computed_float }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ binary:, computed_float: }' do
          let(:instructions) do
            { 'binary': matching_item.binary, 'computed_float': matching_item.computed_float }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_binary:, float: }' do
          let(:instructions) do
            { 'computed_binary': matching_item.computed_binary, 'float': matching_item.float }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { binary:, float: } }' do
          let(:instructions) do
            { assoc: { 'binary': matching_item.assoc.binary, 'float': matching_item.assoc.float } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_binary:, computed_float: } }' do
          let(:instructions) do
            { assoc: { 'computed_binary': matching_item.assoc.computed_binary, 'computed_float': matching_item.assoc.computed_float } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { binary:, computed_float: } }' do
          let(:instructions) do
            { assoc: { 'binary': matching_item.assoc.binary, 'computed_float': matching_item.assoc.computed_float } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_binary:, float: } }' do
          let(:instructions) do
            { assoc: { 'computed_binary': matching_item.assoc.computed_binary, 'float': matching_item.assoc.float } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ binary:, assoc: { float: } }' do
          let(:instructions) do
            { 'binary': matching_item.binary, assoc: { 'float': matching_item.assoc.float } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { binary: }, float: }' do
          let(:instructions) do
            { assoc: { 'binary': matching_item.assoc.binary }, 'float': matching_item.float }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ binary:, assoc: { computed_float: } }' do
          let(:instructions) do
            { 'binary': matching_item.binary, assoc: { 'computed_float': matching_item.assoc.computed_float } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { binary: }, computed_float: }' do
          let(:instructions) do
            { assoc: { 'binary': matching_item.assoc.binary }, 'computed_float': matching_item.computed_float }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_binary:, assoc: { float: } }' do
          let(:instructions) do
            { 'computed_binary': matching_item.computed_binary, assoc: { 'float': matching_item.assoc.float } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_binary: }, float: }' do
          let(:instructions) do
            { assoc: { 'computed_binary': matching_item.assoc.computed_binary }, 'float': matching_item.float }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_binary:, assoc: { computed_float: } }' do
          let(:instructions) do
            { 'computed_binary': matching_item.computed_binary, assoc: { 'computed_float': matching_item.assoc.computed_float } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_binary: }, computed_float: }' do
          let(:instructions) do
            { assoc: { 'computed_binary': matching_item.assoc.computed_binary }, 'computed_float': matching_item.computed_float }
          end

          it_behaves_like 'a successful filter'
        end
      end
    end

    context 'with BINARY and INTEGER type' do
      context 'matching @foo_1' do
        let(:matching_item) { @foo_1 }

        context '{ binary:, integer: }' do
          let(:instructions) do
            { 'binary': matching_item.binary, 'integer': matching_item.integer }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_binary:, computed_integer: }' do
          let(:instructions) do
            { 'computed_binary': matching_item.computed_binary, 'computed_integer': matching_item.computed_integer }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ binary:, computed_integer: }' do
          let(:instructions) do
            { 'binary': matching_item.binary, 'computed_integer': matching_item.computed_integer }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_binary:, integer: }' do
          let(:instructions) do
            { 'computed_binary': matching_item.computed_binary, 'integer': matching_item.integer }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { binary:, integer: } }' do
          let(:instructions) do
            { assoc: { 'binary': matching_item.assoc.binary, 'integer': matching_item.assoc.integer } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_binary:, computed_integer: } }' do
          let(:instructions) do
            { assoc: { 'computed_binary': matching_item.assoc.computed_binary, 'computed_integer': matching_item.assoc.computed_integer } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { binary:, computed_integer: } }' do
          let(:instructions) do
            { assoc: { 'binary': matching_item.assoc.binary, 'computed_integer': matching_item.assoc.computed_integer } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_binary:, integer: } }' do
          let(:instructions) do
            { assoc: { 'computed_binary': matching_item.assoc.computed_binary, 'integer': matching_item.assoc.integer } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ binary:, assoc: { integer: } }' do
          let(:instructions) do
            { 'binary': matching_item.binary, assoc: { 'integer': matching_item.assoc.integer } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { binary: }, integer: }' do
          let(:instructions) do
            { assoc: { 'binary': matching_item.assoc.binary }, 'integer': matching_item.integer }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ binary:, assoc: { computed_integer: } }' do
          let(:instructions) do
            { 'binary': matching_item.binary, assoc: { 'computed_integer': matching_item.assoc.computed_integer } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { binary: }, computed_integer: }' do
          let(:instructions) do
            { assoc: { 'binary': matching_item.assoc.binary }, 'computed_integer': matching_item.computed_integer }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_binary:, assoc: { integer: } }' do
          let(:instructions) do
            { 'computed_binary': matching_item.computed_binary, assoc: { 'integer': matching_item.assoc.integer } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_binary: }, integer: }' do
          let(:instructions) do
            { assoc: { 'computed_binary': matching_item.assoc.computed_binary }, 'integer': matching_item.integer }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_binary:, assoc: { computed_integer: } }' do
          let(:instructions) do
            { 'computed_binary': matching_item.computed_binary, assoc: { 'computed_integer': matching_item.assoc.computed_integer } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_binary: }, computed_integer: }' do
          let(:instructions) do
            { assoc: { 'computed_binary': matching_item.assoc.computed_binary }, 'computed_integer': matching_item.computed_integer }
          end

          it_behaves_like 'a successful filter'
        end
      end

      context 'matching @foo_2' do
        let(:matching_item) { @foo_2 }

        context '{ binary:, integer: }' do
          let(:instructions) do
            { 'binary': matching_item.binary, 'integer': matching_item.integer }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_binary:, computed_integer: }' do
          let(:instructions) do
            { 'computed_binary': matching_item.computed_binary, 'computed_integer': matching_item.computed_integer }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ binary:, computed_integer: }' do
          let(:instructions) do
            { 'binary': matching_item.binary, 'computed_integer': matching_item.computed_integer }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_binary:, integer: }' do
          let(:instructions) do
            { 'computed_binary': matching_item.computed_binary, 'integer': matching_item.integer }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { binary:, integer: } }' do
          let(:instructions) do
            { assoc: { 'binary': matching_item.assoc.binary, 'integer': matching_item.assoc.integer } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_binary:, computed_integer: } }' do
          let(:instructions) do
            { assoc: { 'computed_binary': matching_item.assoc.computed_binary, 'computed_integer': matching_item.assoc.computed_integer } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { binary:, computed_integer: } }' do
          let(:instructions) do
            { assoc: { 'binary': matching_item.assoc.binary, 'computed_integer': matching_item.assoc.computed_integer } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_binary:, integer: } }' do
          let(:instructions) do
            { assoc: { 'computed_binary': matching_item.assoc.computed_binary, 'integer': matching_item.assoc.integer } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ binary:, assoc: { integer: } }' do
          let(:instructions) do
            { 'binary': matching_item.binary, assoc: { 'integer': matching_item.assoc.integer } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { binary: }, integer: }' do
          let(:instructions) do
            { assoc: { 'binary': matching_item.assoc.binary }, 'integer': matching_item.integer }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ binary:, assoc: { computed_integer: } }' do
          let(:instructions) do
            { 'binary': matching_item.binary, assoc: { 'computed_integer': matching_item.assoc.computed_integer } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { binary: }, computed_integer: }' do
          let(:instructions) do
            { assoc: { 'binary': matching_item.assoc.binary }, 'computed_integer': matching_item.computed_integer }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_binary:, assoc: { integer: } }' do
          let(:instructions) do
            { 'computed_binary': matching_item.computed_binary, assoc: { 'integer': matching_item.assoc.integer } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_binary: }, integer: }' do
          let(:instructions) do
            { assoc: { 'computed_binary': matching_item.assoc.computed_binary }, 'integer': matching_item.integer }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_binary:, assoc: { computed_integer: } }' do
          let(:instructions) do
            { 'computed_binary': matching_item.computed_binary, assoc: { 'computed_integer': matching_item.assoc.computed_integer } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_binary: }, computed_integer: }' do
          let(:instructions) do
            { assoc: { 'computed_binary': matching_item.assoc.computed_binary }, 'computed_integer': matching_item.computed_integer }
          end

          it_behaves_like 'a successful filter'
        end
      end
    end

    context 'with BINARY and STRING type' do
      context 'matching @foo_1' do
        let(:matching_item) { @foo_1 }

        context '{ binary:, string: }' do
          let(:instructions) do
            { 'binary': matching_item.binary, 'string': matching_item.string }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_binary:, computed_string: }' do
          let(:instructions) do
            { 'computed_binary': matching_item.computed_binary, 'computed_string': matching_item.computed_string }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ binary:, computed_string: }' do
          let(:instructions) do
            { 'binary': matching_item.binary, 'computed_string': matching_item.computed_string }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_binary:, string: }' do
          let(:instructions) do
            { 'computed_binary': matching_item.computed_binary, 'string': matching_item.string }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { binary:, string: } }' do
          let(:instructions) do
            { assoc: { 'binary': matching_item.assoc.binary, 'string': matching_item.assoc.string } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_binary:, computed_string: } }' do
          let(:instructions) do
            { assoc: { 'computed_binary': matching_item.assoc.computed_binary, 'computed_string': matching_item.assoc.computed_string } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { binary:, computed_string: } }' do
          let(:instructions) do
            { assoc: { 'binary': matching_item.assoc.binary, 'computed_string': matching_item.assoc.computed_string } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_binary:, string: } }' do
          let(:instructions) do
            { assoc: { 'computed_binary': matching_item.assoc.computed_binary, 'string': matching_item.assoc.string } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ binary:, assoc: { string: } }' do
          let(:instructions) do
            { 'binary': matching_item.binary, assoc: { 'string': matching_item.assoc.string } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { binary: }, string: }' do
          let(:instructions) do
            { assoc: { 'binary': matching_item.assoc.binary }, 'string': matching_item.string }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ binary:, assoc: { computed_string: } }' do
          let(:instructions) do
            { 'binary': matching_item.binary, assoc: { 'computed_string': matching_item.assoc.computed_string } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { binary: }, computed_string: }' do
          let(:instructions) do
            { assoc: { 'binary': matching_item.assoc.binary }, 'computed_string': matching_item.computed_string }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_binary:, assoc: { string: } }' do
          let(:instructions) do
            { 'computed_binary': matching_item.computed_binary, assoc: { 'string': matching_item.assoc.string } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_binary: }, string: }' do
          let(:instructions) do
            { assoc: { 'computed_binary': matching_item.assoc.computed_binary }, 'string': matching_item.string }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_binary:, assoc: { computed_string: } }' do
          let(:instructions) do
            { 'computed_binary': matching_item.computed_binary, assoc: { 'computed_string': matching_item.assoc.computed_string } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_binary: }, computed_string: }' do
          let(:instructions) do
            { assoc: { 'computed_binary': matching_item.assoc.computed_binary }, 'computed_string': matching_item.computed_string }
          end

          it_behaves_like 'a successful filter'
        end
      end

      context 'matching @foo_2' do
        let(:matching_item) { @foo_2 }

        context '{ binary:, string: }' do
          let(:instructions) do
            { 'binary': matching_item.binary, 'string': matching_item.string }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_binary:, computed_string: }' do
          let(:instructions) do
            { 'computed_binary': matching_item.computed_binary, 'computed_string': matching_item.computed_string }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ binary:, computed_string: }' do
          let(:instructions) do
            { 'binary': matching_item.binary, 'computed_string': matching_item.computed_string }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_binary:, string: }' do
          let(:instructions) do
            { 'computed_binary': matching_item.computed_binary, 'string': matching_item.string }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { binary:, string: } }' do
          let(:instructions) do
            { assoc: { 'binary': matching_item.assoc.binary, 'string': matching_item.assoc.string } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_binary:, computed_string: } }' do
          let(:instructions) do
            { assoc: { 'computed_binary': matching_item.assoc.computed_binary, 'computed_string': matching_item.assoc.computed_string } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { binary:, computed_string: } }' do
          let(:instructions) do
            { assoc: { 'binary': matching_item.assoc.binary, 'computed_string': matching_item.assoc.computed_string } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_binary:, string: } }' do
          let(:instructions) do
            { assoc: { 'computed_binary': matching_item.assoc.computed_binary, 'string': matching_item.assoc.string } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ binary:, assoc: { string: } }' do
          let(:instructions) do
            { 'binary': matching_item.binary, assoc: { 'string': matching_item.assoc.string } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { binary: }, string: }' do
          let(:instructions) do
            { assoc: { 'binary': matching_item.assoc.binary }, 'string': matching_item.string }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ binary:, assoc: { computed_string: } }' do
          let(:instructions) do
            { 'binary': matching_item.binary, assoc: { 'computed_string': matching_item.assoc.computed_string } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { binary: }, computed_string: }' do
          let(:instructions) do
            { assoc: { 'binary': matching_item.assoc.binary }, 'computed_string': matching_item.computed_string }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_binary:, assoc: { string: } }' do
          let(:instructions) do
            { 'computed_binary': matching_item.computed_binary, assoc: { 'string': matching_item.assoc.string } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_binary: }, string: }' do
          let(:instructions) do
            { assoc: { 'computed_binary': matching_item.assoc.computed_binary }, 'string': matching_item.string }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_binary:, assoc: { computed_string: } }' do
          let(:instructions) do
            { 'computed_binary': matching_item.computed_binary, assoc: { 'computed_string': matching_item.assoc.computed_string } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_binary: }, computed_string: }' do
          let(:instructions) do
            { assoc: { 'computed_binary': matching_item.assoc.computed_binary }, 'computed_string': matching_item.computed_string }
          end

          it_behaves_like 'a successful filter'
        end
      end
    end

    context 'with BINARY and TEXT type' do
      context 'matching @foo_1' do
        let(:matching_item) { @foo_1 }

        context '{ binary:, text: }' do
          let(:instructions) do
            { 'binary': matching_item.binary, 'text': matching_item.text }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_binary:, computed_text: }' do
          let(:instructions) do
            { 'computed_binary': matching_item.computed_binary, 'computed_text': matching_item.computed_text }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ binary:, computed_text: }' do
          let(:instructions) do
            { 'binary': matching_item.binary, 'computed_text': matching_item.computed_text }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_binary:, text: }' do
          let(:instructions) do
            { 'computed_binary': matching_item.computed_binary, 'text': matching_item.text }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { binary:, text: } }' do
          let(:instructions) do
            { assoc: { 'binary': matching_item.assoc.binary, 'text': matching_item.assoc.text } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_binary:, computed_text: } }' do
          let(:instructions) do
            { assoc: { 'computed_binary': matching_item.assoc.computed_binary, 'computed_text': matching_item.assoc.computed_text } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { binary:, computed_text: } }' do
          let(:instructions) do
            { assoc: { 'binary': matching_item.assoc.binary, 'computed_text': matching_item.assoc.computed_text } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_binary:, text: } }' do
          let(:instructions) do
            { assoc: { 'computed_binary': matching_item.assoc.computed_binary, 'text': matching_item.assoc.text } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ binary:, assoc: { text: } }' do
          let(:instructions) do
            { 'binary': matching_item.binary, assoc: { 'text': matching_item.assoc.text } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { binary: }, text: }' do
          let(:instructions) do
            { assoc: { 'binary': matching_item.assoc.binary }, 'text': matching_item.text }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ binary:, assoc: { computed_text: } }' do
          let(:instructions) do
            { 'binary': matching_item.binary, assoc: { 'computed_text': matching_item.assoc.computed_text } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { binary: }, computed_text: }' do
          let(:instructions) do
            { assoc: { 'binary': matching_item.assoc.binary }, 'computed_text': matching_item.computed_text }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_binary:, assoc: { text: } }' do
          let(:instructions) do
            { 'computed_binary': matching_item.computed_binary, assoc: { 'text': matching_item.assoc.text } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_binary: }, text: }' do
          let(:instructions) do
            { assoc: { 'computed_binary': matching_item.assoc.computed_binary }, 'text': matching_item.text }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_binary:, assoc: { computed_text: } }' do
          let(:instructions) do
            { 'computed_binary': matching_item.computed_binary, assoc: { 'computed_text': matching_item.assoc.computed_text } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_binary: }, computed_text: }' do
          let(:instructions) do
            { assoc: { 'computed_binary': matching_item.assoc.computed_binary }, 'computed_text': matching_item.computed_text }
          end

          it_behaves_like 'a successful filter'
        end
      end

      context 'matching @foo_2' do
        let(:matching_item) { @foo_2 }

        context '{ binary:, text: }' do
          let(:instructions) do
            { 'binary': matching_item.binary, 'text': matching_item.text }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_binary:, computed_text: }' do
          let(:instructions) do
            { 'computed_binary': matching_item.computed_binary, 'computed_text': matching_item.computed_text }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ binary:, computed_text: }' do
          let(:instructions) do
            { 'binary': matching_item.binary, 'computed_text': matching_item.computed_text }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_binary:, text: }' do
          let(:instructions) do
            { 'computed_binary': matching_item.computed_binary, 'text': matching_item.text }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { binary:, text: } }' do
          let(:instructions) do
            { assoc: { 'binary': matching_item.assoc.binary, 'text': matching_item.assoc.text } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_binary:, computed_text: } }' do
          let(:instructions) do
            { assoc: { 'computed_binary': matching_item.assoc.computed_binary, 'computed_text': matching_item.assoc.computed_text } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { binary:, computed_text: } }' do
          let(:instructions) do
            { assoc: { 'binary': matching_item.assoc.binary, 'computed_text': matching_item.assoc.computed_text } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_binary:, text: } }' do
          let(:instructions) do
            { assoc: { 'computed_binary': matching_item.assoc.computed_binary, 'text': matching_item.assoc.text } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ binary:, assoc: { text: } }' do
          let(:instructions) do
            { 'binary': matching_item.binary, assoc: { 'text': matching_item.assoc.text } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { binary: }, text: }' do
          let(:instructions) do
            { assoc: { 'binary': matching_item.assoc.binary }, 'text': matching_item.text }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ binary:, assoc: { computed_text: } }' do
          let(:instructions) do
            { 'binary': matching_item.binary, assoc: { 'computed_text': matching_item.assoc.computed_text } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { binary: }, computed_text: }' do
          let(:instructions) do
            { assoc: { 'binary': matching_item.assoc.binary }, 'computed_text': matching_item.computed_text }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_binary:, assoc: { text: } }' do
          let(:instructions) do
            { 'computed_binary': matching_item.computed_binary, assoc: { 'text': matching_item.assoc.text } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_binary: }, text: }' do
          let(:instructions) do
            { assoc: { 'computed_binary': matching_item.assoc.computed_binary }, 'text': matching_item.text }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_binary:, assoc: { computed_text: } }' do
          let(:instructions) do
            { 'computed_binary': matching_item.computed_binary, assoc: { 'computed_text': matching_item.assoc.computed_text } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_binary: }, computed_text: }' do
          let(:instructions) do
            { assoc: { 'computed_binary': matching_item.assoc.computed_binary }, 'computed_text': matching_item.computed_text }
          end

          it_behaves_like 'a successful filter'
        end
      end
    end

    context 'with BINARY and TIME type' do
      context 'matching @foo_1' do
        let(:matching_item) { @foo_1 }

        context '{ binary:, time: }' do
          let(:instructions) do
            { 'binary': matching_item.binary, 'time': matching_item.time }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_binary:, computed_time: }' do
          let(:instructions) do
            { 'computed_binary': matching_item.computed_binary, 'computed_time': matching_item.computed_time }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ binary:, computed_time: }' do
          let(:instructions) do
            { 'binary': matching_item.binary, 'computed_time': matching_item.computed_time }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_binary:, time: }' do
          let(:instructions) do
            { 'computed_binary': matching_item.computed_binary, 'time': matching_item.time }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { binary:, time: } }' do
          let(:instructions) do
            { assoc: { 'binary': matching_item.assoc.binary, 'time': matching_item.assoc.time } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_binary:, computed_time: } }' do
          let(:instructions) do
            { assoc: { 'computed_binary': matching_item.assoc.computed_binary, 'computed_time': matching_item.assoc.computed_time } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { binary:, computed_time: } }' do
          let(:instructions) do
            { assoc: { 'binary': matching_item.assoc.binary, 'computed_time': matching_item.assoc.computed_time } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_binary:, time: } }' do
          let(:instructions) do
            { assoc: { 'computed_binary': matching_item.assoc.computed_binary, 'time': matching_item.assoc.time } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ binary:, assoc: { time: } }' do
          let(:instructions) do
            { 'binary': matching_item.binary, assoc: { 'time': matching_item.assoc.time } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { binary: }, time: }' do
          let(:instructions) do
            { assoc: { 'binary': matching_item.assoc.binary }, 'time': matching_item.time }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ binary:, assoc: { computed_time: } }' do
          let(:instructions) do
            { 'binary': matching_item.binary, assoc: { 'computed_time': matching_item.assoc.computed_time } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { binary: }, computed_time: }' do
          let(:instructions) do
            { assoc: { 'binary': matching_item.assoc.binary }, 'computed_time': matching_item.computed_time }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_binary:, assoc: { time: } }' do
          let(:instructions) do
            { 'computed_binary': matching_item.computed_binary, assoc: { 'time': matching_item.assoc.time } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_binary: }, time: }' do
          let(:instructions) do
            { assoc: { 'computed_binary': matching_item.assoc.computed_binary }, 'time': matching_item.time }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_binary:, assoc: { computed_time: } }' do
          let(:instructions) do
            { 'computed_binary': matching_item.computed_binary, assoc: { 'computed_time': matching_item.assoc.computed_time } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_binary: }, computed_time: }' do
          let(:instructions) do
            { assoc: { 'computed_binary': matching_item.assoc.computed_binary }, 'computed_time': matching_item.computed_time }
          end

          it_behaves_like 'a successful filter'
        end
      end

      context 'matching @foo_2' do
        let(:matching_item) { @foo_2 }

        context '{ binary:, time: }' do
          let(:instructions) do
            { 'binary': matching_item.binary, 'time': matching_item.time }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_binary:, computed_time: }' do
          let(:instructions) do
            { 'computed_binary': matching_item.computed_binary, 'computed_time': matching_item.computed_time }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ binary:, computed_time: }' do
          let(:instructions) do
            { 'binary': matching_item.binary, 'computed_time': matching_item.computed_time }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_binary:, time: }' do
          let(:instructions) do
            { 'computed_binary': matching_item.computed_binary, 'time': matching_item.time }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { binary:, time: } }' do
          let(:instructions) do
            { assoc: { 'binary': matching_item.assoc.binary, 'time': matching_item.assoc.time } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_binary:, computed_time: } }' do
          let(:instructions) do
            { assoc: { 'computed_binary': matching_item.assoc.computed_binary, 'computed_time': matching_item.assoc.computed_time } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { binary:, computed_time: } }' do
          let(:instructions) do
            { assoc: { 'binary': matching_item.assoc.binary, 'computed_time': matching_item.assoc.computed_time } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_binary:, time: } }' do
          let(:instructions) do
            { assoc: { 'computed_binary': matching_item.assoc.computed_binary, 'time': matching_item.assoc.time } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ binary:, assoc: { time: } }' do
          let(:instructions) do
            { 'binary': matching_item.binary, assoc: { 'time': matching_item.assoc.time } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { binary: }, time: }' do
          let(:instructions) do
            { assoc: { 'binary': matching_item.assoc.binary }, 'time': matching_item.time }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ binary:, assoc: { computed_time: } }' do
          let(:instructions) do
            { 'binary': matching_item.binary, assoc: { 'computed_time': matching_item.assoc.computed_time } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { binary: }, computed_time: }' do
          let(:instructions) do
            { assoc: { 'binary': matching_item.assoc.binary }, 'computed_time': matching_item.computed_time }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_binary:, assoc: { time: } }' do
          let(:instructions) do
            { 'computed_binary': matching_item.computed_binary, assoc: { 'time': matching_item.assoc.time } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_binary: }, time: }' do
          let(:instructions) do
            { assoc: { 'computed_binary': matching_item.assoc.computed_binary }, 'time': matching_item.time }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_binary:, assoc: { computed_time: } }' do
          let(:instructions) do
            { 'computed_binary': matching_item.computed_binary, assoc: { 'computed_time': matching_item.assoc.computed_time } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_binary: }, computed_time: }' do
          let(:instructions) do
            { assoc: { 'computed_binary': matching_item.assoc.computed_binary }, 'computed_time': matching_item.computed_time }
          end

          it_behaves_like 'a successful filter'
        end
      end
    end


    context 'with BOOLEAN and DATE type' do
      context 'matching @foo_1' do
        let(:matching_item) { @foo_1 }

        context '{ boolean:, date: }' do
          let(:instructions) do
            { 'boolean': matching_item.boolean, 'date': matching_item.date }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_boolean:, computed_date: }' do
          let(:instructions) do
            { 'computed_boolean': matching_item.computed_boolean, 'computed_date': matching_item.computed_date }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ boolean:, computed_date: }' do
          let(:instructions) do
            { 'boolean': matching_item.boolean, 'computed_date': matching_item.computed_date }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_boolean:, date: }' do
          let(:instructions) do
            { 'computed_boolean': matching_item.computed_boolean, 'date': matching_item.date }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { boolean:, date: } }' do
          let(:instructions) do
            { assoc: { 'boolean': matching_item.assoc.boolean, 'date': matching_item.assoc.date } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_boolean:, computed_date: } }' do
          let(:instructions) do
            { assoc: { 'computed_boolean': matching_item.assoc.computed_boolean, 'computed_date': matching_item.assoc.computed_date } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { boolean:, computed_date: } }' do
          let(:instructions) do
            { assoc: { 'boolean': matching_item.assoc.boolean, 'computed_date': matching_item.assoc.computed_date } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_boolean:, date: } }' do
          let(:instructions) do
            { assoc: { 'computed_boolean': matching_item.assoc.computed_boolean, 'date': matching_item.assoc.date } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ boolean:, assoc: { date: } }' do
          let(:instructions) do
            { 'boolean': matching_item.boolean, assoc: { 'date': matching_item.assoc.date } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { boolean: }, date: }' do
          let(:instructions) do
            { assoc: { 'boolean': matching_item.assoc.boolean }, 'date': matching_item.date }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ boolean:, assoc: { computed_date: } }' do
          let(:instructions) do
            { 'boolean': matching_item.boolean, assoc: { 'computed_date': matching_item.assoc.computed_date } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { boolean: }, computed_date: }' do
          let(:instructions) do
            { assoc: { 'boolean': matching_item.assoc.boolean }, 'computed_date': matching_item.computed_date }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_boolean:, assoc: { date: } }' do
          let(:instructions) do
            { 'computed_boolean': matching_item.computed_boolean, assoc: { 'date': matching_item.assoc.date } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_boolean: }, date: }' do
          let(:instructions) do
            { assoc: { 'computed_boolean': matching_item.assoc.computed_boolean }, 'date': matching_item.date }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_boolean:, assoc: { computed_date: } }' do
          let(:instructions) do
            { 'computed_boolean': matching_item.computed_boolean, assoc: { 'computed_date': matching_item.assoc.computed_date } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_boolean: }, computed_date: }' do
          let(:instructions) do
            { assoc: { 'computed_boolean': matching_item.assoc.computed_boolean }, 'computed_date': matching_item.computed_date }
          end

          it_behaves_like 'a successful filter'
        end
      end

      context 'matching @foo_2' do
        let(:matching_item) { @foo_2 }

        context '{ boolean:, date: }' do
          let(:instructions) do
            { 'boolean': matching_item.boolean, 'date': matching_item.date }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_boolean:, computed_date: }' do
          let(:instructions) do
            { 'computed_boolean': matching_item.computed_boolean, 'computed_date': matching_item.computed_date }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ boolean:, computed_date: }' do
          let(:instructions) do
            { 'boolean': matching_item.boolean, 'computed_date': matching_item.computed_date }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_boolean:, date: }' do
          let(:instructions) do
            { 'computed_boolean': matching_item.computed_boolean, 'date': matching_item.date }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { boolean:, date: } }' do
          let(:instructions) do
            { assoc: { 'boolean': matching_item.assoc.boolean, 'date': matching_item.assoc.date } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_boolean:, computed_date: } }' do
          let(:instructions) do
            { assoc: { 'computed_boolean': matching_item.assoc.computed_boolean, 'computed_date': matching_item.assoc.computed_date } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { boolean:, computed_date: } }' do
          let(:instructions) do
            { assoc: { 'boolean': matching_item.assoc.boolean, 'computed_date': matching_item.assoc.computed_date } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_boolean:, date: } }' do
          let(:instructions) do
            { assoc: { 'computed_boolean': matching_item.assoc.computed_boolean, 'date': matching_item.assoc.date } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ boolean:, assoc: { date: } }' do
          let(:instructions) do
            { 'boolean': matching_item.boolean, assoc: { 'date': matching_item.assoc.date } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { boolean: }, date: }' do
          let(:instructions) do
            { assoc: { 'boolean': matching_item.assoc.boolean }, 'date': matching_item.date }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ boolean:, assoc: { computed_date: } }' do
          let(:instructions) do
            { 'boolean': matching_item.boolean, assoc: { 'computed_date': matching_item.assoc.computed_date } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { boolean: }, computed_date: }' do
          let(:instructions) do
            { assoc: { 'boolean': matching_item.assoc.boolean }, 'computed_date': matching_item.computed_date }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_boolean:, assoc: { date: } }' do
          let(:instructions) do
            { 'computed_boolean': matching_item.computed_boolean, assoc: { 'date': matching_item.assoc.date } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_boolean: }, date: }' do
          let(:instructions) do
            { assoc: { 'computed_boolean': matching_item.assoc.computed_boolean }, 'date': matching_item.date }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_boolean:, assoc: { computed_date: } }' do
          let(:instructions) do
            { 'computed_boolean': matching_item.computed_boolean, assoc: { 'computed_date': matching_item.assoc.computed_date } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_boolean: }, computed_date: }' do
          let(:instructions) do
            { assoc: { 'computed_boolean': matching_item.assoc.computed_boolean }, 'computed_date': matching_item.computed_date }
          end

          it_behaves_like 'a successful filter'
        end
      end
    end

    context 'with BOOLEAN and DATETIME type' do
      context 'matching @foo_1' do
        let(:matching_item) { @foo_1 }

        context '{ boolean:, datetime: }' do
          let(:instructions) do
            { 'boolean': matching_item.boolean, 'datetime': matching_item.datetime }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_boolean:, computed_datetime: }' do
          let(:instructions) do
            { 'computed_boolean': matching_item.computed_boolean, 'computed_datetime': matching_item.computed_datetime }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ boolean:, computed_datetime: }' do
          let(:instructions) do
            { 'boolean': matching_item.boolean, 'computed_datetime': matching_item.computed_datetime }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_boolean:, datetime: }' do
          let(:instructions) do
            { 'computed_boolean': matching_item.computed_boolean, 'datetime': matching_item.datetime }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { boolean:, datetime: } }' do
          let(:instructions) do
            { assoc: { 'boolean': matching_item.assoc.boolean, 'datetime': matching_item.assoc.datetime } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_boolean:, computed_datetime: } }' do
          let(:instructions) do
            { assoc: { 'computed_boolean': matching_item.assoc.computed_boolean, 'computed_datetime': matching_item.assoc.computed_datetime } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { boolean:, computed_datetime: } }' do
          let(:instructions) do
            { assoc: { 'boolean': matching_item.assoc.boolean, 'computed_datetime': matching_item.assoc.computed_datetime } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_boolean:, datetime: } }' do
          let(:instructions) do
            { assoc: { 'computed_boolean': matching_item.assoc.computed_boolean, 'datetime': matching_item.assoc.datetime } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ boolean:, assoc: { datetime: } }' do
          let(:instructions) do
            { 'boolean': matching_item.boolean, assoc: { 'datetime': matching_item.assoc.datetime } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { boolean: }, datetime: }' do
          let(:instructions) do
            { assoc: { 'boolean': matching_item.assoc.boolean }, 'datetime': matching_item.datetime }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ boolean:, assoc: { computed_datetime: } }' do
          let(:instructions) do
            { 'boolean': matching_item.boolean, assoc: { 'computed_datetime': matching_item.assoc.computed_datetime } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { boolean: }, computed_datetime: }' do
          let(:instructions) do
            { assoc: { 'boolean': matching_item.assoc.boolean }, 'computed_datetime': matching_item.computed_datetime }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_boolean:, assoc: { datetime: } }' do
          let(:instructions) do
            { 'computed_boolean': matching_item.computed_boolean, assoc: { 'datetime': matching_item.assoc.datetime } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_boolean: }, datetime: }' do
          let(:instructions) do
            { assoc: { 'computed_boolean': matching_item.assoc.computed_boolean }, 'datetime': matching_item.datetime }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_boolean:, assoc: { computed_datetime: } }' do
          let(:instructions) do
            { 'computed_boolean': matching_item.computed_boolean, assoc: { 'computed_datetime': matching_item.assoc.computed_datetime } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_boolean: }, computed_datetime: }' do
          let(:instructions) do
            { assoc: { 'computed_boolean': matching_item.assoc.computed_boolean }, 'computed_datetime': matching_item.computed_datetime }
          end

          it_behaves_like 'a successful filter'
        end
      end

      context 'matching @foo_2' do
        let(:matching_item) { @foo_2 }

        context '{ boolean:, datetime: }' do
          let(:instructions) do
            { 'boolean': matching_item.boolean, 'datetime': matching_item.datetime }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_boolean:, computed_datetime: }' do
          let(:instructions) do
            { 'computed_boolean': matching_item.computed_boolean, 'computed_datetime': matching_item.computed_datetime }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ boolean:, computed_datetime: }' do
          let(:instructions) do
            { 'boolean': matching_item.boolean, 'computed_datetime': matching_item.computed_datetime }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_boolean:, datetime: }' do
          let(:instructions) do
            { 'computed_boolean': matching_item.computed_boolean, 'datetime': matching_item.datetime }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { boolean:, datetime: } }' do
          let(:instructions) do
            { assoc: { 'boolean': matching_item.assoc.boolean, 'datetime': matching_item.assoc.datetime } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_boolean:, computed_datetime: } }' do
          let(:instructions) do
            { assoc: { 'computed_boolean': matching_item.assoc.computed_boolean, 'computed_datetime': matching_item.assoc.computed_datetime } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { boolean:, computed_datetime: } }' do
          let(:instructions) do
            { assoc: { 'boolean': matching_item.assoc.boolean, 'computed_datetime': matching_item.assoc.computed_datetime } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_boolean:, datetime: } }' do
          let(:instructions) do
            { assoc: { 'computed_boolean': matching_item.assoc.computed_boolean, 'datetime': matching_item.assoc.datetime } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ boolean:, assoc: { datetime: } }' do
          let(:instructions) do
            { 'boolean': matching_item.boolean, assoc: { 'datetime': matching_item.assoc.datetime } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { boolean: }, datetime: }' do
          let(:instructions) do
            { assoc: { 'boolean': matching_item.assoc.boolean }, 'datetime': matching_item.datetime }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ boolean:, assoc: { computed_datetime: } }' do
          let(:instructions) do
            { 'boolean': matching_item.boolean, assoc: { 'computed_datetime': matching_item.assoc.computed_datetime } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { boolean: }, computed_datetime: }' do
          let(:instructions) do
            { assoc: { 'boolean': matching_item.assoc.boolean }, 'computed_datetime': matching_item.computed_datetime }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_boolean:, assoc: { datetime: } }' do
          let(:instructions) do
            { 'computed_boolean': matching_item.computed_boolean, assoc: { 'datetime': matching_item.assoc.datetime } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_boolean: }, datetime: }' do
          let(:instructions) do
            { assoc: { 'computed_boolean': matching_item.assoc.computed_boolean }, 'datetime': matching_item.datetime }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_boolean:, assoc: { computed_datetime: } }' do
          let(:instructions) do
            { 'computed_boolean': matching_item.computed_boolean, assoc: { 'computed_datetime': matching_item.assoc.computed_datetime } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_boolean: }, computed_datetime: }' do
          let(:instructions) do
            { assoc: { 'computed_boolean': matching_item.assoc.computed_boolean }, 'computed_datetime': matching_item.computed_datetime }
          end

          it_behaves_like 'a successful filter'
        end
      end
    end

    context 'with BOOLEAN and DECIMAL type' do
      context 'matching @foo_1' do
        let(:matching_item) { @foo_1 }

        context '{ boolean:, decimal: }' do
          let(:instructions) do
            { 'boolean': matching_item.boolean, 'decimal': matching_item.decimal }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_boolean:, computed_decimal: }' do
          let(:instructions) do
            { 'computed_boolean': matching_item.computed_boolean, 'computed_decimal': matching_item.computed_decimal }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ boolean:, computed_decimal: }' do
          let(:instructions) do
            { 'boolean': matching_item.boolean, 'computed_decimal': matching_item.computed_decimal }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_boolean:, decimal: }' do
          let(:instructions) do
            { 'computed_boolean': matching_item.computed_boolean, 'decimal': matching_item.decimal }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { boolean:, decimal: } }' do
          let(:instructions) do
            { assoc: { 'boolean': matching_item.assoc.boolean, 'decimal': matching_item.assoc.decimal } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_boolean:, computed_decimal: } }' do
          let(:instructions) do
            { assoc: { 'computed_boolean': matching_item.assoc.computed_boolean, 'computed_decimal': matching_item.assoc.computed_decimal } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { boolean:, computed_decimal: } }' do
          let(:instructions) do
            { assoc: { 'boolean': matching_item.assoc.boolean, 'computed_decimal': matching_item.assoc.computed_decimal } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_boolean:, decimal: } }' do
          let(:instructions) do
            { assoc: { 'computed_boolean': matching_item.assoc.computed_boolean, 'decimal': matching_item.assoc.decimal } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ boolean:, assoc: { decimal: } }' do
          let(:instructions) do
            { 'boolean': matching_item.boolean, assoc: { 'decimal': matching_item.assoc.decimal } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { boolean: }, decimal: }' do
          let(:instructions) do
            { assoc: { 'boolean': matching_item.assoc.boolean }, 'decimal': matching_item.decimal }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ boolean:, assoc: { computed_decimal: } }' do
          let(:instructions) do
            { 'boolean': matching_item.boolean, assoc: { 'computed_decimal': matching_item.assoc.computed_decimal } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { boolean: }, computed_decimal: }' do
          let(:instructions) do
            { assoc: { 'boolean': matching_item.assoc.boolean }, 'computed_decimal': matching_item.computed_decimal }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_boolean:, assoc: { decimal: } }' do
          let(:instructions) do
            { 'computed_boolean': matching_item.computed_boolean, assoc: { 'decimal': matching_item.assoc.decimal } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_boolean: }, decimal: }' do
          let(:instructions) do
            { assoc: { 'computed_boolean': matching_item.assoc.computed_boolean }, 'decimal': matching_item.decimal }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_boolean:, assoc: { computed_decimal: } }' do
          let(:instructions) do
            { 'computed_boolean': matching_item.computed_boolean, assoc: { 'computed_decimal': matching_item.assoc.computed_decimal } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_boolean: }, computed_decimal: }' do
          let(:instructions) do
            { assoc: { 'computed_boolean': matching_item.assoc.computed_boolean }, 'computed_decimal': matching_item.computed_decimal }
          end

          it_behaves_like 'a successful filter'
        end
      end

      context 'matching @foo_2' do
        let(:matching_item) { @foo_2 }

        context '{ boolean:, decimal: }' do
          let(:instructions) do
            { 'boolean': matching_item.boolean, 'decimal': matching_item.decimal }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_boolean:, computed_decimal: }' do
          let(:instructions) do
            { 'computed_boolean': matching_item.computed_boolean, 'computed_decimal': matching_item.computed_decimal }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ boolean:, computed_decimal: }' do
          let(:instructions) do
            { 'boolean': matching_item.boolean, 'computed_decimal': matching_item.computed_decimal }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_boolean:, decimal: }' do
          let(:instructions) do
            { 'computed_boolean': matching_item.computed_boolean, 'decimal': matching_item.decimal }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { boolean:, decimal: } }' do
          let(:instructions) do
            { assoc: { 'boolean': matching_item.assoc.boolean, 'decimal': matching_item.assoc.decimal } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_boolean:, computed_decimal: } }' do
          let(:instructions) do
            { assoc: { 'computed_boolean': matching_item.assoc.computed_boolean, 'computed_decimal': matching_item.assoc.computed_decimal } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { boolean:, computed_decimal: } }' do
          let(:instructions) do
            { assoc: { 'boolean': matching_item.assoc.boolean, 'computed_decimal': matching_item.assoc.computed_decimal } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_boolean:, decimal: } }' do
          let(:instructions) do
            { assoc: { 'computed_boolean': matching_item.assoc.computed_boolean, 'decimal': matching_item.assoc.decimal } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ boolean:, assoc: { decimal: } }' do
          let(:instructions) do
            { 'boolean': matching_item.boolean, assoc: { 'decimal': matching_item.assoc.decimal } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { boolean: }, decimal: }' do
          let(:instructions) do
            { assoc: { 'boolean': matching_item.assoc.boolean }, 'decimal': matching_item.decimal }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ boolean:, assoc: { computed_decimal: } }' do
          let(:instructions) do
            { 'boolean': matching_item.boolean, assoc: { 'computed_decimal': matching_item.assoc.computed_decimal } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { boolean: }, computed_decimal: }' do
          let(:instructions) do
            { assoc: { 'boolean': matching_item.assoc.boolean }, 'computed_decimal': matching_item.computed_decimal }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_boolean:, assoc: { decimal: } }' do
          let(:instructions) do
            { 'computed_boolean': matching_item.computed_boolean, assoc: { 'decimal': matching_item.assoc.decimal } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_boolean: }, decimal: }' do
          let(:instructions) do
            { assoc: { 'computed_boolean': matching_item.assoc.computed_boolean }, 'decimal': matching_item.decimal }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_boolean:, assoc: { computed_decimal: } }' do
          let(:instructions) do
            { 'computed_boolean': matching_item.computed_boolean, assoc: { 'computed_decimal': matching_item.assoc.computed_decimal } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_boolean: }, computed_decimal: }' do
          let(:instructions) do
            { assoc: { 'computed_boolean': matching_item.assoc.computed_boolean }, 'computed_decimal': matching_item.computed_decimal }
          end

          it_behaves_like 'a successful filter'
        end
      end
    end

    context 'with BOOLEAN and FLOAT type' do
      context 'matching @foo_1' do
        let(:matching_item) { @foo_1 }

        context '{ boolean:, float: }' do
          let(:instructions) do
            { 'boolean': matching_item.boolean, 'float': matching_item.float }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_boolean:, computed_float: }' do
          let(:instructions) do
            { 'computed_boolean': matching_item.computed_boolean, 'computed_float': matching_item.computed_float }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ boolean:, computed_float: }' do
          let(:instructions) do
            { 'boolean': matching_item.boolean, 'computed_float': matching_item.computed_float }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_boolean:, float: }' do
          let(:instructions) do
            { 'computed_boolean': matching_item.computed_boolean, 'float': matching_item.float }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { boolean:, float: } }' do
          let(:instructions) do
            { assoc: { 'boolean': matching_item.assoc.boolean, 'float': matching_item.assoc.float } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_boolean:, computed_float: } }' do
          let(:instructions) do
            { assoc: { 'computed_boolean': matching_item.assoc.computed_boolean, 'computed_float': matching_item.assoc.computed_float } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { boolean:, computed_float: } }' do
          let(:instructions) do
            { assoc: { 'boolean': matching_item.assoc.boolean, 'computed_float': matching_item.assoc.computed_float } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_boolean:, float: } }' do
          let(:instructions) do
            { assoc: { 'computed_boolean': matching_item.assoc.computed_boolean, 'float': matching_item.assoc.float } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ boolean:, assoc: { float: } }' do
          let(:instructions) do
            { 'boolean': matching_item.boolean, assoc: { 'float': matching_item.assoc.float } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { boolean: }, float: }' do
          let(:instructions) do
            { assoc: { 'boolean': matching_item.assoc.boolean }, 'float': matching_item.float }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ boolean:, assoc: { computed_float: } }' do
          let(:instructions) do
            { 'boolean': matching_item.boolean, assoc: { 'computed_float': matching_item.assoc.computed_float } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { boolean: }, computed_float: }' do
          let(:instructions) do
            { assoc: { 'boolean': matching_item.assoc.boolean }, 'computed_float': matching_item.computed_float }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_boolean:, assoc: { float: } }' do
          let(:instructions) do
            { 'computed_boolean': matching_item.computed_boolean, assoc: { 'float': matching_item.assoc.float } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_boolean: }, float: }' do
          let(:instructions) do
            { assoc: { 'computed_boolean': matching_item.assoc.computed_boolean }, 'float': matching_item.float }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_boolean:, assoc: { computed_float: } }' do
          let(:instructions) do
            { 'computed_boolean': matching_item.computed_boolean, assoc: { 'computed_float': matching_item.assoc.computed_float } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_boolean: }, computed_float: }' do
          let(:instructions) do
            { assoc: { 'computed_boolean': matching_item.assoc.computed_boolean }, 'computed_float': matching_item.computed_float }
          end

          it_behaves_like 'a successful filter'
        end
      end

      context 'matching @foo_2' do
        let(:matching_item) { @foo_2 }

        context '{ boolean:, float: }' do
          let(:instructions) do
            { 'boolean': matching_item.boolean, 'float': matching_item.float }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_boolean:, computed_float: }' do
          let(:instructions) do
            { 'computed_boolean': matching_item.computed_boolean, 'computed_float': matching_item.computed_float }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ boolean:, computed_float: }' do
          let(:instructions) do
            { 'boolean': matching_item.boolean, 'computed_float': matching_item.computed_float }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_boolean:, float: }' do
          let(:instructions) do
            { 'computed_boolean': matching_item.computed_boolean, 'float': matching_item.float }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { boolean:, float: } }' do
          let(:instructions) do
            { assoc: { 'boolean': matching_item.assoc.boolean, 'float': matching_item.assoc.float } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_boolean:, computed_float: } }' do
          let(:instructions) do
            { assoc: { 'computed_boolean': matching_item.assoc.computed_boolean, 'computed_float': matching_item.assoc.computed_float } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { boolean:, computed_float: } }' do
          let(:instructions) do
            { assoc: { 'boolean': matching_item.assoc.boolean, 'computed_float': matching_item.assoc.computed_float } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_boolean:, float: } }' do
          let(:instructions) do
            { assoc: { 'computed_boolean': matching_item.assoc.computed_boolean, 'float': matching_item.assoc.float } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ boolean:, assoc: { float: } }' do
          let(:instructions) do
            { 'boolean': matching_item.boolean, assoc: { 'float': matching_item.assoc.float } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { boolean: }, float: }' do
          let(:instructions) do
            { assoc: { 'boolean': matching_item.assoc.boolean }, 'float': matching_item.float }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ boolean:, assoc: { computed_float: } }' do
          let(:instructions) do
            { 'boolean': matching_item.boolean, assoc: { 'computed_float': matching_item.assoc.computed_float } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { boolean: }, computed_float: }' do
          let(:instructions) do
            { assoc: { 'boolean': matching_item.assoc.boolean }, 'computed_float': matching_item.computed_float }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_boolean:, assoc: { float: } }' do
          let(:instructions) do
            { 'computed_boolean': matching_item.computed_boolean, assoc: { 'float': matching_item.assoc.float } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_boolean: }, float: }' do
          let(:instructions) do
            { assoc: { 'computed_boolean': matching_item.assoc.computed_boolean }, 'float': matching_item.float }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_boolean:, assoc: { computed_float: } }' do
          let(:instructions) do
            { 'computed_boolean': matching_item.computed_boolean, assoc: { 'computed_float': matching_item.assoc.computed_float } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_boolean: }, computed_float: }' do
          let(:instructions) do
            { assoc: { 'computed_boolean': matching_item.assoc.computed_boolean }, 'computed_float': matching_item.computed_float }
          end

          it_behaves_like 'a successful filter'
        end
      end
    end

    context 'with BOOLEAN and INTEGER type' do
      context 'matching @foo_1' do
        let(:matching_item) { @foo_1 }

        context '{ boolean:, integer: }' do
          let(:instructions) do
            { 'boolean': matching_item.boolean, 'integer': matching_item.integer }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_boolean:, computed_integer: }' do
          let(:instructions) do
            { 'computed_boolean': matching_item.computed_boolean, 'computed_integer': matching_item.computed_integer }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ boolean:, computed_integer: }' do
          let(:instructions) do
            { 'boolean': matching_item.boolean, 'computed_integer': matching_item.computed_integer }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_boolean:, integer: }' do
          let(:instructions) do
            { 'computed_boolean': matching_item.computed_boolean, 'integer': matching_item.integer }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { boolean:, integer: } }' do
          let(:instructions) do
            { assoc: { 'boolean': matching_item.assoc.boolean, 'integer': matching_item.assoc.integer } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_boolean:, computed_integer: } }' do
          let(:instructions) do
            { assoc: { 'computed_boolean': matching_item.assoc.computed_boolean, 'computed_integer': matching_item.assoc.computed_integer } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { boolean:, computed_integer: } }' do
          let(:instructions) do
            { assoc: { 'boolean': matching_item.assoc.boolean, 'computed_integer': matching_item.assoc.computed_integer } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_boolean:, integer: } }' do
          let(:instructions) do
            { assoc: { 'computed_boolean': matching_item.assoc.computed_boolean, 'integer': matching_item.assoc.integer } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ boolean:, assoc: { integer: } }' do
          let(:instructions) do
            { 'boolean': matching_item.boolean, assoc: { 'integer': matching_item.assoc.integer } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { boolean: }, integer: }' do
          let(:instructions) do
            { assoc: { 'boolean': matching_item.assoc.boolean }, 'integer': matching_item.integer }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ boolean:, assoc: { computed_integer: } }' do
          let(:instructions) do
            { 'boolean': matching_item.boolean, assoc: { 'computed_integer': matching_item.assoc.computed_integer } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { boolean: }, computed_integer: }' do
          let(:instructions) do
            { assoc: { 'boolean': matching_item.assoc.boolean }, 'computed_integer': matching_item.computed_integer }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_boolean:, assoc: { integer: } }' do
          let(:instructions) do
            { 'computed_boolean': matching_item.computed_boolean, assoc: { 'integer': matching_item.assoc.integer } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_boolean: }, integer: }' do
          let(:instructions) do
            { assoc: { 'computed_boolean': matching_item.assoc.computed_boolean }, 'integer': matching_item.integer }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_boolean:, assoc: { computed_integer: } }' do
          let(:instructions) do
            { 'computed_boolean': matching_item.computed_boolean, assoc: { 'computed_integer': matching_item.assoc.computed_integer } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_boolean: }, computed_integer: }' do
          let(:instructions) do
            { assoc: { 'computed_boolean': matching_item.assoc.computed_boolean }, 'computed_integer': matching_item.computed_integer }
          end

          it_behaves_like 'a successful filter'
        end
      end

      context 'matching @foo_2' do
        let(:matching_item) { @foo_2 }

        context '{ boolean:, integer: }' do
          let(:instructions) do
            { 'boolean': matching_item.boolean, 'integer': matching_item.integer }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_boolean:, computed_integer: }' do
          let(:instructions) do
            { 'computed_boolean': matching_item.computed_boolean, 'computed_integer': matching_item.computed_integer }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ boolean:, computed_integer: }' do
          let(:instructions) do
            { 'boolean': matching_item.boolean, 'computed_integer': matching_item.computed_integer }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_boolean:, integer: }' do
          let(:instructions) do
            { 'computed_boolean': matching_item.computed_boolean, 'integer': matching_item.integer }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { boolean:, integer: } }' do
          let(:instructions) do
            { assoc: { 'boolean': matching_item.assoc.boolean, 'integer': matching_item.assoc.integer } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_boolean:, computed_integer: } }' do
          let(:instructions) do
            { assoc: { 'computed_boolean': matching_item.assoc.computed_boolean, 'computed_integer': matching_item.assoc.computed_integer } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { boolean:, computed_integer: } }' do
          let(:instructions) do
            { assoc: { 'boolean': matching_item.assoc.boolean, 'computed_integer': matching_item.assoc.computed_integer } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_boolean:, integer: } }' do
          let(:instructions) do
            { assoc: { 'computed_boolean': matching_item.assoc.computed_boolean, 'integer': matching_item.assoc.integer } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ boolean:, assoc: { integer: } }' do
          let(:instructions) do
            { 'boolean': matching_item.boolean, assoc: { 'integer': matching_item.assoc.integer } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { boolean: }, integer: }' do
          let(:instructions) do
            { assoc: { 'boolean': matching_item.assoc.boolean }, 'integer': matching_item.integer }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ boolean:, assoc: { computed_integer: } }' do
          let(:instructions) do
            { 'boolean': matching_item.boolean, assoc: { 'computed_integer': matching_item.assoc.computed_integer } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { boolean: }, computed_integer: }' do
          let(:instructions) do
            { assoc: { 'boolean': matching_item.assoc.boolean }, 'computed_integer': matching_item.computed_integer }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_boolean:, assoc: { integer: } }' do
          let(:instructions) do
            { 'computed_boolean': matching_item.computed_boolean, assoc: { 'integer': matching_item.assoc.integer } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_boolean: }, integer: }' do
          let(:instructions) do
            { assoc: { 'computed_boolean': matching_item.assoc.computed_boolean }, 'integer': matching_item.integer }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_boolean:, assoc: { computed_integer: } }' do
          let(:instructions) do
            { 'computed_boolean': matching_item.computed_boolean, assoc: { 'computed_integer': matching_item.assoc.computed_integer } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_boolean: }, computed_integer: }' do
          let(:instructions) do
            { assoc: { 'computed_boolean': matching_item.assoc.computed_boolean }, 'computed_integer': matching_item.computed_integer }
          end

          it_behaves_like 'a successful filter'
        end
      end
    end

    context 'with BOOLEAN and STRING type' do
      context 'matching @foo_1' do
        let(:matching_item) { @foo_1 }

        context '{ boolean:, string: }' do
          let(:instructions) do
            { 'boolean': matching_item.boolean, 'string': matching_item.string }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_boolean:, computed_string: }' do
          let(:instructions) do
            { 'computed_boolean': matching_item.computed_boolean, 'computed_string': matching_item.computed_string }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ boolean:, computed_string: }' do
          let(:instructions) do
            { 'boolean': matching_item.boolean, 'computed_string': matching_item.computed_string }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_boolean:, string: }' do
          let(:instructions) do
            { 'computed_boolean': matching_item.computed_boolean, 'string': matching_item.string }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { boolean:, string: } }' do
          let(:instructions) do
            { assoc: { 'boolean': matching_item.assoc.boolean, 'string': matching_item.assoc.string } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_boolean:, computed_string: } }' do
          let(:instructions) do
            { assoc: { 'computed_boolean': matching_item.assoc.computed_boolean, 'computed_string': matching_item.assoc.computed_string } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { boolean:, computed_string: } }' do
          let(:instructions) do
            { assoc: { 'boolean': matching_item.assoc.boolean, 'computed_string': matching_item.assoc.computed_string } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_boolean:, string: } }' do
          let(:instructions) do
            { assoc: { 'computed_boolean': matching_item.assoc.computed_boolean, 'string': matching_item.assoc.string } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ boolean:, assoc: { string: } }' do
          let(:instructions) do
            { 'boolean': matching_item.boolean, assoc: { 'string': matching_item.assoc.string } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { boolean: }, string: }' do
          let(:instructions) do
            { assoc: { 'boolean': matching_item.assoc.boolean }, 'string': matching_item.string }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ boolean:, assoc: { computed_string: } }' do
          let(:instructions) do
            { 'boolean': matching_item.boolean, assoc: { 'computed_string': matching_item.assoc.computed_string } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { boolean: }, computed_string: }' do
          let(:instructions) do
            { assoc: { 'boolean': matching_item.assoc.boolean }, 'computed_string': matching_item.computed_string }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_boolean:, assoc: { string: } }' do
          let(:instructions) do
            { 'computed_boolean': matching_item.computed_boolean, assoc: { 'string': matching_item.assoc.string } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_boolean: }, string: }' do
          let(:instructions) do
            { assoc: { 'computed_boolean': matching_item.assoc.computed_boolean }, 'string': matching_item.string }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_boolean:, assoc: { computed_string: } }' do
          let(:instructions) do
            { 'computed_boolean': matching_item.computed_boolean, assoc: { 'computed_string': matching_item.assoc.computed_string } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_boolean: }, computed_string: }' do
          let(:instructions) do
            { assoc: { 'computed_boolean': matching_item.assoc.computed_boolean }, 'computed_string': matching_item.computed_string }
          end

          it_behaves_like 'a successful filter'
        end
      end

      context 'matching @foo_2' do
        let(:matching_item) { @foo_2 }

        context '{ boolean:, string: }' do
          let(:instructions) do
            { 'boolean': matching_item.boolean, 'string': matching_item.string }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_boolean:, computed_string: }' do
          let(:instructions) do
            { 'computed_boolean': matching_item.computed_boolean, 'computed_string': matching_item.computed_string }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ boolean:, computed_string: }' do
          let(:instructions) do
            { 'boolean': matching_item.boolean, 'computed_string': matching_item.computed_string }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_boolean:, string: }' do
          let(:instructions) do
            { 'computed_boolean': matching_item.computed_boolean, 'string': matching_item.string }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { boolean:, string: } }' do
          let(:instructions) do
            { assoc: { 'boolean': matching_item.assoc.boolean, 'string': matching_item.assoc.string } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_boolean:, computed_string: } }' do
          let(:instructions) do
            { assoc: { 'computed_boolean': matching_item.assoc.computed_boolean, 'computed_string': matching_item.assoc.computed_string } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { boolean:, computed_string: } }' do
          let(:instructions) do
            { assoc: { 'boolean': matching_item.assoc.boolean, 'computed_string': matching_item.assoc.computed_string } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_boolean:, string: } }' do
          let(:instructions) do
            { assoc: { 'computed_boolean': matching_item.assoc.computed_boolean, 'string': matching_item.assoc.string } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ boolean:, assoc: { string: } }' do
          let(:instructions) do
            { 'boolean': matching_item.boolean, assoc: { 'string': matching_item.assoc.string } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { boolean: }, string: }' do
          let(:instructions) do
            { assoc: { 'boolean': matching_item.assoc.boolean }, 'string': matching_item.string }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ boolean:, assoc: { computed_string: } }' do
          let(:instructions) do
            { 'boolean': matching_item.boolean, assoc: { 'computed_string': matching_item.assoc.computed_string } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { boolean: }, computed_string: }' do
          let(:instructions) do
            { assoc: { 'boolean': matching_item.assoc.boolean }, 'computed_string': matching_item.computed_string }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_boolean:, assoc: { string: } }' do
          let(:instructions) do
            { 'computed_boolean': matching_item.computed_boolean, assoc: { 'string': matching_item.assoc.string } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_boolean: }, string: }' do
          let(:instructions) do
            { assoc: { 'computed_boolean': matching_item.assoc.computed_boolean }, 'string': matching_item.string }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_boolean:, assoc: { computed_string: } }' do
          let(:instructions) do
            { 'computed_boolean': matching_item.computed_boolean, assoc: { 'computed_string': matching_item.assoc.computed_string } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_boolean: }, computed_string: }' do
          let(:instructions) do
            { assoc: { 'computed_boolean': matching_item.assoc.computed_boolean }, 'computed_string': matching_item.computed_string }
          end

          it_behaves_like 'a successful filter'
        end
      end
    end

    context 'with BOOLEAN and TEXT type' do
      context 'matching @foo_1' do
        let(:matching_item) { @foo_1 }

        context '{ boolean:, text: }' do
          let(:instructions) do
            { 'boolean': matching_item.boolean, 'text': matching_item.text }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_boolean:, computed_text: }' do
          let(:instructions) do
            { 'computed_boolean': matching_item.computed_boolean, 'computed_text': matching_item.computed_text }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ boolean:, computed_text: }' do
          let(:instructions) do
            { 'boolean': matching_item.boolean, 'computed_text': matching_item.computed_text }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_boolean:, text: }' do
          let(:instructions) do
            { 'computed_boolean': matching_item.computed_boolean, 'text': matching_item.text }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { boolean:, text: } }' do
          let(:instructions) do
            { assoc: { 'boolean': matching_item.assoc.boolean, 'text': matching_item.assoc.text } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_boolean:, computed_text: } }' do
          let(:instructions) do
            { assoc: { 'computed_boolean': matching_item.assoc.computed_boolean, 'computed_text': matching_item.assoc.computed_text } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { boolean:, computed_text: } }' do
          let(:instructions) do
            { assoc: { 'boolean': matching_item.assoc.boolean, 'computed_text': matching_item.assoc.computed_text } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_boolean:, text: } }' do
          let(:instructions) do
            { assoc: { 'computed_boolean': matching_item.assoc.computed_boolean, 'text': matching_item.assoc.text } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ boolean:, assoc: { text: } }' do
          let(:instructions) do
            { 'boolean': matching_item.boolean, assoc: { 'text': matching_item.assoc.text } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { boolean: }, text: }' do
          let(:instructions) do
            { assoc: { 'boolean': matching_item.assoc.boolean }, 'text': matching_item.text }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ boolean:, assoc: { computed_text: } }' do
          let(:instructions) do
            { 'boolean': matching_item.boolean, assoc: { 'computed_text': matching_item.assoc.computed_text } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { boolean: }, computed_text: }' do
          let(:instructions) do
            { assoc: { 'boolean': matching_item.assoc.boolean }, 'computed_text': matching_item.computed_text }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_boolean:, assoc: { text: } }' do
          let(:instructions) do
            { 'computed_boolean': matching_item.computed_boolean, assoc: { 'text': matching_item.assoc.text } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_boolean: }, text: }' do
          let(:instructions) do
            { assoc: { 'computed_boolean': matching_item.assoc.computed_boolean }, 'text': matching_item.text }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_boolean:, assoc: { computed_text: } }' do
          let(:instructions) do
            { 'computed_boolean': matching_item.computed_boolean, assoc: { 'computed_text': matching_item.assoc.computed_text } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_boolean: }, computed_text: }' do
          let(:instructions) do
            { assoc: { 'computed_boolean': matching_item.assoc.computed_boolean }, 'computed_text': matching_item.computed_text }
          end

          it_behaves_like 'a successful filter'
        end
      end

      context 'matching @foo_2' do
        let(:matching_item) { @foo_2 }

        context '{ boolean:, text: }' do
          let(:instructions) do
            { 'boolean': matching_item.boolean, 'text': matching_item.text }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_boolean:, computed_text: }' do
          let(:instructions) do
            { 'computed_boolean': matching_item.computed_boolean, 'computed_text': matching_item.computed_text }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ boolean:, computed_text: }' do
          let(:instructions) do
            { 'boolean': matching_item.boolean, 'computed_text': matching_item.computed_text }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_boolean:, text: }' do
          let(:instructions) do
            { 'computed_boolean': matching_item.computed_boolean, 'text': matching_item.text }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { boolean:, text: } }' do
          let(:instructions) do
            { assoc: { 'boolean': matching_item.assoc.boolean, 'text': matching_item.assoc.text } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_boolean:, computed_text: } }' do
          let(:instructions) do
            { assoc: { 'computed_boolean': matching_item.assoc.computed_boolean, 'computed_text': matching_item.assoc.computed_text } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { boolean:, computed_text: } }' do
          let(:instructions) do
            { assoc: { 'boolean': matching_item.assoc.boolean, 'computed_text': matching_item.assoc.computed_text } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_boolean:, text: } }' do
          let(:instructions) do
            { assoc: { 'computed_boolean': matching_item.assoc.computed_boolean, 'text': matching_item.assoc.text } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ boolean:, assoc: { text: } }' do
          let(:instructions) do
            { 'boolean': matching_item.boolean, assoc: { 'text': matching_item.assoc.text } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { boolean: }, text: }' do
          let(:instructions) do
            { assoc: { 'boolean': matching_item.assoc.boolean }, 'text': matching_item.text }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ boolean:, assoc: { computed_text: } }' do
          let(:instructions) do
            { 'boolean': matching_item.boolean, assoc: { 'computed_text': matching_item.assoc.computed_text } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { boolean: }, computed_text: }' do
          let(:instructions) do
            { assoc: { 'boolean': matching_item.assoc.boolean }, 'computed_text': matching_item.computed_text }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_boolean:, assoc: { text: } }' do
          let(:instructions) do
            { 'computed_boolean': matching_item.computed_boolean, assoc: { 'text': matching_item.assoc.text } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_boolean: }, text: }' do
          let(:instructions) do
            { assoc: { 'computed_boolean': matching_item.assoc.computed_boolean }, 'text': matching_item.text }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_boolean:, assoc: { computed_text: } }' do
          let(:instructions) do
            { 'computed_boolean': matching_item.computed_boolean, assoc: { 'computed_text': matching_item.assoc.computed_text } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_boolean: }, computed_text: }' do
          let(:instructions) do
            { assoc: { 'computed_boolean': matching_item.assoc.computed_boolean }, 'computed_text': matching_item.computed_text }
          end

          it_behaves_like 'a successful filter'
        end
      end
    end

    context 'with BOOLEAN and TIME type' do
      context 'matching @foo_1' do
        let(:matching_item) { @foo_1 }

        context '{ boolean:, time: }' do
          let(:instructions) do
            { 'boolean': matching_item.boolean, 'time': matching_item.time }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_boolean:, computed_time: }' do
          let(:instructions) do
            { 'computed_boolean': matching_item.computed_boolean, 'computed_time': matching_item.computed_time }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ boolean:, computed_time: }' do
          let(:instructions) do
            { 'boolean': matching_item.boolean, 'computed_time': matching_item.computed_time }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_boolean:, time: }' do
          let(:instructions) do
            { 'computed_boolean': matching_item.computed_boolean, 'time': matching_item.time }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { boolean:, time: } }' do
          let(:instructions) do
            { assoc: { 'boolean': matching_item.assoc.boolean, 'time': matching_item.assoc.time } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_boolean:, computed_time: } }' do
          let(:instructions) do
            { assoc: { 'computed_boolean': matching_item.assoc.computed_boolean, 'computed_time': matching_item.assoc.computed_time } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { boolean:, computed_time: } }' do
          let(:instructions) do
            { assoc: { 'boolean': matching_item.assoc.boolean, 'computed_time': matching_item.assoc.computed_time } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_boolean:, time: } }' do
          let(:instructions) do
            { assoc: { 'computed_boolean': matching_item.assoc.computed_boolean, 'time': matching_item.assoc.time } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ boolean:, assoc: { time: } }' do
          let(:instructions) do
            { 'boolean': matching_item.boolean, assoc: { 'time': matching_item.assoc.time } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { boolean: }, time: }' do
          let(:instructions) do
            { assoc: { 'boolean': matching_item.assoc.boolean }, 'time': matching_item.time }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ boolean:, assoc: { computed_time: } }' do
          let(:instructions) do
            { 'boolean': matching_item.boolean, assoc: { 'computed_time': matching_item.assoc.computed_time } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { boolean: }, computed_time: }' do
          let(:instructions) do
            { assoc: { 'boolean': matching_item.assoc.boolean }, 'computed_time': matching_item.computed_time }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_boolean:, assoc: { time: } }' do
          let(:instructions) do
            { 'computed_boolean': matching_item.computed_boolean, assoc: { 'time': matching_item.assoc.time } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_boolean: }, time: }' do
          let(:instructions) do
            { assoc: { 'computed_boolean': matching_item.assoc.computed_boolean }, 'time': matching_item.time }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_boolean:, assoc: { computed_time: } }' do
          let(:instructions) do
            { 'computed_boolean': matching_item.computed_boolean, assoc: { 'computed_time': matching_item.assoc.computed_time } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_boolean: }, computed_time: }' do
          let(:instructions) do
            { assoc: { 'computed_boolean': matching_item.assoc.computed_boolean }, 'computed_time': matching_item.computed_time }
          end

          it_behaves_like 'a successful filter'
        end
      end

      context 'matching @foo_2' do
        let(:matching_item) { @foo_2 }

        context '{ boolean:, time: }' do
          let(:instructions) do
            { 'boolean': matching_item.boolean, 'time': matching_item.time }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_boolean:, computed_time: }' do
          let(:instructions) do
            { 'computed_boolean': matching_item.computed_boolean, 'computed_time': matching_item.computed_time }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ boolean:, computed_time: }' do
          let(:instructions) do
            { 'boolean': matching_item.boolean, 'computed_time': matching_item.computed_time }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_boolean:, time: }' do
          let(:instructions) do
            { 'computed_boolean': matching_item.computed_boolean, 'time': matching_item.time }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { boolean:, time: } }' do
          let(:instructions) do
            { assoc: { 'boolean': matching_item.assoc.boolean, 'time': matching_item.assoc.time } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_boolean:, computed_time: } }' do
          let(:instructions) do
            { assoc: { 'computed_boolean': matching_item.assoc.computed_boolean, 'computed_time': matching_item.assoc.computed_time } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { boolean:, computed_time: } }' do
          let(:instructions) do
            { assoc: { 'boolean': matching_item.assoc.boolean, 'computed_time': matching_item.assoc.computed_time } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_boolean:, time: } }' do
          let(:instructions) do
            { assoc: { 'computed_boolean': matching_item.assoc.computed_boolean, 'time': matching_item.assoc.time } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ boolean:, assoc: { time: } }' do
          let(:instructions) do
            { 'boolean': matching_item.boolean, assoc: { 'time': matching_item.assoc.time } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { boolean: }, time: }' do
          let(:instructions) do
            { assoc: { 'boolean': matching_item.assoc.boolean }, 'time': matching_item.time }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ boolean:, assoc: { computed_time: } }' do
          let(:instructions) do
            { 'boolean': matching_item.boolean, assoc: { 'computed_time': matching_item.assoc.computed_time } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { boolean: }, computed_time: }' do
          let(:instructions) do
            { assoc: { 'boolean': matching_item.assoc.boolean }, 'computed_time': matching_item.computed_time }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_boolean:, assoc: { time: } }' do
          let(:instructions) do
            { 'computed_boolean': matching_item.computed_boolean, assoc: { 'time': matching_item.assoc.time } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_boolean: }, time: }' do
          let(:instructions) do
            { assoc: { 'computed_boolean': matching_item.assoc.computed_boolean }, 'time': matching_item.time }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_boolean:, assoc: { computed_time: } }' do
          let(:instructions) do
            { 'computed_boolean': matching_item.computed_boolean, assoc: { 'computed_time': matching_item.assoc.computed_time } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_boolean: }, computed_time: }' do
          let(:instructions) do
            { assoc: { 'computed_boolean': matching_item.assoc.computed_boolean }, 'computed_time': matching_item.computed_time }
          end

          it_behaves_like 'a successful filter'
        end
      end
    end


    context 'with DATE and DATETIME type' do
      context 'matching @foo_1' do
        let(:matching_item) { @foo_1 }

        context '{ date:, datetime: }' do
          let(:instructions) do
            { 'date': matching_item.date, 'datetime': matching_item.datetime }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_date:, computed_datetime: }' do
          let(:instructions) do
            { 'computed_date': matching_item.computed_date, 'computed_datetime': matching_item.computed_datetime }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ date:, computed_datetime: }' do
          let(:instructions) do
            { 'date': matching_item.date, 'computed_datetime': matching_item.computed_datetime }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_date:, datetime: }' do
          let(:instructions) do
            { 'computed_date': matching_item.computed_date, 'datetime': matching_item.datetime }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { date:, datetime: } }' do
          let(:instructions) do
            { assoc: { 'date': matching_item.assoc.date, 'datetime': matching_item.assoc.datetime } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_date:, computed_datetime: } }' do
          let(:instructions) do
            { assoc: { 'computed_date': matching_item.assoc.computed_date, 'computed_datetime': matching_item.assoc.computed_datetime } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { date:, computed_datetime: } }' do
          let(:instructions) do
            { assoc: { 'date': matching_item.assoc.date, 'computed_datetime': matching_item.assoc.computed_datetime } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_date:, datetime: } }' do
          let(:instructions) do
            { assoc: { 'computed_date': matching_item.assoc.computed_date, 'datetime': matching_item.assoc.datetime } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ date:, assoc: { datetime: } }' do
          let(:instructions) do
            { 'date': matching_item.date, assoc: { 'datetime': matching_item.assoc.datetime } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { date: }, datetime: }' do
          let(:instructions) do
            { assoc: { 'date': matching_item.assoc.date }, 'datetime': matching_item.datetime }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ date:, assoc: { computed_datetime: } }' do
          let(:instructions) do
            { 'date': matching_item.date, assoc: { 'computed_datetime': matching_item.assoc.computed_datetime } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { date: }, computed_datetime: }' do
          let(:instructions) do
            { assoc: { 'date': matching_item.assoc.date }, 'computed_datetime': matching_item.computed_datetime }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_date:, assoc: { datetime: } }' do
          let(:instructions) do
            { 'computed_date': matching_item.computed_date, assoc: { 'datetime': matching_item.assoc.datetime } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_date: }, datetime: }' do
          let(:instructions) do
            { assoc: { 'computed_date': matching_item.assoc.computed_date }, 'datetime': matching_item.datetime }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_date:, assoc: { computed_datetime: } }' do
          let(:instructions) do
            { 'computed_date': matching_item.computed_date, assoc: { 'computed_datetime': matching_item.assoc.computed_datetime } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_date: }, computed_datetime: }' do
          let(:instructions) do
            { assoc: { 'computed_date': matching_item.assoc.computed_date }, 'computed_datetime': matching_item.computed_datetime }
          end

          it_behaves_like 'a successful filter'
        end
      end

      context 'matching @foo_2' do
        let(:matching_item) { @foo_2 }

        context '{ date:, datetime: }' do
          let(:instructions) do
            { 'date': matching_item.date, 'datetime': matching_item.datetime }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_date:, computed_datetime: }' do
          let(:instructions) do
            { 'computed_date': matching_item.computed_date, 'computed_datetime': matching_item.computed_datetime }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ date:, computed_datetime: }' do
          let(:instructions) do
            { 'date': matching_item.date, 'computed_datetime': matching_item.computed_datetime }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_date:, datetime: }' do
          let(:instructions) do
            { 'computed_date': matching_item.computed_date, 'datetime': matching_item.datetime }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { date:, datetime: } }' do
          let(:instructions) do
            { assoc: { 'date': matching_item.assoc.date, 'datetime': matching_item.assoc.datetime } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_date:, computed_datetime: } }' do
          let(:instructions) do
            { assoc: { 'computed_date': matching_item.assoc.computed_date, 'computed_datetime': matching_item.assoc.computed_datetime } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { date:, computed_datetime: } }' do
          let(:instructions) do
            { assoc: { 'date': matching_item.assoc.date, 'computed_datetime': matching_item.assoc.computed_datetime } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_date:, datetime: } }' do
          let(:instructions) do
            { assoc: { 'computed_date': matching_item.assoc.computed_date, 'datetime': matching_item.assoc.datetime } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ date:, assoc: { datetime: } }' do
          let(:instructions) do
            { 'date': matching_item.date, assoc: { 'datetime': matching_item.assoc.datetime } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { date: }, datetime: }' do
          let(:instructions) do
            { assoc: { 'date': matching_item.assoc.date }, 'datetime': matching_item.datetime }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ date:, assoc: { computed_datetime: } }' do
          let(:instructions) do
            { 'date': matching_item.date, assoc: { 'computed_datetime': matching_item.assoc.computed_datetime } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { date: }, computed_datetime: }' do
          let(:instructions) do
            { assoc: { 'date': matching_item.assoc.date }, 'computed_datetime': matching_item.computed_datetime }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_date:, assoc: { datetime: } }' do
          let(:instructions) do
            { 'computed_date': matching_item.computed_date, assoc: { 'datetime': matching_item.assoc.datetime } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_date: }, datetime: }' do
          let(:instructions) do
            { assoc: { 'computed_date': matching_item.assoc.computed_date }, 'datetime': matching_item.datetime }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_date:, assoc: { computed_datetime: } }' do
          let(:instructions) do
            { 'computed_date': matching_item.computed_date, assoc: { 'computed_datetime': matching_item.assoc.computed_datetime } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_date: }, computed_datetime: }' do
          let(:instructions) do
            { assoc: { 'computed_date': matching_item.assoc.computed_date }, 'computed_datetime': matching_item.computed_datetime }
          end

          it_behaves_like 'a successful filter'
        end
      end
    end

    context 'with DATE and DECIMAL type' do
      context 'matching @foo_1' do
        let(:matching_item) { @foo_1 }

        context '{ date:, decimal: }' do
          let(:instructions) do
            { 'date': matching_item.date, 'decimal': matching_item.decimal }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_date:, computed_decimal: }' do
          let(:instructions) do
            { 'computed_date': matching_item.computed_date, 'computed_decimal': matching_item.computed_decimal }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ date:, computed_decimal: }' do
          let(:instructions) do
            { 'date': matching_item.date, 'computed_decimal': matching_item.computed_decimal }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_date:, decimal: }' do
          let(:instructions) do
            { 'computed_date': matching_item.computed_date, 'decimal': matching_item.decimal }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { date:, decimal: } }' do
          let(:instructions) do
            { assoc: { 'date': matching_item.assoc.date, 'decimal': matching_item.assoc.decimal } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_date:, computed_decimal: } }' do
          let(:instructions) do
            { assoc: { 'computed_date': matching_item.assoc.computed_date, 'computed_decimal': matching_item.assoc.computed_decimal } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { date:, computed_decimal: } }' do
          let(:instructions) do
            { assoc: { 'date': matching_item.assoc.date, 'computed_decimal': matching_item.assoc.computed_decimal } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_date:, decimal: } }' do
          let(:instructions) do
            { assoc: { 'computed_date': matching_item.assoc.computed_date, 'decimal': matching_item.assoc.decimal } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ date:, assoc: { decimal: } }' do
          let(:instructions) do
            { 'date': matching_item.date, assoc: { 'decimal': matching_item.assoc.decimal } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { date: }, decimal: }' do
          let(:instructions) do
            { assoc: { 'date': matching_item.assoc.date }, 'decimal': matching_item.decimal }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ date:, assoc: { computed_decimal: } }' do
          let(:instructions) do
            { 'date': matching_item.date, assoc: { 'computed_decimal': matching_item.assoc.computed_decimal } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { date: }, computed_decimal: }' do
          let(:instructions) do
            { assoc: { 'date': matching_item.assoc.date }, 'computed_decimal': matching_item.computed_decimal }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_date:, assoc: { decimal: } }' do
          let(:instructions) do
            { 'computed_date': matching_item.computed_date, assoc: { 'decimal': matching_item.assoc.decimal } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_date: }, decimal: }' do
          let(:instructions) do
            { assoc: { 'computed_date': matching_item.assoc.computed_date }, 'decimal': matching_item.decimal }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_date:, assoc: { computed_decimal: } }' do
          let(:instructions) do
            { 'computed_date': matching_item.computed_date, assoc: { 'computed_decimal': matching_item.assoc.computed_decimal } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_date: }, computed_decimal: }' do
          let(:instructions) do
            { assoc: { 'computed_date': matching_item.assoc.computed_date }, 'computed_decimal': matching_item.computed_decimal }
          end

          it_behaves_like 'a successful filter'
        end
      end

      context 'matching @foo_2' do
        let(:matching_item) { @foo_2 }

        context '{ date:, decimal: }' do
          let(:instructions) do
            { 'date': matching_item.date, 'decimal': matching_item.decimal }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_date:, computed_decimal: }' do
          let(:instructions) do
            { 'computed_date': matching_item.computed_date, 'computed_decimal': matching_item.computed_decimal }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ date:, computed_decimal: }' do
          let(:instructions) do
            { 'date': matching_item.date, 'computed_decimal': matching_item.computed_decimal }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_date:, decimal: }' do
          let(:instructions) do
            { 'computed_date': matching_item.computed_date, 'decimal': matching_item.decimal }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { date:, decimal: } }' do
          let(:instructions) do
            { assoc: { 'date': matching_item.assoc.date, 'decimal': matching_item.assoc.decimal } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_date:, computed_decimal: } }' do
          let(:instructions) do
            { assoc: { 'computed_date': matching_item.assoc.computed_date, 'computed_decimal': matching_item.assoc.computed_decimal } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { date:, computed_decimal: } }' do
          let(:instructions) do
            { assoc: { 'date': matching_item.assoc.date, 'computed_decimal': matching_item.assoc.computed_decimal } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_date:, decimal: } }' do
          let(:instructions) do
            { assoc: { 'computed_date': matching_item.assoc.computed_date, 'decimal': matching_item.assoc.decimal } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ date:, assoc: { decimal: } }' do
          let(:instructions) do
            { 'date': matching_item.date, assoc: { 'decimal': matching_item.assoc.decimal } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { date: }, decimal: }' do
          let(:instructions) do
            { assoc: { 'date': matching_item.assoc.date }, 'decimal': matching_item.decimal }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ date:, assoc: { computed_decimal: } }' do
          let(:instructions) do
            { 'date': matching_item.date, assoc: { 'computed_decimal': matching_item.assoc.computed_decimal } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { date: }, computed_decimal: }' do
          let(:instructions) do
            { assoc: { 'date': matching_item.assoc.date }, 'computed_decimal': matching_item.computed_decimal }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_date:, assoc: { decimal: } }' do
          let(:instructions) do
            { 'computed_date': matching_item.computed_date, assoc: { 'decimal': matching_item.assoc.decimal } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_date: }, decimal: }' do
          let(:instructions) do
            { assoc: { 'computed_date': matching_item.assoc.computed_date }, 'decimal': matching_item.decimal }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_date:, assoc: { computed_decimal: } }' do
          let(:instructions) do
            { 'computed_date': matching_item.computed_date, assoc: { 'computed_decimal': matching_item.assoc.computed_decimal } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_date: }, computed_decimal: }' do
          let(:instructions) do
            { assoc: { 'computed_date': matching_item.assoc.computed_date }, 'computed_decimal': matching_item.computed_decimal }
          end

          it_behaves_like 'a successful filter'
        end
      end
    end

    context 'with DATE and FLOAT type' do
      context 'matching @foo_1' do
        let(:matching_item) { @foo_1 }

        context '{ date:, float: }' do
          let(:instructions) do
            { 'date': matching_item.date, 'float': matching_item.float }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_date:, computed_float: }' do
          let(:instructions) do
            { 'computed_date': matching_item.computed_date, 'computed_float': matching_item.computed_float }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ date:, computed_float: }' do
          let(:instructions) do
            { 'date': matching_item.date, 'computed_float': matching_item.computed_float }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_date:, float: }' do
          let(:instructions) do
            { 'computed_date': matching_item.computed_date, 'float': matching_item.float }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { date:, float: } }' do
          let(:instructions) do
            { assoc: { 'date': matching_item.assoc.date, 'float': matching_item.assoc.float } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_date:, computed_float: } }' do
          let(:instructions) do
            { assoc: { 'computed_date': matching_item.assoc.computed_date, 'computed_float': matching_item.assoc.computed_float } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { date:, computed_float: } }' do
          let(:instructions) do
            { assoc: { 'date': matching_item.assoc.date, 'computed_float': matching_item.assoc.computed_float } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_date:, float: } }' do
          let(:instructions) do
            { assoc: { 'computed_date': matching_item.assoc.computed_date, 'float': matching_item.assoc.float } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ date:, assoc: { float: } }' do
          let(:instructions) do
            { 'date': matching_item.date, assoc: { 'float': matching_item.assoc.float } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { date: }, float: }' do
          let(:instructions) do
            { assoc: { 'date': matching_item.assoc.date }, 'float': matching_item.float }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ date:, assoc: { computed_float: } }' do
          let(:instructions) do
            { 'date': matching_item.date, assoc: { 'computed_float': matching_item.assoc.computed_float } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { date: }, computed_float: }' do
          let(:instructions) do
            { assoc: { 'date': matching_item.assoc.date }, 'computed_float': matching_item.computed_float }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_date:, assoc: { float: } }' do
          let(:instructions) do
            { 'computed_date': matching_item.computed_date, assoc: { 'float': matching_item.assoc.float } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_date: }, float: }' do
          let(:instructions) do
            { assoc: { 'computed_date': matching_item.assoc.computed_date }, 'float': matching_item.float }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_date:, assoc: { computed_float: } }' do
          let(:instructions) do
            { 'computed_date': matching_item.computed_date, assoc: { 'computed_float': matching_item.assoc.computed_float } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_date: }, computed_float: }' do
          let(:instructions) do
            { assoc: { 'computed_date': matching_item.assoc.computed_date }, 'computed_float': matching_item.computed_float }
          end

          it_behaves_like 'a successful filter'
        end
      end

      context 'matching @foo_2' do
        let(:matching_item) { @foo_2 }

        context '{ date:, float: }' do
          let(:instructions) do
            { 'date': matching_item.date, 'float': matching_item.float }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_date:, computed_float: }' do
          let(:instructions) do
            { 'computed_date': matching_item.computed_date, 'computed_float': matching_item.computed_float }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ date:, computed_float: }' do
          let(:instructions) do
            { 'date': matching_item.date, 'computed_float': matching_item.computed_float }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_date:, float: }' do
          let(:instructions) do
            { 'computed_date': matching_item.computed_date, 'float': matching_item.float }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { date:, float: } }' do
          let(:instructions) do
            { assoc: { 'date': matching_item.assoc.date, 'float': matching_item.assoc.float } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_date:, computed_float: } }' do
          let(:instructions) do
            { assoc: { 'computed_date': matching_item.assoc.computed_date, 'computed_float': matching_item.assoc.computed_float } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { date:, computed_float: } }' do
          let(:instructions) do
            { assoc: { 'date': matching_item.assoc.date, 'computed_float': matching_item.assoc.computed_float } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_date:, float: } }' do
          let(:instructions) do
            { assoc: { 'computed_date': matching_item.assoc.computed_date, 'float': matching_item.assoc.float } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ date:, assoc: { float: } }' do
          let(:instructions) do
            { 'date': matching_item.date, assoc: { 'float': matching_item.assoc.float } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { date: }, float: }' do
          let(:instructions) do
            { assoc: { 'date': matching_item.assoc.date }, 'float': matching_item.float }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ date:, assoc: { computed_float: } }' do
          let(:instructions) do
            { 'date': matching_item.date, assoc: { 'computed_float': matching_item.assoc.computed_float } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { date: }, computed_float: }' do
          let(:instructions) do
            { assoc: { 'date': matching_item.assoc.date }, 'computed_float': matching_item.computed_float }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_date:, assoc: { float: } }' do
          let(:instructions) do
            { 'computed_date': matching_item.computed_date, assoc: { 'float': matching_item.assoc.float } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_date: }, float: }' do
          let(:instructions) do
            { assoc: { 'computed_date': matching_item.assoc.computed_date }, 'float': matching_item.float }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_date:, assoc: { computed_float: } }' do
          let(:instructions) do
            { 'computed_date': matching_item.computed_date, assoc: { 'computed_float': matching_item.assoc.computed_float } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_date: }, computed_float: }' do
          let(:instructions) do
            { assoc: { 'computed_date': matching_item.assoc.computed_date }, 'computed_float': matching_item.computed_float }
          end

          it_behaves_like 'a successful filter'
        end
      end
    end

    context 'with DATE and INTEGER type' do
      context 'matching @foo_1' do
        let(:matching_item) { @foo_1 }

        context '{ date:, integer: }' do
          let(:instructions) do
            { 'date': matching_item.date, 'integer': matching_item.integer }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_date:, computed_integer: }' do
          let(:instructions) do
            { 'computed_date': matching_item.computed_date, 'computed_integer': matching_item.computed_integer }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ date:, computed_integer: }' do
          let(:instructions) do
            { 'date': matching_item.date, 'computed_integer': matching_item.computed_integer }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_date:, integer: }' do
          let(:instructions) do
            { 'computed_date': matching_item.computed_date, 'integer': matching_item.integer }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { date:, integer: } }' do
          let(:instructions) do
            { assoc: { 'date': matching_item.assoc.date, 'integer': matching_item.assoc.integer } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_date:, computed_integer: } }' do
          let(:instructions) do
            { assoc: { 'computed_date': matching_item.assoc.computed_date, 'computed_integer': matching_item.assoc.computed_integer } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { date:, computed_integer: } }' do
          let(:instructions) do
            { assoc: { 'date': matching_item.assoc.date, 'computed_integer': matching_item.assoc.computed_integer } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_date:, integer: } }' do
          let(:instructions) do
            { assoc: { 'computed_date': matching_item.assoc.computed_date, 'integer': matching_item.assoc.integer } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ date:, assoc: { integer: } }' do
          let(:instructions) do
            { 'date': matching_item.date, assoc: { 'integer': matching_item.assoc.integer } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { date: }, integer: }' do
          let(:instructions) do
            { assoc: { 'date': matching_item.assoc.date }, 'integer': matching_item.integer }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ date:, assoc: { computed_integer: } }' do
          let(:instructions) do
            { 'date': matching_item.date, assoc: { 'computed_integer': matching_item.assoc.computed_integer } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { date: }, computed_integer: }' do
          let(:instructions) do
            { assoc: { 'date': matching_item.assoc.date }, 'computed_integer': matching_item.computed_integer }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_date:, assoc: { integer: } }' do
          let(:instructions) do
            { 'computed_date': matching_item.computed_date, assoc: { 'integer': matching_item.assoc.integer } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_date: }, integer: }' do
          let(:instructions) do
            { assoc: { 'computed_date': matching_item.assoc.computed_date }, 'integer': matching_item.integer }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_date:, assoc: { computed_integer: } }' do
          let(:instructions) do
            { 'computed_date': matching_item.computed_date, assoc: { 'computed_integer': matching_item.assoc.computed_integer } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_date: }, computed_integer: }' do
          let(:instructions) do
            { assoc: { 'computed_date': matching_item.assoc.computed_date }, 'computed_integer': matching_item.computed_integer }
          end

          it_behaves_like 'a successful filter'
        end
      end

      context 'matching @foo_2' do
        let(:matching_item) { @foo_2 }

        context '{ date:, integer: }' do
          let(:instructions) do
            { 'date': matching_item.date, 'integer': matching_item.integer }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_date:, computed_integer: }' do
          let(:instructions) do
            { 'computed_date': matching_item.computed_date, 'computed_integer': matching_item.computed_integer }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ date:, computed_integer: }' do
          let(:instructions) do
            { 'date': matching_item.date, 'computed_integer': matching_item.computed_integer }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_date:, integer: }' do
          let(:instructions) do
            { 'computed_date': matching_item.computed_date, 'integer': matching_item.integer }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { date:, integer: } }' do
          let(:instructions) do
            { assoc: { 'date': matching_item.assoc.date, 'integer': matching_item.assoc.integer } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_date:, computed_integer: } }' do
          let(:instructions) do
            { assoc: { 'computed_date': matching_item.assoc.computed_date, 'computed_integer': matching_item.assoc.computed_integer } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { date:, computed_integer: } }' do
          let(:instructions) do
            { assoc: { 'date': matching_item.assoc.date, 'computed_integer': matching_item.assoc.computed_integer } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_date:, integer: } }' do
          let(:instructions) do
            { assoc: { 'computed_date': matching_item.assoc.computed_date, 'integer': matching_item.assoc.integer } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ date:, assoc: { integer: } }' do
          let(:instructions) do
            { 'date': matching_item.date, assoc: { 'integer': matching_item.assoc.integer } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { date: }, integer: }' do
          let(:instructions) do
            { assoc: { 'date': matching_item.assoc.date }, 'integer': matching_item.integer }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ date:, assoc: { computed_integer: } }' do
          let(:instructions) do
            { 'date': matching_item.date, assoc: { 'computed_integer': matching_item.assoc.computed_integer } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { date: }, computed_integer: }' do
          let(:instructions) do
            { assoc: { 'date': matching_item.assoc.date }, 'computed_integer': matching_item.computed_integer }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_date:, assoc: { integer: } }' do
          let(:instructions) do
            { 'computed_date': matching_item.computed_date, assoc: { 'integer': matching_item.assoc.integer } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_date: }, integer: }' do
          let(:instructions) do
            { assoc: { 'computed_date': matching_item.assoc.computed_date }, 'integer': matching_item.integer }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_date:, assoc: { computed_integer: } }' do
          let(:instructions) do
            { 'computed_date': matching_item.computed_date, assoc: { 'computed_integer': matching_item.assoc.computed_integer } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_date: }, computed_integer: }' do
          let(:instructions) do
            { assoc: { 'computed_date': matching_item.assoc.computed_date }, 'computed_integer': matching_item.computed_integer }
          end

          it_behaves_like 'a successful filter'
        end
      end
    end

    context 'with DATE and STRING type' do
      context 'matching @foo_1' do
        let(:matching_item) { @foo_1 }

        context '{ date:, string: }' do
          let(:instructions) do
            { 'date': matching_item.date, 'string': matching_item.string }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_date:, computed_string: }' do
          let(:instructions) do
            { 'computed_date': matching_item.computed_date, 'computed_string': matching_item.computed_string }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ date:, computed_string: }' do
          let(:instructions) do
            { 'date': matching_item.date, 'computed_string': matching_item.computed_string }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_date:, string: }' do
          let(:instructions) do
            { 'computed_date': matching_item.computed_date, 'string': matching_item.string }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { date:, string: } }' do
          let(:instructions) do
            { assoc: { 'date': matching_item.assoc.date, 'string': matching_item.assoc.string } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_date:, computed_string: } }' do
          let(:instructions) do
            { assoc: { 'computed_date': matching_item.assoc.computed_date, 'computed_string': matching_item.assoc.computed_string } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { date:, computed_string: } }' do
          let(:instructions) do
            { assoc: { 'date': matching_item.assoc.date, 'computed_string': matching_item.assoc.computed_string } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_date:, string: } }' do
          let(:instructions) do
            { assoc: { 'computed_date': matching_item.assoc.computed_date, 'string': matching_item.assoc.string } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ date:, assoc: { string: } }' do
          let(:instructions) do
            { 'date': matching_item.date, assoc: { 'string': matching_item.assoc.string } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { date: }, string: }' do
          let(:instructions) do
            { assoc: { 'date': matching_item.assoc.date }, 'string': matching_item.string }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ date:, assoc: { computed_string: } }' do
          let(:instructions) do
            { 'date': matching_item.date, assoc: { 'computed_string': matching_item.assoc.computed_string } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { date: }, computed_string: }' do
          let(:instructions) do
            { assoc: { 'date': matching_item.assoc.date }, 'computed_string': matching_item.computed_string }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_date:, assoc: { string: } }' do
          let(:instructions) do
            { 'computed_date': matching_item.computed_date, assoc: { 'string': matching_item.assoc.string } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_date: }, string: }' do
          let(:instructions) do
            { assoc: { 'computed_date': matching_item.assoc.computed_date }, 'string': matching_item.string }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_date:, assoc: { computed_string: } }' do
          let(:instructions) do
            { 'computed_date': matching_item.computed_date, assoc: { 'computed_string': matching_item.assoc.computed_string } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_date: }, computed_string: }' do
          let(:instructions) do
            { assoc: { 'computed_date': matching_item.assoc.computed_date }, 'computed_string': matching_item.computed_string }
          end

          it_behaves_like 'a successful filter'
        end
      end

      context 'matching @foo_2' do
        let(:matching_item) { @foo_2 }

        context '{ date:, string: }' do
          let(:instructions) do
            { 'date': matching_item.date, 'string': matching_item.string }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_date:, computed_string: }' do
          let(:instructions) do
            { 'computed_date': matching_item.computed_date, 'computed_string': matching_item.computed_string }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ date:, computed_string: }' do
          let(:instructions) do
            { 'date': matching_item.date, 'computed_string': matching_item.computed_string }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_date:, string: }' do
          let(:instructions) do
            { 'computed_date': matching_item.computed_date, 'string': matching_item.string }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { date:, string: } }' do
          let(:instructions) do
            { assoc: { 'date': matching_item.assoc.date, 'string': matching_item.assoc.string } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_date:, computed_string: } }' do
          let(:instructions) do
            { assoc: { 'computed_date': matching_item.assoc.computed_date, 'computed_string': matching_item.assoc.computed_string } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { date:, computed_string: } }' do
          let(:instructions) do
            { assoc: { 'date': matching_item.assoc.date, 'computed_string': matching_item.assoc.computed_string } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_date:, string: } }' do
          let(:instructions) do
            { assoc: { 'computed_date': matching_item.assoc.computed_date, 'string': matching_item.assoc.string } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ date:, assoc: { string: } }' do
          let(:instructions) do
            { 'date': matching_item.date, assoc: { 'string': matching_item.assoc.string } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { date: }, string: }' do
          let(:instructions) do
            { assoc: { 'date': matching_item.assoc.date }, 'string': matching_item.string }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ date:, assoc: { computed_string: } }' do
          let(:instructions) do
            { 'date': matching_item.date, assoc: { 'computed_string': matching_item.assoc.computed_string } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { date: }, computed_string: }' do
          let(:instructions) do
            { assoc: { 'date': matching_item.assoc.date }, 'computed_string': matching_item.computed_string }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_date:, assoc: { string: } }' do
          let(:instructions) do
            { 'computed_date': matching_item.computed_date, assoc: { 'string': matching_item.assoc.string } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_date: }, string: }' do
          let(:instructions) do
            { assoc: { 'computed_date': matching_item.assoc.computed_date }, 'string': matching_item.string }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_date:, assoc: { computed_string: } }' do
          let(:instructions) do
            { 'computed_date': matching_item.computed_date, assoc: { 'computed_string': matching_item.assoc.computed_string } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_date: }, computed_string: }' do
          let(:instructions) do
            { assoc: { 'computed_date': matching_item.assoc.computed_date }, 'computed_string': matching_item.computed_string }
          end

          it_behaves_like 'a successful filter'
        end
      end
    end

    context 'with DATE and TEXT type' do
      context 'matching @foo_1' do
        let(:matching_item) { @foo_1 }

        context '{ date:, text: }' do
          let(:instructions) do
            { 'date': matching_item.date, 'text': matching_item.text }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_date:, computed_text: }' do
          let(:instructions) do
            { 'computed_date': matching_item.computed_date, 'computed_text': matching_item.computed_text }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ date:, computed_text: }' do
          let(:instructions) do
            { 'date': matching_item.date, 'computed_text': matching_item.computed_text }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_date:, text: }' do
          let(:instructions) do
            { 'computed_date': matching_item.computed_date, 'text': matching_item.text }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { date:, text: } }' do
          let(:instructions) do
            { assoc: { 'date': matching_item.assoc.date, 'text': matching_item.assoc.text } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_date:, computed_text: } }' do
          let(:instructions) do
            { assoc: { 'computed_date': matching_item.assoc.computed_date, 'computed_text': matching_item.assoc.computed_text } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { date:, computed_text: } }' do
          let(:instructions) do
            { assoc: { 'date': matching_item.assoc.date, 'computed_text': matching_item.assoc.computed_text } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_date:, text: } }' do
          let(:instructions) do
            { assoc: { 'computed_date': matching_item.assoc.computed_date, 'text': matching_item.assoc.text } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ date:, assoc: { text: } }' do
          let(:instructions) do
            { 'date': matching_item.date, assoc: { 'text': matching_item.assoc.text } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { date: }, text: }' do
          let(:instructions) do
            { assoc: { 'date': matching_item.assoc.date }, 'text': matching_item.text }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ date:, assoc: { computed_text: } }' do
          let(:instructions) do
            { 'date': matching_item.date, assoc: { 'computed_text': matching_item.assoc.computed_text } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { date: }, computed_text: }' do
          let(:instructions) do
            { assoc: { 'date': matching_item.assoc.date }, 'computed_text': matching_item.computed_text }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_date:, assoc: { text: } }' do
          let(:instructions) do
            { 'computed_date': matching_item.computed_date, assoc: { 'text': matching_item.assoc.text } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_date: }, text: }' do
          let(:instructions) do
            { assoc: { 'computed_date': matching_item.assoc.computed_date }, 'text': matching_item.text }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_date:, assoc: { computed_text: } }' do
          let(:instructions) do
            { 'computed_date': matching_item.computed_date, assoc: { 'computed_text': matching_item.assoc.computed_text } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_date: }, computed_text: }' do
          let(:instructions) do
            { assoc: { 'computed_date': matching_item.assoc.computed_date }, 'computed_text': matching_item.computed_text }
          end

          it_behaves_like 'a successful filter'
        end
      end

      context 'matching @foo_2' do
        let(:matching_item) { @foo_2 }

        context '{ date:, text: }' do
          let(:instructions) do
            { 'date': matching_item.date, 'text': matching_item.text }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_date:, computed_text: }' do
          let(:instructions) do
            { 'computed_date': matching_item.computed_date, 'computed_text': matching_item.computed_text }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ date:, computed_text: }' do
          let(:instructions) do
            { 'date': matching_item.date, 'computed_text': matching_item.computed_text }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_date:, text: }' do
          let(:instructions) do
            { 'computed_date': matching_item.computed_date, 'text': matching_item.text }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { date:, text: } }' do
          let(:instructions) do
            { assoc: { 'date': matching_item.assoc.date, 'text': matching_item.assoc.text } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_date:, computed_text: } }' do
          let(:instructions) do
            { assoc: { 'computed_date': matching_item.assoc.computed_date, 'computed_text': matching_item.assoc.computed_text } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { date:, computed_text: } }' do
          let(:instructions) do
            { assoc: { 'date': matching_item.assoc.date, 'computed_text': matching_item.assoc.computed_text } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_date:, text: } }' do
          let(:instructions) do
            { assoc: { 'computed_date': matching_item.assoc.computed_date, 'text': matching_item.assoc.text } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ date:, assoc: { text: } }' do
          let(:instructions) do
            { 'date': matching_item.date, assoc: { 'text': matching_item.assoc.text } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { date: }, text: }' do
          let(:instructions) do
            { assoc: { 'date': matching_item.assoc.date }, 'text': matching_item.text }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ date:, assoc: { computed_text: } }' do
          let(:instructions) do
            { 'date': matching_item.date, assoc: { 'computed_text': matching_item.assoc.computed_text } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { date: }, computed_text: }' do
          let(:instructions) do
            { assoc: { 'date': matching_item.assoc.date }, 'computed_text': matching_item.computed_text }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_date:, assoc: { text: } }' do
          let(:instructions) do
            { 'computed_date': matching_item.computed_date, assoc: { 'text': matching_item.assoc.text } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_date: }, text: }' do
          let(:instructions) do
            { assoc: { 'computed_date': matching_item.assoc.computed_date }, 'text': matching_item.text }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_date:, assoc: { computed_text: } }' do
          let(:instructions) do
            { 'computed_date': matching_item.computed_date, assoc: { 'computed_text': matching_item.assoc.computed_text } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_date: }, computed_text: }' do
          let(:instructions) do
            { assoc: { 'computed_date': matching_item.assoc.computed_date }, 'computed_text': matching_item.computed_text }
          end

          it_behaves_like 'a successful filter'
        end
      end
    end

    context 'with DATE and TIME type' do
      context 'matching @foo_1' do
        let(:matching_item) { @foo_1 }

        context '{ date:, time: }' do
          let(:instructions) do
            { 'date': matching_item.date, 'time': matching_item.time }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_date:, computed_time: }' do
          let(:instructions) do
            { 'computed_date': matching_item.computed_date, 'computed_time': matching_item.computed_time }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ date:, computed_time: }' do
          let(:instructions) do
            { 'date': matching_item.date, 'computed_time': matching_item.computed_time }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_date:, time: }' do
          let(:instructions) do
            { 'computed_date': matching_item.computed_date, 'time': matching_item.time }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { date:, time: } }' do
          let(:instructions) do
            { assoc: { 'date': matching_item.assoc.date, 'time': matching_item.assoc.time } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_date:, computed_time: } }' do
          let(:instructions) do
            { assoc: { 'computed_date': matching_item.assoc.computed_date, 'computed_time': matching_item.assoc.computed_time } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { date:, computed_time: } }' do
          let(:instructions) do
            { assoc: { 'date': matching_item.assoc.date, 'computed_time': matching_item.assoc.computed_time } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_date:, time: } }' do
          let(:instructions) do
            { assoc: { 'computed_date': matching_item.assoc.computed_date, 'time': matching_item.assoc.time } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ date:, assoc: { time: } }' do
          let(:instructions) do
            { 'date': matching_item.date, assoc: { 'time': matching_item.assoc.time } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { date: }, time: }' do
          let(:instructions) do
            { assoc: { 'date': matching_item.assoc.date }, 'time': matching_item.time }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ date:, assoc: { computed_time: } }' do
          let(:instructions) do
            { 'date': matching_item.date, assoc: { 'computed_time': matching_item.assoc.computed_time } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { date: }, computed_time: }' do
          let(:instructions) do
            { assoc: { 'date': matching_item.assoc.date }, 'computed_time': matching_item.computed_time }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_date:, assoc: { time: } }' do
          let(:instructions) do
            { 'computed_date': matching_item.computed_date, assoc: { 'time': matching_item.assoc.time } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_date: }, time: }' do
          let(:instructions) do
            { assoc: { 'computed_date': matching_item.assoc.computed_date }, 'time': matching_item.time }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_date:, assoc: { computed_time: } }' do
          let(:instructions) do
            { 'computed_date': matching_item.computed_date, assoc: { 'computed_time': matching_item.assoc.computed_time } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_date: }, computed_time: }' do
          let(:instructions) do
            { assoc: { 'computed_date': matching_item.assoc.computed_date }, 'computed_time': matching_item.computed_time }
          end

          it_behaves_like 'a successful filter'
        end
      end

      context 'matching @foo_2' do
        let(:matching_item) { @foo_2 }

        context '{ date:, time: }' do
          let(:instructions) do
            { 'date': matching_item.date, 'time': matching_item.time }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_date:, computed_time: }' do
          let(:instructions) do
            { 'computed_date': matching_item.computed_date, 'computed_time': matching_item.computed_time }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ date:, computed_time: }' do
          let(:instructions) do
            { 'date': matching_item.date, 'computed_time': matching_item.computed_time }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_date:, time: }' do
          let(:instructions) do
            { 'computed_date': matching_item.computed_date, 'time': matching_item.time }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { date:, time: } }' do
          let(:instructions) do
            { assoc: { 'date': matching_item.assoc.date, 'time': matching_item.assoc.time } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_date:, computed_time: } }' do
          let(:instructions) do
            { assoc: { 'computed_date': matching_item.assoc.computed_date, 'computed_time': matching_item.assoc.computed_time } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { date:, computed_time: } }' do
          let(:instructions) do
            { assoc: { 'date': matching_item.assoc.date, 'computed_time': matching_item.assoc.computed_time } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_date:, time: } }' do
          let(:instructions) do
            { assoc: { 'computed_date': matching_item.assoc.computed_date, 'time': matching_item.assoc.time } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ date:, assoc: { time: } }' do
          let(:instructions) do
            { 'date': matching_item.date, assoc: { 'time': matching_item.assoc.time } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { date: }, time: }' do
          let(:instructions) do
            { assoc: { 'date': matching_item.assoc.date }, 'time': matching_item.time }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ date:, assoc: { computed_time: } }' do
          let(:instructions) do
            { 'date': matching_item.date, assoc: { 'computed_time': matching_item.assoc.computed_time } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { date: }, computed_time: }' do
          let(:instructions) do
            { assoc: { 'date': matching_item.assoc.date }, 'computed_time': matching_item.computed_time }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_date:, assoc: { time: } }' do
          let(:instructions) do
            { 'computed_date': matching_item.computed_date, assoc: { 'time': matching_item.assoc.time } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_date: }, time: }' do
          let(:instructions) do
            { assoc: { 'computed_date': matching_item.assoc.computed_date }, 'time': matching_item.time }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_date:, assoc: { computed_time: } }' do
          let(:instructions) do
            { 'computed_date': matching_item.computed_date, assoc: { 'computed_time': matching_item.assoc.computed_time } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_date: }, computed_time: }' do
          let(:instructions) do
            { assoc: { 'computed_date': matching_item.assoc.computed_date }, 'computed_time': matching_item.computed_time }
          end

          it_behaves_like 'a successful filter'
        end
      end
    end


    context 'with DATETIME and DECIMAL type' do
      context 'matching @foo_1' do
        let(:matching_item) { @foo_1 }

        context '{ datetime:, decimal: }' do
          let(:instructions) do
            { 'datetime': matching_item.datetime, 'decimal': matching_item.decimal }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_datetime:, computed_decimal: }' do
          let(:instructions) do
            { 'computed_datetime': matching_item.computed_datetime, 'computed_decimal': matching_item.computed_decimal }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ datetime:, computed_decimal: }' do
          let(:instructions) do
            { 'datetime': matching_item.datetime, 'computed_decimal': matching_item.computed_decimal }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_datetime:, decimal: }' do
          let(:instructions) do
            { 'computed_datetime': matching_item.computed_datetime, 'decimal': matching_item.decimal }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { datetime:, decimal: } }' do
          let(:instructions) do
            { assoc: { 'datetime': matching_item.assoc.datetime, 'decimal': matching_item.assoc.decimal } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_datetime:, computed_decimal: } }' do
          let(:instructions) do
            { assoc: { 'computed_datetime': matching_item.assoc.computed_datetime, 'computed_decimal': matching_item.assoc.computed_decimal } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { datetime:, computed_decimal: } }' do
          let(:instructions) do
            { assoc: { 'datetime': matching_item.assoc.datetime, 'computed_decimal': matching_item.assoc.computed_decimal } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_datetime:, decimal: } }' do
          let(:instructions) do
            { assoc: { 'computed_datetime': matching_item.assoc.computed_datetime, 'decimal': matching_item.assoc.decimal } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ datetime:, assoc: { decimal: } }' do
          let(:instructions) do
            { 'datetime': matching_item.datetime, assoc: { 'decimal': matching_item.assoc.decimal } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { datetime: }, decimal: }' do
          let(:instructions) do
            { assoc: { 'datetime': matching_item.assoc.datetime }, 'decimal': matching_item.decimal }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ datetime:, assoc: { computed_decimal: } }' do
          let(:instructions) do
            { 'datetime': matching_item.datetime, assoc: { 'computed_decimal': matching_item.assoc.computed_decimal } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { datetime: }, computed_decimal: }' do
          let(:instructions) do
            { assoc: { 'datetime': matching_item.assoc.datetime }, 'computed_decimal': matching_item.computed_decimal }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_datetime:, assoc: { decimal: } }' do
          let(:instructions) do
            { 'computed_datetime': matching_item.computed_datetime, assoc: { 'decimal': matching_item.assoc.decimal } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_datetime: }, decimal: }' do
          let(:instructions) do
            { assoc: { 'computed_datetime': matching_item.assoc.computed_datetime }, 'decimal': matching_item.decimal }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_datetime:, assoc: { computed_decimal: } }' do
          let(:instructions) do
            { 'computed_datetime': matching_item.computed_datetime, assoc: { 'computed_decimal': matching_item.assoc.computed_decimal } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_datetime: }, computed_decimal: }' do
          let(:instructions) do
            { assoc: { 'computed_datetime': matching_item.assoc.computed_datetime }, 'computed_decimal': matching_item.computed_decimal }
          end

          it_behaves_like 'a successful filter'
        end
      end

      context 'matching @foo_2' do
        let(:matching_item) { @foo_2 }

        context '{ datetime:, decimal: }' do
          let(:instructions) do
            { 'datetime': matching_item.datetime, 'decimal': matching_item.decimal }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_datetime:, computed_decimal: }' do
          let(:instructions) do
            { 'computed_datetime': matching_item.computed_datetime, 'computed_decimal': matching_item.computed_decimal }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ datetime:, computed_decimal: }' do
          let(:instructions) do
            { 'datetime': matching_item.datetime, 'computed_decimal': matching_item.computed_decimal }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_datetime:, decimal: }' do
          let(:instructions) do
            { 'computed_datetime': matching_item.computed_datetime, 'decimal': matching_item.decimal }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { datetime:, decimal: } }' do
          let(:instructions) do
            { assoc: { 'datetime': matching_item.assoc.datetime, 'decimal': matching_item.assoc.decimal } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_datetime:, computed_decimal: } }' do
          let(:instructions) do
            { assoc: { 'computed_datetime': matching_item.assoc.computed_datetime, 'computed_decimal': matching_item.assoc.computed_decimal } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { datetime:, computed_decimal: } }' do
          let(:instructions) do
            { assoc: { 'datetime': matching_item.assoc.datetime, 'computed_decimal': matching_item.assoc.computed_decimal } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_datetime:, decimal: } }' do
          let(:instructions) do
            { assoc: { 'computed_datetime': matching_item.assoc.computed_datetime, 'decimal': matching_item.assoc.decimal } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ datetime:, assoc: { decimal: } }' do
          let(:instructions) do
            { 'datetime': matching_item.datetime, assoc: { 'decimal': matching_item.assoc.decimal } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { datetime: }, decimal: }' do
          let(:instructions) do
            { assoc: { 'datetime': matching_item.assoc.datetime }, 'decimal': matching_item.decimal }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ datetime:, assoc: { computed_decimal: } }' do
          let(:instructions) do
            { 'datetime': matching_item.datetime, assoc: { 'computed_decimal': matching_item.assoc.computed_decimal } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { datetime: }, computed_decimal: }' do
          let(:instructions) do
            { assoc: { 'datetime': matching_item.assoc.datetime }, 'computed_decimal': matching_item.computed_decimal }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_datetime:, assoc: { decimal: } }' do
          let(:instructions) do
            { 'computed_datetime': matching_item.computed_datetime, assoc: { 'decimal': matching_item.assoc.decimal } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_datetime: }, decimal: }' do
          let(:instructions) do
            { assoc: { 'computed_datetime': matching_item.assoc.computed_datetime }, 'decimal': matching_item.decimal }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_datetime:, assoc: { computed_decimal: } }' do
          let(:instructions) do
            { 'computed_datetime': matching_item.computed_datetime, assoc: { 'computed_decimal': matching_item.assoc.computed_decimal } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_datetime: }, computed_decimal: }' do
          let(:instructions) do
            { assoc: { 'computed_datetime': matching_item.assoc.computed_datetime }, 'computed_decimal': matching_item.computed_decimal }
          end

          it_behaves_like 'a successful filter'
        end
      end
    end

    context 'with DATETIME and FLOAT type' do
      context 'matching @foo_1' do
        let(:matching_item) { @foo_1 }

        context '{ datetime:, float: }' do
          let(:instructions) do
            { 'datetime': matching_item.datetime, 'float': matching_item.float }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_datetime:, computed_float: }' do
          let(:instructions) do
            { 'computed_datetime': matching_item.computed_datetime, 'computed_float': matching_item.computed_float }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ datetime:, computed_float: }' do
          let(:instructions) do
            { 'datetime': matching_item.datetime, 'computed_float': matching_item.computed_float }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_datetime:, float: }' do
          let(:instructions) do
            { 'computed_datetime': matching_item.computed_datetime, 'float': matching_item.float }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { datetime:, float: } }' do
          let(:instructions) do
            { assoc: { 'datetime': matching_item.assoc.datetime, 'float': matching_item.assoc.float } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_datetime:, computed_float: } }' do
          let(:instructions) do
            { assoc: { 'computed_datetime': matching_item.assoc.computed_datetime, 'computed_float': matching_item.assoc.computed_float } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { datetime:, computed_float: } }' do
          let(:instructions) do
            { assoc: { 'datetime': matching_item.assoc.datetime, 'computed_float': matching_item.assoc.computed_float } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_datetime:, float: } }' do
          let(:instructions) do
            { assoc: { 'computed_datetime': matching_item.assoc.computed_datetime, 'float': matching_item.assoc.float } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ datetime:, assoc: { float: } }' do
          let(:instructions) do
            { 'datetime': matching_item.datetime, assoc: { 'float': matching_item.assoc.float } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { datetime: }, float: }' do
          let(:instructions) do
            { assoc: { 'datetime': matching_item.assoc.datetime }, 'float': matching_item.float }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ datetime:, assoc: { computed_float: } }' do
          let(:instructions) do
            { 'datetime': matching_item.datetime, assoc: { 'computed_float': matching_item.assoc.computed_float } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { datetime: }, computed_float: }' do
          let(:instructions) do
            { assoc: { 'datetime': matching_item.assoc.datetime }, 'computed_float': matching_item.computed_float }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_datetime:, assoc: { float: } }' do
          let(:instructions) do
            { 'computed_datetime': matching_item.computed_datetime, assoc: { 'float': matching_item.assoc.float } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_datetime: }, float: }' do
          let(:instructions) do
            { assoc: { 'computed_datetime': matching_item.assoc.computed_datetime }, 'float': matching_item.float }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_datetime:, assoc: { computed_float: } }' do
          let(:instructions) do
            { 'computed_datetime': matching_item.computed_datetime, assoc: { 'computed_float': matching_item.assoc.computed_float } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_datetime: }, computed_float: }' do
          let(:instructions) do
            { assoc: { 'computed_datetime': matching_item.assoc.computed_datetime }, 'computed_float': matching_item.computed_float }
          end

          it_behaves_like 'a successful filter'
        end
      end

      context 'matching @foo_2' do
        let(:matching_item) { @foo_2 }

        context '{ datetime:, float: }' do
          let(:instructions) do
            { 'datetime': matching_item.datetime, 'float': matching_item.float }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_datetime:, computed_float: }' do
          let(:instructions) do
            { 'computed_datetime': matching_item.computed_datetime, 'computed_float': matching_item.computed_float }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ datetime:, computed_float: }' do
          let(:instructions) do
            { 'datetime': matching_item.datetime, 'computed_float': matching_item.computed_float }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_datetime:, float: }' do
          let(:instructions) do
            { 'computed_datetime': matching_item.computed_datetime, 'float': matching_item.float }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { datetime:, float: } }' do
          let(:instructions) do
            { assoc: { 'datetime': matching_item.assoc.datetime, 'float': matching_item.assoc.float } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_datetime:, computed_float: } }' do
          let(:instructions) do
            { assoc: { 'computed_datetime': matching_item.assoc.computed_datetime, 'computed_float': matching_item.assoc.computed_float } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { datetime:, computed_float: } }' do
          let(:instructions) do
            { assoc: { 'datetime': matching_item.assoc.datetime, 'computed_float': matching_item.assoc.computed_float } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_datetime:, float: } }' do
          let(:instructions) do
            { assoc: { 'computed_datetime': matching_item.assoc.computed_datetime, 'float': matching_item.assoc.float } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ datetime:, assoc: { float: } }' do
          let(:instructions) do
            { 'datetime': matching_item.datetime, assoc: { 'float': matching_item.assoc.float } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { datetime: }, float: }' do
          let(:instructions) do
            { assoc: { 'datetime': matching_item.assoc.datetime }, 'float': matching_item.float }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ datetime:, assoc: { computed_float: } }' do
          let(:instructions) do
            { 'datetime': matching_item.datetime, assoc: { 'computed_float': matching_item.assoc.computed_float } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { datetime: }, computed_float: }' do
          let(:instructions) do
            { assoc: { 'datetime': matching_item.assoc.datetime }, 'computed_float': matching_item.computed_float }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_datetime:, assoc: { float: } }' do
          let(:instructions) do
            { 'computed_datetime': matching_item.computed_datetime, assoc: { 'float': matching_item.assoc.float } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_datetime: }, float: }' do
          let(:instructions) do
            { assoc: { 'computed_datetime': matching_item.assoc.computed_datetime }, 'float': matching_item.float }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_datetime:, assoc: { computed_float: } }' do
          let(:instructions) do
            { 'computed_datetime': matching_item.computed_datetime, assoc: { 'computed_float': matching_item.assoc.computed_float } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_datetime: }, computed_float: }' do
          let(:instructions) do
            { assoc: { 'computed_datetime': matching_item.assoc.computed_datetime }, 'computed_float': matching_item.computed_float }
          end

          it_behaves_like 'a successful filter'
        end
      end
    end

    context 'with DATETIME and INTEGER type' do
      context 'matching @foo_1' do
        let(:matching_item) { @foo_1 }

        context '{ datetime:, integer: }' do
          let(:instructions) do
            { 'datetime': matching_item.datetime, 'integer': matching_item.integer }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_datetime:, computed_integer: }' do
          let(:instructions) do
            { 'computed_datetime': matching_item.computed_datetime, 'computed_integer': matching_item.computed_integer }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ datetime:, computed_integer: }' do
          let(:instructions) do
            { 'datetime': matching_item.datetime, 'computed_integer': matching_item.computed_integer }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_datetime:, integer: }' do
          let(:instructions) do
            { 'computed_datetime': matching_item.computed_datetime, 'integer': matching_item.integer }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { datetime:, integer: } }' do
          let(:instructions) do
            { assoc: { 'datetime': matching_item.assoc.datetime, 'integer': matching_item.assoc.integer } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_datetime:, computed_integer: } }' do
          let(:instructions) do
            { assoc: { 'computed_datetime': matching_item.assoc.computed_datetime, 'computed_integer': matching_item.assoc.computed_integer } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { datetime:, computed_integer: } }' do
          let(:instructions) do
            { assoc: { 'datetime': matching_item.assoc.datetime, 'computed_integer': matching_item.assoc.computed_integer } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_datetime:, integer: } }' do
          let(:instructions) do
            { assoc: { 'computed_datetime': matching_item.assoc.computed_datetime, 'integer': matching_item.assoc.integer } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ datetime:, assoc: { integer: } }' do
          let(:instructions) do
            { 'datetime': matching_item.datetime, assoc: { 'integer': matching_item.assoc.integer } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { datetime: }, integer: }' do
          let(:instructions) do
            { assoc: { 'datetime': matching_item.assoc.datetime }, 'integer': matching_item.integer }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ datetime:, assoc: { computed_integer: } }' do
          let(:instructions) do
            { 'datetime': matching_item.datetime, assoc: { 'computed_integer': matching_item.assoc.computed_integer } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { datetime: }, computed_integer: }' do
          let(:instructions) do
            { assoc: { 'datetime': matching_item.assoc.datetime }, 'computed_integer': matching_item.computed_integer }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_datetime:, assoc: { integer: } }' do
          let(:instructions) do
            { 'computed_datetime': matching_item.computed_datetime, assoc: { 'integer': matching_item.assoc.integer } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_datetime: }, integer: }' do
          let(:instructions) do
            { assoc: { 'computed_datetime': matching_item.assoc.computed_datetime }, 'integer': matching_item.integer }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_datetime:, assoc: { computed_integer: } }' do
          let(:instructions) do
            { 'computed_datetime': matching_item.computed_datetime, assoc: { 'computed_integer': matching_item.assoc.computed_integer } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_datetime: }, computed_integer: }' do
          let(:instructions) do
            { assoc: { 'computed_datetime': matching_item.assoc.computed_datetime }, 'computed_integer': matching_item.computed_integer }
          end

          it_behaves_like 'a successful filter'
        end
      end

      context 'matching @foo_2' do
        let(:matching_item) { @foo_2 }

        context '{ datetime:, integer: }' do
          let(:instructions) do
            { 'datetime': matching_item.datetime, 'integer': matching_item.integer }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_datetime:, computed_integer: }' do
          let(:instructions) do
            { 'computed_datetime': matching_item.computed_datetime, 'computed_integer': matching_item.computed_integer }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ datetime:, computed_integer: }' do
          let(:instructions) do
            { 'datetime': matching_item.datetime, 'computed_integer': matching_item.computed_integer }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_datetime:, integer: }' do
          let(:instructions) do
            { 'computed_datetime': matching_item.computed_datetime, 'integer': matching_item.integer }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { datetime:, integer: } }' do
          let(:instructions) do
            { assoc: { 'datetime': matching_item.assoc.datetime, 'integer': matching_item.assoc.integer } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_datetime:, computed_integer: } }' do
          let(:instructions) do
            { assoc: { 'computed_datetime': matching_item.assoc.computed_datetime, 'computed_integer': matching_item.assoc.computed_integer } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { datetime:, computed_integer: } }' do
          let(:instructions) do
            { assoc: { 'datetime': matching_item.assoc.datetime, 'computed_integer': matching_item.assoc.computed_integer } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_datetime:, integer: } }' do
          let(:instructions) do
            { assoc: { 'computed_datetime': matching_item.assoc.computed_datetime, 'integer': matching_item.assoc.integer } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ datetime:, assoc: { integer: } }' do
          let(:instructions) do
            { 'datetime': matching_item.datetime, assoc: { 'integer': matching_item.assoc.integer } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { datetime: }, integer: }' do
          let(:instructions) do
            { assoc: { 'datetime': matching_item.assoc.datetime }, 'integer': matching_item.integer }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ datetime:, assoc: { computed_integer: } }' do
          let(:instructions) do
            { 'datetime': matching_item.datetime, assoc: { 'computed_integer': matching_item.assoc.computed_integer } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { datetime: }, computed_integer: }' do
          let(:instructions) do
            { assoc: { 'datetime': matching_item.assoc.datetime }, 'computed_integer': matching_item.computed_integer }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_datetime:, assoc: { integer: } }' do
          let(:instructions) do
            { 'computed_datetime': matching_item.computed_datetime, assoc: { 'integer': matching_item.assoc.integer } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_datetime: }, integer: }' do
          let(:instructions) do
            { assoc: { 'computed_datetime': matching_item.assoc.computed_datetime }, 'integer': matching_item.integer }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_datetime:, assoc: { computed_integer: } }' do
          let(:instructions) do
            { 'computed_datetime': matching_item.computed_datetime, assoc: { 'computed_integer': matching_item.assoc.computed_integer } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_datetime: }, computed_integer: }' do
          let(:instructions) do
            { assoc: { 'computed_datetime': matching_item.assoc.computed_datetime }, 'computed_integer': matching_item.computed_integer }
          end

          it_behaves_like 'a successful filter'
        end
      end
    end

    context 'with DATETIME and STRING type' do
      context 'matching @foo_1' do
        let(:matching_item) { @foo_1 }

        context '{ datetime:, string: }' do
          let(:instructions) do
            { 'datetime': matching_item.datetime, 'string': matching_item.string }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_datetime:, computed_string: }' do
          let(:instructions) do
            { 'computed_datetime': matching_item.computed_datetime, 'computed_string': matching_item.computed_string }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ datetime:, computed_string: }' do
          let(:instructions) do
            { 'datetime': matching_item.datetime, 'computed_string': matching_item.computed_string }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_datetime:, string: }' do
          let(:instructions) do
            { 'computed_datetime': matching_item.computed_datetime, 'string': matching_item.string }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { datetime:, string: } }' do
          let(:instructions) do
            { assoc: { 'datetime': matching_item.assoc.datetime, 'string': matching_item.assoc.string } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_datetime:, computed_string: } }' do
          let(:instructions) do
            { assoc: { 'computed_datetime': matching_item.assoc.computed_datetime, 'computed_string': matching_item.assoc.computed_string } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { datetime:, computed_string: } }' do
          let(:instructions) do
            { assoc: { 'datetime': matching_item.assoc.datetime, 'computed_string': matching_item.assoc.computed_string } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_datetime:, string: } }' do
          let(:instructions) do
            { assoc: { 'computed_datetime': matching_item.assoc.computed_datetime, 'string': matching_item.assoc.string } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ datetime:, assoc: { string: } }' do
          let(:instructions) do
            { 'datetime': matching_item.datetime, assoc: { 'string': matching_item.assoc.string } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { datetime: }, string: }' do
          let(:instructions) do
            { assoc: { 'datetime': matching_item.assoc.datetime }, 'string': matching_item.string }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ datetime:, assoc: { computed_string: } }' do
          let(:instructions) do
            { 'datetime': matching_item.datetime, assoc: { 'computed_string': matching_item.assoc.computed_string } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { datetime: }, computed_string: }' do
          let(:instructions) do
            { assoc: { 'datetime': matching_item.assoc.datetime }, 'computed_string': matching_item.computed_string }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_datetime:, assoc: { string: } }' do
          let(:instructions) do
            { 'computed_datetime': matching_item.computed_datetime, assoc: { 'string': matching_item.assoc.string } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_datetime: }, string: }' do
          let(:instructions) do
            { assoc: { 'computed_datetime': matching_item.assoc.computed_datetime }, 'string': matching_item.string }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_datetime:, assoc: { computed_string: } }' do
          let(:instructions) do
            { 'computed_datetime': matching_item.computed_datetime, assoc: { 'computed_string': matching_item.assoc.computed_string } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_datetime: }, computed_string: }' do
          let(:instructions) do
            { assoc: { 'computed_datetime': matching_item.assoc.computed_datetime }, 'computed_string': matching_item.computed_string }
          end

          it_behaves_like 'a successful filter'
        end
      end

      context 'matching @foo_2' do
        let(:matching_item) { @foo_2 }

        context '{ datetime:, string: }' do
          let(:instructions) do
            { 'datetime': matching_item.datetime, 'string': matching_item.string }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_datetime:, computed_string: }' do
          let(:instructions) do
            { 'computed_datetime': matching_item.computed_datetime, 'computed_string': matching_item.computed_string }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ datetime:, computed_string: }' do
          let(:instructions) do
            { 'datetime': matching_item.datetime, 'computed_string': matching_item.computed_string }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_datetime:, string: }' do
          let(:instructions) do
            { 'computed_datetime': matching_item.computed_datetime, 'string': matching_item.string }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { datetime:, string: } }' do
          let(:instructions) do
            { assoc: { 'datetime': matching_item.assoc.datetime, 'string': matching_item.assoc.string } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_datetime:, computed_string: } }' do
          let(:instructions) do
            { assoc: { 'computed_datetime': matching_item.assoc.computed_datetime, 'computed_string': matching_item.assoc.computed_string } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { datetime:, computed_string: } }' do
          let(:instructions) do
            { assoc: { 'datetime': matching_item.assoc.datetime, 'computed_string': matching_item.assoc.computed_string } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_datetime:, string: } }' do
          let(:instructions) do
            { assoc: { 'computed_datetime': matching_item.assoc.computed_datetime, 'string': matching_item.assoc.string } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ datetime:, assoc: { string: } }' do
          let(:instructions) do
            { 'datetime': matching_item.datetime, assoc: { 'string': matching_item.assoc.string } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { datetime: }, string: }' do
          let(:instructions) do
            { assoc: { 'datetime': matching_item.assoc.datetime }, 'string': matching_item.string }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ datetime:, assoc: { computed_string: } }' do
          let(:instructions) do
            { 'datetime': matching_item.datetime, assoc: { 'computed_string': matching_item.assoc.computed_string } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { datetime: }, computed_string: }' do
          let(:instructions) do
            { assoc: { 'datetime': matching_item.assoc.datetime }, 'computed_string': matching_item.computed_string }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_datetime:, assoc: { string: } }' do
          let(:instructions) do
            { 'computed_datetime': matching_item.computed_datetime, assoc: { 'string': matching_item.assoc.string } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_datetime: }, string: }' do
          let(:instructions) do
            { assoc: { 'computed_datetime': matching_item.assoc.computed_datetime }, 'string': matching_item.string }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_datetime:, assoc: { computed_string: } }' do
          let(:instructions) do
            { 'computed_datetime': matching_item.computed_datetime, assoc: { 'computed_string': matching_item.assoc.computed_string } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_datetime: }, computed_string: }' do
          let(:instructions) do
            { assoc: { 'computed_datetime': matching_item.assoc.computed_datetime }, 'computed_string': matching_item.computed_string }
          end

          it_behaves_like 'a successful filter'
        end
      end
    end

    context 'with DATETIME and TEXT type' do
      context 'matching @foo_1' do
        let(:matching_item) { @foo_1 }

        context '{ datetime:, text: }' do
          let(:instructions) do
            { 'datetime': matching_item.datetime, 'text': matching_item.text }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_datetime:, computed_text: }' do
          let(:instructions) do
            { 'computed_datetime': matching_item.computed_datetime, 'computed_text': matching_item.computed_text }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ datetime:, computed_text: }' do
          let(:instructions) do
            { 'datetime': matching_item.datetime, 'computed_text': matching_item.computed_text }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_datetime:, text: }' do
          let(:instructions) do
            { 'computed_datetime': matching_item.computed_datetime, 'text': matching_item.text }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { datetime:, text: } }' do
          let(:instructions) do
            { assoc: { 'datetime': matching_item.assoc.datetime, 'text': matching_item.assoc.text } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_datetime:, computed_text: } }' do
          let(:instructions) do
            { assoc: { 'computed_datetime': matching_item.assoc.computed_datetime, 'computed_text': matching_item.assoc.computed_text } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { datetime:, computed_text: } }' do
          let(:instructions) do
            { assoc: { 'datetime': matching_item.assoc.datetime, 'computed_text': matching_item.assoc.computed_text } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_datetime:, text: } }' do
          let(:instructions) do
            { assoc: { 'computed_datetime': matching_item.assoc.computed_datetime, 'text': matching_item.assoc.text } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ datetime:, assoc: { text: } }' do
          let(:instructions) do
            { 'datetime': matching_item.datetime, assoc: { 'text': matching_item.assoc.text } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { datetime: }, text: }' do
          let(:instructions) do
            { assoc: { 'datetime': matching_item.assoc.datetime }, 'text': matching_item.text }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ datetime:, assoc: { computed_text: } }' do
          let(:instructions) do
            { 'datetime': matching_item.datetime, assoc: { 'computed_text': matching_item.assoc.computed_text } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { datetime: }, computed_text: }' do
          let(:instructions) do
            { assoc: { 'datetime': matching_item.assoc.datetime }, 'computed_text': matching_item.computed_text }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_datetime:, assoc: { text: } }' do
          let(:instructions) do
            { 'computed_datetime': matching_item.computed_datetime, assoc: { 'text': matching_item.assoc.text } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_datetime: }, text: }' do
          let(:instructions) do
            { assoc: { 'computed_datetime': matching_item.assoc.computed_datetime }, 'text': matching_item.text }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_datetime:, assoc: { computed_text: } }' do
          let(:instructions) do
            { 'computed_datetime': matching_item.computed_datetime, assoc: { 'computed_text': matching_item.assoc.computed_text } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_datetime: }, computed_text: }' do
          let(:instructions) do
            { assoc: { 'computed_datetime': matching_item.assoc.computed_datetime }, 'computed_text': matching_item.computed_text }
          end

          it_behaves_like 'a successful filter'
        end
      end

      context 'matching @foo_2' do
        let(:matching_item) { @foo_2 }

        context '{ datetime:, text: }' do
          let(:instructions) do
            { 'datetime': matching_item.datetime, 'text': matching_item.text }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_datetime:, computed_text: }' do
          let(:instructions) do
            { 'computed_datetime': matching_item.computed_datetime, 'computed_text': matching_item.computed_text }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ datetime:, computed_text: }' do
          let(:instructions) do
            { 'datetime': matching_item.datetime, 'computed_text': matching_item.computed_text }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_datetime:, text: }' do
          let(:instructions) do
            { 'computed_datetime': matching_item.computed_datetime, 'text': matching_item.text }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { datetime:, text: } }' do
          let(:instructions) do
            { assoc: { 'datetime': matching_item.assoc.datetime, 'text': matching_item.assoc.text } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_datetime:, computed_text: } }' do
          let(:instructions) do
            { assoc: { 'computed_datetime': matching_item.assoc.computed_datetime, 'computed_text': matching_item.assoc.computed_text } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { datetime:, computed_text: } }' do
          let(:instructions) do
            { assoc: { 'datetime': matching_item.assoc.datetime, 'computed_text': matching_item.assoc.computed_text } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_datetime:, text: } }' do
          let(:instructions) do
            { assoc: { 'computed_datetime': matching_item.assoc.computed_datetime, 'text': matching_item.assoc.text } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ datetime:, assoc: { text: } }' do
          let(:instructions) do
            { 'datetime': matching_item.datetime, assoc: { 'text': matching_item.assoc.text } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { datetime: }, text: }' do
          let(:instructions) do
            { assoc: { 'datetime': matching_item.assoc.datetime }, 'text': matching_item.text }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ datetime:, assoc: { computed_text: } }' do
          let(:instructions) do
            { 'datetime': matching_item.datetime, assoc: { 'computed_text': matching_item.assoc.computed_text } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { datetime: }, computed_text: }' do
          let(:instructions) do
            { assoc: { 'datetime': matching_item.assoc.datetime }, 'computed_text': matching_item.computed_text }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_datetime:, assoc: { text: } }' do
          let(:instructions) do
            { 'computed_datetime': matching_item.computed_datetime, assoc: { 'text': matching_item.assoc.text } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_datetime: }, text: }' do
          let(:instructions) do
            { assoc: { 'computed_datetime': matching_item.assoc.computed_datetime }, 'text': matching_item.text }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_datetime:, assoc: { computed_text: } }' do
          let(:instructions) do
            { 'computed_datetime': matching_item.computed_datetime, assoc: { 'computed_text': matching_item.assoc.computed_text } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_datetime: }, computed_text: }' do
          let(:instructions) do
            { assoc: { 'computed_datetime': matching_item.assoc.computed_datetime }, 'computed_text': matching_item.computed_text }
          end

          it_behaves_like 'a successful filter'
        end
      end
    end

    context 'with DATETIME and TIME type' do
      context 'matching @foo_1' do
        let(:matching_item) { @foo_1 }

        context '{ datetime:, time: }' do
          let(:instructions) do
            { 'datetime': matching_item.datetime, 'time': matching_item.time }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_datetime:, computed_time: }' do
          let(:instructions) do
            { 'computed_datetime': matching_item.computed_datetime, 'computed_time': matching_item.computed_time }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ datetime:, computed_time: }' do
          let(:instructions) do
            { 'datetime': matching_item.datetime, 'computed_time': matching_item.computed_time }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_datetime:, time: }' do
          let(:instructions) do
            { 'computed_datetime': matching_item.computed_datetime, 'time': matching_item.time }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { datetime:, time: } }' do
          let(:instructions) do
            { assoc: { 'datetime': matching_item.assoc.datetime, 'time': matching_item.assoc.time } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_datetime:, computed_time: } }' do
          let(:instructions) do
            { assoc: { 'computed_datetime': matching_item.assoc.computed_datetime, 'computed_time': matching_item.assoc.computed_time } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { datetime:, computed_time: } }' do
          let(:instructions) do
            { assoc: { 'datetime': matching_item.assoc.datetime, 'computed_time': matching_item.assoc.computed_time } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_datetime:, time: } }' do
          let(:instructions) do
            { assoc: { 'computed_datetime': matching_item.assoc.computed_datetime, 'time': matching_item.assoc.time } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ datetime:, assoc: { time: } }' do
          let(:instructions) do
            { 'datetime': matching_item.datetime, assoc: { 'time': matching_item.assoc.time } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { datetime: }, time: }' do
          let(:instructions) do
            { assoc: { 'datetime': matching_item.assoc.datetime }, 'time': matching_item.time }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ datetime:, assoc: { computed_time: } }' do
          let(:instructions) do
            { 'datetime': matching_item.datetime, assoc: { 'computed_time': matching_item.assoc.computed_time } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { datetime: }, computed_time: }' do
          let(:instructions) do
            { assoc: { 'datetime': matching_item.assoc.datetime }, 'computed_time': matching_item.computed_time }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_datetime:, assoc: { time: } }' do
          let(:instructions) do
            { 'computed_datetime': matching_item.computed_datetime, assoc: { 'time': matching_item.assoc.time } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_datetime: }, time: }' do
          let(:instructions) do
            { assoc: { 'computed_datetime': matching_item.assoc.computed_datetime }, 'time': matching_item.time }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_datetime:, assoc: { computed_time: } }' do
          let(:instructions) do
            { 'computed_datetime': matching_item.computed_datetime, assoc: { 'computed_time': matching_item.assoc.computed_time } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_datetime: }, computed_time: }' do
          let(:instructions) do
            { assoc: { 'computed_datetime': matching_item.assoc.computed_datetime }, 'computed_time': matching_item.computed_time }
          end

          it_behaves_like 'a successful filter'
        end
      end

      context 'matching @foo_2' do
        let(:matching_item) { @foo_2 }

        context '{ datetime:, time: }' do
          let(:instructions) do
            { 'datetime': matching_item.datetime, 'time': matching_item.time }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_datetime:, computed_time: }' do
          let(:instructions) do
            { 'computed_datetime': matching_item.computed_datetime, 'computed_time': matching_item.computed_time }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ datetime:, computed_time: }' do
          let(:instructions) do
            { 'datetime': matching_item.datetime, 'computed_time': matching_item.computed_time }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_datetime:, time: }' do
          let(:instructions) do
            { 'computed_datetime': matching_item.computed_datetime, 'time': matching_item.time }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { datetime:, time: } }' do
          let(:instructions) do
            { assoc: { 'datetime': matching_item.assoc.datetime, 'time': matching_item.assoc.time } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_datetime:, computed_time: } }' do
          let(:instructions) do
            { assoc: { 'computed_datetime': matching_item.assoc.computed_datetime, 'computed_time': matching_item.assoc.computed_time } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { datetime:, computed_time: } }' do
          let(:instructions) do
            { assoc: { 'datetime': matching_item.assoc.datetime, 'computed_time': matching_item.assoc.computed_time } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_datetime:, time: } }' do
          let(:instructions) do
            { assoc: { 'computed_datetime': matching_item.assoc.computed_datetime, 'time': matching_item.assoc.time } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ datetime:, assoc: { time: } }' do
          let(:instructions) do
            { 'datetime': matching_item.datetime, assoc: { 'time': matching_item.assoc.time } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { datetime: }, time: }' do
          let(:instructions) do
            { assoc: { 'datetime': matching_item.assoc.datetime }, 'time': matching_item.time }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ datetime:, assoc: { computed_time: } }' do
          let(:instructions) do
            { 'datetime': matching_item.datetime, assoc: { 'computed_time': matching_item.assoc.computed_time } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { datetime: }, computed_time: }' do
          let(:instructions) do
            { assoc: { 'datetime': matching_item.assoc.datetime }, 'computed_time': matching_item.computed_time }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_datetime:, assoc: { time: } }' do
          let(:instructions) do
            { 'computed_datetime': matching_item.computed_datetime, assoc: { 'time': matching_item.assoc.time } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_datetime: }, time: }' do
          let(:instructions) do
            { assoc: { 'computed_datetime': matching_item.assoc.computed_datetime }, 'time': matching_item.time }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_datetime:, assoc: { computed_time: } }' do
          let(:instructions) do
            { 'computed_datetime': matching_item.computed_datetime, assoc: { 'computed_time': matching_item.assoc.computed_time } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_datetime: }, computed_time: }' do
          let(:instructions) do
            { assoc: { 'computed_datetime': matching_item.assoc.computed_datetime }, 'computed_time': matching_item.computed_time }
          end

          it_behaves_like 'a successful filter'
        end
      end
    end


    context 'with DECIMAL and FLOAT type' do
      context 'matching @foo_1' do
        let(:matching_item) { @foo_1 }

        context '{ decimal:, float: }' do
          let(:instructions) do
            { 'decimal': matching_item.decimal, 'float': matching_item.float }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_decimal:, computed_float: }' do
          let(:instructions) do
            { 'computed_decimal': matching_item.computed_decimal, 'computed_float': matching_item.computed_float }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ decimal:, computed_float: }' do
          let(:instructions) do
            { 'decimal': matching_item.decimal, 'computed_float': matching_item.computed_float }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_decimal:, float: }' do
          let(:instructions) do
            { 'computed_decimal': matching_item.computed_decimal, 'float': matching_item.float }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { decimal:, float: } }' do
          let(:instructions) do
            { assoc: { 'decimal': matching_item.assoc.decimal, 'float': matching_item.assoc.float } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_decimal:, computed_float: } }' do
          let(:instructions) do
            { assoc: { 'computed_decimal': matching_item.assoc.computed_decimal, 'computed_float': matching_item.assoc.computed_float } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { decimal:, computed_float: } }' do
          let(:instructions) do
            { assoc: { 'decimal': matching_item.assoc.decimal, 'computed_float': matching_item.assoc.computed_float } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_decimal:, float: } }' do
          let(:instructions) do
            { assoc: { 'computed_decimal': matching_item.assoc.computed_decimal, 'float': matching_item.assoc.float } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ decimal:, assoc: { float: } }' do
          let(:instructions) do
            { 'decimal': matching_item.decimal, assoc: { 'float': matching_item.assoc.float } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { decimal: }, float: }' do
          let(:instructions) do
            { assoc: { 'decimal': matching_item.assoc.decimal }, 'float': matching_item.float }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ decimal:, assoc: { computed_float: } }' do
          let(:instructions) do
            { 'decimal': matching_item.decimal, assoc: { 'computed_float': matching_item.assoc.computed_float } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { decimal: }, computed_float: }' do
          let(:instructions) do
            { assoc: { 'decimal': matching_item.assoc.decimal }, 'computed_float': matching_item.computed_float }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_decimal:, assoc: { float: } }' do
          let(:instructions) do
            { 'computed_decimal': matching_item.computed_decimal, assoc: { 'float': matching_item.assoc.float } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_decimal: }, float: }' do
          let(:instructions) do
            { assoc: { 'computed_decimal': matching_item.assoc.computed_decimal }, 'float': matching_item.float }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_decimal:, assoc: { computed_float: } }' do
          let(:instructions) do
            { 'computed_decimal': matching_item.computed_decimal, assoc: { 'computed_float': matching_item.assoc.computed_float } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_decimal: }, computed_float: }' do
          let(:instructions) do
            { assoc: { 'computed_decimal': matching_item.assoc.computed_decimal }, 'computed_float': matching_item.computed_float }
          end

          it_behaves_like 'a successful filter'
        end
      end

      context 'matching @foo_2' do
        let(:matching_item) { @foo_2 }

        context '{ decimal:, float: }' do
          let(:instructions) do
            { 'decimal': matching_item.decimal, 'float': matching_item.float }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_decimal:, computed_float: }' do
          let(:instructions) do
            { 'computed_decimal': matching_item.computed_decimal, 'computed_float': matching_item.computed_float }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ decimal:, computed_float: }' do
          let(:instructions) do
            { 'decimal': matching_item.decimal, 'computed_float': matching_item.computed_float }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_decimal:, float: }' do
          let(:instructions) do
            { 'computed_decimal': matching_item.computed_decimal, 'float': matching_item.float }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { decimal:, float: } }' do
          let(:instructions) do
            { assoc: { 'decimal': matching_item.assoc.decimal, 'float': matching_item.assoc.float } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_decimal:, computed_float: } }' do
          let(:instructions) do
            { assoc: { 'computed_decimal': matching_item.assoc.computed_decimal, 'computed_float': matching_item.assoc.computed_float } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { decimal:, computed_float: } }' do
          let(:instructions) do
            { assoc: { 'decimal': matching_item.assoc.decimal, 'computed_float': matching_item.assoc.computed_float } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_decimal:, float: } }' do
          let(:instructions) do
            { assoc: { 'computed_decimal': matching_item.assoc.computed_decimal, 'float': matching_item.assoc.float } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ decimal:, assoc: { float: } }' do
          let(:instructions) do
            { 'decimal': matching_item.decimal, assoc: { 'float': matching_item.assoc.float } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { decimal: }, float: }' do
          let(:instructions) do
            { assoc: { 'decimal': matching_item.assoc.decimal }, 'float': matching_item.float }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ decimal:, assoc: { computed_float: } }' do
          let(:instructions) do
            { 'decimal': matching_item.decimal, assoc: { 'computed_float': matching_item.assoc.computed_float } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { decimal: }, computed_float: }' do
          let(:instructions) do
            { assoc: { 'decimal': matching_item.assoc.decimal }, 'computed_float': matching_item.computed_float }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_decimal:, assoc: { float: } }' do
          let(:instructions) do
            { 'computed_decimal': matching_item.computed_decimal, assoc: { 'float': matching_item.assoc.float } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_decimal: }, float: }' do
          let(:instructions) do
            { assoc: { 'computed_decimal': matching_item.assoc.computed_decimal }, 'float': matching_item.float }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_decimal:, assoc: { computed_float: } }' do
          let(:instructions) do
            { 'computed_decimal': matching_item.computed_decimal, assoc: { 'computed_float': matching_item.assoc.computed_float } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_decimal: }, computed_float: }' do
          let(:instructions) do
            { assoc: { 'computed_decimal': matching_item.assoc.computed_decimal }, 'computed_float': matching_item.computed_float }
          end

          it_behaves_like 'a successful filter'
        end
      end
    end

    context 'with DECIMAL and INTEGER type' do
      context 'matching @foo_1' do
        let(:matching_item) { @foo_1 }

        context '{ decimal:, integer: }' do
          let(:instructions) do
            { 'decimal': matching_item.decimal, 'integer': matching_item.integer }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_decimal:, computed_integer: }' do
          let(:instructions) do
            { 'computed_decimal': matching_item.computed_decimal, 'computed_integer': matching_item.computed_integer }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ decimal:, computed_integer: }' do
          let(:instructions) do
            { 'decimal': matching_item.decimal, 'computed_integer': matching_item.computed_integer }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_decimal:, integer: }' do
          let(:instructions) do
            { 'computed_decimal': matching_item.computed_decimal, 'integer': matching_item.integer }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { decimal:, integer: } }' do
          let(:instructions) do
            { assoc: { 'decimal': matching_item.assoc.decimal, 'integer': matching_item.assoc.integer } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_decimal:, computed_integer: } }' do
          let(:instructions) do
            { assoc: { 'computed_decimal': matching_item.assoc.computed_decimal, 'computed_integer': matching_item.assoc.computed_integer } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { decimal:, computed_integer: } }' do
          let(:instructions) do
            { assoc: { 'decimal': matching_item.assoc.decimal, 'computed_integer': matching_item.assoc.computed_integer } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_decimal:, integer: } }' do
          let(:instructions) do
            { assoc: { 'computed_decimal': matching_item.assoc.computed_decimal, 'integer': matching_item.assoc.integer } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ decimal:, assoc: { integer: } }' do
          let(:instructions) do
            { 'decimal': matching_item.decimal, assoc: { 'integer': matching_item.assoc.integer } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { decimal: }, integer: }' do
          let(:instructions) do
            { assoc: { 'decimal': matching_item.assoc.decimal }, 'integer': matching_item.integer }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ decimal:, assoc: { computed_integer: } }' do
          let(:instructions) do
            { 'decimal': matching_item.decimal, assoc: { 'computed_integer': matching_item.assoc.computed_integer } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { decimal: }, computed_integer: }' do
          let(:instructions) do
            { assoc: { 'decimal': matching_item.assoc.decimal }, 'computed_integer': matching_item.computed_integer }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_decimal:, assoc: { integer: } }' do
          let(:instructions) do
            { 'computed_decimal': matching_item.computed_decimal, assoc: { 'integer': matching_item.assoc.integer } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_decimal: }, integer: }' do
          let(:instructions) do
            { assoc: { 'computed_decimal': matching_item.assoc.computed_decimal }, 'integer': matching_item.integer }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_decimal:, assoc: { computed_integer: } }' do
          let(:instructions) do
            { 'computed_decimal': matching_item.computed_decimal, assoc: { 'computed_integer': matching_item.assoc.computed_integer } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_decimal: }, computed_integer: }' do
          let(:instructions) do
            { assoc: { 'computed_decimal': matching_item.assoc.computed_decimal }, 'computed_integer': matching_item.computed_integer }
          end

          it_behaves_like 'a successful filter'
        end
      end

      context 'matching @foo_2' do
        let(:matching_item) { @foo_2 }

        context '{ decimal:, integer: }' do
          let(:instructions) do
            { 'decimal': matching_item.decimal, 'integer': matching_item.integer }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_decimal:, computed_integer: }' do
          let(:instructions) do
            { 'computed_decimal': matching_item.computed_decimal, 'computed_integer': matching_item.computed_integer }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ decimal:, computed_integer: }' do
          let(:instructions) do
            { 'decimal': matching_item.decimal, 'computed_integer': matching_item.computed_integer }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_decimal:, integer: }' do
          let(:instructions) do
            { 'computed_decimal': matching_item.computed_decimal, 'integer': matching_item.integer }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { decimal:, integer: } }' do
          let(:instructions) do
            { assoc: { 'decimal': matching_item.assoc.decimal, 'integer': matching_item.assoc.integer } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_decimal:, computed_integer: } }' do
          let(:instructions) do
            { assoc: { 'computed_decimal': matching_item.assoc.computed_decimal, 'computed_integer': matching_item.assoc.computed_integer } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { decimal:, computed_integer: } }' do
          let(:instructions) do
            { assoc: { 'decimal': matching_item.assoc.decimal, 'computed_integer': matching_item.assoc.computed_integer } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_decimal:, integer: } }' do
          let(:instructions) do
            { assoc: { 'computed_decimal': matching_item.assoc.computed_decimal, 'integer': matching_item.assoc.integer } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ decimal:, assoc: { integer: } }' do
          let(:instructions) do
            { 'decimal': matching_item.decimal, assoc: { 'integer': matching_item.assoc.integer } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { decimal: }, integer: }' do
          let(:instructions) do
            { assoc: { 'decimal': matching_item.assoc.decimal }, 'integer': matching_item.integer }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ decimal:, assoc: { computed_integer: } }' do
          let(:instructions) do
            { 'decimal': matching_item.decimal, assoc: { 'computed_integer': matching_item.assoc.computed_integer } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { decimal: }, computed_integer: }' do
          let(:instructions) do
            { assoc: { 'decimal': matching_item.assoc.decimal }, 'computed_integer': matching_item.computed_integer }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_decimal:, assoc: { integer: } }' do
          let(:instructions) do
            { 'computed_decimal': matching_item.computed_decimal, assoc: { 'integer': matching_item.assoc.integer } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_decimal: }, integer: }' do
          let(:instructions) do
            { assoc: { 'computed_decimal': matching_item.assoc.computed_decimal }, 'integer': matching_item.integer }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_decimal:, assoc: { computed_integer: } }' do
          let(:instructions) do
            { 'computed_decimal': matching_item.computed_decimal, assoc: { 'computed_integer': matching_item.assoc.computed_integer } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_decimal: }, computed_integer: }' do
          let(:instructions) do
            { assoc: { 'computed_decimal': matching_item.assoc.computed_decimal }, 'computed_integer': matching_item.computed_integer }
          end

          it_behaves_like 'a successful filter'
        end
      end
    end

    context 'with DECIMAL and STRING type' do
      context 'matching @foo_1' do
        let(:matching_item) { @foo_1 }

        context '{ decimal:, string: }' do
          let(:instructions) do
            { 'decimal': matching_item.decimal, 'string': matching_item.string }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_decimal:, computed_string: }' do
          let(:instructions) do
            { 'computed_decimal': matching_item.computed_decimal, 'computed_string': matching_item.computed_string }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ decimal:, computed_string: }' do
          let(:instructions) do
            { 'decimal': matching_item.decimal, 'computed_string': matching_item.computed_string }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_decimal:, string: }' do
          let(:instructions) do
            { 'computed_decimal': matching_item.computed_decimal, 'string': matching_item.string }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { decimal:, string: } }' do
          let(:instructions) do
            { assoc: { 'decimal': matching_item.assoc.decimal, 'string': matching_item.assoc.string } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_decimal:, computed_string: } }' do
          let(:instructions) do
            { assoc: { 'computed_decimal': matching_item.assoc.computed_decimal, 'computed_string': matching_item.assoc.computed_string } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { decimal:, computed_string: } }' do
          let(:instructions) do
            { assoc: { 'decimal': matching_item.assoc.decimal, 'computed_string': matching_item.assoc.computed_string } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_decimal:, string: } }' do
          let(:instructions) do
            { assoc: { 'computed_decimal': matching_item.assoc.computed_decimal, 'string': matching_item.assoc.string } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ decimal:, assoc: { string: } }' do
          let(:instructions) do
            { 'decimal': matching_item.decimal, assoc: { 'string': matching_item.assoc.string } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { decimal: }, string: }' do
          let(:instructions) do
            { assoc: { 'decimal': matching_item.assoc.decimal }, 'string': matching_item.string }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ decimal:, assoc: { computed_string: } }' do
          let(:instructions) do
            { 'decimal': matching_item.decimal, assoc: { 'computed_string': matching_item.assoc.computed_string } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { decimal: }, computed_string: }' do
          let(:instructions) do
            { assoc: { 'decimal': matching_item.assoc.decimal }, 'computed_string': matching_item.computed_string }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_decimal:, assoc: { string: } }' do
          let(:instructions) do
            { 'computed_decimal': matching_item.computed_decimal, assoc: { 'string': matching_item.assoc.string } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_decimal: }, string: }' do
          let(:instructions) do
            { assoc: { 'computed_decimal': matching_item.assoc.computed_decimal }, 'string': matching_item.string }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_decimal:, assoc: { computed_string: } }' do
          let(:instructions) do
            { 'computed_decimal': matching_item.computed_decimal, assoc: { 'computed_string': matching_item.assoc.computed_string } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_decimal: }, computed_string: }' do
          let(:instructions) do
            { assoc: { 'computed_decimal': matching_item.assoc.computed_decimal }, 'computed_string': matching_item.computed_string }
          end

          it_behaves_like 'a successful filter'
        end
      end

      context 'matching @foo_2' do
        let(:matching_item) { @foo_2 }

        context '{ decimal:, string: }' do
          let(:instructions) do
            { 'decimal': matching_item.decimal, 'string': matching_item.string }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_decimal:, computed_string: }' do
          let(:instructions) do
            { 'computed_decimal': matching_item.computed_decimal, 'computed_string': matching_item.computed_string }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ decimal:, computed_string: }' do
          let(:instructions) do
            { 'decimal': matching_item.decimal, 'computed_string': matching_item.computed_string }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_decimal:, string: }' do
          let(:instructions) do
            { 'computed_decimal': matching_item.computed_decimal, 'string': matching_item.string }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { decimal:, string: } }' do
          let(:instructions) do
            { assoc: { 'decimal': matching_item.assoc.decimal, 'string': matching_item.assoc.string } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_decimal:, computed_string: } }' do
          let(:instructions) do
            { assoc: { 'computed_decimal': matching_item.assoc.computed_decimal, 'computed_string': matching_item.assoc.computed_string } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { decimal:, computed_string: } }' do
          let(:instructions) do
            { assoc: { 'decimal': matching_item.assoc.decimal, 'computed_string': matching_item.assoc.computed_string } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_decimal:, string: } }' do
          let(:instructions) do
            { assoc: { 'computed_decimal': matching_item.assoc.computed_decimal, 'string': matching_item.assoc.string } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ decimal:, assoc: { string: } }' do
          let(:instructions) do
            { 'decimal': matching_item.decimal, assoc: { 'string': matching_item.assoc.string } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { decimal: }, string: }' do
          let(:instructions) do
            { assoc: { 'decimal': matching_item.assoc.decimal }, 'string': matching_item.string }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ decimal:, assoc: { computed_string: } }' do
          let(:instructions) do
            { 'decimal': matching_item.decimal, assoc: { 'computed_string': matching_item.assoc.computed_string } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { decimal: }, computed_string: }' do
          let(:instructions) do
            { assoc: { 'decimal': matching_item.assoc.decimal }, 'computed_string': matching_item.computed_string }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_decimal:, assoc: { string: } }' do
          let(:instructions) do
            { 'computed_decimal': matching_item.computed_decimal, assoc: { 'string': matching_item.assoc.string } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_decimal: }, string: }' do
          let(:instructions) do
            { assoc: { 'computed_decimal': matching_item.assoc.computed_decimal }, 'string': matching_item.string }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_decimal:, assoc: { computed_string: } }' do
          let(:instructions) do
            { 'computed_decimal': matching_item.computed_decimal, assoc: { 'computed_string': matching_item.assoc.computed_string } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_decimal: }, computed_string: }' do
          let(:instructions) do
            { assoc: { 'computed_decimal': matching_item.assoc.computed_decimal }, 'computed_string': matching_item.computed_string }
          end

          it_behaves_like 'a successful filter'
        end
      end
    end

    context 'with DECIMAL and TEXT type' do
      context 'matching @foo_1' do
        let(:matching_item) { @foo_1 }

        context '{ decimal:, text: }' do
          let(:instructions) do
            { 'decimal': matching_item.decimal, 'text': matching_item.text }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_decimal:, computed_text: }' do
          let(:instructions) do
            { 'computed_decimal': matching_item.computed_decimal, 'computed_text': matching_item.computed_text }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ decimal:, computed_text: }' do
          let(:instructions) do
            { 'decimal': matching_item.decimal, 'computed_text': matching_item.computed_text }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_decimal:, text: }' do
          let(:instructions) do
            { 'computed_decimal': matching_item.computed_decimal, 'text': matching_item.text }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { decimal:, text: } }' do
          let(:instructions) do
            { assoc: { 'decimal': matching_item.assoc.decimal, 'text': matching_item.assoc.text } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_decimal:, computed_text: } }' do
          let(:instructions) do
            { assoc: { 'computed_decimal': matching_item.assoc.computed_decimal, 'computed_text': matching_item.assoc.computed_text } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { decimal:, computed_text: } }' do
          let(:instructions) do
            { assoc: { 'decimal': matching_item.assoc.decimal, 'computed_text': matching_item.assoc.computed_text } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_decimal:, text: } }' do
          let(:instructions) do
            { assoc: { 'computed_decimal': matching_item.assoc.computed_decimal, 'text': matching_item.assoc.text } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ decimal:, assoc: { text: } }' do
          let(:instructions) do
            { 'decimal': matching_item.decimal, assoc: { 'text': matching_item.assoc.text } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { decimal: }, text: }' do
          let(:instructions) do
            { assoc: { 'decimal': matching_item.assoc.decimal }, 'text': matching_item.text }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ decimal:, assoc: { computed_text: } }' do
          let(:instructions) do
            { 'decimal': matching_item.decimal, assoc: { 'computed_text': matching_item.assoc.computed_text } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { decimal: }, computed_text: }' do
          let(:instructions) do
            { assoc: { 'decimal': matching_item.assoc.decimal }, 'computed_text': matching_item.computed_text }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_decimal:, assoc: { text: } }' do
          let(:instructions) do
            { 'computed_decimal': matching_item.computed_decimal, assoc: { 'text': matching_item.assoc.text } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_decimal: }, text: }' do
          let(:instructions) do
            { assoc: { 'computed_decimal': matching_item.assoc.computed_decimal }, 'text': matching_item.text }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_decimal:, assoc: { computed_text: } }' do
          let(:instructions) do
            { 'computed_decimal': matching_item.computed_decimal, assoc: { 'computed_text': matching_item.assoc.computed_text } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_decimal: }, computed_text: }' do
          let(:instructions) do
            { assoc: { 'computed_decimal': matching_item.assoc.computed_decimal }, 'computed_text': matching_item.computed_text }
          end

          it_behaves_like 'a successful filter'
        end
      end

      context 'matching @foo_2' do
        let(:matching_item) { @foo_2 }

        context '{ decimal:, text: }' do
          let(:instructions) do
            { 'decimal': matching_item.decimal, 'text': matching_item.text }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_decimal:, computed_text: }' do
          let(:instructions) do
            { 'computed_decimal': matching_item.computed_decimal, 'computed_text': matching_item.computed_text }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ decimal:, computed_text: }' do
          let(:instructions) do
            { 'decimal': matching_item.decimal, 'computed_text': matching_item.computed_text }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_decimal:, text: }' do
          let(:instructions) do
            { 'computed_decimal': matching_item.computed_decimal, 'text': matching_item.text }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { decimal:, text: } }' do
          let(:instructions) do
            { assoc: { 'decimal': matching_item.assoc.decimal, 'text': matching_item.assoc.text } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_decimal:, computed_text: } }' do
          let(:instructions) do
            { assoc: { 'computed_decimal': matching_item.assoc.computed_decimal, 'computed_text': matching_item.assoc.computed_text } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { decimal:, computed_text: } }' do
          let(:instructions) do
            { assoc: { 'decimal': matching_item.assoc.decimal, 'computed_text': matching_item.assoc.computed_text } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_decimal:, text: } }' do
          let(:instructions) do
            { assoc: { 'computed_decimal': matching_item.assoc.computed_decimal, 'text': matching_item.assoc.text } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ decimal:, assoc: { text: } }' do
          let(:instructions) do
            { 'decimal': matching_item.decimal, assoc: { 'text': matching_item.assoc.text } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { decimal: }, text: }' do
          let(:instructions) do
            { assoc: { 'decimal': matching_item.assoc.decimal }, 'text': matching_item.text }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ decimal:, assoc: { computed_text: } }' do
          let(:instructions) do
            { 'decimal': matching_item.decimal, assoc: { 'computed_text': matching_item.assoc.computed_text } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { decimal: }, computed_text: }' do
          let(:instructions) do
            { assoc: { 'decimal': matching_item.assoc.decimal }, 'computed_text': matching_item.computed_text }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_decimal:, assoc: { text: } }' do
          let(:instructions) do
            { 'computed_decimal': matching_item.computed_decimal, assoc: { 'text': matching_item.assoc.text } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_decimal: }, text: }' do
          let(:instructions) do
            { assoc: { 'computed_decimal': matching_item.assoc.computed_decimal }, 'text': matching_item.text }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_decimal:, assoc: { computed_text: } }' do
          let(:instructions) do
            { 'computed_decimal': matching_item.computed_decimal, assoc: { 'computed_text': matching_item.assoc.computed_text } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_decimal: }, computed_text: }' do
          let(:instructions) do
            { assoc: { 'computed_decimal': matching_item.assoc.computed_decimal }, 'computed_text': matching_item.computed_text }
          end

          it_behaves_like 'a successful filter'
        end
      end
    end

    context 'with DECIMAL and TIME type' do
      context 'matching @foo_1' do
        let(:matching_item) { @foo_1 }

        context '{ decimal:, time: }' do
          let(:instructions) do
            { 'decimal': matching_item.decimal, 'time': matching_item.time }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_decimal:, computed_time: }' do
          let(:instructions) do
            { 'computed_decimal': matching_item.computed_decimal, 'computed_time': matching_item.computed_time }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ decimal:, computed_time: }' do
          let(:instructions) do
            { 'decimal': matching_item.decimal, 'computed_time': matching_item.computed_time }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_decimal:, time: }' do
          let(:instructions) do
            { 'computed_decimal': matching_item.computed_decimal, 'time': matching_item.time }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { decimal:, time: } }' do
          let(:instructions) do
            { assoc: { 'decimal': matching_item.assoc.decimal, 'time': matching_item.assoc.time } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_decimal:, computed_time: } }' do
          let(:instructions) do
            { assoc: { 'computed_decimal': matching_item.assoc.computed_decimal, 'computed_time': matching_item.assoc.computed_time } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { decimal:, computed_time: } }' do
          let(:instructions) do
            { assoc: { 'decimal': matching_item.assoc.decimal, 'computed_time': matching_item.assoc.computed_time } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_decimal:, time: } }' do
          let(:instructions) do
            { assoc: { 'computed_decimal': matching_item.assoc.computed_decimal, 'time': matching_item.assoc.time } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ decimal:, assoc: { time: } }' do
          let(:instructions) do
            { 'decimal': matching_item.decimal, assoc: { 'time': matching_item.assoc.time } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { decimal: }, time: }' do
          let(:instructions) do
            { assoc: { 'decimal': matching_item.assoc.decimal }, 'time': matching_item.time }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ decimal:, assoc: { computed_time: } }' do
          let(:instructions) do
            { 'decimal': matching_item.decimal, assoc: { 'computed_time': matching_item.assoc.computed_time } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { decimal: }, computed_time: }' do
          let(:instructions) do
            { assoc: { 'decimal': matching_item.assoc.decimal }, 'computed_time': matching_item.computed_time }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_decimal:, assoc: { time: } }' do
          let(:instructions) do
            { 'computed_decimal': matching_item.computed_decimal, assoc: { 'time': matching_item.assoc.time } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_decimal: }, time: }' do
          let(:instructions) do
            { assoc: { 'computed_decimal': matching_item.assoc.computed_decimal }, 'time': matching_item.time }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_decimal:, assoc: { computed_time: } }' do
          let(:instructions) do
            { 'computed_decimal': matching_item.computed_decimal, assoc: { 'computed_time': matching_item.assoc.computed_time } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_decimal: }, computed_time: }' do
          let(:instructions) do
            { assoc: { 'computed_decimal': matching_item.assoc.computed_decimal }, 'computed_time': matching_item.computed_time }
          end

          it_behaves_like 'a successful filter'
        end
      end

      context 'matching @foo_2' do
        let(:matching_item) { @foo_2 }

        context '{ decimal:, time: }' do
          let(:instructions) do
            { 'decimal': matching_item.decimal, 'time': matching_item.time }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_decimal:, computed_time: }' do
          let(:instructions) do
            { 'computed_decimal': matching_item.computed_decimal, 'computed_time': matching_item.computed_time }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ decimal:, computed_time: }' do
          let(:instructions) do
            { 'decimal': matching_item.decimal, 'computed_time': matching_item.computed_time }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_decimal:, time: }' do
          let(:instructions) do
            { 'computed_decimal': matching_item.computed_decimal, 'time': matching_item.time }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { decimal:, time: } }' do
          let(:instructions) do
            { assoc: { 'decimal': matching_item.assoc.decimal, 'time': matching_item.assoc.time } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_decimal:, computed_time: } }' do
          let(:instructions) do
            { assoc: { 'computed_decimal': matching_item.assoc.computed_decimal, 'computed_time': matching_item.assoc.computed_time } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { decimal:, computed_time: } }' do
          let(:instructions) do
            { assoc: { 'decimal': matching_item.assoc.decimal, 'computed_time': matching_item.assoc.computed_time } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_decimal:, time: } }' do
          let(:instructions) do
            { assoc: { 'computed_decimal': matching_item.assoc.computed_decimal, 'time': matching_item.assoc.time } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ decimal:, assoc: { time: } }' do
          let(:instructions) do
            { 'decimal': matching_item.decimal, assoc: { 'time': matching_item.assoc.time } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { decimal: }, time: }' do
          let(:instructions) do
            { assoc: { 'decimal': matching_item.assoc.decimal }, 'time': matching_item.time }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ decimal:, assoc: { computed_time: } }' do
          let(:instructions) do
            { 'decimal': matching_item.decimal, assoc: { 'computed_time': matching_item.assoc.computed_time } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { decimal: }, computed_time: }' do
          let(:instructions) do
            { assoc: { 'decimal': matching_item.assoc.decimal }, 'computed_time': matching_item.computed_time }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_decimal:, assoc: { time: } }' do
          let(:instructions) do
            { 'computed_decimal': matching_item.computed_decimal, assoc: { 'time': matching_item.assoc.time } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_decimal: }, time: }' do
          let(:instructions) do
            { assoc: { 'computed_decimal': matching_item.assoc.computed_decimal }, 'time': matching_item.time }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_decimal:, assoc: { computed_time: } }' do
          let(:instructions) do
            { 'computed_decimal': matching_item.computed_decimal, assoc: { 'computed_time': matching_item.assoc.computed_time } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_decimal: }, computed_time: }' do
          let(:instructions) do
            { assoc: { 'computed_decimal': matching_item.assoc.computed_decimal }, 'computed_time': matching_item.computed_time }
          end

          it_behaves_like 'a successful filter'
        end
      end
    end


    context 'with FLOAT and INTEGER type' do
      context 'matching @foo_1' do
        let(:matching_item) { @foo_1 }

        context '{ float:, integer: }' do
          let(:instructions) do
            { 'float': matching_item.float, 'integer': matching_item.integer }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_float:, computed_integer: }' do
          let(:instructions) do
            { 'computed_float': matching_item.computed_float, 'computed_integer': matching_item.computed_integer }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ float:, computed_integer: }' do
          let(:instructions) do
            { 'float': matching_item.float, 'computed_integer': matching_item.computed_integer }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_float:, integer: }' do
          let(:instructions) do
            { 'computed_float': matching_item.computed_float, 'integer': matching_item.integer }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { float:, integer: } }' do
          let(:instructions) do
            { assoc: { 'float': matching_item.assoc.float, 'integer': matching_item.assoc.integer } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_float:, computed_integer: } }' do
          let(:instructions) do
            { assoc: { 'computed_float': matching_item.assoc.computed_float, 'computed_integer': matching_item.assoc.computed_integer } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { float:, computed_integer: } }' do
          let(:instructions) do
            { assoc: { 'float': matching_item.assoc.float, 'computed_integer': matching_item.assoc.computed_integer } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_float:, integer: } }' do
          let(:instructions) do
            { assoc: { 'computed_float': matching_item.assoc.computed_float, 'integer': matching_item.assoc.integer } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ float:, assoc: { integer: } }' do
          let(:instructions) do
            { 'float': matching_item.float, assoc: { 'integer': matching_item.assoc.integer } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { float: }, integer: }' do
          let(:instructions) do
            { assoc: { 'float': matching_item.assoc.float }, 'integer': matching_item.integer }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ float:, assoc: { computed_integer: } }' do
          let(:instructions) do
            { 'float': matching_item.float, assoc: { 'computed_integer': matching_item.assoc.computed_integer } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { float: }, computed_integer: }' do
          let(:instructions) do
            { assoc: { 'float': matching_item.assoc.float }, 'computed_integer': matching_item.computed_integer }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_float:, assoc: { integer: } }' do
          let(:instructions) do
            { 'computed_float': matching_item.computed_float, assoc: { 'integer': matching_item.assoc.integer } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_float: }, integer: }' do
          let(:instructions) do
            { assoc: { 'computed_float': matching_item.assoc.computed_float }, 'integer': matching_item.integer }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_float:, assoc: { computed_integer: } }' do
          let(:instructions) do
            { 'computed_float': matching_item.computed_float, assoc: { 'computed_integer': matching_item.assoc.computed_integer } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_float: }, computed_integer: }' do
          let(:instructions) do
            { assoc: { 'computed_float': matching_item.assoc.computed_float }, 'computed_integer': matching_item.computed_integer }
          end

          it_behaves_like 'a successful filter'
        end
      end

      context 'matching @foo_2' do
        let(:matching_item) { @foo_2 }

        context '{ float:, integer: }' do
          let(:instructions) do
            { 'float': matching_item.float, 'integer': matching_item.integer }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_float:, computed_integer: }' do
          let(:instructions) do
            { 'computed_float': matching_item.computed_float, 'computed_integer': matching_item.computed_integer }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ float:, computed_integer: }' do
          let(:instructions) do
            { 'float': matching_item.float, 'computed_integer': matching_item.computed_integer }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_float:, integer: }' do
          let(:instructions) do
            { 'computed_float': matching_item.computed_float, 'integer': matching_item.integer }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { float:, integer: } }' do
          let(:instructions) do
            { assoc: { 'float': matching_item.assoc.float, 'integer': matching_item.assoc.integer } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_float:, computed_integer: } }' do
          let(:instructions) do
            { assoc: { 'computed_float': matching_item.assoc.computed_float, 'computed_integer': matching_item.assoc.computed_integer } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { float:, computed_integer: } }' do
          let(:instructions) do
            { assoc: { 'float': matching_item.assoc.float, 'computed_integer': matching_item.assoc.computed_integer } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_float:, integer: } }' do
          let(:instructions) do
            { assoc: { 'computed_float': matching_item.assoc.computed_float, 'integer': matching_item.assoc.integer } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ float:, assoc: { integer: } }' do
          let(:instructions) do
            { 'float': matching_item.float, assoc: { 'integer': matching_item.assoc.integer } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { float: }, integer: }' do
          let(:instructions) do
            { assoc: { 'float': matching_item.assoc.float }, 'integer': matching_item.integer }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ float:, assoc: { computed_integer: } }' do
          let(:instructions) do
            { 'float': matching_item.float, assoc: { 'computed_integer': matching_item.assoc.computed_integer } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { float: }, computed_integer: }' do
          let(:instructions) do
            { assoc: { 'float': matching_item.assoc.float }, 'computed_integer': matching_item.computed_integer }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_float:, assoc: { integer: } }' do
          let(:instructions) do
            { 'computed_float': matching_item.computed_float, assoc: { 'integer': matching_item.assoc.integer } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_float: }, integer: }' do
          let(:instructions) do
            { assoc: { 'computed_float': matching_item.assoc.computed_float }, 'integer': matching_item.integer }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_float:, assoc: { computed_integer: } }' do
          let(:instructions) do
            { 'computed_float': matching_item.computed_float, assoc: { 'computed_integer': matching_item.assoc.computed_integer } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_float: }, computed_integer: }' do
          let(:instructions) do
            { assoc: { 'computed_float': matching_item.assoc.computed_float }, 'computed_integer': matching_item.computed_integer }
          end

          it_behaves_like 'a successful filter'
        end
      end
    end

    context 'with FLOAT and STRING type' do
      context 'matching @foo_1' do
        let(:matching_item) { @foo_1 }

        context '{ float:, string: }' do
          let(:instructions) do
            { 'float': matching_item.float, 'string': matching_item.string }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_float:, computed_string: }' do
          let(:instructions) do
            { 'computed_float': matching_item.computed_float, 'computed_string': matching_item.computed_string }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ float:, computed_string: }' do
          let(:instructions) do
            { 'float': matching_item.float, 'computed_string': matching_item.computed_string }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_float:, string: }' do
          let(:instructions) do
            { 'computed_float': matching_item.computed_float, 'string': matching_item.string }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { float:, string: } }' do
          let(:instructions) do
            { assoc: { 'float': matching_item.assoc.float, 'string': matching_item.assoc.string } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_float:, computed_string: } }' do
          let(:instructions) do
            { assoc: { 'computed_float': matching_item.assoc.computed_float, 'computed_string': matching_item.assoc.computed_string } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { float:, computed_string: } }' do
          let(:instructions) do
            { assoc: { 'float': matching_item.assoc.float, 'computed_string': matching_item.assoc.computed_string } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_float:, string: } }' do
          let(:instructions) do
            { assoc: { 'computed_float': matching_item.assoc.computed_float, 'string': matching_item.assoc.string } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ float:, assoc: { string: } }' do
          let(:instructions) do
            { 'float': matching_item.float, assoc: { 'string': matching_item.assoc.string } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { float: }, string: }' do
          let(:instructions) do
            { assoc: { 'float': matching_item.assoc.float }, 'string': matching_item.string }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ float:, assoc: { computed_string: } }' do
          let(:instructions) do
            { 'float': matching_item.float, assoc: { 'computed_string': matching_item.assoc.computed_string } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { float: }, computed_string: }' do
          let(:instructions) do
            { assoc: { 'float': matching_item.assoc.float }, 'computed_string': matching_item.computed_string }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_float:, assoc: { string: } }' do
          let(:instructions) do
            { 'computed_float': matching_item.computed_float, assoc: { 'string': matching_item.assoc.string } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_float: }, string: }' do
          let(:instructions) do
            { assoc: { 'computed_float': matching_item.assoc.computed_float }, 'string': matching_item.string }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_float:, assoc: { computed_string: } }' do
          let(:instructions) do
            { 'computed_float': matching_item.computed_float, assoc: { 'computed_string': matching_item.assoc.computed_string } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_float: }, computed_string: }' do
          let(:instructions) do
            { assoc: { 'computed_float': matching_item.assoc.computed_float }, 'computed_string': matching_item.computed_string }
          end

          it_behaves_like 'a successful filter'
        end
      end

      context 'matching @foo_2' do
        let(:matching_item) { @foo_2 }

        context '{ float:, string: }' do
          let(:instructions) do
            { 'float': matching_item.float, 'string': matching_item.string }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_float:, computed_string: }' do
          let(:instructions) do
            { 'computed_float': matching_item.computed_float, 'computed_string': matching_item.computed_string }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ float:, computed_string: }' do
          let(:instructions) do
            { 'float': matching_item.float, 'computed_string': matching_item.computed_string }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_float:, string: }' do
          let(:instructions) do
            { 'computed_float': matching_item.computed_float, 'string': matching_item.string }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { float:, string: } }' do
          let(:instructions) do
            { assoc: { 'float': matching_item.assoc.float, 'string': matching_item.assoc.string } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_float:, computed_string: } }' do
          let(:instructions) do
            { assoc: { 'computed_float': matching_item.assoc.computed_float, 'computed_string': matching_item.assoc.computed_string } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { float:, computed_string: } }' do
          let(:instructions) do
            { assoc: { 'float': matching_item.assoc.float, 'computed_string': matching_item.assoc.computed_string } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_float:, string: } }' do
          let(:instructions) do
            { assoc: { 'computed_float': matching_item.assoc.computed_float, 'string': matching_item.assoc.string } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ float:, assoc: { string: } }' do
          let(:instructions) do
            { 'float': matching_item.float, assoc: { 'string': matching_item.assoc.string } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { float: }, string: }' do
          let(:instructions) do
            { assoc: { 'float': matching_item.assoc.float }, 'string': matching_item.string }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ float:, assoc: { computed_string: } }' do
          let(:instructions) do
            { 'float': matching_item.float, assoc: { 'computed_string': matching_item.assoc.computed_string } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { float: }, computed_string: }' do
          let(:instructions) do
            { assoc: { 'float': matching_item.assoc.float }, 'computed_string': matching_item.computed_string }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_float:, assoc: { string: } }' do
          let(:instructions) do
            { 'computed_float': matching_item.computed_float, assoc: { 'string': matching_item.assoc.string } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_float: }, string: }' do
          let(:instructions) do
            { assoc: { 'computed_float': matching_item.assoc.computed_float }, 'string': matching_item.string }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_float:, assoc: { computed_string: } }' do
          let(:instructions) do
            { 'computed_float': matching_item.computed_float, assoc: { 'computed_string': matching_item.assoc.computed_string } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_float: }, computed_string: }' do
          let(:instructions) do
            { assoc: { 'computed_float': matching_item.assoc.computed_float }, 'computed_string': matching_item.computed_string }
          end

          it_behaves_like 'a successful filter'
        end
      end
    end

    context 'with FLOAT and TEXT type' do
      context 'matching @foo_1' do
        let(:matching_item) { @foo_1 }

        context '{ float:, text: }' do
          let(:instructions) do
            { 'float': matching_item.float, 'text': matching_item.text }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_float:, computed_text: }' do
          let(:instructions) do
            { 'computed_float': matching_item.computed_float, 'computed_text': matching_item.computed_text }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ float:, computed_text: }' do
          let(:instructions) do
            { 'float': matching_item.float, 'computed_text': matching_item.computed_text }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_float:, text: }' do
          let(:instructions) do
            { 'computed_float': matching_item.computed_float, 'text': matching_item.text }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { float:, text: } }' do
          let(:instructions) do
            { assoc: { 'float': matching_item.assoc.float, 'text': matching_item.assoc.text } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_float:, computed_text: } }' do
          let(:instructions) do
            { assoc: { 'computed_float': matching_item.assoc.computed_float, 'computed_text': matching_item.assoc.computed_text } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { float:, computed_text: } }' do
          let(:instructions) do
            { assoc: { 'float': matching_item.assoc.float, 'computed_text': matching_item.assoc.computed_text } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_float:, text: } }' do
          let(:instructions) do
            { assoc: { 'computed_float': matching_item.assoc.computed_float, 'text': matching_item.assoc.text } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ float:, assoc: { text: } }' do
          let(:instructions) do
            { 'float': matching_item.float, assoc: { 'text': matching_item.assoc.text } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { float: }, text: }' do
          let(:instructions) do
            { assoc: { 'float': matching_item.assoc.float }, 'text': matching_item.text }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ float:, assoc: { computed_text: } }' do
          let(:instructions) do
            { 'float': matching_item.float, assoc: { 'computed_text': matching_item.assoc.computed_text } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { float: }, computed_text: }' do
          let(:instructions) do
            { assoc: { 'float': matching_item.assoc.float }, 'computed_text': matching_item.computed_text }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_float:, assoc: { text: } }' do
          let(:instructions) do
            { 'computed_float': matching_item.computed_float, assoc: { 'text': matching_item.assoc.text } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_float: }, text: }' do
          let(:instructions) do
            { assoc: { 'computed_float': matching_item.assoc.computed_float }, 'text': matching_item.text }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_float:, assoc: { computed_text: } }' do
          let(:instructions) do
            { 'computed_float': matching_item.computed_float, assoc: { 'computed_text': matching_item.assoc.computed_text } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_float: }, computed_text: }' do
          let(:instructions) do
            { assoc: { 'computed_float': matching_item.assoc.computed_float }, 'computed_text': matching_item.computed_text }
          end

          it_behaves_like 'a successful filter'
        end
      end

      context 'matching @foo_2' do
        let(:matching_item) { @foo_2 }

        context '{ float:, text: }' do
          let(:instructions) do
            { 'float': matching_item.float, 'text': matching_item.text }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_float:, computed_text: }' do
          let(:instructions) do
            { 'computed_float': matching_item.computed_float, 'computed_text': matching_item.computed_text }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ float:, computed_text: }' do
          let(:instructions) do
            { 'float': matching_item.float, 'computed_text': matching_item.computed_text }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_float:, text: }' do
          let(:instructions) do
            { 'computed_float': matching_item.computed_float, 'text': matching_item.text }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { float:, text: } }' do
          let(:instructions) do
            { assoc: { 'float': matching_item.assoc.float, 'text': matching_item.assoc.text } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_float:, computed_text: } }' do
          let(:instructions) do
            { assoc: { 'computed_float': matching_item.assoc.computed_float, 'computed_text': matching_item.assoc.computed_text } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { float:, computed_text: } }' do
          let(:instructions) do
            { assoc: { 'float': matching_item.assoc.float, 'computed_text': matching_item.assoc.computed_text } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_float:, text: } }' do
          let(:instructions) do
            { assoc: { 'computed_float': matching_item.assoc.computed_float, 'text': matching_item.assoc.text } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ float:, assoc: { text: } }' do
          let(:instructions) do
            { 'float': matching_item.float, assoc: { 'text': matching_item.assoc.text } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { float: }, text: }' do
          let(:instructions) do
            { assoc: { 'float': matching_item.assoc.float }, 'text': matching_item.text }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ float:, assoc: { computed_text: } }' do
          let(:instructions) do
            { 'float': matching_item.float, assoc: { 'computed_text': matching_item.assoc.computed_text } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { float: }, computed_text: }' do
          let(:instructions) do
            { assoc: { 'float': matching_item.assoc.float }, 'computed_text': matching_item.computed_text }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_float:, assoc: { text: } }' do
          let(:instructions) do
            { 'computed_float': matching_item.computed_float, assoc: { 'text': matching_item.assoc.text } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_float: }, text: }' do
          let(:instructions) do
            { assoc: { 'computed_float': matching_item.assoc.computed_float }, 'text': matching_item.text }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_float:, assoc: { computed_text: } }' do
          let(:instructions) do
            { 'computed_float': matching_item.computed_float, assoc: { 'computed_text': matching_item.assoc.computed_text } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_float: }, computed_text: }' do
          let(:instructions) do
            { assoc: { 'computed_float': matching_item.assoc.computed_float }, 'computed_text': matching_item.computed_text }
          end

          it_behaves_like 'a successful filter'
        end
      end
    end

    context 'with FLOAT and TIME type' do
      context 'matching @foo_1' do
        let(:matching_item) { @foo_1 }

        context '{ float:, time: }' do
          let(:instructions) do
            { 'float': matching_item.float, 'time': matching_item.time }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_float:, computed_time: }' do
          let(:instructions) do
            { 'computed_float': matching_item.computed_float, 'computed_time': matching_item.computed_time }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ float:, computed_time: }' do
          let(:instructions) do
            { 'float': matching_item.float, 'computed_time': matching_item.computed_time }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_float:, time: }' do
          let(:instructions) do
            { 'computed_float': matching_item.computed_float, 'time': matching_item.time }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { float:, time: } }' do
          let(:instructions) do
            { assoc: { 'float': matching_item.assoc.float, 'time': matching_item.assoc.time } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_float:, computed_time: } }' do
          let(:instructions) do
            { assoc: { 'computed_float': matching_item.assoc.computed_float, 'computed_time': matching_item.assoc.computed_time } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { float:, computed_time: } }' do
          let(:instructions) do
            { assoc: { 'float': matching_item.assoc.float, 'computed_time': matching_item.assoc.computed_time } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_float:, time: } }' do
          let(:instructions) do
            { assoc: { 'computed_float': matching_item.assoc.computed_float, 'time': matching_item.assoc.time } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ float:, assoc: { time: } }' do
          let(:instructions) do
            { 'float': matching_item.float, assoc: { 'time': matching_item.assoc.time } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { float: }, time: }' do
          let(:instructions) do
            { assoc: { 'float': matching_item.assoc.float }, 'time': matching_item.time }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ float:, assoc: { computed_time: } }' do
          let(:instructions) do
            { 'float': matching_item.float, assoc: { 'computed_time': matching_item.assoc.computed_time } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { float: }, computed_time: }' do
          let(:instructions) do
            { assoc: { 'float': matching_item.assoc.float }, 'computed_time': matching_item.computed_time }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_float:, assoc: { time: } }' do
          let(:instructions) do
            { 'computed_float': matching_item.computed_float, assoc: { 'time': matching_item.assoc.time } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_float: }, time: }' do
          let(:instructions) do
            { assoc: { 'computed_float': matching_item.assoc.computed_float }, 'time': matching_item.time }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_float:, assoc: { computed_time: } }' do
          let(:instructions) do
            { 'computed_float': matching_item.computed_float, assoc: { 'computed_time': matching_item.assoc.computed_time } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_float: }, computed_time: }' do
          let(:instructions) do
            { assoc: { 'computed_float': matching_item.assoc.computed_float }, 'computed_time': matching_item.computed_time }
          end

          it_behaves_like 'a successful filter'
        end
      end

      context 'matching @foo_2' do
        let(:matching_item) { @foo_2 }

        context '{ float:, time: }' do
          let(:instructions) do
            { 'float': matching_item.float, 'time': matching_item.time }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_float:, computed_time: }' do
          let(:instructions) do
            { 'computed_float': matching_item.computed_float, 'computed_time': matching_item.computed_time }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ float:, computed_time: }' do
          let(:instructions) do
            { 'float': matching_item.float, 'computed_time': matching_item.computed_time }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_float:, time: }' do
          let(:instructions) do
            { 'computed_float': matching_item.computed_float, 'time': matching_item.time }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { float:, time: } }' do
          let(:instructions) do
            { assoc: { 'float': matching_item.assoc.float, 'time': matching_item.assoc.time } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_float:, computed_time: } }' do
          let(:instructions) do
            { assoc: { 'computed_float': matching_item.assoc.computed_float, 'computed_time': matching_item.assoc.computed_time } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { float:, computed_time: } }' do
          let(:instructions) do
            { assoc: { 'float': matching_item.assoc.float, 'computed_time': matching_item.assoc.computed_time } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_float:, time: } }' do
          let(:instructions) do
            { assoc: { 'computed_float': matching_item.assoc.computed_float, 'time': matching_item.assoc.time } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ float:, assoc: { time: } }' do
          let(:instructions) do
            { 'float': matching_item.float, assoc: { 'time': matching_item.assoc.time } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { float: }, time: }' do
          let(:instructions) do
            { assoc: { 'float': matching_item.assoc.float }, 'time': matching_item.time }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ float:, assoc: { computed_time: } }' do
          let(:instructions) do
            { 'float': matching_item.float, assoc: { 'computed_time': matching_item.assoc.computed_time } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { float: }, computed_time: }' do
          let(:instructions) do
            { assoc: { 'float': matching_item.assoc.float }, 'computed_time': matching_item.computed_time }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_float:, assoc: { time: } }' do
          let(:instructions) do
            { 'computed_float': matching_item.computed_float, assoc: { 'time': matching_item.assoc.time } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_float: }, time: }' do
          let(:instructions) do
            { assoc: { 'computed_float': matching_item.assoc.computed_float }, 'time': matching_item.time }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_float:, assoc: { computed_time: } }' do
          let(:instructions) do
            { 'computed_float': matching_item.computed_float, assoc: { 'computed_time': matching_item.assoc.computed_time } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_float: }, computed_time: }' do
          let(:instructions) do
            { assoc: { 'computed_float': matching_item.assoc.computed_float }, 'computed_time': matching_item.computed_time }
          end

          it_behaves_like 'a successful filter'
        end
      end
    end


    context 'with INTEGER and STRING type' do
      context 'matching @foo_1' do
        let(:matching_item) { @foo_1 }

        context '{ integer:, string: }' do
          let(:instructions) do
            { 'integer': matching_item.integer, 'string': matching_item.string }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_integer:, computed_string: }' do
          let(:instructions) do
            { 'computed_integer': matching_item.computed_integer, 'computed_string': matching_item.computed_string }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ integer:, computed_string: }' do
          let(:instructions) do
            { 'integer': matching_item.integer, 'computed_string': matching_item.computed_string }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_integer:, string: }' do
          let(:instructions) do
            { 'computed_integer': matching_item.computed_integer, 'string': matching_item.string }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { integer:, string: } }' do
          let(:instructions) do
            { assoc: { 'integer': matching_item.assoc.integer, 'string': matching_item.assoc.string } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_integer:, computed_string: } }' do
          let(:instructions) do
            { assoc: { 'computed_integer': matching_item.assoc.computed_integer, 'computed_string': matching_item.assoc.computed_string } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { integer:, computed_string: } }' do
          let(:instructions) do
            { assoc: { 'integer': matching_item.assoc.integer, 'computed_string': matching_item.assoc.computed_string } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_integer:, string: } }' do
          let(:instructions) do
            { assoc: { 'computed_integer': matching_item.assoc.computed_integer, 'string': matching_item.assoc.string } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ integer:, assoc: { string: } }' do
          let(:instructions) do
            { 'integer': matching_item.integer, assoc: { 'string': matching_item.assoc.string } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { integer: }, string: }' do
          let(:instructions) do
            { assoc: { 'integer': matching_item.assoc.integer }, 'string': matching_item.string }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ integer:, assoc: { computed_string: } }' do
          let(:instructions) do
            { 'integer': matching_item.integer, assoc: { 'computed_string': matching_item.assoc.computed_string } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { integer: }, computed_string: }' do
          let(:instructions) do
            { assoc: { 'integer': matching_item.assoc.integer }, 'computed_string': matching_item.computed_string }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_integer:, assoc: { string: } }' do
          let(:instructions) do
            { 'computed_integer': matching_item.computed_integer, assoc: { 'string': matching_item.assoc.string } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_integer: }, string: }' do
          let(:instructions) do
            { assoc: { 'computed_integer': matching_item.assoc.computed_integer }, 'string': matching_item.string }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_integer:, assoc: { computed_string: } }' do
          let(:instructions) do
            { 'computed_integer': matching_item.computed_integer, assoc: { 'computed_string': matching_item.assoc.computed_string } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_integer: }, computed_string: }' do
          let(:instructions) do
            { assoc: { 'computed_integer': matching_item.assoc.computed_integer }, 'computed_string': matching_item.computed_string }
          end

          it_behaves_like 'a successful filter'
        end
      end

      context 'matching @foo_2' do
        let(:matching_item) { @foo_2 }

        context '{ integer:, string: }' do
          let(:instructions) do
            { 'integer': matching_item.integer, 'string': matching_item.string }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_integer:, computed_string: }' do
          let(:instructions) do
            { 'computed_integer': matching_item.computed_integer, 'computed_string': matching_item.computed_string }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ integer:, computed_string: }' do
          let(:instructions) do
            { 'integer': matching_item.integer, 'computed_string': matching_item.computed_string }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_integer:, string: }' do
          let(:instructions) do
            { 'computed_integer': matching_item.computed_integer, 'string': matching_item.string }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { integer:, string: } }' do
          let(:instructions) do
            { assoc: { 'integer': matching_item.assoc.integer, 'string': matching_item.assoc.string } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_integer:, computed_string: } }' do
          let(:instructions) do
            { assoc: { 'computed_integer': matching_item.assoc.computed_integer, 'computed_string': matching_item.assoc.computed_string } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { integer:, computed_string: } }' do
          let(:instructions) do
            { assoc: { 'integer': matching_item.assoc.integer, 'computed_string': matching_item.assoc.computed_string } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_integer:, string: } }' do
          let(:instructions) do
            { assoc: { 'computed_integer': matching_item.assoc.computed_integer, 'string': matching_item.assoc.string } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ integer:, assoc: { string: } }' do
          let(:instructions) do
            { 'integer': matching_item.integer, assoc: { 'string': matching_item.assoc.string } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { integer: }, string: }' do
          let(:instructions) do
            { assoc: { 'integer': matching_item.assoc.integer }, 'string': matching_item.string }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ integer:, assoc: { computed_string: } }' do
          let(:instructions) do
            { 'integer': matching_item.integer, assoc: { 'computed_string': matching_item.assoc.computed_string } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { integer: }, computed_string: }' do
          let(:instructions) do
            { assoc: { 'integer': matching_item.assoc.integer }, 'computed_string': matching_item.computed_string }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_integer:, assoc: { string: } }' do
          let(:instructions) do
            { 'computed_integer': matching_item.computed_integer, assoc: { 'string': matching_item.assoc.string } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_integer: }, string: }' do
          let(:instructions) do
            { assoc: { 'computed_integer': matching_item.assoc.computed_integer }, 'string': matching_item.string }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_integer:, assoc: { computed_string: } }' do
          let(:instructions) do
            { 'computed_integer': matching_item.computed_integer, assoc: { 'computed_string': matching_item.assoc.computed_string } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_integer: }, computed_string: }' do
          let(:instructions) do
            { assoc: { 'computed_integer': matching_item.assoc.computed_integer }, 'computed_string': matching_item.computed_string }
          end

          it_behaves_like 'a successful filter'
        end
      end
    end

    context 'with INTEGER and TEXT type' do
      context 'matching @foo_1' do
        let(:matching_item) { @foo_1 }

        context '{ integer:, text: }' do
          let(:instructions) do
            { 'integer': matching_item.integer, 'text': matching_item.text }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_integer:, computed_text: }' do
          let(:instructions) do
            { 'computed_integer': matching_item.computed_integer, 'computed_text': matching_item.computed_text }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ integer:, computed_text: }' do
          let(:instructions) do
            { 'integer': matching_item.integer, 'computed_text': matching_item.computed_text }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_integer:, text: }' do
          let(:instructions) do
            { 'computed_integer': matching_item.computed_integer, 'text': matching_item.text }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { integer:, text: } }' do
          let(:instructions) do
            { assoc: { 'integer': matching_item.assoc.integer, 'text': matching_item.assoc.text } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_integer:, computed_text: } }' do
          let(:instructions) do
            { assoc: { 'computed_integer': matching_item.assoc.computed_integer, 'computed_text': matching_item.assoc.computed_text } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { integer:, computed_text: } }' do
          let(:instructions) do
            { assoc: { 'integer': matching_item.assoc.integer, 'computed_text': matching_item.assoc.computed_text } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_integer:, text: } }' do
          let(:instructions) do
            { assoc: { 'computed_integer': matching_item.assoc.computed_integer, 'text': matching_item.assoc.text } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ integer:, assoc: { text: } }' do
          let(:instructions) do
            { 'integer': matching_item.integer, assoc: { 'text': matching_item.assoc.text } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { integer: }, text: }' do
          let(:instructions) do
            { assoc: { 'integer': matching_item.assoc.integer }, 'text': matching_item.text }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ integer:, assoc: { computed_text: } }' do
          let(:instructions) do
            { 'integer': matching_item.integer, assoc: { 'computed_text': matching_item.assoc.computed_text } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { integer: }, computed_text: }' do
          let(:instructions) do
            { assoc: { 'integer': matching_item.assoc.integer }, 'computed_text': matching_item.computed_text }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_integer:, assoc: { text: } }' do
          let(:instructions) do
            { 'computed_integer': matching_item.computed_integer, assoc: { 'text': matching_item.assoc.text } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_integer: }, text: }' do
          let(:instructions) do
            { assoc: { 'computed_integer': matching_item.assoc.computed_integer }, 'text': matching_item.text }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_integer:, assoc: { computed_text: } }' do
          let(:instructions) do
            { 'computed_integer': matching_item.computed_integer, assoc: { 'computed_text': matching_item.assoc.computed_text } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_integer: }, computed_text: }' do
          let(:instructions) do
            { assoc: { 'computed_integer': matching_item.assoc.computed_integer }, 'computed_text': matching_item.computed_text }
          end

          it_behaves_like 'a successful filter'
        end
      end

      context 'matching @foo_2' do
        let(:matching_item) { @foo_2 }

        context '{ integer:, text: }' do
          let(:instructions) do
            { 'integer': matching_item.integer, 'text': matching_item.text }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_integer:, computed_text: }' do
          let(:instructions) do
            { 'computed_integer': matching_item.computed_integer, 'computed_text': matching_item.computed_text }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ integer:, computed_text: }' do
          let(:instructions) do
            { 'integer': matching_item.integer, 'computed_text': matching_item.computed_text }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_integer:, text: }' do
          let(:instructions) do
            { 'computed_integer': matching_item.computed_integer, 'text': matching_item.text }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { integer:, text: } }' do
          let(:instructions) do
            { assoc: { 'integer': matching_item.assoc.integer, 'text': matching_item.assoc.text } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_integer:, computed_text: } }' do
          let(:instructions) do
            { assoc: { 'computed_integer': matching_item.assoc.computed_integer, 'computed_text': matching_item.assoc.computed_text } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { integer:, computed_text: } }' do
          let(:instructions) do
            { assoc: { 'integer': matching_item.assoc.integer, 'computed_text': matching_item.assoc.computed_text } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_integer:, text: } }' do
          let(:instructions) do
            { assoc: { 'computed_integer': matching_item.assoc.computed_integer, 'text': matching_item.assoc.text } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ integer:, assoc: { text: } }' do
          let(:instructions) do
            { 'integer': matching_item.integer, assoc: { 'text': matching_item.assoc.text } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { integer: }, text: }' do
          let(:instructions) do
            { assoc: { 'integer': matching_item.assoc.integer }, 'text': matching_item.text }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ integer:, assoc: { computed_text: } }' do
          let(:instructions) do
            { 'integer': matching_item.integer, assoc: { 'computed_text': matching_item.assoc.computed_text } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { integer: }, computed_text: }' do
          let(:instructions) do
            { assoc: { 'integer': matching_item.assoc.integer }, 'computed_text': matching_item.computed_text }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_integer:, assoc: { text: } }' do
          let(:instructions) do
            { 'computed_integer': matching_item.computed_integer, assoc: { 'text': matching_item.assoc.text } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_integer: }, text: }' do
          let(:instructions) do
            { assoc: { 'computed_integer': matching_item.assoc.computed_integer }, 'text': matching_item.text }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_integer:, assoc: { computed_text: } }' do
          let(:instructions) do
            { 'computed_integer': matching_item.computed_integer, assoc: { 'computed_text': matching_item.assoc.computed_text } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_integer: }, computed_text: }' do
          let(:instructions) do
            { assoc: { 'computed_integer': matching_item.assoc.computed_integer }, 'computed_text': matching_item.computed_text }
          end

          it_behaves_like 'a successful filter'
        end
      end
    end

    context 'with INTEGER and TIME type' do
      context 'matching @foo_1' do
        let(:matching_item) { @foo_1 }

        context '{ integer:, time: }' do
          let(:instructions) do
            { 'integer': matching_item.integer, 'time': matching_item.time }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_integer:, computed_time: }' do
          let(:instructions) do
            { 'computed_integer': matching_item.computed_integer, 'computed_time': matching_item.computed_time }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ integer:, computed_time: }' do
          let(:instructions) do
            { 'integer': matching_item.integer, 'computed_time': matching_item.computed_time }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_integer:, time: }' do
          let(:instructions) do
            { 'computed_integer': matching_item.computed_integer, 'time': matching_item.time }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { integer:, time: } }' do
          let(:instructions) do
            { assoc: { 'integer': matching_item.assoc.integer, 'time': matching_item.assoc.time } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_integer:, computed_time: } }' do
          let(:instructions) do
            { assoc: { 'computed_integer': matching_item.assoc.computed_integer, 'computed_time': matching_item.assoc.computed_time } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { integer:, computed_time: } }' do
          let(:instructions) do
            { assoc: { 'integer': matching_item.assoc.integer, 'computed_time': matching_item.assoc.computed_time } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_integer:, time: } }' do
          let(:instructions) do
            { assoc: { 'computed_integer': matching_item.assoc.computed_integer, 'time': matching_item.assoc.time } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ integer:, assoc: { time: } }' do
          let(:instructions) do
            { 'integer': matching_item.integer, assoc: { 'time': matching_item.assoc.time } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { integer: }, time: }' do
          let(:instructions) do
            { assoc: { 'integer': matching_item.assoc.integer }, 'time': matching_item.time }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ integer:, assoc: { computed_time: } }' do
          let(:instructions) do
            { 'integer': matching_item.integer, assoc: { 'computed_time': matching_item.assoc.computed_time } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { integer: }, computed_time: }' do
          let(:instructions) do
            { assoc: { 'integer': matching_item.assoc.integer }, 'computed_time': matching_item.computed_time }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_integer:, assoc: { time: } }' do
          let(:instructions) do
            { 'computed_integer': matching_item.computed_integer, assoc: { 'time': matching_item.assoc.time } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_integer: }, time: }' do
          let(:instructions) do
            { assoc: { 'computed_integer': matching_item.assoc.computed_integer }, 'time': matching_item.time }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_integer:, assoc: { computed_time: } }' do
          let(:instructions) do
            { 'computed_integer': matching_item.computed_integer, assoc: { 'computed_time': matching_item.assoc.computed_time } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_integer: }, computed_time: }' do
          let(:instructions) do
            { assoc: { 'computed_integer': matching_item.assoc.computed_integer }, 'computed_time': matching_item.computed_time }
          end

          it_behaves_like 'a successful filter'
        end
      end

      context 'matching @foo_2' do
        let(:matching_item) { @foo_2 }

        context '{ integer:, time: }' do
          let(:instructions) do
            { 'integer': matching_item.integer, 'time': matching_item.time }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_integer:, computed_time: }' do
          let(:instructions) do
            { 'computed_integer': matching_item.computed_integer, 'computed_time': matching_item.computed_time }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ integer:, computed_time: }' do
          let(:instructions) do
            { 'integer': matching_item.integer, 'computed_time': matching_item.computed_time }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_integer:, time: }' do
          let(:instructions) do
            { 'computed_integer': matching_item.computed_integer, 'time': matching_item.time }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { integer:, time: } }' do
          let(:instructions) do
            { assoc: { 'integer': matching_item.assoc.integer, 'time': matching_item.assoc.time } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_integer:, computed_time: } }' do
          let(:instructions) do
            { assoc: { 'computed_integer': matching_item.assoc.computed_integer, 'computed_time': matching_item.assoc.computed_time } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { integer:, computed_time: } }' do
          let(:instructions) do
            { assoc: { 'integer': matching_item.assoc.integer, 'computed_time': matching_item.assoc.computed_time } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_integer:, time: } }' do
          let(:instructions) do
            { assoc: { 'computed_integer': matching_item.assoc.computed_integer, 'time': matching_item.assoc.time } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ integer:, assoc: { time: } }' do
          let(:instructions) do
            { 'integer': matching_item.integer, assoc: { 'time': matching_item.assoc.time } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { integer: }, time: }' do
          let(:instructions) do
            { assoc: { 'integer': matching_item.assoc.integer }, 'time': matching_item.time }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ integer:, assoc: { computed_time: } }' do
          let(:instructions) do
            { 'integer': matching_item.integer, assoc: { 'computed_time': matching_item.assoc.computed_time } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { integer: }, computed_time: }' do
          let(:instructions) do
            { assoc: { 'integer': matching_item.assoc.integer }, 'computed_time': matching_item.computed_time }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_integer:, assoc: { time: } }' do
          let(:instructions) do
            { 'computed_integer': matching_item.computed_integer, assoc: { 'time': matching_item.assoc.time } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_integer: }, time: }' do
          let(:instructions) do
            { assoc: { 'computed_integer': matching_item.assoc.computed_integer }, 'time': matching_item.time }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_integer:, assoc: { computed_time: } }' do
          let(:instructions) do
            { 'computed_integer': matching_item.computed_integer, assoc: { 'computed_time': matching_item.assoc.computed_time } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_integer: }, computed_time: }' do
          let(:instructions) do
            { assoc: { 'computed_integer': matching_item.assoc.computed_integer }, 'computed_time': matching_item.computed_time }
          end

          it_behaves_like 'a successful filter'
        end
      end
    end


    context 'with STRING and TEXT type' do
      context 'matching @foo_1' do
        let(:matching_item) { @foo_1 }

        context '{ string:, text: }' do
          let(:instructions) do
            { 'string': matching_item.string, 'text': matching_item.text }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_string:, computed_text: }' do
          let(:instructions) do
            { 'computed_string': matching_item.computed_string, 'computed_text': matching_item.computed_text }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ string:, computed_text: }' do
          let(:instructions) do
            { 'string': matching_item.string, 'computed_text': matching_item.computed_text }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_string:, text: }' do
          let(:instructions) do
            { 'computed_string': matching_item.computed_string, 'text': matching_item.text }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { string:, text: } }' do
          let(:instructions) do
            { assoc: { 'string': matching_item.assoc.string, 'text': matching_item.assoc.text } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_string:, computed_text: } }' do
          let(:instructions) do
            { assoc: { 'computed_string': matching_item.assoc.computed_string, 'computed_text': matching_item.assoc.computed_text } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { string:, computed_text: } }' do
          let(:instructions) do
            { assoc: { 'string': matching_item.assoc.string, 'computed_text': matching_item.assoc.computed_text } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_string:, text: } }' do
          let(:instructions) do
            { assoc: { 'computed_string': matching_item.assoc.computed_string, 'text': matching_item.assoc.text } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ string:, assoc: { text: } }' do
          let(:instructions) do
            { 'string': matching_item.string, assoc: { 'text': matching_item.assoc.text } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { string: }, text: }' do
          let(:instructions) do
            { assoc: { 'string': matching_item.assoc.string }, 'text': matching_item.text }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ string:, assoc: { computed_text: } }' do
          let(:instructions) do
            { 'string': matching_item.string, assoc: { 'computed_text': matching_item.assoc.computed_text } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { string: }, computed_text: }' do
          let(:instructions) do
            { assoc: { 'string': matching_item.assoc.string }, 'computed_text': matching_item.computed_text }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_string:, assoc: { text: } }' do
          let(:instructions) do
            { 'computed_string': matching_item.computed_string, assoc: { 'text': matching_item.assoc.text } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_string: }, text: }' do
          let(:instructions) do
            { assoc: { 'computed_string': matching_item.assoc.computed_string }, 'text': matching_item.text }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_string:, assoc: { computed_text: } }' do
          let(:instructions) do
            { 'computed_string': matching_item.computed_string, assoc: { 'computed_text': matching_item.assoc.computed_text } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_string: }, computed_text: }' do
          let(:instructions) do
            { assoc: { 'computed_string': matching_item.assoc.computed_string }, 'computed_text': matching_item.computed_text }
          end

          it_behaves_like 'a successful filter'
        end
      end

      context 'matching @foo_2' do
        let(:matching_item) { @foo_2 }

        context '{ string:, text: }' do
          let(:instructions) do
            { 'string': matching_item.string, 'text': matching_item.text }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_string:, computed_text: }' do
          let(:instructions) do
            { 'computed_string': matching_item.computed_string, 'computed_text': matching_item.computed_text }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ string:, computed_text: }' do
          let(:instructions) do
            { 'string': matching_item.string, 'computed_text': matching_item.computed_text }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_string:, text: }' do
          let(:instructions) do
            { 'computed_string': matching_item.computed_string, 'text': matching_item.text }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { string:, text: } }' do
          let(:instructions) do
            { assoc: { 'string': matching_item.assoc.string, 'text': matching_item.assoc.text } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_string:, computed_text: } }' do
          let(:instructions) do
            { assoc: { 'computed_string': matching_item.assoc.computed_string, 'computed_text': matching_item.assoc.computed_text } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { string:, computed_text: } }' do
          let(:instructions) do
            { assoc: { 'string': matching_item.assoc.string, 'computed_text': matching_item.assoc.computed_text } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_string:, text: } }' do
          let(:instructions) do
            { assoc: { 'computed_string': matching_item.assoc.computed_string, 'text': matching_item.assoc.text } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ string:, assoc: { text: } }' do
          let(:instructions) do
            { 'string': matching_item.string, assoc: { 'text': matching_item.assoc.text } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { string: }, text: }' do
          let(:instructions) do
            { assoc: { 'string': matching_item.assoc.string }, 'text': matching_item.text }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ string:, assoc: { computed_text: } }' do
          let(:instructions) do
            { 'string': matching_item.string, assoc: { 'computed_text': matching_item.assoc.computed_text } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { string: }, computed_text: }' do
          let(:instructions) do
            { assoc: { 'string': matching_item.assoc.string }, 'computed_text': matching_item.computed_text }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_string:, assoc: { text: } }' do
          let(:instructions) do
            { 'computed_string': matching_item.computed_string, assoc: { 'text': matching_item.assoc.text } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_string: }, text: }' do
          let(:instructions) do
            { assoc: { 'computed_string': matching_item.assoc.computed_string }, 'text': matching_item.text }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_string:, assoc: { computed_text: } }' do
          let(:instructions) do
            { 'computed_string': matching_item.computed_string, assoc: { 'computed_text': matching_item.assoc.computed_text } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_string: }, computed_text: }' do
          let(:instructions) do
            { assoc: { 'computed_string': matching_item.assoc.computed_string }, 'computed_text': matching_item.computed_text }
          end

          it_behaves_like 'a successful filter'
        end
      end
    end

    context 'with STRING and TIME type' do
      context 'matching @foo_1' do
        let(:matching_item) { @foo_1 }

        context '{ string:, time: }' do
          let(:instructions) do
            { 'string': matching_item.string, 'time': matching_item.time }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_string:, computed_time: }' do
          let(:instructions) do
            { 'computed_string': matching_item.computed_string, 'computed_time': matching_item.computed_time }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ string:, computed_time: }' do
          let(:instructions) do
            { 'string': matching_item.string, 'computed_time': matching_item.computed_time }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_string:, time: }' do
          let(:instructions) do
            { 'computed_string': matching_item.computed_string, 'time': matching_item.time }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { string:, time: } }' do
          let(:instructions) do
            { assoc: { 'string': matching_item.assoc.string, 'time': matching_item.assoc.time } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_string:, computed_time: } }' do
          let(:instructions) do
            { assoc: { 'computed_string': matching_item.assoc.computed_string, 'computed_time': matching_item.assoc.computed_time } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { string:, computed_time: } }' do
          let(:instructions) do
            { assoc: { 'string': matching_item.assoc.string, 'computed_time': matching_item.assoc.computed_time } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_string:, time: } }' do
          let(:instructions) do
            { assoc: { 'computed_string': matching_item.assoc.computed_string, 'time': matching_item.assoc.time } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ string:, assoc: { time: } }' do
          let(:instructions) do
            { 'string': matching_item.string, assoc: { 'time': matching_item.assoc.time } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { string: }, time: }' do
          let(:instructions) do
            { assoc: { 'string': matching_item.assoc.string }, 'time': matching_item.time }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ string:, assoc: { computed_time: } }' do
          let(:instructions) do
            { 'string': matching_item.string, assoc: { 'computed_time': matching_item.assoc.computed_time } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { string: }, computed_time: }' do
          let(:instructions) do
            { assoc: { 'string': matching_item.assoc.string }, 'computed_time': matching_item.computed_time }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_string:, assoc: { time: } }' do
          let(:instructions) do
            { 'computed_string': matching_item.computed_string, assoc: { 'time': matching_item.assoc.time } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_string: }, time: }' do
          let(:instructions) do
            { assoc: { 'computed_string': matching_item.assoc.computed_string }, 'time': matching_item.time }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_string:, assoc: { computed_time: } }' do
          let(:instructions) do
            { 'computed_string': matching_item.computed_string, assoc: { 'computed_time': matching_item.assoc.computed_time } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_string: }, computed_time: }' do
          let(:instructions) do
            { assoc: { 'computed_string': matching_item.assoc.computed_string }, 'computed_time': matching_item.computed_time }
          end

          it_behaves_like 'a successful filter'
        end
      end

      context 'matching @foo_2' do
        let(:matching_item) { @foo_2 }

        context '{ string:, time: }' do
          let(:instructions) do
            { 'string': matching_item.string, 'time': matching_item.time }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_string:, computed_time: }' do
          let(:instructions) do
            { 'computed_string': matching_item.computed_string, 'computed_time': matching_item.computed_time }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ string:, computed_time: }' do
          let(:instructions) do
            { 'string': matching_item.string, 'computed_time': matching_item.computed_time }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_string:, time: }' do
          let(:instructions) do
            { 'computed_string': matching_item.computed_string, 'time': matching_item.time }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { string:, time: } }' do
          let(:instructions) do
            { assoc: { 'string': matching_item.assoc.string, 'time': matching_item.assoc.time } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_string:, computed_time: } }' do
          let(:instructions) do
            { assoc: { 'computed_string': matching_item.assoc.computed_string, 'computed_time': matching_item.assoc.computed_time } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { string:, computed_time: } }' do
          let(:instructions) do
            { assoc: { 'string': matching_item.assoc.string, 'computed_time': matching_item.assoc.computed_time } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_string:, time: } }' do
          let(:instructions) do
            { assoc: { 'computed_string': matching_item.assoc.computed_string, 'time': matching_item.assoc.time } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ string:, assoc: { time: } }' do
          let(:instructions) do
            { 'string': matching_item.string, assoc: { 'time': matching_item.assoc.time } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { string: }, time: }' do
          let(:instructions) do
            { assoc: { 'string': matching_item.assoc.string }, 'time': matching_item.time }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ string:, assoc: { computed_time: } }' do
          let(:instructions) do
            { 'string': matching_item.string, assoc: { 'computed_time': matching_item.assoc.computed_time } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { string: }, computed_time: }' do
          let(:instructions) do
            { assoc: { 'string': matching_item.assoc.string }, 'computed_time': matching_item.computed_time }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_string:, assoc: { time: } }' do
          let(:instructions) do
            { 'computed_string': matching_item.computed_string, assoc: { 'time': matching_item.assoc.time } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_string: }, time: }' do
          let(:instructions) do
            { assoc: { 'computed_string': matching_item.assoc.computed_string }, 'time': matching_item.time }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_string:, assoc: { computed_time: } }' do
          let(:instructions) do
            { 'computed_string': matching_item.computed_string, assoc: { 'computed_time': matching_item.assoc.computed_time } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_string: }, computed_time: }' do
          let(:instructions) do
            { assoc: { 'computed_string': matching_item.assoc.computed_string }, 'computed_time': matching_item.computed_time }
          end

          it_behaves_like 'a successful filter'
        end
      end
    end


    context 'with TEXT and TIME type' do
      context 'matching @foo_1' do
        let(:matching_item) { @foo_1 }

        context '{ text:, time: }' do
          let(:instructions) do
            { 'text': matching_item.text, 'time': matching_item.time }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_text:, computed_time: }' do
          let(:instructions) do
            { 'computed_text': matching_item.computed_text, 'computed_time': matching_item.computed_time }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ text:, computed_time: }' do
          let(:instructions) do
            { 'text': matching_item.text, 'computed_time': matching_item.computed_time }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_text:, time: }' do
          let(:instructions) do
            { 'computed_text': matching_item.computed_text, 'time': matching_item.time }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { text:, time: } }' do
          let(:instructions) do
            { assoc: { 'text': matching_item.assoc.text, 'time': matching_item.assoc.time } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_text:, computed_time: } }' do
          let(:instructions) do
            { assoc: { 'computed_text': matching_item.assoc.computed_text, 'computed_time': matching_item.assoc.computed_time } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { text:, computed_time: } }' do
          let(:instructions) do
            { assoc: { 'text': matching_item.assoc.text, 'computed_time': matching_item.assoc.computed_time } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_text:, time: } }' do
          let(:instructions) do
            { assoc: { 'computed_text': matching_item.assoc.computed_text, 'time': matching_item.assoc.time } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ text:, assoc: { time: } }' do
          let(:instructions) do
            { 'text': matching_item.text, assoc: { 'time': matching_item.assoc.time } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { text: }, time: }' do
          let(:instructions) do
            { assoc: { 'text': matching_item.assoc.text }, 'time': matching_item.time }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ text:, assoc: { computed_time: } }' do
          let(:instructions) do
            { 'text': matching_item.text, assoc: { 'computed_time': matching_item.assoc.computed_time } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { text: }, computed_time: }' do
          let(:instructions) do
            { assoc: { 'text': matching_item.assoc.text }, 'computed_time': matching_item.computed_time }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_text:, assoc: { time: } }' do
          let(:instructions) do
            { 'computed_text': matching_item.computed_text, assoc: { 'time': matching_item.assoc.time } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_text: }, time: }' do
          let(:instructions) do
            { assoc: { 'computed_text': matching_item.assoc.computed_text }, 'time': matching_item.time }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_text:, assoc: { computed_time: } }' do
          let(:instructions) do
            { 'computed_text': matching_item.computed_text, assoc: { 'computed_time': matching_item.assoc.computed_time } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_text: }, computed_time: }' do
          let(:instructions) do
            { assoc: { 'computed_text': matching_item.assoc.computed_text }, 'computed_time': matching_item.computed_time }
          end

          it_behaves_like 'a successful filter'
        end
      end

      context 'matching @foo_2' do
        let(:matching_item) { @foo_2 }

        context '{ text:, time: }' do
          let(:instructions) do
            { 'text': matching_item.text, 'time': matching_item.time }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_text:, computed_time: }' do
          let(:instructions) do
            { 'computed_text': matching_item.computed_text, 'computed_time': matching_item.computed_time }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ text:, computed_time: }' do
          let(:instructions) do
            { 'text': matching_item.text, 'computed_time': matching_item.computed_time }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_text:, time: }' do
          let(:instructions) do
            { 'computed_text': matching_item.computed_text, 'time': matching_item.time }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { text:, time: } }' do
          let(:instructions) do
            { assoc: { 'text': matching_item.assoc.text, 'time': matching_item.assoc.time } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_text:, computed_time: } }' do
          let(:instructions) do
            { assoc: { 'computed_text': matching_item.assoc.computed_text, 'computed_time': matching_item.assoc.computed_time } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { text:, computed_time: } }' do
          let(:instructions) do
            { assoc: { 'text': matching_item.assoc.text, 'computed_time': matching_item.assoc.computed_time } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_text:, time: } }' do
          let(:instructions) do
            { assoc: { 'computed_text': matching_item.assoc.computed_text, 'time': matching_item.assoc.time } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ text:, assoc: { time: } }' do
          let(:instructions) do
            { 'text': matching_item.text, assoc: { 'time': matching_item.assoc.time } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { text: }, time: }' do
          let(:instructions) do
            { assoc: { 'text': matching_item.assoc.text }, 'time': matching_item.time }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ text:, assoc: { computed_time: } }' do
          let(:instructions) do
            { 'text': matching_item.text, assoc: { 'computed_time': matching_item.assoc.computed_time } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { text: }, computed_time: }' do
          let(:instructions) do
            { assoc: { 'text': matching_item.assoc.text }, 'computed_time': matching_item.computed_time }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_text:, assoc: { time: } }' do
          let(:instructions) do
            { 'computed_text': matching_item.computed_text, assoc: { 'time': matching_item.assoc.time } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_text: }, time: }' do
          let(:instructions) do
            { assoc: { 'computed_text': matching_item.assoc.computed_text }, 'time': matching_item.time }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_text:, assoc: { computed_time: } }' do
          let(:instructions) do
            { 'computed_text': matching_item.computed_text, assoc: { 'computed_time': matching_item.assoc.computed_time } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_text: }, computed_time: }' do
          let(:instructions) do
            { assoc: { 'computed_text': matching_item.assoc.computed_text }, 'computed_time': matching_item.computed_time }
          end

          it_behaves_like 'a successful filter'
        end
      end
    end
  end
end
