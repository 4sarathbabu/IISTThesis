# IISTThesis 2.0 — Migration Guide

This guide is for anyone already writing a thesis or report with the original `iist.cls` who wants to move to IISTThesis 2.0. It is written for the upgrade decision and the upgrade steps, not as an implementation record — see `CHANGELOG.md` if you want the full itemized change list.

---

## Why IISTThesis 2.0?

The original `iist.cls` handles IIST's front-matter and formatting requirements well, but it was built as a thin wrapper around LaTeX's `report` class, and several things a long, professionally bound dissertation needs were either missing or quietly not working as intended:

- PDFs produced by the template carried no title, author, or subject metadata.
- Binding margins were defined asymmetrically (wider on the inside edge) but never actually mirrored between left- and right-hand pages, because the class was never truly two-sided.
- Several front-matter pages (Certificate, Declaration, Dedication, Acknowledgements, Abstract) didn't appear in the Table of Contents or PDF bookmarks, while the rest of the document did.
- There was no way to compile a single chapter for quick review, no draft-watermarking, and no line-numbering workflow for supervisor comments.
- Indexing was always initialized, whether or not a thesis used it, adding an unconditional external dependency.

IISTThesis 2.0 addresses these without changing how you write a thesis in it.

---

## What's New?

### Better typography

- `microtype` (character protrusion and spacing refinements)
- `booktabs` for professional table rules
- Corrected mismatch between section-numbering depth and Table-of-Contents depth, so numbered subsections and sub-subsections are now actually navigable
- Widow/orphan control, including specifically around displayed equations

### Better navigation

- `cleveref` support (`\cref`, `\Cref`) across all theorem-like environments, with proper names for `assumption`, `condition`, `example`, `problem`, and `claim`
- Every front-matter section now consistently appears in both the Table of Contents and the PDF bookmark tree
- PDF bookmark depth matches the Table of Contents depth

### Better PDF output

- Automatic PDF metadata: `pdftitle` and `pdfauthor` are filled in from your existing `\title{}`/`\author{}`; optional `\subject{}` and `\keywords{}` commands fill `pdfsubject`/`pdfkeywords`
- A modernized hyperlink style — colored text instead of the previous colored boxes around links — with full bookmark and navigation settings

### Better review workflow

- `draft` mode: an unobtrusive watermark with build date, time, and an optional version label you set yourself
- `review` mode: line-numbered body text (front matter stays unnumbered), safe to use alongside numbered equations
- `chapteronly` mode: compile a single chapter via `\includeonly`, with front matter suppressed and the bibliography and cross-references into other chapters still resolving correctly

### Better thesis production workflow

- A default `\graphicspath` so images can be referenced by filename alone, without breaking any chapter that already uses an explicit path
- `pdflscape` for landscape tables and figures, which rotates the actual PDF page for on-screen reading
- Indexing is now optional (`index` class option) rather than always initialized

### Better support for bound dissertations

- The class is now built on `book` rather than `report`, with genuine `oneside`/`twoside` options
- Under `twoside`, binding margins now actually mirror between odd and even pages, instead of silently applying the same margin to every page
- Running headers: chapter title on verso pages, section title on recto pages (or both, under `oneside`), with page numbers kept unobtrusively in the footer
- An adaptive title page: spacing is computed from the actual size of each block, so a long title or a long specialization name no longer needs manual adjustment

---

## New Class Options

| Option | Purpose | Default |
|---|---|---|
| `oneside` | Single-sided layout, matching the original template's output | Yes (if neither `oneside` nor `twoside` is given) |
| `twoside` | Two-sided layout with correctly mirrored binding margins and split verso/recto running headers | No |
| `draft` | Adds a build watermark (date, time, optional version label); also enables standard LaTeX draft-mode box marking | No |
| `review` | Line-numbered body text for supervisor review | No |
| `index` | Enables indexing (`imakeidx`/`\printindex`); required if your thesis uses `\index{}` | No |
| `chapteronly` | Suppresses front matter so a single chapter can be compiled quickly via `\includeonly` | No |

All options can be combined, including with each other (for example `twoside,draft,review` for a watermarked, line-numbered, binding-margin-correct copy to send a supervisor) and with the original degree/document-type options (`phd`, `mtech`, `ms`, `btech`, `thesis`, `project`, `synopsis`, `internship`, `report`).

---

## Backwards Compatibility

The following continue to work exactly as before, with no changes required:

- Every command: `\title`, `\author`, `\studentid`, `\advisor`, `\specialization`, `\department`
- Every front-matter macro: `\maketitle`, `\makecertificate`, `\makedeclaration`, `\makededication`, `\makeacknowledgements`, `\makeabstract`, `\maketableofcontents`, `\makelistoftables`, `\makelistoffigures`, `\makelistofalgorithms`, `\makeabbreviations`, `\makenomenclature`, `\makechaptersettings`, `\makebibsettings`, `\makepublications`, `\makeappendixsettings`, `\makeindexsettings`
- Every front-matter content file: `certificate.tex`, `declaration.tex`, `dedication.tex`, `acknowledgements.tex`, `abstract.tex`, `abbreviations.tex`, `nomenclature.tex`, `publications.tex`
- All theorem-like environments and their numbering
- `algorithm2e` integration and chapter-scoped algorithm numbering
- All degree and document-type options (`phd`, `mtech`, `ms`, `btech`, `thesis`, `project`, `synopsis`, `internship`, `report`)
- The default (no new options given) visual output of the document

### One breaking change

Indexing is no longer initialized unconditionally. In the original template, `imakeidx` and `\makeindex` were always active, whether or not a thesis used an index. In IISTThesis 2.0, they are only active when the `index` class option is given.

**If your thesis uses `\index{}` anywhere**, add `index` to your `\documentclass[...]{iist}` options. If it doesn't, no action is needed — and you no longer carry an indexing dependency you weren't using.

If you forget this step, `\makeindexsettings` will not error; it will print a clear warning telling you to add the option.

---

## Recommended Migration

1. Replace your project's `iist.cls` with the IISTThesis 2.0 version.
2. Add `iist-draft.sty` to the same directory (it is only loaded if you use `draft` or `review`; otherwise it can be left unused).
3. Check whether your thesis uses `\index{}`. If it does, add `index` to your `\documentclass[...]{iist}` options.
4. Recompile with your existing build process (`latexmk`, or `pdflatex`/`bibtex`/`pdflatex`/`pdflatex`).
5. Confirm your PDF's Document Properties now show your title and author — this happens automatically and needs no extra step.
6. Optionally, adopt the new options as they're useful to you: `twoside` for a binding-ready copy, `draft` or `review` for a supervisor-review copy, `chapteronly` for fast single-chapter iteration.

No chapter files, front-matter files, or macro calls need to be edited as part of this migration, aside from step 3.

---

## Why These Changes?

This is not a redesign of the IIST template. It is an engineering modernization: the document-type system, the front-matter workflow, and the command interface that IIST students already know are deliberately unchanged. What changed is the document-engineering machinery underneath — the base class, the margin and header handling, the PDF output configuration, and the tooling around drafting and review — brought in line with practices common to mature, actively maintained dissertation templates, while remaining fully compliant with IIST's formatting requirements throughout.

The guiding rule for every change in this release was: if it didn't need to change to get the new capability, it didn't change.
