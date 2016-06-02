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
	rm -f $(MOSTLYCLEANFILES)

clean: mostlyclean
	rm -f $(CLEANFILES)

$(CONTRIBUTION).ins: $(CONTRIBUTION).dtx
	tex $(CONTRIBUTION).dtx

$(CONTRIBUTION).sty: $(CONTRIBUTION).dtx
	tex $(CONTRIBUTION).dtx

$(CONTRIBUTION).pdf: $(CONTRIBUTION).dtx
	pdflatex $(CONTRIBUTION).dtx
	makeindex -s gind.ist $(CONTRIBUTION).idx
	makeindex -s gglo.ist -o $(CONTRIBUTION).gls $(CONTRIBUTION).glo
	pdflatex $(CONTRIBUTION).dtx
	pdflatex $(CONTRIBUTION).dtx

$(CONTRIBUTION).tar.gz: $(DISTFILES)
	ctanify $(DISTFILES)
