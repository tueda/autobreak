LATEX = pdflatex
#LATEX = lualatex
LATEX_OPT = -interaction=nonstopmode -halt-on-error

PDFS = \
	test-basic.pdf \
	test-simple.pdf \
	test-simple-two.pdf \
	test-many.pdf \
	test-twocolumn.pdf \
	test-punct.pdf \
	test-every.pdf \
	test-unbalanced.pdf \
	test-textstyle.pdf \
	test-fontsize.pdf \
	test-muskip.pdf \
	test-trace.pdf \

all: $(PDFS)

mostlyclean:
	rm -f test*.aux test*.log

clean: mostlyclean
	rm -f autobreak.sty test*.pdf z?-???.inc cos-???.inc trace-*.inc

CHECK = \
	if grep 'Overfull' *.log || grep 'Warning' *.log; then \
		exit 1; \
	fi; \
	echo 'OK' \

check: $(PDFS)
	$(CHECK)

autobreak.sty: ../autobreak.dtx
	[ -f autobreak.sty ] || ln -s ../autobreak.sty
	make -C .. autobreak.sty

z2-100.inc: zetasum.py
	python zetasum.py 2 100 >z2-100.inc

z2-500.inc: zetasum.py
	python zetasum.py 2 500 >z2-500.inc

z3-100.inc: zetasum.py
	python zetasum.py 3 100 >z3-100.inc

z4-100.inc: zetasum.py
	python zetasum.py 4 100 >z4-100.inc

z5-100.inc: zetasum.py
	python zetasum.py 5 100 >z5-100.inc

cos-100.inc: cos.py
	python cos.py 100 >cos-100.inc

trace-10.inc: trace.sh trace.frm
	sh trace.sh 10 >trace-10.inc

DEPS = autobreak.sty drawboxes.sty drawboxes.lua

test-basic.pdf: $(DEPS)

test-simple.pdf: $(DEPS) z2-500.inc

test-simple-two.pdf: $(DEPS) z2-100.inc z3-100.inc

test-many.pdf: $(DEPS) z2-100.inc z3-100.inc

test-twocolumn.pdf: $(DEPS) z2-100.inc z3-100.inc z4-100.inc z5-100.inc

test-punct.pdf: $(DEPS)

test-every.pdf: $(DEPS) cos-100.inc

test-unbalanced.pdf: $(DEPS)

test-textstyle.pdf: $(DEPS) z2-100.inc

test-fontsize.pdf: $(DEPS) z2-100.inc

test-muskip.pdf: $(DEPS) z2-100.inc

test-trace.pdf: $(DEPS) trace-10.inc

.SUFFIXES: .pdf .tex

.tex.pdf:
	$(LATEX) $(LATEX_OPT) $<
	$(LATEX) $(LATEX_OPT) $<
