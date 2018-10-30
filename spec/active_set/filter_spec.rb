# frozen_string_literal: true

require 'spec_helper'

RSpec.shared_examples 'a successful filter' do
  it { expect(result.map(&:id)).to eq [matching_item.id] }
end

RSpec.describe ActiveSet do
  before(:all) do
    @foo_1 = FactoryBot.create(:foo, assoc: FactoryBot.create(:assoc))
    @foo_2 = FactoryBot.create(:foo, assoc: FactoryBot.create(:assoc))
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

        context '{ computed_assoc: { binary: } }' do
          let(:instructions) do
            { computed_assoc: { 'binary': matching_item.computed_assoc.binary } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_assoc: { computed_binary: } }' do
          let(:instructions) do
            { computed_assoc: { 'computed_binary': matching_item.computed_assoc.computed_binary } }
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

        context '{ computed_assoc: { binary: } }' do
          let(:instructions) do
            { computed_assoc: { 'binary': matching_item.computed_assoc.binary } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_assoc: { computed_binary: } }' do
          let(:instructions) do
            { computed_assoc: { 'computed_binary': matching_item.computed_assoc.computed_binary } }
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

        context '{ computed_assoc: { boolean: } }' do
          let(:instructions) do
            { computed_assoc: { 'boolean': matching_item.computed_assoc.boolean } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_assoc: { computed_boolean: } }' do
          let(:instructions) do
            { computed_assoc: { 'computed_boolean': matching_item.computed_assoc.computed_boolean } }
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

        context '{ computed_assoc: { boolean: } }' do
          let(:instructions) do
            { computed_assoc: { 'boolean': matching_item.computed_assoc.boolean } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_assoc: { computed_boolean: } }' do
          let(:instructions) do
            { computed_assoc: { 'computed_boolean': matching_item.computed_assoc.computed_boolean } }
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

        context '{ computed_assoc: { date: } }' do
          let(:instructions) do
            { computed_assoc: { 'date': matching_item.computed_assoc.date } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_assoc: { computed_date: } }' do
          let(:instructions) do
            { computed_assoc: { 'computed_date': matching_item.computed_assoc.computed_date } }
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

        context '{ computed_assoc: { date: } }' do
          let(:instructions) do
            { computed_assoc: { 'date': matching_item.computed_assoc.date } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_assoc: { computed_date: } }' do
          let(:instructions) do
            { computed_assoc: { 'computed_date': matching_item.computed_assoc.computed_date } }
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

        context '{ computed_assoc: { datetime: } }' do
          let(:instructions) do
            { computed_assoc: { 'datetime': matching_item.computed_assoc.datetime } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_assoc: { computed_datetime: } }' do
          let(:instructions) do
            { computed_assoc: { 'computed_datetime': matching_item.computed_assoc.computed_datetime } }
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

        context '{ computed_assoc: { datetime: } }' do
          let(:instructions) do
            { computed_assoc: { 'datetime': matching_item.computed_assoc.datetime } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_assoc: { computed_datetime: } }' do
          let(:instructions) do
            { computed_assoc: { 'computed_datetime': matching_item.computed_assoc.computed_datetime } }
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

        context '{ computed_assoc: { decimal: } }' do
          let(:instructions) do
            { computed_assoc: { 'decimal': matching_item.computed_assoc.decimal } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_assoc: { computed_decimal: } }' do
          let(:instructions) do
            { computed_assoc: { 'computed_decimal': matching_item.computed_assoc.computed_decimal } }
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

        context '{ computed_assoc: { decimal: } }' do
          let(:instructions) do
            { computed_assoc: { 'decimal': matching_item.computed_assoc.decimal } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_assoc: { computed_decimal: } }' do
          let(:instructions) do
            { computed_assoc: { 'computed_decimal': matching_item.computed_assoc.computed_decimal } }
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

        context '{ computed_assoc: { float: } }' do
          let(:instructions) do
            { computed_assoc: { 'float': matching_item.computed_assoc.float } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_assoc: { computed_float: } }' do
          let(:instructions) do
            { computed_assoc: { 'computed_float': matching_item.computed_assoc.computed_float } }
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

        context '{ computed_assoc: { float: } }' do
          let(:instructions) do
            { computed_assoc: { 'float': matching_item.computed_assoc.float } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_assoc: { computed_float: } }' do
          let(:instructions) do
            { computed_assoc: { 'computed_float': matching_item.computed_assoc.computed_float } }
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

        context '{ computed_assoc: { integer: } }' do
          let(:instructions) do
            { computed_assoc: { 'integer': matching_item.computed_assoc.integer } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_assoc: { computed_integer: } }' do
          let(:instructions) do
            { computed_assoc: { 'computed_integer': matching_item.computed_assoc.computed_integer } }
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

        context '{ computed_assoc: { integer: } }' do
          let(:instructions) do
            { computed_assoc: { 'integer': matching_item.computed_assoc.integer } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_assoc: { computed_integer: } }' do
          let(:instructions) do
            { computed_assoc: { 'computed_integer': matching_item.computed_assoc.computed_integer } }
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

        context '{ computed_assoc: { string: } }' do
          let(:instructions) do
            { computed_assoc: { 'string': matching_item.computed_assoc.string } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_assoc: { computed_string: } }' do
          let(:instructions) do
            { computed_assoc: { 'computed_string': matching_item.computed_assoc.computed_string } }
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

        context '{ computed_assoc: { string: } }' do
          let(:instructions) do
            { computed_assoc: { 'string': matching_item.computed_assoc.string } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_assoc: { computed_string: } }' do
          let(:instructions) do
            { computed_assoc: { 'computed_string': matching_item.computed_assoc.computed_string } }
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

        context '{ computed_assoc: { text: } }' do
          let(:instructions) do
            { computed_assoc: { 'text': matching_item.computed_assoc.text } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_assoc: { computed_text: } }' do
          let(:instructions) do
            { computed_assoc: { 'computed_text': matching_item.computed_assoc.computed_text } }
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

        context '{ computed_assoc: { text: } }' do
          let(:instructions) do
            { computed_assoc: { 'text': matching_item.computed_assoc.text } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_assoc: { computed_text: } }' do
          let(:instructions) do
            { computed_assoc: { 'computed_text': matching_item.computed_assoc.computed_text } }
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

        context '{ computed_assoc: { time: } }' do
          let(:instructions) do
            { computed_assoc: { 'time': matching_item.computed_assoc.time } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_assoc: { computed_time: } }' do
          let(:instructions) do
            { computed_assoc: { 'computed_time': matching_item.computed_assoc.computed_time } }
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

        context '{ computed_assoc: { time: } }' do
          let(:instructions) do
            { computed_assoc: { 'time': matching_item.computed_assoc.time } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_assoc: { computed_time: } }' do
          let(:instructions) do
            { computed_assoc: { 'computed_time': matching_item.computed_assoc.computed_time } }
          end

          it_behaves_like 'a successful filter'
        end
      end
    end

    context 'on a SCOPE' do
      context 'matching @foo_1' do
        let(:matching_item) { @foo_1 }

        context '{ datetime_between: [] }' do
          let(:instructions) do
            { 'datetime_between': [
                (matching_item.datetime - 1.day),
                (matching_item.datetime + 1.day)
              ] }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ string_ends_with: }' do
          let(:instructions) do
            { 'string_ends_with': matching_item.string[-3..-1] }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { datetime_between: [] } }' do
          let(:instructions) do
            { assoc: {
                'datetime_between': [
                  (matching_item.assoc.datetime - 1.day),
                  (matching_item.assoc.datetime + 1.day)
                ]
              }
            }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { string_ends_with: } }' do
          let(:instructions) do
            { assoc: { 'string_ends_with': matching_item.assoc.string[-3..-1] } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_assoc: { datetime_between: [] } }' do
          let(:instructions) do
            { computed_assoc: {
                'datetime_between': [
                  (matching_item.computed_assoc.datetime - 1.day),
                  (matching_item.computed_assoc.datetime + 1.day)
                ]
              }
            }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_assoc: { string_ends_with: } }' do
          let(:instructions) do
            { computed_assoc: { 'string_ends_with': matching_item.computed_assoc.string[-3..-1] } }
          end

          it_behaves_like 'a successful filter'
        end
      end

      context 'matching @foo_2' do
        let(:matching_item) { @foo_2 }

        context '{ datetime_between: [] }' do
          let(:instructions) do
            { 'datetime_between': [
                (matching_item.datetime - 1.day),
                (matching_item.datetime + 1.day)
              ] }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ string_ends_with: }' do
          let(:instructions) do
            { 'string_ends_with': matching_item.string[-3..-1] }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { datetime_between: [] } }' do
          let(:instructions) do
            { assoc: {
                'datetime_between': [
                  (matching_item.assoc.datetime - 1.day),
                  (matching_item.assoc.datetime + 1.day)
                ]
              }
            }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { string_ends_with: } }' do
          let(:instructions) do
            { assoc: { 'string_ends_with': matching_item.assoc.string[-3..-1] } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_assoc: { datetime_between: [] } }' do
          let(:instructions) do
            { computed_assoc: {
                'datetime_between': [
                  (matching_item.computed_assoc.datetime - 1.day),
                  (matching_item.computed_assoc.datetime + 1.day)
                ]
              }
            }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_assoc: { string_ends_with: } }' do
          let(:instructions) do
            { computed_assoc: { 'string_ends_with': matching_item.computed_assoc.string[-3..-1] } }
          end

          it_behaves_like 'a successful filter'
        end
      end
    end

    # --------------------------------------------------------------------------

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

        context '{ computed_assoc: { integer:, string: } }' do
          let(:instructions) do
            { computed_assoc: { 'integer': matching_item.computed_assoc.integer, 'string': matching_item.computed_assoc.string } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_assoc: { computed_integer:, computed_string: } }' do
          let(:instructions) do
            { computed_assoc: { 'computed_integer': matching_item.computed_assoc.computed_integer, 'computed_string': matching_item.computed_assoc.computed_string } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_assoc: { integer:, computed_string: } }' do
          let(:instructions) do
            { computed_assoc: { 'integer': matching_item.computed_assoc.integer, 'computed_string': matching_item.computed_assoc.computed_string } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_assoc: { computed_integer:, string: } }' do
          let(:instructions) do
            { computed_assoc: { 'computed_integer': matching_item.computed_assoc.computed_integer, 'string': matching_item.computed_assoc.string } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ integer:, computed_assoc: { string: } }' do
          let(:instructions) do
            { 'integer': matching_item.integer, computed_assoc: { 'string': matching_item.computed_assoc.string } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_assoc: { integer: }, string: }' do
          let(:instructions) do
            { computed_assoc: { 'integer': matching_item.computed_assoc.integer }, 'string': matching_item.string }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ integer:, computed_assoc: { computed_string: } }' do
          let(:instructions) do
            { 'integer': matching_item.integer, computed_assoc: { 'computed_string': matching_item.computed_assoc.computed_string } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_assoc: { integer: }, computed_string: }' do
          let(:instructions) do
            { computed_assoc: { 'integer': matching_item.computed_assoc.integer }, 'computed_string': matching_item.computed_string }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_integer:, computed_assoc: { string: } }' do
          let(:instructions) do
            { 'computed_integer': matching_item.computed_integer, computed_assoc: { 'string': matching_item.computed_assoc.string } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_assoc: { computed_integer: }, string: }' do
          let(:instructions) do
            { computed_assoc: { 'computed_integer': matching_item.computed_assoc.computed_integer }, 'string': matching_item.string }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_integer:, computed_assoc: { computed_string: } }' do
          let(:instructions) do
            { 'computed_integer': matching_item.computed_integer, computed_assoc: { 'computed_string': matching_item.computed_assoc.computed_string } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_assoc: { computed_integer: }, computed_string: }' do
          let(:instructions) do
            { computed_assoc: { 'computed_integer': matching_item.computed_assoc.computed_integer }, 'computed_string': matching_item.computed_string }
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

        context '{ computed_assoc: { integer:, string: } }' do
          let(:instructions) do
            { computed_assoc: { 'integer': matching_item.computed_assoc.integer, 'string': matching_item.computed_assoc.string } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_assoc: { computed_integer:, computed_string: } }' do
          let(:instructions) do
            { computed_assoc: { 'computed_integer': matching_item.computed_assoc.computed_integer, 'computed_string': matching_item.computed_assoc.computed_string } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_assoc: { integer:, computed_string: } }' do
          let(:instructions) do
            { computed_assoc: { 'integer': matching_item.computed_assoc.integer, 'computed_string': matching_item.computed_assoc.computed_string } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_assoc: { computed_integer:, string: } }' do
          let(:instructions) do
            { computed_assoc: { 'computed_integer': matching_item.computed_assoc.computed_integer, 'string': matching_item.computed_assoc.string } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ integer:, computed_assoc: { string: } }' do
          let(:instructions) do
            { 'integer': matching_item.integer, computed_assoc: { 'string': matching_item.computed_assoc.string } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_assoc: { integer: }, string: }' do
          let(:instructions) do
            { computed_assoc: { 'integer': matching_item.computed_assoc.integer }, 'string': matching_item.string }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ integer:, computed_assoc: { computed_string: } }' do
          let(:instructions) do
            { 'integer': matching_item.integer, computed_assoc: { 'computed_string': matching_item.computed_assoc.computed_string } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_assoc: { integer: }, computed_string: }' do
          let(:instructions) do
            { computed_assoc: { 'integer': matching_item.computed_assoc.integer }, 'computed_string': matching_item.computed_string }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_integer:, computed_assoc: { string: } }' do
          let(:instructions) do
            { 'computed_integer': matching_item.computed_integer, computed_assoc: { 'string': matching_item.computed_assoc.string } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_assoc: { computed_integer: }, string: }' do
          let(:instructions) do
            { computed_assoc: { 'computed_integer': matching_item.computed_assoc.computed_integer }, 'string': matching_item.string }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_integer:, computed_assoc: { computed_string: } }' do
          let(:instructions) do
            { 'computed_integer': matching_item.computed_integer, computed_assoc: { 'computed_string': matching_item.computed_assoc.computed_string } }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_assoc: { computed_integer: }, computed_string: }' do
          let(:instructions) do
            { computed_assoc: { 'computed_integer': matching_item.computed_assoc.computed_integer }, 'computed_string': matching_item.computed_string }
          end

          it_behaves_like 'a successful filter'
        end
      end
    end

    context 'with BINARY and BOOLEAN type' do
      context 'matching @foo_1' do
        let(:matching_item) { @foo_1 }

        context '{ binary:, boolean: }' do
          let(:instructions) do
            { 'binary': matching_item.binary, 'boolean': matching_item.boolean }
          end

          it_behaves_like 'a successful filter'
        end
      end
    end

    context 'with BINARY and DATE type' do
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

        context '{ binary:, computed_datetime: }' do
          let(:instructions) do
            { 'binary': matching_item.binary, 'computed_datetime': matching_item.computed_datetime }
          end

          it_behaves_like 'a successful filter'
        end
      end
    end

    context 'with BINARY and DECIMAL type' do
      context 'matching @foo_2' do
        let(:matching_item) { @foo_2 }

        context '{ binary:, decimal: }' do
          let(:instructions) do
            { 'binary': matching_item.binary, 'decimal': matching_item.decimal }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_binary:, decimal: }' do
          let(:instructions) do
            { 'computed_binary': matching_item.computed_binary, 'decimal': matching_item.decimal }
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

        context '{ assoc: { binary:, float: } }' do
          let(:instructions) do
            { assoc: { 'binary': matching_item.assoc.binary, 'float': matching_item.assoc.float } }
          end

          it_behaves_like 'a successful filter'
        end
      end
    end

    context 'with BINARY and INTEGER type' do
      context 'matching @foo_2' do
        let(:matching_item) { @foo_2 }

        context '{ binary:, integer: }' do
          let(:instructions) do
            { 'binary': matching_item.binary, 'integer': matching_item.integer }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_binary:, computed_integer: } }' do
          let(:instructions) do
            { assoc: { 'computed_binary': matching_item.assoc.computed_binary, 'computed_integer': matching_item.assoc.computed_integer } }
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

        context '{ assoc: { binary:, computed_string: } }' do
          let(:instructions) do
            { assoc: { 'binary': matching_item.assoc.binary, 'computed_string': matching_item.assoc.computed_string } }
          end

          it_behaves_like 'a successful filter'
        end
      end
    end

    context 'with BINARY and TEXT type' do
      context 'matching @foo_2' do
        let(:matching_item) { @foo_2 }

        context '{ binary:, text: }' do
          let(:instructions) do
            { 'binary': matching_item.binary, 'text': matching_item.text }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_binary:, text: } }' do
          let(:instructions) do
            { assoc: { 'computed_binary': matching_item.assoc.computed_binary, 'text': matching_item.assoc.text } }
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

        context '{ binary:, assoc: { time: } }' do
          let(:instructions) do
            { 'binary': matching_item.binary, assoc: { 'time': matching_item.assoc.time } }
          end

          it_behaves_like 'a successful filter'
        end
      end
    end


    context 'with BOOLEAN and DATE type' do
      context 'matching @foo_2' do
        let(:matching_item) { @foo_2 }

        context '{ boolean:, date: }' do
          let(:instructions) do
            { 'boolean': matching_item.boolean, 'date': matching_item.date }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { boolean: }, date: }' do
          let(:instructions) do
            { assoc: { 'boolean': matching_item.assoc.boolean }, 'date': matching_item.date }
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

        context '{ boolean:, assoc: { computed_datetime: } }' do
          let(:instructions) do
            { 'boolean': matching_item.boolean, assoc: { 'computed_datetime': matching_item.assoc.computed_datetime } }
          end

          it_behaves_like 'a successful filter'
        end
      end
    end

    context 'with BOOLEAN and DECIMAL type' do
      context 'matching @foo_2' do
        let(:matching_item) { @foo_2 }

        context '{ boolean:, decimal: }' do
          let(:instructions) do
            { 'boolean': matching_item.boolean, 'decimal': matching_item.decimal }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { boolean: }, computed_decimal: }' do
          let(:instructions) do
            { assoc: { 'boolean': matching_item.assoc.boolean }, 'computed_decimal': matching_item.computed_decimal }
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

        context '{ computed_boolean:, assoc: { float: } }' do
          let(:instructions) do
            { 'computed_boolean': matching_item.computed_boolean, assoc: { 'float': matching_item.assoc.float } }
          end

          it_behaves_like 'a successful filter'
        end
      end
    end

    context 'with BOOLEAN and INTEGER type' do
      context 'matching @foo_2' do
        let(:matching_item) { @foo_2 }

        context '{ boolean:, integer: }' do
          let(:instructions) do
            { 'boolean': matching_item.boolean, 'integer': matching_item.integer }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_boolean: }, integer: }' do
          let(:instructions) do
            { assoc: { 'computed_boolean': matching_item.assoc.computed_boolean }, 'integer': matching_item.integer }
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

        context '{ computed_boolean:, assoc: { computed_string: } }' do
          let(:instructions) do
            { 'computed_boolean': matching_item.computed_boolean, assoc: { 'computed_string': matching_item.assoc.computed_string } }
          end

          it_behaves_like 'a successful filter'
        end
      end
    end

    context 'with BOOLEAN and TEXT type' do
      context 'matching @foo_2' do
        let(:matching_item) { @foo_2 }

        context '{ boolean:, text: }' do
          let(:instructions) do
            { 'boolean': matching_item.boolean, 'text': matching_item.text }
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

        context '{ computed_assoc: { boolean:, time: } }' do
          let(:instructions) do
            { computed_assoc: { 'boolean': matching_item.computed_assoc.boolean, 'time': matching_item.computed_assoc.time } }
          end

          it_behaves_like 'a successful filter'
        end
      end
    end


    context 'with DATE and DATETIME type' do
      context 'matching @foo_2' do
        let(:matching_item) { @foo_2 }

        context '{ date:, datetime: }' do
          let(:instructions) do
            { 'date': matching_item.date, 'datetime': matching_item.datetime }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_assoc: { computed_date:, computed_datetime: } }' do
          let(:instructions) do
            { computed_assoc: { 'computed_date': matching_item.computed_assoc.computed_date, 'computed_datetime': matching_item.computed_assoc.computed_datetime } }
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

        context '{ computed_assoc: { date:, computed_decimal: } }' do
          let(:instructions) do
            { computed_assoc: { 'date': matching_item.computed_assoc.date, 'computed_decimal': matching_item.computed_assoc.computed_decimal } }
          end

          it_behaves_like 'a successful filter'
        end
      end
    end

    context 'with DATE and FLOAT type' do
      context 'matching @foo_2' do
        let(:matching_item) { @foo_2 }

        context '{ date:, float: }' do
          let(:instructions) do
            { 'date': matching_item.date, 'float': matching_item.float }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_assoc: { computed_date:, float: } }' do
          let(:instructions) do
            { computed_assoc: { 'computed_date': matching_item.computed_assoc.computed_date, 'float': matching_item.computed_assoc.float } }
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

        context '{ date:, computed_assoc: { integer: } }' do
          let(:instructions) do
            { 'date': matching_item.date, computed_assoc: { 'integer': matching_item.computed_assoc.integer } }
          end

          it_behaves_like 'a successful filter'
        end
      end
    end

    context 'with DATE and STRING type' do
      context 'matching @foo_2' do
        let(:matching_item) { @foo_2 }

        context '{ date:, string: }' do
          let(:instructions) do
            { 'date': matching_item.date, 'string': matching_item.string }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_assoc: { date: }, string: }' do
          let(:instructions) do
            { computed_assoc: { 'date': matching_item.computed_assoc.date }, 'string': matching_item.string }
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

        context '{ date:, computed_assoc: { computed_text: } }' do
          let(:instructions) do
            { 'date': matching_item.date, computed_assoc: { 'computed_text': matching_item.computed_assoc.computed_text } }
          end

          it_behaves_like 'a successful filter'
        end
      end
    end

    context 'with DATE and TIME type' do
      context 'matching @foo_2' do
        let(:matching_item) { @foo_2 }

        context '{ date:, time: }' do
          let(:instructions) do
            { 'date': matching_item.date, 'time': matching_item.time }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_assoc: { date: }, computed_time: }' do
          let(:instructions) do
            { computed_assoc: { 'date': matching_item.computed_assoc.date }, 'computed_time': matching_item.computed_time }
          end

          it_behaves_like 'a successful filter'
        end
      end
    end


    context 'with DATETIME and DECIMAL type' do
      context 'matching @foo_2' do
        let(:matching_item) { @foo_2 }

        context '{ datetime:, decimal: }' do
          let(:instructions) do
            { 'datetime': matching_item.datetime, 'decimal': matching_item.decimal }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ datetime:, computed_assoc: { computed_decimal: } }' do
          let(:instructions) do
            { 'datetime': matching_item.datetime, computed_assoc: { 'computed_decimal': matching_item.computed_assoc.computed_decimal } }
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

        context '{ computed_assoc: { datetime: }, computed_float: }' do
          let(:instructions) do
            { computed_assoc: { 'datetime': matching_item.computed_assoc.datetime }, 'computed_float': matching_item.computed_float }
          end

          it_behaves_like 'a successful filter'
        end
      end
    end

    context 'with DATETIME and INTEGER type' do
      context 'matching @foo_2' do
        let(:matching_item) { @foo_2 }

        context '{ datetime:, integer: }' do
          let(:instructions) do
            { 'datetime': matching_item.datetime, 'integer': matching_item.integer }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_assoc: { datetime: }, computed_integer: }' do
          let(:instructions) do
            { computed_assoc: { 'datetime': matching_item.computed_assoc.datetime }, 'computed_integer': matching_item.computed_integer }
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

        context '{ computed_datetime:, computed_assoc: { string: } }' do
          let(:instructions) do
            { 'computed_datetime': matching_item.computed_datetime, computed_assoc: { 'string': matching_item.computed_assoc.string } }
          end

          it_behaves_like 'a successful filter'
        end
      end
    end

    context 'with DATETIME and TEXT type' do
      context 'matching @foo_2' do
        let(:matching_item) { @foo_2 }

        context '{ datetime:, text: }' do
          let(:instructions) do
            { 'datetime': matching_item.datetime, 'text': matching_item.text }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_assoc: { computed_datetime: }, text: }' do
          let(:instructions) do
            { computed_assoc: { 'computed_datetime': matching_item.computed_assoc.computed_datetime }, 'text': matching_item.text }
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

        context '{ computed_datetime:, computed_assoc: { computed_time: } }' do
          let(:instructions) do
            { 'computed_datetime': matching_item.computed_datetime, computed_assoc: { 'computed_time': matching_item.computed_assoc.computed_time } }
          end

          it_behaves_like 'a successful filter'
        end
      end
    end


    context 'with DECIMAL and FLOAT type' do
      context 'matching @foo_2' do
        let(:matching_item) { @foo_2 }

        context '{ decimal:, float: }' do
          let(:instructions) do
            { 'decimal': matching_item.decimal, 'float': matching_item.float }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_assoc: { computed_decimal: }, computed_float: }' do
          let(:instructions) do
            { computed_assoc: { 'computed_decimal': matching_item.computed_assoc.computed_decimal }, 'computed_float': matching_item.computed_float }
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

        context '{ decimal:, integer: }' do
          let(:instructions) do
            { 'decimal': matching_item.decimal, 'integer': matching_item.integer }
          end

          it_behaves_like 'a successful filter'
        end
      end
    end

    context 'with DECIMAL and STRING type' do
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

        context '{ decimal:, computed_text: }' do
          let(:instructions) do
            { 'decimal': matching_item.decimal, 'computed_text': matching_item.computed_text }
          end

          it_behaves_like 'a successful filter'
        end
      end
    end

    context 'with DECIMAL and TIME type' do
      context 'matching @foo_2' do
        let(:matching_item) { @foo_2 }

        context '{ decimal:, time: }' do
          let(:instructions) do
            { 'decimal': matching_item.decimal, 'time': matching_item.time }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ computed_decimal:, time: }' do
          let(:instructions) do
            { 'computed_decimal': matching_item.computed_decimal, 'time': matching_item.time }
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

        context '{ assoc: { float:, integer: } }' do
          let(:instructions) do
            { assoc: { 'float': matching_item.assoc.float, 'integer': matching_item.assoc.integer } }
          end

          it_behaves_like 'a successful filter'
        end
      end
    end

    context 'with FLOAT and STRING type' do
      context 'matching @foo_2' do
        let(:matching_item) { @foo_2 }

        context '{ float:, string: }' do
          let(:instructions) do
            { 'float': matching_item.float, 'string': matching_item.string }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_float:, computed_string: } }' do
          let(:instructions) do
            { assoc: { 'computed_float': matching_item.assoc.computed_float, 'computed_string': matching_item.assoc.computed_string } }
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

        context '{ assoc: { float:, computed_text: } }' do
          let(:instructions) do
            { assoc: { 'float': matching_item.assoc.float, 'computed_text': matching_item.assoc.computed_text } }
          end

          it_behaves_like 'a successful filter'
        end
      end
    end

    context 'with FLOAT and TIME type' do
      context 'matching @foo_2' do
        let(:matching_item) { @foo_2 }

        context '{ float:, time: }' do
          let(:instructions) do
            { 'float': matching_item.float, 'time': matching_item.time }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { computed_float:, time: } }' do
          let(:instructions) do
            { assoc: { 'computed_float': matching_item.assoc.computed_float, 'time': matching_item.assoc.time } }
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

        context '{ integer:, assoc: { text: } }' do
          let(:instructions) do
            { 'integer': matching_item.integer, assoc: { 'text': matching_item.assoc.text } }
          end

          it_behaves_like 'a successful filter'
        end
      end
    end

    context 'with INTEGER and TIME type' do
      context 'matching @foo_2' do
        let(:matching_item) { @foo_2 }

        context '{ integer:, time: }' do
          let(:instructions) do
            { 'integer': matching_item.integer, 'time': matching_item.time }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { integer: }, time: }' do
          let(:instructions) do
            { assoc: { 'integer': matching_item.assoc.integer }, 'time': matching_item.time }
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

        context '{ string:, assoc: { computed_text: } }' do
          let(:instructions) do
            { 'string': matching_item.string, assoc: { 'computed_text': matching_item.assoc.computed_text } }
          end

          it_behaves_like 'a successful filter'
        end
      end
    end

    context 'with STRING and TIME type' do
      context 'matching @foo_2' do
        let(:matching_item) { @foo_2 }

        context '{ string:, time: }' do
          let(:instructions) do
            { 'string': matching_item.string, 'time': matching_item.time }
          end

          it_behaves_like 'a successful filter'
        end

        context '{ assoc: { string: }, computed_time: }' do
          let(:instructions) do
            { assoc: { 'string': matching_item.assoc.string }, 'computed_time': matching_item.computed_time }
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

        context '{ computed_text:, assoc: { time: } }' do
          let(:instructions) do
            { 'computed_text': matching_item.computed_text, assoc: { 'time': matching_item.assoc.time } }
          end

          it_behaves_like 'a successful filter'
        end
      end
    end
  end
end
