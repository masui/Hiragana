dict:
	gzip -d < SKK-JISYO.L.gz | nkf -w | ruby skkdic2json.rb > dict.json


