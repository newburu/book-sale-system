names = [
  "集英社",
  "講談社",
  "小学館",
]
names.each.with_index(1) do |name, idx|
  Publisher.seed do |s|
    s.id = idx
    s.name = name
  end
end