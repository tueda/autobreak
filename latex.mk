MAKEFILE4LATEX_REVISION = v0.5.0
MAKEFILE4LATEX_CACHE = $(shell git rev-parse --show-toplevel)/.cache

BUILDDIR = .build

CLEANFILES += \
	autobreak.ins \
	autobreak.pdf \
	autobreak.sty \
	autobreak*.zip \

CLEANDIRS += build testfiles

all: autobreak.ins autobreak.sty autobreak.pdf

dist: _FORCE
	@$(call exec,texlua build.lua ctan)

autobreak.ins: autobreak.sty

autobreak.sty: autobreak.dtx
	@$(call exec,tex autobreak.dtx)
	@$(ensure_build_dir)
	@mv autobreak.log $(BUILDDIR)/autobreak.sty.log

autobreak.pdf: autobreak.dtx autobreak.sty
	@$(init_toolchain)
	@$(call typeset,$(latex))
	@$(mv_target)

do_makeindex = \
	if $$need_makeindex; then \
		need_makeindex=false; \
		$(call do_backup,$*.ind); \
		$(call set_aux_file,$*.ind); \
		$(call copy_build_temp_file,$*.idx); \
		$(call exec,$(makeindex) -s gind.ist $*.idx); \
		mv $*.ind $*.ilg $(BUILDDIR)/; \
		$(clear_build_temp_files); \
		$(reset_aux_file); \
		$(call check_modified,$*.ind) && need_latex=:; \
	fi

do_makeglossaries = \
	if $$need_makeglossaries; then \
		need_makeglossaries=false; \
		$(call do_backup,$*.gls); \
		$(call set_aux_file,$*.gls); \
		$(call copy_build_temp_file,$*.glo); \
		$(call exec,$(makeindex) -s gglo.ist -o $*.gls -t $*.glg $*.glo); \
		mv $*.gls $*.glg $(BUILDDIR)/; \
		$(clear_build_temp_files); \
		$(reset_aux_file); \
		$(call check_modified,$*.gls) && need_latex=:; \
	fi

prepare-testfiles: autobreak.ins
	@$(MAKE) -C tests prepare-inc-files
	@mkdir -p testfiles/support
	@touch testfiles/support/drawboxes.sty
	@cp tests/.build/*.inc testfiles/support/
	@$(foreach src,$(wildcard tests/test-*.tex), \
		sed -e '1i \\\input{regression-test.tex}' \
			-e '/\\begin{document}/a \\\START\n\\\showoutput' \
			-e '/\\end{document}/i \\\vfil\\\break\n\\\END' \
			$(src) \
			>$(patsubst tests/test-%.tex,testfiles/%.lvt,$(src)); \
	)

check-testfiles:
	@$(foreach test,$(wildcard testfiles/*.lvt), \
		grep -q '\\START' $(test) || exit 1; \
		grep -q '\\END' $(test) || exit 1; \
	)

l3build-save: prepare-testfiles check-testfiles
	@$(call exec,texlua build.lua save --engine pdftex $(patsubst testfiles/%.lvt,%,$(wildcard testfiles/*.lvt)))

l3build-check:
	@$(call exec,texlua build.lua check --engine pdftex)
