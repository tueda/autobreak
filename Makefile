LATEX = pdflatex
LATEX_OPT = -interaction=nonstopmode -halt-on-error

CONTRIBUTION = autobreak

MOSTLYCLEANFILES = \
	$(CONTRIBUTION).aux \
	$(CONTRIBUTION).glo \
	$(CONTRIBUTION).gls \
	$(CONTRIBUTION).hd \
	$(CONTRIBUTION).idx \
	$(CONTRIBUTION).ilg \
	$(CONTRIBUTION).ind \
	$(CONTRIBUTION).log \
	$(CONTRIBUTION).out \
	$(CONTRIBUTION).tar.gz \
	$(CONTRIBUTION).tmp \
	$(CONTRIBUTION).toc \

CLEANFILES = \
	$(CONTRIBUTION).ins \
	$(CONTRIBUTION).pdf \
	$(CONTRIBUTION).sty \

DISTFILES = \
	$(CONTRIBUTION).dtx \
	$(CONTRIBUTION).ins \
	$(CONTRIBUTION).sty \
	$(CONTRIBUTION).pdf \
	README.md \

all: $(CONTRIBUTION).pdf

dist: $(CONTRIBUTION).tar.gz

mostlyclean:
	make -C tests mostlyclean
	rm -f $(MOSTLYCLEANFILES)

clean: mostlyclean
	make -C tests clean
	rm -f $(CLEANFILES)

CHECK = \
	if grep 'Overfull' *.log || grep 'Warning' *.log; then \
		exit 1; \
	fi; \
	echo 'OK' \

check: all
	make -C tests check
	$(CHECK)

$(CONTRIBUTION).ins: $(CONTRIBUTION).dtx
	tex $(CONTRIBUTION).dtx

$(CONTRIBUTION).sty: $(CONTRIBUTION).dtx
	tex $(CONTRIBUTION).dtx

$(CONTRIBUTION).pdf: $(CONTRIBUTION).dtx
	touch thumbpdf.sty
	$(LATEX) $(LATEX_OPT) $(CONTRIBUTION).dtx
	makeindex -s gind.ist $(CONTRIBUTION).idx
	makeindex -s gglo.ist -o $(CONTRIBUTION).gls $(CONTRIBUTION).glo
	$(LATEX) $(LATEX_OPT) $(CONTRIBUTION).dtx
	$(LATEX) $(LATEX_OPT) $(CONTRIBUTION).dtx
	rm thumbpdf.sty

$(CONTRIBUTION).tar.gz: $(DISTFILES)
	ctanify $(DISTFILES)
