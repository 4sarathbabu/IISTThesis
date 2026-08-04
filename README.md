# IISTThesis 2.0

A LaTeX thesis and report template for the Indian Institute of Space Science and Technology (IIST).

Repository: [https://github.com/ramzan-basheer/IIST_Thesis-2.0](https://github.com/ramzan-basheer/IIST_Thesis-2.0)

---

## Introduction

`iist.cls` lets IIST students prepare theses, dissertations, and reports that comply with institute formatting requirements without hand-rolling front matter, page numbering, or bibliography scaffolding. IISTThesis 2.0 is an architectural modernization of the original template: it keeps every command and document-type option a returning user already knows, and adds the document-engineering features expected of a long, professionally bound academic document — automatic PDF metadata, correct two-sided binding margins, running headers, a draft/review workflow, and modern typography packages.

### Supported document types

- Thesis (`thesis`)
- Project report (`project`)
- Synopsis (`synopsis`)
- Internship report (`internship`)
- Generic report (`report`)

### Supported degrees

- Ph.D. (default)
- M.Tech (`mtech`)
- M.S. (`ms`)
- B.Tech (`btech`)

### Philosophy

IISTThesis 2.0 is not a redesign. It is an evolution of the existing `iist.cls`: every user-facing command keeps its original name and behavior, and the default output of a plain `\documentclass{iist}` is visually unchanged from the original template. New capabilities are opt-in via class options, so existing writing habits and existing front-matter files continue to work with no rewriting required. Where the template borrows ideas — box-based title-page spacing, draft watermarking, a chapter-only compile mode — those ideas are implemented natively for IIST's own macro and option conventions, not copied from another codebase.

---

## Features

### Academic features

These are the features a thesis actually needs to satisfy IIST's submission requirements, unchanged in interface from the original template.

| Feature | Description |
|---|---|
| **Certificate** | `\makecertificate`, content in `certificate.tex` |
| **Declaration** | `\makedeclaration`, content in `declaration.tex` |
| **Dedication** | `\makededication`, content in `dedication.tex` |
| **Acknowledgements** | `\makeacknowledgements`, content in `acknowledgements.tex` |
| **Abstract** | `\makeabstract`, content in `abstract.tex` |
| **Publications** | `\makepublications`, content in `publications.tex` |
| **Appendices** | `\makeappendixsettings`, followed by `\chapter{...}` for each appendix |
| **Nomenclature** | `\makenomenclature`, content in `nomenclature.tex` |
| **Abbreviations** | `\makeabbreviations`, content in `abbreviations.tex` |
| **Theorem environments** | `theorem`, `lemma`, `corollary`, `proposition`, `conjecture`, `definition`, `condition`, `assumption`, `example`, `problem`, `remark`, `claim`, `note`, all chapter-numbered |
| **Algorithm support** | `algorithm2e`, chapter-scoped numbering, line numbers on |

All eight `\make...` front-matter macros now consistently register their page in both the Table of Contents and the PDF bookmark tree — in the original template, Certificate/Declaration/Dedication/Acknowledgements/Abstract were silently omitted from both while every other section was included.

### Modern document engineering

| Feature | What changed |
|---|---|
| **PDF metadata** | `pdftitle`/`pdfauthor` populate automatically from `\title{}`/`\author{}`; optional `\subject{}` and `\keywords{}` commands set `pdfsubject`/`pdfkeywords` |
| **Professional hyperlinks** | `colorlinks` with restrained, print-safe colors, replacing the previous bordered-link style; full bookmark and navigation configuration |
| **Running headers** | Chapter title on verso pages, section title on recto pages (two-sided), or both shown on every page (one-sided); page numbers kept in the footer |
| **Two-sided printing** | Genuine `oneside`/`twoside` support on a `book`-based class, with binding margins that correctly mirror between odd and even pages |
| **Adaptive title page** | Title-page spacing is computed from the actual height of each block (title, degree line, author, logo, department, date), so long titles or specialization names no longer require manual spacing adjustments |
| **Draft mode** | Optional watermark showing build date, time, and a user-settable version string, plus standard LaTeX draft-mode overfull-box marking |
| **Review mode** | Optional line-numbered body text (front matter excluded), safe to combine with numbered equations |
| **Chapter-only compilation** | Compile a single chapter via `\includeonly`, with front matter suppressed and cross-references/bibliography still resolving correctly |
| **Graphics path** | `\graphicspath{{Figures/}{Figures/Chapters/}{./}}`, so bare image filenames resolve automatically; explicit paths in existing chapters are unaffected |
| **Landscape pages** | `pdflscape`, which rotates the actual PDF page for on-screen reading (not just the printed content) |
| **cleveref** | `\cref`/`\Cref` support for all theorem-like environments, including friendly names for `assumption`, `condition`, `example`, `problem`, and `claim` |
| **booktabs** | Professional table rules (`\toprule`, `\midrule`, `\bottomrule`) |
| **microtype** | Character protrusion, kerning, and spacing refinements for better-justified text |

---

## Installation

### Required files

Place the following two files in your thesis project directory, alongside `doct.tex`:

- `iist.cls` — the class file (required)
- `iist-draft.sty` — companion module for `draft` and `review` modes (required **only** if you use those options; otherwise it is never loaded and can be omitted)

### Directory structure

A typical project directory looks like this:

```
your-thesis/
├── doct.tex                 # main document (\documentclass{iist} ...)
├── iist.cls
├── iist-draft.sty            # only needed for draft/review mode
├── certificate.tex
├── declaration.tex
├── dedication.tex
├── acknowledgements.tex
├── abstract.tex
├── abbreviations.tex
├── nomenclature.tex
├── publications.tex
├── chapter1.tex
├── chapter2.tex
├── appendixA.tex
├── appendixB.tex
├── doct.bib
├── IEEEtran.bst
├── indexstyle.ist            # only needed if you use the `index` option
├── logo.pdf
└── Figures/                   # optional: default search path for \includegraphics
    └── Chapters/
```

`Figures/` and `Figures/Chapters/` are new default locations for images (bare filenames passed to `\includegraphics` are resolved there automatically); they are not mandatory, and any chapter that already gives an explicit image path continues to work unchanged.

---

## Basic Usage

Minimal document class declaration:

```latex
\documentclass[phd,thesis,twoside]{iist}
```

Metadata (unchanged from the original template, plus two new optional commands):

```latex
\title{Your Thesis Title}
\author{Your Name}
\studentid{SC21D001}
\advisor{Dr. Advisor Name}
\specialization{Your Specialization}
\department{Your Department}

% new, optional -- feed the PDF's metadata fields
\subject{One-line summary of the thesis}
\keywords{keyword one, keyword two, keyword three}
```

### `oneside` / `twoside`

```latex
\documentclass[phd,thesis,oneside]{iist}   % default; matches the original template
\documentclass[phd,thesis,twoside]{iist}   % binding-ready, mirrored margins
```

### `draft`

```latex
\documentclass[phd,thesis,twoside,draft]{iist}
...
\draftversion{Chapter 5 -- Rev 3}   % optional, shown in the watermark
```

### `review`

```latex
\documentclass[phd,thesis,twoside,review]{iist}
```

Produces line-numbered body text (front matter is left unnumbered) for supervisor comments.

### `chapteronly`

```latex
\documentclass[phd,thesis,chapteronly]{iist}
...
\includeonly{chapter5}
```

Compiles only the listed chapter(s); front matter is suppressed, but the bibliography and cross-references into other (excluded) chapters continue to resolve from their existing `.aux` files.

### `index`

```latex
\documentclass[phd,thesis,twoside,index]{iist}
...
\index{your term}
...
\makeindexsettings
```

The `index` option must be given if the thesis uses `\index{}`; see [Migration](#migration-from-the-original-template) below.

---

## Migration from the original template

IISTThesis 2.0 is **mostly backward compatible**: every command, macro name, and front-matter file from the original template is unchanged, and the default (no-option) output is visually identical.

There is **one intentional breaking change**: indexing is no longer enabled unconditionally. If your thesis uses `\index{}` and `\makeindexsettings`, add the `index` option to your `\documentclass[...]{iist}` line. Without it, `\makeindexsettings` now prints a clear warning instead of silently doing nothing.

See `IISTThesis_2.0_Migration_Guide.md` for the full guide.

---

## Repository structure

```
IIST_Thesis-2.0/
├── iist.cls                       # the class file
├── iist-draft.sty                  # draft/review companion module
├── README.md
├── IISTThesis_2.0_Migration_Guide.md
├── CHANGELOG.md
├── LICENSE
├── doct.tex                        # example/starter main document
├── certificate.tex, declaration.tex, dedication.tex,
│   acknowledgements.tex, abstract.tex, abbreviations.tex,
│   nomenclature.tex, publications.tex                 # front-matter content
├── chapter1.tex, chapter2.tex, ...                     # example chapters
├── appendixA.tex, appendixB.tex                        # example appendices
├── doct.bib, IEEEtran.bst                               # bibliography
├── indexstyle.ist                                       # index style (with `index` option)
├── logo.pdf                                              # institute logo
└── Figures/                                              # recommended image directory
```

---

## Compilation

With `latexmk` (recommended):

```bash
latexmk -pdf doct.tex
```

Manually, with `pdflatex` and `bibtex`:

```bash
pdflatex doct.tex
bibtex doct
pdflatex doct.tex
pdflatex doct.tex
```

If the `index` option is used, `imakeidx` invokes `makeindex` automatically during compilation (this requires `-shell-escape`/`--shell-escape`, or the equivalent enabled in your editor or `latexmk` configuration). If it is not enabled, run `makeindex` manually between the `pdflatex` passes above.

---

## License

Distributed under the GNU General Public License v3.0 (or, at your option, any later version), matching the original template's licensing. See `LICENSE` for the full text.

---

## Acknowledgements

`iist.cls` was originally created by **Sarath Babu** ([original template](https://github.com/4sarathbabu/IISTThesis)). IISTThesis 2.0 is an architectural modernization and extension of that template — its document-engineering internals have been substantially rebuilt, while its institutional workflow, command interface, and front-matter conventions are deliberately preserved. Every IIST student who has used the original template should be able to pick up IISTThesis 2.0 without relearning how it works.
