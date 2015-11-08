json.array!(@subcategories) do |subcategory|
  json.extract! subcategory, :name, :id
end
