#!/usr/bin/env texlua

module = "autobreak"

unpackfiles = {"*.dtx"}

if not release_date then
  kpse.set_program_name("kpsewhich")
  dofile(kpse.lookup("l3build.lua"))
end
