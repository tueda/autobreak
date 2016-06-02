#! /bin/sh
""":" .

exec python "$0" ${1+"$@"}
"""

import sys

__doc__ = """Print the infinite product for cos(x)."""

n = 50

if len(sys.argv) >= 2:
    n = int(sys.argv[1])

print(r'    \cos(x) =')
for j in range(1, n + 1):
    print(r'    \left(1-\frac{{4x^2}}{{{0}\pi^2}}\right)'.format(
        (2 * j - 1)**2 if j >= 2 else ''))
print(r'    \dots')
