@entries = {}

table = [
  ['a', ["あ"]],
  ['b', ["ば", "び", "ぶ", "べ", "ぼ"]],
  ['c', ["ち"]],
  ['d', ["だ", "で"]],
  ['e', ["え"]],
  ['g', ["が", "ぎ", "ぐ", "げ", "ご"]],
  ['h', ["は", "ひ", "ふ", "へ", "ほ"]],
  ['i', ["い"]],
  ['j', ["じ"]],
  ['k', ["か", "き", "く", "け", "こ"]],
  ['m', ["ま", "み", "む", "め", "も"]],
  ['n', ["な", "に", "ぬ", "ね", "の", "ん"]],
  ['o', ["お"]],
  ['r', ["ら", "り", "る", "れ", "ろ"]],
  ['s', ["さ", "し", "す", "せ", "そ"]],
  ['t', ["た", "ち", "つ", "て", "と", "っ"]],
  ['u', ["う"]],
  ['w', ["わ"]],
  ['y', ["や", "ゆ", "よ"]],
  ['z', ["ざ", "じ", "ず", "ぜ", "ぞ"]]
]

ARGF.each { |line|
  line.chomp!
  next if line =~ /^\s*;/
  (y, e) = line.split
  e.sub!(/^\//,'').sub!(/\/$/,'')
  words = e.split(/\//).map { |s|
    s.sub(/;.*/,'')
  }
  words.each { |word|
    okuri_ari = false
    table.each { |te|
      rpat = te[0]
      if y =~ /^(.*)#{rpat}$/ then
        head = $1
        te[1].each { |c|
          @entries[word[0]] = [] unless @entries[word[0]]
          @entries[word[0]] << ["#{word}#{c}", "#{head}#{c}"]
        }
        okuri_ari = true
      end
    }
    unless okuri_ari
      @entries[word[0]] = [] unless @entries[word[0]]
      @entries[word[0]] << [word, y]
    end
  }
}

@newentries = {}
@entries.each { |c,entries|
  @newentries[c] = entries.sort { |a,b|
    b[0].length <=> a[0].length
  }
}
@entries = @newentries

require 'json'
File.open("dict.json","w"){ |f|
  f.puts @entries.to_json
}

