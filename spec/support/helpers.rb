def all_possible_paths_for(type)
  %W[
    #{type}
    computed_#{type}
    one.#{type}
    one.computed_#{type}
    computed_one.#{type}
    computed_one.computed_#{type}
  ]
end

def all_possible_path_combinations_for(type_1, type_2)
  all_possible_paths_for(type_1)
    .product(
  all_possible_paths_for(type_2))
end

def all_possible_sort_instructions_for(type)
  all_possible_paths_for(type)
    .product([:asc, 'desc'])
    .map { |instruction_tuple| Hash[*instruction_tuple] }
end

def all_possible_sort_instruction_combinations_for(type_1, type_2)
  all_possible_path_combinations_for(type_1, type_2)
    .to_enum
    .with_index
    .map do |paths, index|
      directions = index.odd? ? ['asc', :desc] : [:desc, 'asc']
      Hash[paths.zip(directions)]
    end
end

def value_for(object:, path:)
  value = path.split('.').reduce(object) { |obj, m| obj.send(m.gsub('(i)', '')) }
  return value.to_s if [true, false].include? value
  return value&.downcase if path.end_with? '(i)'

  value
end

RSpec.shared_examples 'a sorted collection' do |instructions|
  it do
    result.each_cons(2) do |left_result, right_result|
      instructions.each do |(path, dir)|
        left_value = value_for(path: path, object: left_result)
        right_value = value_for(path: path, object: right_result)
        sortedness = dir.to_s == 'asc' ? -1 : 1

        expect(left_value <=> right_value).to satisfy { |v| [0, nil, sortedness].include? v }
        break unless left_value == right_value
      end
    end
  end
end
