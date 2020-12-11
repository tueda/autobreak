#!/bin/bash
set -eu
SCRIPTDIR=$(cd $(dirname "$0"); pwd)
N=10
[ $# -ge 1 ] && [ -n "$1" ] && N=$1

form -q -D N=$N $SCRIPTDIR/trace.frm   |
  sed 's/F=//'                         | # Remove the LHS
  sed 's/\*/ /g'                       | # "*" -> " "
  sed 's/(/{/g'                        | # "(" -> "{"
  sed 's/)/}/g'                        | # ")" -> "}"
  sed 's/d_/g^/g'                      | # "d_" -> "g^"
  sed 's/mu\([1-9][0-9]\)/\\mu_{\1}/g' | # "mu" -> "\mu"
  sed 's/mu\([1-9]\)/\\mu_\1/g'        | # "mu" -> "\mu"
  sed 's/,/ /g'                        | # "," -> " "
  sed 's/;//g'                         | # ";" -> ""
  sed '/^ *$/d'                        | # Remove empty lines
  cat
