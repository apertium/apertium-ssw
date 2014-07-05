all: .deps/.d
	hfst-lexc apertium-ssw.ssw.lexc -o .deps/ssw.lexc.hfst
	hfst-twolc apertium-ssw.ssw.twoc -o .deps/ssw.twoc.hfst
	hfst-twolc apertium-ssw.ssw.twol -o .deps/ssw.twol.hfst

	hfst-compose-intersect -1 .deps/ssw.lexc.hfst -2 .deps/ssw.twol.hfst | hfst-invert -o .deps/ssw.mor.hfst
	hfst-compose-intersect -1 .deps/ssw.mor.hfst -2 .deps/ssw.twoc.hfst | hfst-fst2fst -f foma -o .deps/ssw.automorf.hfst
	hfst-invert .deps/ssw.automorf.hfst -o .deps/ssw.autogen.hfst

	hfst-fst2txt .deps/ssw.automorf.hfst -o ssw.automorf.att
	hfst-fst2txt .deps/ssw.autogen.hfst -o ssw.autogen.att

	cg-comp apertium-ssw.ssw.rlx ssw.rlx.bin

	lt-comp lr ssw.automorf.att ssw.automorf.bin 
	lt-comp lr ssw.autogen.att ssw.autogen.bin 

.deps/.d:
	test -d .deps || mkdir .deps
	touch $@

clean:
	rm *.hfst *.rlx.bin
