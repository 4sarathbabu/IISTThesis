# Changelog

All notable changes to `iist.cls` and the IISTThesis template are documented in this file.

The format follows [Keep a Changelog](https://keepachangelog.com/en/1.0.0/).

---

## [2.0.0] — IISTThesis 2.0 — 2026-08-04

### Added

- Automatic PDF metadata: `pdftitle` and `pdfauthor` populate from `\title{}`/`\author{}`; new `\subject{}` and `\keywords{}` commands populate `pdfsubject`/`pdfkeywords`.
- New `iist-draft.sty` companion module, loaded only when `draft` and/or `review` is used.
- New `draft` class option: adds a build watermark (date, time, and a version string) via `iist-draft.sty`; new `\draftversion{...}` command sets the version string shown.
- New `review` class option: line-numbered body text (front matter excluded), with a compatibility patch for numbered `amsmath` display environments (`equation`, `align`, `gather`, and their starred forms).
- New `chapteronly` class option: suppresses all front-matter-generating macros so a single chapter can be compiled via `\includeonly`, with the bibliography and cross-references into other chapters still resolving.
- New `oneside`/`twoside` class options, on a `book`-based class, with correctly mirrored binding margins under `twoside`.
- New `index` class option, gating `imakeidx`/`\makeindex` (see Changed and Removed below).
- Running headers and footers via `fancyhdr`: chapter title on verso pages and section title on recto pages under `twoside`; both shown under `oneside`; page numbers kept in the footer.
- `cleveref` support across all theorem-like environments, including `\crefname`/`\Crefname` registrations for `assumption`, `condition`, `example`, `problem`, and `claim`.
- `microtype`, `booktabs`, and `subcaption` packages.
- `pdflscape` for landscape figures and tables.
- `\graphicspath{{Figures/}{Figures/Chapters/}{./}}` default image search path.
- `\phantomsection` and Table-of-Contents/bookmark registration for `\makecertificate`, `\makedeclaration`, `\makededication`, `\makeacknowledgements`, and `\makeabstract`.
- Explicit `\hypersetup{bookmarksdepth=3}`, matching the corrected Table-of-Contents depth.

### Changed

- Base class changed from `report` to `book`. `\frontmatter`/`\mainmatter` now handle roman/arabic page numbering internally, replacing manual counter resets previously performed inside `\maketitle` and `\makechaptersettings`.
- Default remains single-sided (`oneside`) to preserve the original template's default output; `twoside` must now be requested explicitly to activate mirrored binding margins.
- Hyperlink styling changed from bordered links (`linkbordercolor`, `citebordercolor`, `urlbordercolor`) to `colorlinks=true` with new restrained link/citation/URL colors; hyperref configuration expanded to include `unicode`, `bookmarksopen`, `bookmarksnumbered`, `breaklinks`, `linktocpage`, and `pdfstartview=FitV`.
- hyperref is now loaded with the `final` option, so PDF metadata and hyperlink styling are no longer suppressed when `draft` mode is active.
- `\setcounter{tocdepth}{1}` changed to `\setcounter{tocdepth}{3}`, matching the existing `secnumdepth=4` numbering depth used throughout (chapter/section/subsection/subsubsection now all appear in the Table of Contents and PDF bookmarks).
- `microtype` is loaded with `expansion=false` to remain compatible with the template's default font setup, while still providing protrusion, kerning, and spacing improvements.
- `\makechaptersettings` now calls `\mainmatter` instead of manually resetting the page counter and numbering style, and now also activates the running-header page style and (in `review` mode) line numbering.
- `\maketitle` now calls `\frontmatter` instead of manually setting roman page numbering, and establishes a consistent, footer-only `plain` page style for all subsequent front matter.
- Title-page layout changed from fixed `\vspace` values to box-measured, proportionally distributed spacing, so page balance no longer depends on title/specialization text length. Visible wording and content are unchanged.
- Indexing changed from unconditional to opt-in via the new `index` class option (**breaking change** — see below).
- `\makeindexsettings` now checks whether `index` was enabled and prints a warning instead of assuming `imakeidx` was loaded.

### Fixed

- Front-matter pages built without `\chapter*` (Certificate, Declaration, Dedication, Acknowledgements, Abstract) previously inherited an inconsistent page style with the page number in the header; they now consistently use the same footer-only style as the rest of the document.
- Binding margins (`inner=1.5in`, `outer=1in`) previously applied identically to every page regardless of odd/even position, since the class was never genuinely two-sided; they now mirror correctly once `twoside` is active.
- PDF documents previously carried no title, author, subject, or keyword metadata regardless of what was set via `\title{}`/`\author{}`.

### Removed

- Unconditional `\makeindex[options=-s indexstyle.ist]` invocation and the associated always-on `imakeidx` load; both now require the `index` class option.
- Bordered hyperlink styling (`linkbordercolor`, `citebordercolor`, `urlbordercolor`), replaced by `colorlinks`.

---

## [1.0.0] — Original Template

Initial `iist.cls`, created by Sarath Babu. See the [original repository](https://github.com/4sarathbabu/IISTThesis) for its history.
