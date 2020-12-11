#!/bin/sh
""":" .

exec python "$0" ${1+"$@"}
"""

import sys

__doc__ = """Print the sum for a zeta value."""

s = 2
n = 50

if len(sys.argv) >= 2:
    s = int(sys.argv[1])
if len(sys.argv) >= 3:
    n = int(sys.argv[2])

print(r'    \zeta({0}) ='.format(s))
print(r'    1')
for j in range(2, n + 1):
    print(r'    + \frac{{1}}{{{0}}}'.format(j ** s))
print(r'    + \dots')
