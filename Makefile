all:
	hfst-lexc apertium-ssw.ssw.lexc -o ssw.lexc.hfst
	hfst-twolc apertium-ssw.ssw.twoc -o ssw.twoc.hfst
	hfst-twolc apertium-ssw.ssw.twol -o ssw.twol.hfst

	hfst-compose-intersect -1 ssw.lexc.hfst -2 ssw.twol.hfst | hfst-invert -o ssw.mor.hfst

	hfst-compose-intersect -1 ssw.mor.hfst -2 ssw.twoc.hfst | hfst-fst2fst -O -o ssw.automorf.hfst

clean:
	rm *.hfst
