dict:
	gzip -d < SKK-JISYO.L.gz | nkf -w | ruby skkdic2json.rb > dict.json

test:
	echo '増井です' | ruby hiragana.rb
	echo '歩いて食べて' | ruby hiragana.rb
	echo '湘南台の図書館でバニーガールとデートする' | ruby hiragana.rb
	echo '1234^&*(みたいな記号' | ruby hiragana.rb
