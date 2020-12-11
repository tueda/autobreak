MAKEFILE4LATEX_REVISION = v0.5.0
MAKEFILE4LATEX_CACHE = $(shell git rev-parse --show-toplevel)/.cache

BUILDDIR = .build

CLEANFILES += \
	autobreak.ins \
	autobreak.pdf \
	autobreak.sty \
	autobreak*.zip \

CLEANDIRS += build

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
