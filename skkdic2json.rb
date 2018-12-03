#
# SKK辞書の送りがなを展開する
#
okurigana_table = {
  'a' => ["あ"],
  'b' => ["ば", "び", "ぶ", "べ", "ぼ", "っ"],
  'c' => ["ち", "っ"],
  'd' => ["だ", "で", "っ"],
  'e' => ["え"],
  'f' => [],
  'g' => ["が", "ぎ", "ぐ", "げ", "ご", "っ"],
  'h' => ["は", "ひ", "ふ", "へ", "ほ", "っ"],
  'i' => ["い"],
  'j' => ["じ", "っ"],
  'k' => ["か", "き", "く", "け", "こ", "っ"],
  'l' => [],
  'm' => ["ま", "み", "む", "め", "も", "っ"],
  'n' => ["な", "に", "ぬ", "ね", "の", "ん"],
  'o' => ["お"],
  'p' => ["ぱ", "ぴ", "ぷ", "ぺ", "ぽ", "っ"],
  'q' => [],
  'r' => ["ら", "り", "る", "れ", "ろ", "っ"],
  's' => ["さ", "し", "す", "せ", "そ", "っ"],
  't' => ["た", "ち", "つ", "て", "と", "っ"],
  'u' => ["う"],
  'v' => [],
  'w' => ["わ"],
  'x' => [],
  'y' => ["や", "ゆ", "よ"],
  'z' => ["ざ", "じ", "ず", "ぜ", "ぞ", "っ"]
}

entries = {}

ARGF.each { |line|
  line.chomp!
  next if line =~ /^\s*;/
  next if line =~ /^>/
  (yomi, wordlist) = line.split
  wordlist.sub(/^\//,'').sub(/\/$/,'').split(/\//).map { |s|
    s.sub(/;.*/,'')
  }.each { |word|
    if yomi =~ /^(.*)([a-z])$/ then
      head = $1
      okurigana_table[$2].each { |c|
        entries[word[0]] = [] unless entries[word[0]]
        entries[word[0]] << ["#{word}#{c}", "#{head}#{c}"]
      }
    else
      entries[word[0]] = [] unless entries[word[0]]
      entries[word[0]] << [word, yomi]
    end
  }
}

entries.each { |c,wordlist|
  entries[c] = wordlist.sort { |a,b|
    b[0].length <=> a[0].length
  }
}

require 'json'

puts entries.to_json

