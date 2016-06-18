autobreak
=========
Simple line breaking of long formulae.

This package provides a simple mechanism to (semi-)automatically insert
line/page breaks in long equations.


Example
-------

```latex
\documentclass{article}
\usepackage{amsmath}
\usepackage{autobreak}
\pagestyle{empty}
\allowdisplaybreaks
\begin{document}

\begin{align}
  \begin{autobreak}
    \zeta(2) =
    1
    + \frac{1}{4}
    + \frac{1}{9}
    + \frac{1}{16}
    + \frac{1}{25}
    + \frac{1}{36}
    + \frac{1}{49}
    + \frac{1}{64}
    + \frac{1}{81}
    + \frac{1}{100}
    + \frac{1}{121}
    + \frac{1}{144}
    + \frac{1}{169}
    + \frac{1}{196}
    + \frac{1}{225}
    + \frac{1}{256}
    + \frac{1}{289}
    + \frac{1}{324}
    + \frac{1}{361}
    + \frac{1}{400}
    + \frac{1}{441}
    + \frac{1}{484}
    + \frac{1}{529}
    + \frac{1}{576}
    + \frac{1}{625}
    + \frac{1}{676}
    + \frac{1}{729}
    + \frac{1}{784}
    + \frac{1}{841}
    + \frac{1}{900}
    + \dots
  \end{autobreak}
\end{align}

\end{document}
```
Here, new line characters in the autobreak environment are recognized as
candidates for line breaks.


Licence
-------
The LaTeX Project Public License 1.3 (or any later version)


Bugs and remarks
----------------
Feedback is welcome on the Issue Tracker of GitHub:

  https://github.com/tueda/autobreak/issues
