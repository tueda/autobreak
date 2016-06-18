all: example.png

mostlyclean:
	rm -f example.aux example.log example.pdf example-crop.pdf

clean: mostlyclean
	rm -f example.png

example.png: example.tex
	pdflatex example
	pdfcrop --margins 10 example.pdf example-crop.pdf
	convert -density 150 -quality 90 example-crop.pdf example.png
