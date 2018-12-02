require 'json'

def kata2hira(s)
  hira = "あいうえおぁぃぅぇぉかきくけこがぎぐげご" +
         "さしすせそざじずぜぞたちつてとだぢづでどっなにぬねの" +
         "はひふへほばびぶべぼぱぴぷぺぽまみむめもやゆよゃゅょ" +
         "らりるれろわをんー"
  kata = "アイウエオァィゥェォカキクケコガギグゲゴ" +
         "サシスセソザジズゼゾタチツテトダヂヅデドッナニヌネノ" +
         "ハヒフヘホバビブベボパピプペポマミムメモヤユヨャュョ" +
         "ラリルレロワヲンー"
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

ARGF.each { |line|
  line.chomp!
  puts hiragana(line)
}



