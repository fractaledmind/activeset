module PathHelpers
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

  def value_for(object:, path:)
    ActiveSet::AttributeInstruction.new(path, nil).value_for(item: object)
  end
end
