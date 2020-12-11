BUILDDIR =.build

# LUA=1 uses LuaLaTeX to visualize boxes.
LUA =
ifneq ($(LUA),)
	TOOLCHAIN = lualatex
endif

TESTS = check-logs

# NOTE: autobreak is not responsible for "Underfull \vbox" warnings.
check-logs: pdf _FORCE
	@echo "Checking log files..."
	@ls .build/*.log
	@if grep 'Overfull' .build/*.log || grep 'Warning' .build/*.log; then exit 1; fi
	@echo OK

inc_files = $(addprefix $(BUILDDIR)/, \
	z2-100.inc z2-500.inc z3-100.inc z4-100.inc z5-100.inc \
	cos-100.inc trace-10.inc)

prepare-inc-files: $(inc_files)

PREREQUISITE = $(BUILDDIR)/autobreak.sty $(inc_files)

$(BUILDDIR)/autobreak.sty: ../autobreak.dtx
	@$(MAKE) -C .. -s autobreak.sty
	@$(ensure_build_dir)
	@cd $(BUILDDIR) && { [ -f autobreak.sty ] || ln -s ../../autobreak.sty; }

$(BUILDDIR)/z2-100.inc: scripts/zetasum.py
	@$(ensure_build_dir)
	@$(call exec,python scripts/zetasum.py 2 100 >$(BUILDDIR)/z2-100.inc)

$(BUILDDIR)/z2-500.inc: scripts/zetasum.py
	@$(ensure_build_dir)
	@$(call exec,python scripts/zetasum.py 2 500 >$(BUILDDIR)/z2-500.inc)

$(BUILDDIR)/z3-100.inc: scripts/zetasum.py
	@$(ensure_build_dir)
	@$(call exec,python scripts/zetasum.py 3 100 >$(BUILDDIR)/z3-100.inc)

$(BUILDDIR)/z4-100.inc: scripts/zetasum.py
	@$(ensure_build_dir)
	@$(call exec,python scripts/zetasum.py 4 100 >$(BUILDDIR)/z4-100.inc)

$(BUILDDIR)/z5-100.inc: scripts/zetasum.py
	@$(ensure_build_dir)
	@$(call exec,python scripts/zetasum.py 5 100 >$(BUILDDIR)/z5-100.inc)

$(BUILDDIR)/cos-100.inc: scripts/cos.py
	@$(ensure_build_dir)
	@$(call exec,python scripts/cos.py 100 >$(BUILDDIR)/cos-100.inc)

$(BUILDDIR)/trace-10.inc: scripts/trace.sh scripts/trace.frm
	@$(ensure_build_dir)
	@$(call exec,bash scripts/trace.sh 10 >$(BUILDDIR)/trace-10.inc)
