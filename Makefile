all:
	pdflatex autobreak.dtx
	makeindex -s gind.ist autobreak.idx
	makeindex -s gglo.ist -o autobreak.gls autobreak.glo
	pdflatex autobreak.dtx
	pdflatex autobreak.dtx

mostlyclean:
	rm -f autobreak.{aux,glo,gls,hd,idx,ilg,ind,log,out,log}

clean: mostlyclean
	rm -f autobreak.{ins,pdf,sty}
