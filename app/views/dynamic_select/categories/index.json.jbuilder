json.array!(@categories) do |category|
  json.extract! category, :name, :id
end
