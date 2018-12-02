require 'json'

def hiragana(text)
  @entries = JSON.parse(File.read("dict.json")) unless @entries
  hira = "あいうえおぁぃぅぇぉかきくけこがぎぐげご" +
          "さしすせそざじずぜぞたちつてとだぢづでどっなにぬねの" +
          "はひふへほばびぶべぼぱぴぷぺぽまみむめもやゆよゃゅょ" +
          "らりるれろわをんー"
  kata = "アイウエオァィゥェォカキクケコガギグゲゴ" +
          "サシスセソザジズゼゾタチツテトダヂヅデドッナニヌネノ" +
          "ハヒフヘホバビブベボパピプペポマミムメモヤユヨャュョ" +
          "ラリルレロワヲンー"
  s = ''
  while text != '' do
    processed = false
    c = text[0]
    if @entries[c] && c !~ /\w/ && !hira.index(c) && !kata.index(c) then
      @entries[c].each { |entry|
        if text.index(entry[0]) == 0 then
	  text = text[entry[0].length..-1]
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
  s.tr(kata,hira)
end

ARGF.each { |line|
  line.chomp!
  puts hiragana(line)
}



