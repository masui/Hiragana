require 'json'

def kata2hira(s)
  hira = "あいうえおぁぃぅぇぉかきくけこがぎぐげご" +
    "さしすせそざじずぜぞたちつてとだぢづでどっなにぬねの" +
    "はひふへほばびぶべぼぱぴぷぺぽまみむめもやゆよゃゅょ" +
    "らりるれろわをん"
  kata = "アイウエオァィゥェォカキクケコガギグゲゴ" +
    "サシスセソザジズゼゾタチツテトダヂヅデドッナニヌネノ" +
    "ハヒフヘホバビブベボパピプペポマミムメモヤユヨャュョ" +
    "ラリルレロワヲン"
  s.tr(kata,hira)
end

def hiragana(text)
  @entries = JSON.parse(File.read("dict.json")) unless @entries
  s = ''
  while text != '' do
    processed = false
    if @entries[text[0]] && text[0] !~ /\w/ then
      @entries[text[0]].each { |entry|
        if text.sub!(/^#{entry[0]}/,'') then
          s += entry[1]
          processed = true
          break
        end
      }
    end
    unless processed
      s += text[0]
      text.sub!(/^./,'')
    end
  end
  kata2hira(s)
end

puts hiragana("今日はいろいろkankan$%^食べて来ました")
puts hiragana("藤沢でごはんを食べました")
puts hiragana("増井の体重は平均して減っていません")
puts hiragana("天気が良いので自転車で走ってきました")
puts hiragana("大地震がありました")
puts hiragana("浅草でフェスに来ています")
puts hiragana("1234湘南台の研究所が凄かった")


