names = [
  "講談社",
  "KADOKAWA",
  "集英社",
  "小学館",
  "学研プラス",
  "文藝春秋",
  "新潮社",
  "医学書院",
  "宝島社",
  "ダイヤモンド社",
]
names.each.with_index(1) do |name, idx|
  Publisher.seed do |s|
    s.id = idx
    s.name = name
  end
end