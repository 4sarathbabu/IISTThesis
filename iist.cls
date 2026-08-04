%% -----------'iist.cls' Thesis/Report Template for IIST------------ %%
%%                  Copyright (C) 2018  Sarath Babu                  %%
%%           IISTThesis 2.0 modernization, 2026                     %%
%%
%% This program is free software: you can redistribute it and/or modify
%% it under the terms of the GNU General Public License as published by
%% the Free Software Foundation, either version 3 of the License, or
%% (at your option) any later version.
%%
%% This program is distributed in the hope that it will be useful, but
%% WITHOUT ANY WARRANTY; without even the implied warranty of
%% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
%% General Public License for more details.
%%
%% You should have received a copy of the GNU General Public License
%% along with this program.  If not, see <http://www.gnu.org/licenses/>.
%%
%% Original contact: 4sarathbabu@gmail.com
%% Original URL: https://github.com/4sarathbabu/IISTThesis
%%
%% ------------------------------------------------------------------ %%
%% IISTThesis 2.0
%%
%% This is an EVOLUTION of the original single-file iist.cls, not a
%% replacement template. Every user-facing command from v1 (\title,
%% \author, \department, \specialization, \advisor, \studentid, the
%% eight \make... front-matter macros, and all theorem environments)
%% keeps its original name and calling convention. A v1 doct.tex should
%% compile against this file with no edits, aside from one deliberate,
%% explicitly-requested exception: indexing is now opt-in via the new
%% `index' class option (see "Optional Index" below, and the migration
%% report for the one-line fix this requires of any thesis that used
%% \index{}/\printindex under v1).
%%
%% New in 2.0 (all additive; see IISTThesis2_Migration_Report.md for
%% full rationale, backward-compatibility notes, and the one breaking
%% change above):
%%   - Automatic PDF metadata (pdftitle/pdfauthor/pdfsubject/pdfkeywords)
%%   - Modernized hyperref profile (bookmarks, colorlinks, no borders)
%%   - Consistent ToC/bookmark registration across ALL front matter
%%   - microtype, booktabs, subcaption, cleveref, widow/orphan control
%%   - Resolved tocdepth/secnumdepth mismatch
%%   - \graphicspath convention (Figures/, Figures/Chapters/)
%%   - pdflscape for landscape figures/tables
%%   - Optional index (`index' option), no longer unconditional
%%   - book base class with real oneside/twoside (default: oneside,
%%     matching v1's implicit behaviour, so existing builds are
%%     visually unchanged unless `twoside' is explicitly requested)
%%   - Correct binding-margin mirroring once `twoside' is requested
%%   - Running headers/footers (chapter on verso, section on recto)
%%   - `draft' option: watermark + build timestamp + version string
%%   - `review' option: line numbering, amsmath-safe
%%   - `chapteronly' option: compile one chapter with \includeonly,
%%     front matter auto-suppressed, references/bibliography intact
%%   - Adaptive (box-based) title-page spacing
%% ------------------------------------------------------------------ %%


%%---- Identification ---- %%
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{iist}[2026/08/04 IISTThesis 2.0 -- IIST LaTeX Class]


%% ---- Declarations ---- %%
%% (unchanged from v1, plus \Title/\Author pre-declared empty below so
%%  that PDF-metadata population can never see an undefined macro even
%%  if a document forgets to call \title{}/\author{} before \begin{document})
\newcommand{\Degree}{phd}
\newcommand{\Doctype}{thesis}
\newcommand{\Degreetext}{Doctor of Philosophy}
\newcommand{\Department}{}
\newcommand{\Specialization}{}
\newcommand{\Advisor}{}
\newcommand{\Studentid}{}
\newcommand{\CPSpecialization}{}
\newcommand{\CPTitle}{}
\newcommand{\CPAuthor}{}
\newcommand{\Title}{}   % NEW: pre-declared (was previously only defined
\newcommand{\Author}{}  % NEW: as a side effect of \title{}/\author{} being called)


%% ---- Internal (non-user-facing) state, IIST@-namespaced to avoid any -%%
%% ---- collision with LaTeX kernel or third-party package internals ---%%
\newif\ifIIST@twoside     \IIST@twosidefalse  % default preserves v1's implicit oneside
\newif\ifIIST@draft       \IIST@draftfalse
\newif\ifIIST@review      \IIST@reviewfalse
\newif\ifIIST@index       \IIST@indexfalse
\newif\ifIIST@chapteronly \IIST@chapteronlyfalse


%% ---- Options: Degree / Document Type (UNCHANGED from v1) ---- %%
\DeclareOption{mtech}
{
  \renewcommand{\Degree}{mtech}
  \renewcommand{\Degreetext}{Master of Technology}
}
\DeclareOption{ms}
{
  \renewcommand{\Degree}{ms}
  \renewcommand{\Degreetext}{Master of Science}
}
\DeclareOption{btech}
{
  \renewcommand{\Degree}{btech}
  \renewcommand{\Doctype}{project report}
  \renewcommand{\Degreetext}{Bachelor of Technology}
}
\DeclareOption{synopsis}
{
  \renewcommand{\Doctype}{synopsis}
}
\DeclareOption{internship}
{
  \renewcommand{\Doctype}{internship report}
}
\DeclareOption{thesis}
{
  \renewcommand{\Doctype}{thesis}
}
\DeclareOption{project}
{
  \renewcommand{\Doctype}{project report}
}
\DeclareOption{report}
{
  \renewcommand{\Doctype}{report}
}


%% ---- Options: Structural / Engineering (NEW in 2.0) ---- %%
% oneside/twoside -- Phase 2.2. Default stays oneside so that a document
% using \documentclass{iist} with no options renders identically to v1
% (which was implicitly oneside via the `report' base class). `twoside'
% must be requested explicitly to get mirrored binding margins -- see
% the geometry call below and the migration report for why this default
% was chosen over silently switching everyone to twoside.
\DeclareOption{oneside}{\IIST@twosidefalse}
\DeclareOption{twoside}{\IIST@twosidetrue}

% draft -- Phase 2.4. Also passed through to the base class so that the
% standard LaTeX draft behaviour (overfull-box marking, outlined
% figures) is available in addition to the IISTThesis watermark.
\DeclareOption{draft}{\IIST@drafttrue\PassOptionsToClass{draft}{book}}

% review -- Phase 2.5. Line-numbered body text for supervisor review.
\DeclareOption{review}{\IIST@reviewtrue}

% index -- Phase 1.8. Indexing is now opt-in; see \makeindexsettings.
\DeclareOption{index}{\IIST@indextrue}

% chapteronly -- Phase 2.6. Suppresses all front matter so that, combined
% with \includeonly{...} in doct.tex, a single chapter can be compiled
% with working cross-references and bibliography for fast supervisor
% review, without editing any chapter file.
\DeclareOption{chapteronly}{\IIST@chapteronlytrue}

% Any other option is forwarded to the base class, exactly as in v1
% (previously forwarded to `report'; now forwarded to `book').
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{book}}
\ProcessOptions\relax


%% ---- Preliminaries (Base class for the template) ---- %%
% Phase 2.1: migrated report -> book. book natively provides
% \frontmatter/\mainmatter/\backmatter (roman/arabic pagenumbering and
% the mainmatter flag), which replaces the hand-rolled page-numbering
% resets v1 performed inside \maketitle and \makechaptersettings, and
% book defaults new chapters to a recto (right-hand) page under
% twoside, which report never did. Font size stays fixed at 12pt as in
% v1 (not exposed as an option; out of scope for this revision).
%
% Phase 2.2: oneside/twoside is passed explicitly rather than left to
% book's own default (which is twoside) specifically so that a plain
% \documentclass{iist} continues to render exactly as it did under v1.
\ifIIST@twoside
  \LoadClass[12pt,twoside]{book}
\else
  \LoadClass[12pt,oneside]{book}
\fi


%% ---- Required Package Initializations ---- %%
% Binding margins: inner/outer only mirror between odd/even pages when
% `twoside' is truly active at the class level (Phase 2.2 fix). Under
% v1 (report, always oneside) these values silently collapsed to plain
% left/right margins applied to every page -- the corrected mirroring
% now happens automatically once `twoside' is requested, with no change
% needed to the geometry call itself.
\usepackage[inner=1.5in, outer=1in, top=1in, bottom=1.25in]{geometry}
\usepackage[english]{babel}
\usepackage{setspace}
\usepackage{graphicx}
\usepackage{longtable}
\usepackage[T1]{fontenc}
\usepackage{ifthen}
\usepackage[ruled, algochapter, linesnumbered]{algorithm2e} % UNCHANGED (Phase-2 constraint: do not redesign)
\usepackage{titlesec}
\usepackage{xcolor}
\usepackage{calc}          % NEW: provides \totalheightof, used by the adaptive title page (Phase 2.7)
% [final] is required here, not cosmetic: hyperref auto-detects the
% document-class-level `draft' option (which IISTThesis's own `draft'
% class option passes through to book, so that standard overfull-box
% marking still works -- Phase 2.4) and, on seeing it, silently drops
% into its own draft mode, which suppresses PDF metadata, bookmarks,
% and colored links entirely ("Package hyperref Warning: Draft mode
% on."). That would silently break Phase 1.1/1.2 for exactly the
% builds (draft-mode, i.e. supervisor-review copies) where working
% navigation and metadata matter most. [final] pins hyperref to full
% functionality regardless of the class-level draft state; it is a
% no-op for a non-draft build.
\usepackage[final]{hyperref}      % configured below, after colour definitions
\usepackage{emptypage}
\usepackage[labelfont=bf]{caption}
\usepackage{subcaption}    % NEW (Phase 1.4): must follow `caption'
\usepackage{amsmath}
\usepackage{amssymb}
\usepackage{amsthm}
% NEW (Phase 1.4). `expansion=false' is deliberate: pdfTeX's font-expansion
% feature requires fully scalable (Type1/OpenType) fonts, and the default
% Computer Modern set used by v1 includes some sizes that are not
% guaranteed scalable in every installation, which makes expansion raise
% a fatal error in that case. Protrusion, kerning, spacing, and tracking
% all still apply and do not have this requirement, so this keeps v1's
% exact font family/appearance unchanged (per this phase's own
% "without altering document appearance unnecessarily" brief) while
% still gaining microtype's benefit, and avoids adding a new font
% package purely to satisfy the expansion feature.
\usepackage[expansion=false]{microtype}
\usepackage{booktabs}      % NEW (Phase 1.4): professional table rules
\usepackage{pdflscape}     % NEW (Phase 1.7): rotates the PDF page itself for on-screen reading,
                            % unlike plain `lscape' which only rotates content for a print/DVI
                            % workflow -- the technically correct choice for a pdflatex/xelatex thesis
\usepackage{fancyhdr}       % NEW (Phase 2.3): running headers/footers


%% ---- Restrained academic link colours (Phase 1.2) ---- %%
% Dark, print-safe tones rather than the saturated defaults, so that
% colorlinks reads as "formal document" rather than "web page".
\definecolor{IISTlinkcolor}{RGB}{0,51,102}   % dark academic blue -- cross-references
\definecolor{IISTcitecolor}{RGB}{0,90,60}    % dark green -- citations
\definecolor{IISTurlcolor}{RGB}{110,0,0}     % dark maroon -- URLs


%% ---- Content Styles ---- %%
\onehalfspacing   % Line spacing (unchanged)

% Hyperref modernization (Phase 1.2). Replaces the v1 bordered-link
% configuration outright, per the modernization brief ("remove bordered
% hyperlinks"). PDF metadata (pdftitle/pdfauthor/pdfsubject/pdfkeywords)
% is populated separately below, deferred to \AtBeginDocument since it
% depends on \Title/\Author, which are only known once the user's
% preamble has run.
\hypersetup{
  unicode=true,
  bookmarksopen=true,
  bookmarksnumbered=true,
  breaklinks=true,
  linktocpage=true,
  pdfstartview=FitV,
  colorlinks=true,
  linkcolor=IISTlinkcolor,
  citecolor=IISTcitecolor,
  urlcolor=IISTurlcolor,
  anchorcolor=black,
}

\titleformat{\chapter}[display]{\LARGE\bfseries}{\chaptertitlename\ 
\thechapter}{1mm}{\huge} % Chapter title (unchanged)
\titleformat*{\section}{\Large\bfseries} % Section title (unchanged)
\titleformat*{\subsection}{\large\bfseries} % Subsection title (unchanged)
\titleformat*{\subsubsection}{\bfseries} % Subsubsection title (unchanged)

% Optional index (Phase 1.8). imakeidx + indexstyle.ist are only loaded
% if the `index' option was given, removing the unconditional external
% dependency and the shell-escape assumption that a document not using
% an index would otherwise carry for no reason. \makeindexsettings
% below has a matching guard so that omitting `index' fails safely
% (with a clear warning) rather than erroring on an undefined \printindex.
\ifIIST@index
  \RequirePackage{imakeidx}
  \makeindex[options= -s indexstyle.ist]
\fi

% Graphics convention (Phase 1.6). \graphicspath only resolves BARE
% filenames passed to \includegraphics; any already-existing explicit
% relative or absolute path in a chapter file is untouched by this, so
% existing chapters that already specify a path continue to work
% unchanged. `./' is included last as an explicit fallback to the
% current working directory.
\graphicspath{{Figures/}{Figures/Chapters/}{./}}

% TOC depth vs. section numbering depth (Phase 1.5). v1 numbered down to
% subsubsection (secnumdepth=4) but showed only chapter+section in the
% ToC/bookmarks (tocdepth=1) -- numbered structure the reader could not
% navigate to. tocdepth is raised to 3 (chapter/section/subsection/
% subsubsection) to match the numbering depth actually used, while
% stopping short of paragraph-level (depth 4) entries, which would
% bloat the ToC of a 300+ page dissertation without adding navigational
% value. bookmarksdepth is set explicitly to the same value rather than
% left to be inferred from tocdepth, so the two cannot silently drift
% apart again if tocdepth is ever revisited.
\setcounter{secnumdepth}{4}
\setcounter{tocdepth}{3}
\hypersetup{bookmarksdepth=3}

% Widow/orphan control (Phase 1.4). displaywidowpenalty is included
% alongside the two requested penalties since it specifically prevents
% a stranded single line immediately after a displayed equation --
% relevant throughout an equation-dense dissertation. Values match the
% conventional "effectively forbid" setting; layout is otherwise
% unaffected (LaTeX will still occasionally have to break a paragraph
% less ideally to honour this, exactly as intended).
\clubpenalty=10000
\widowpenalty=10000
\displaywidowpenalty=10000


%% ---- Assumption, Definition, Remark, Theorem, Proposition, and
%% Lemma ---- %%
%% (UNCHANGED from v1 -- theorem environments are an explicitly
%%  preserved feature; not redesigned.)
\theoremstyle{plain}
\newtheorem{theorem}{Theorem}[chapter]
\newtheorem{lemma}{Lemma}[chapter]
\newtheorem{corollary}{Corollary}[chapter]
\newtheorem{proposition}{Proposition}[chapter]
\newtheorem{conjecture}{Conjecture}[chapter]

\theoremstyle{definition}
\newtheorem{definition}{Definition}[chapter]
\newtheorem{condition}{Condition}[chapter]
\newtheorem{assumption}{Assumption}[chapter]
\newtheorem{example}{Example}[chapter]
\newtheorem{problem}{Problem}[chapter]

\theoremstyle{remark}
\newtheorem{remark}{Remark}[chapter]
\newtheorem{claim}{Claim}[chapter]
\newtheorem*{note}{Note}


%% ---- cleveref (Phase 1.4) ---- %%
% Loaded here, deliberately AFTER hyperref (already loaded above) and
% AFTER every \newtheorem call, which is the correct ordering for
% cleveref to pick up both hyperref's link machinery and the custom
% theorem environments' names automatically. \crefname/\Crefname is
% supplied explicitly for the environments amsthm/cleveref do not
% already know friendly names for (assumption/condition/example/
% problem/claim), so \cref{...} on these reads naturally rather than
% falling back to a generic label.
\usepackage{cleveref}
\crefname{assumption}{assumption}{assumptions}
\Crefname{assumption}{Assumption}{Assumptions}
\crefname{condition}{condition}{conditions}
\Crefname{condition}{Condition}{Conditions}
\crefname{example}{example}{examples}
\Crefname{example}{Example}{Examples}
\crefname{problem}{problem}{problems}
\Crefname{problem}{Problem}{Problems}
\crefname{claim}{claim}{claims}
\Crefname{claim}{Claim}{Claims}


%% ---- Custom Commands ---- %%
%% (UNCHANGED from v1 in calling convention and behaviour)
\renewcommand{\title}[2][]
{
  \renewcommand{\Title}{#2}
  \ifthenelse{\equal{#1}{}}
  {
    \renewcommand{\CPTitle}{#2}
  }
  {
    \renewcommand{\CPTitle}{#1}
  }
}

\renewcommand{\author}[2][]
{
  \renewcommand{\Author}{#2}
  \ifthenelse{\equal{#1}{}}
  {
    \renewcommand{\CPAuthor}{#2}
  }
  {
    \renewcommand{\CPAuthor}{#1}
  }
}

\newcommand{\department}[1]
{
  \renewcommand{\Department}{#1}
}

\newcommand{\specialization}[2][]
{
  \renewcommand{\Specialization}{#2}
  \ifthenelse{\equal{#1}{}}
  {
    \renewcommand{\CPSpecialization}{#2}
  }
  {
    \renewcommand{\CPSpecialization}{#1}
  }
}

\newcommand{\advisor}[1]
{
  \renewcommand{\Advisor}{#1}
}

\newcommand{\studentid}[1]
{
  \renewcommand{\Studentid}{#1}
}

% NEW (Phase 1.1): optional metadata hooks. Both are safe to leave
% unset -- pdfsubject/pdfkeywords then populate as empty strings rather
% than failing, so no existing document needs to adopt these.
\newcommand{\@iistsubject}{}
\newcommand{\subject}[1]{\renewcommand{\@iistsubject}{#1}}
\newcommand{\@iistkeywords}{}
\newcommand{\keywords}[1]{\renewcommand{\@iistkeywords}{#1}}

% \newcommand{\Title}{\@title}
% \newcommand{\Author}{\@author}
\newcommand{\Date}{\@date}


%% ---- Automatic PDF metadata (Phase 1.1) ---- %%
% Deferred to \AtBeginDocument because \Title/\Author are only settled
% once the user's preamble (\title{...}, \author{...}) has executed.
% Requires no user intervention: pdftitle/pdfauthor populate from the
% existing \title/\author calls automatically; \subject{}/\keywords{}
% are optional enhancements on top.
\AtBeginDocument{
  \hypersetup{
    pdftitle   = {\Title},
    pdfauthor  = {\Author},
    pdfsubject = {\@iistsubject},
    pdfkeywords= {\@iistkeywords}
  }
}


%% ---- Design of Title Page (Phase 2.7: adaptive spacing) ---- %%
% v1 used a chain of fixed \vspace values, which looks uneven for a
% very long title, a long specialization name, or (via \Advisor, held
% for future use) a long advisor line. This replaces the fixed spacing
% with the same box-measurement technique used by several established
% thesis classes: every title-page block is typeset once into a
% \savebox, its height is measured with \totalheightof, and the
% leftover vertical space on the page is distributed across the blocks
% in fixed proportions -- so the page self-balances regardless of how
% much text any individual block contains. The visible CONTENT and
% wording of the title page (CP-numbering, "A/An <doctype> submitted
% ... degree of", degree text, "in <specialization>" for non-PhD
% degrees, "by <author>", the logo, department block, date) is
% unchanged from v1.
\newcommand{\IIST@computeTitlePageSpacing}{

  \newsavebox{\IIST@TitleBox}
  \begin{lrbox}{\IIST@TitleBox}
    \begin{minipage}[c]{0.95\textwidth}
      \centering \LARGE\bfseries \CPTitle
    \end{minipage}
  \end{lrbox}

  \newsavebox{\IIST@SubmissionBox}
  \begin{lrbox}{\IIST@SubmissionBox}
    \begin{minipage}[c]{0.9\textwidth}
      \centering
      \ifthenelse{\equal{\Doctype}{internship report}}{An}{A}\
      \Doctype\ submitted in partial fulfillment for the award of the
      degree of\\[4mm]
      \textbf{\large \Degreetext}%
      \ifthenelse{\equal{\Degree}{phd}}{}{%
        \\[2mm] in\\[2mm] \textbf{\large \CPSpecialization}%
      }
    \end{minipage}
  \end{lrbox}

  \newsavebox{\IIST@AuthorBox}
  \begin{lrbox}{\IIST@AuthorBox}
    \begin{minipage}[c]{\textwidth}
      \centering by\\[2mm] \textbf{\large \CPAuthor}
    \end{minipage}
  \end{lrbox}

  \newsavebox{\IIST@LogoBox}
  \begin{lrbox}{\IIST@LogoBox}
    \includegraphics[scale=0.2]{logo.pdf}
  \end{lrbox}

  \newsavebox{\IIST@DeptBox}
  \begin{lrbox}{\IIST@DeptBox}
    \begin{minipage}[c]{\textwidth}
      \centering
      \begin{spacing}{1.25}
        \textbf{Department of \Department}\\
        \textbf{Indian Institute of Space Science and Technology}\\
        \textbf{Thiruvananthapuram, India}
      \end{spacing}
    \end{minipage}
  \end{lrbox}

  \newsavebox{\IIST@DateBox}
  \begin{lrbox}{\IIST@DateBox}
    \textbf{\large \Date}
  \end{lrbox}

  % Leftover vertical space, to be distributed proportionally below.
  % A small fixed reserve is subtracted for the inter-block \vspace
  % calls that remain (kept fixed, not proportional, since they are
  % meant to read as consistent "paragraph-like" gaps rather than
  % scale with page content).
  \newlength{\IIST@titlepagespacing}
  \setlength{\IIST@titlepagespacing}{ \textheight
    - \totalheightof{\usebox{\IIST@TitleBox}}
    - \totalheightof{\usebox{\IIST@SubmissionBox}}
    - \totalheightof{\usebox{\IIST@AuthorBox}}
    - \totalheightof{\usebox{\IIST@LogoBox}}
    - \totalheightof{\usebox{\IIST@DeptBox}}
    - \totalheightof{\usebox{\IIST@DateBox}}
    - 6em % fixed reserve for the inter-block gaps below
  }
}

\renewcommand{\maketitle}
{
  \IIST@computeTitlePageSpacing
  \renewcommand{\thepage}{CP-\arabic{page}}
  \begin{center}
    \thispagestyle{empty}
    \begin{spacing}{1}
      % NOTE: each \usebox / \vspace pair below is followed by \par.
      % Without it, `center' (a trivlist) leaves the box and the next
      % \vspace inside the same unclosed paragraph, and the explicit
      % \vspace glue gets absorbed into that paragraph's line-breaking
      % instead of standing as real inter-block vertical space -- the
      % title-page blocks visually collapse into one another even
      % though \IIST@titlepagespacing is correctly nonzero. \par after
      % every box and every \vspace closes each block out cleanly.
      \vspace*{.12\IIST@titlepagespacing}\par
      \usebox{\IIST@TitleBox}\par
      \vspace{.20\IIST@titlepagespacing}\par
      \usebox{\IIST@SubmissionBox}\par
      \vspace{.16\IIST@titlepagespacing}\par
      \usebox{\IIST@AuthorBox}\par
      \vspace{.20\IIST@titlepagespacing}\par
      \usebox{\IIST@LogoBox}\par
      \vspace{.20\IIST@titlepagespacing}\par
      \usebox{\IIST@DeptBox}\par
      \vspace{.12\IIST@titlepagespacing}\par
      \usebox{\IIST@DateBox}\par
    \end{spacing}
    \vfill
  \end{center}
  \newpage~\thispagestyle{empty}\newpage
  \frontmatter % book-provided: cleardoublepage + roman pagenumbering + @mainmatterfalse
              % (replaces v1's manual \pagenumbering{roman} call -- Phase 2.1)
  % Establish the unobtrusive `plain' style (footer page number, no
  % header) as the ambient style for all front matter. Without this,
  % pages built here directly (Certificate/Declaration/Dedication/
  % Acknowledgements/Abstract, none of which use \chapter*) fall back
  % to book's kernel default `headings' style -- page number in the
  % HEADER -- while the \chapter*-based front-matter pages
  % (Abbreviations/Nomenclature/Publications, which get `plain'
  % automatically from \chapter*) would not, producing exactly the
  % kind of unexplained inconsistency Phase 1.3 asks to eliminate.
  \pagestyle{plain}
}


%% ---- Design of Certificate Page ---- %%
% NEW: \phantomsection + \addcontentsline, for consistency with every
% other front-matter section (Phase 1.3). v1 omitted this for
% Certificate/Declaration/Dedication/Acknowledgements/Abstract while
% including it for List of Tables/Figures/Algorithms, Abbreviations,
% Nomenclature, Bibliography, Publications, Appendices, and the Index
% -- an inconsistency with no underlying rationale.
\newcommand{\makecertificate}
{
  \cleardoublepage
  \newpage
  \phantomsection
  \addcontentsline{toc}{chapter}{Certificate}
  \vspace*{5cm}
  \begin{center}
    {\LARGE \bf Certificate}
  \end{center}
  \input{certificate}
}


%% ---- Design of Declaration Page ---- %%
\newcommand{\makedeclaration}
{
  \newpage \cleardoublepage
  \phantomsection
  \addcontentsline{toc}{chapter}{Declaration}
  \vspace*{1cm}
  \begin{center}
    {\LARGE \bf Declaration}
  \end{center}
  \input{declaration}
}


%% ---- Design of Dedication Page ---- %%
\newcommand{\makededication}
{
  \newpage \cleardoublepage
  \phantomsection
  \addcontentsline{toc}{chapter}{Dedication}
  \vspace*{0.3\textheight}
  \input{dedication}
  \vfill
}


%% ---- Design of Acknowledgements ---- %%
\newcommand{\makeacknowledgements}
{
  \newpage \cleardoublepage
  \phantomsection
  \addcontentsline{toc}{chapter}{Acknowledgements}
  \vspace*{1cm}
  \begin{center}
    {\LARGE \bf Acknowledgements}
  \end{center}
  \input{acknowledgements}
}


%% ---- Design of Abstract ---- %%
\newcommand{\makeabstract}
{
  \newpage \cleardoublepage
  \phantomsection
  \addcontentsline{toc}{chapter}{Abstract}
  \vspace*{1cm}
  \begin{center}
    {\LARGE \bf Abstract}
  \end{center}
  \input{abstract}
}


%% ---- Design of Table of Contents ---- %%
%% (UNCHANGED)
\newcommand{\maketableofcontents}
{
  % --- Basic Table of Contents --- %
  \newpage \cleardoublepage
  \tableofcontents
}

%% ---- List of Tables ---- %%
%% (UNCHANGED)
\newcommand{\makelistoftables}
{
  \newpage \cleardoublepage
  \phantomsection
  \addcontentsline{toc}{chapter}{List of Tables}
  \listoftables
}

%% ---- List of Figures ---- %%
%% (UNCHANGED)
\newcommand{\makelistoffigures}
{
  \newpage \cleardoublepage
  \phantomsection
  \addcontentsline{toc}{chapter}{List of Figures}
  \listoffigures
}

%% ---- List of Algorithms ---- %%
%% (UNCHANGED)
\newcommand{\makelistofalgorithms}
{
  \newpage \cleardoublepage
  \phantomsection
  \addcontentsline{toc}{chapter}{List of Algorithms}
  \listofalgorithms
}

%% ---- Abbreviations ---- %%
%% (UNCHANGED)
\newcommand{\makeabbreviations}
{
  \newpage \cleardoublepage
  \phantomsection
  \addcontentsline{toc}{chapter}{Abbreviations}
  \chapter*{Abbreviations}
  \vspace*{-5mm}
  \input{abbreviations}
}


%% ---- Nomenclature ---- %%
%% (UNCHANGED -- already registered itself to the ToC in v1, and
%%  nomenclature generation is out of scope for this revision)
\newcommand{\makenomenclature}
{
  \newpage \cleardoublepage
  \phantomsection
  \addcontentsline{toc}{chapter}{Nomenclature}
  \chapter*{Nomenclature}
  \vspace*{-5mm}
  \input{nomenclature}
}


%% ---- Running Headers/Footers (Phase 2.3) ---- %%
% v1's default (report's plain style) showed only a bare page number.
% For a 300+ page dissertation, showing the current chapter (verso) and
% section (recto) meaningfully aids navigation in both the bound copy
% and the PDF. Page numbers are kept in the FOOTER, outer corner,
% rather than boxed into the header, to stay visually unobtrusive.
% Two named styles are defined explicitly (rather than one style with
% internal \ifIIST@twoside branching on every field) so the oneside
% and twoside behaviour are each easy to read and verify independently.
\renewcommand{\chaptermark}[1]{\markboth{\thechapter.\ #1}{}}
\renewcommand{\sectionmark}[1]{\markright{\thesection\ \ #1}}
\setlength{\headheight}{14.5pt}

\fancypagestyle{iistheadingstwoside}{
  \fancyhf{}
  \fancyhead[LE]{\nouppercase{\leftmark}}  % verso (even): chapter title
  \fancyhead[RO]{\nouppercase{\rightmark}} % recto (odd): section title
  \fancyfoot[LE]{\thepage}
  \fancyfoot[RO]{\thepage}
  \renewcommand{\headrulewidth}{0.4pt}
  \renewcommand{\footrulewidth}{0pt}
}

\fancypagestyle{iistheadingsoneside}{
  \fancyhf{}
  \fancyhead[L]{\nouppercase{\leftmark}}
  \fancyhead[R]{\nouppercase{\rightmark}}
  \fancyfoot[C]{\thepage}
  \renewcommand{\headrulewidth}{0.4pt}
  \renewcommand{\footrulewidth}{0pt}
}

% Chapter-opening pages use LaTeX's `plain' page style automatically;
% headers are cleared there by convention, but the page number is kept
% so pagination remains unbroken at chapter starts.
\fancypagestyle{plain}{
  \fancyhf{}
  \ifIIST@twoside
    \fancyfoot[LE]{\thepage}
    \fancyfoot[RO]{\thepage}
  \else
    \fancyfoot[C]{\thepage}
  \fi
  \renewcommand{\headrulewidth}{0pt}
}

\newcommand{\iistsetpagestyle}{
  \ifIIST@twoside
    \pagestyle{iistheadingstwoside}
  \else
    \pagestyle{iistheadingsoneside}
  \fi
}


%% ---- Initialize Pages Format for Chapters ---- %%
% Phase 2.1: replaced the manual \setcounter{page}{0}+\pagenumbering{arabic}
% pair with book's own \mainmatter (which performs the equivalent reset,
% plus \cleardoublepage and the mainmatter flag) -- one fewer hand-rolled
% state transition to maintain. Also now activates the running-header
% page style (Phase 2.3) and, in review mode, line numbering (Phase 2.5),
% so the author does not need to call anything beyond the existing
% \makechaptersettings.
\newcommand{\makechaptersettings}
{
  \newpage
  \mainmatter
  \ifthenelse{\equal{\Doctype}{synopsis}}
  {
    \renewcommand{\thesection}{\arabic{section}}
    \setcounter{table}{0}
  }
  {}
  \iistsetpagestyle
  \ifIIST@review \linenumbers \fi
}


%% ---- Initialize Bibliography Settings ---- %%
%% (UNCHANGED)
\newcommand{\makebibsettings}
{
  \phantomsection
  \addcontentsline{toc}{chapter}{Bibliography}
}


%% ---- Initialize Publications Settings ---- %%
%% (UNCHANGED)
\newcommand{\makepublications}
{
  \newpage
  \ifthenelse{\equal{\Doctype}{synopsis}}{}{\cleardoublepage}
  \phantomsection
  \addcontentsline{toc}{chapter}{List of Publications}
  \chapter*{List of Publications}
  \input{publications}
}


%% ---- Initialize Appendix Settings ---- %%
%% (UNCHANGED)
\newcommand{\makeappendixsettings}
{
  \newpage
  \ifthenelse{\equal{\Doctype}{synopsis}}{}{\cleardoublepage}
  \phantomsection
  \appendix
  \addcontentsline{toc}{chapter}{Appendices}
  \renewcommand{\thechapter} {\Alph{chapter}}
}


%% ---- Initialize Index Settings ---- %%
% Phase 1.8: guarded by \ifIIST@index. If the `index' class option was
% not given, \printindex was never defined (imakeidx was never
% loaded), so calling \makeindexsettings unconditionally would error.
% This now fails safely with a clear, actionable warning instead,
% preserving compatibility with existing documents that DO use the
% index (they simply need to add `index' to \documentclass options)
% while not forcing the dependency on everyone else.
\newcommand{\makeindexsettings}
{
  \ifIIST@index
    \newpage
    \ifthenelse{\equal{\Doctype}{synopsis}}{}{\cleardoublepage}
    \phantomsection
    \openup -3.25mm
    \addcontentsline{toc}{chapter}{Index}
    \printindex
    \onehalfspacing
  \else
    \ClassWarning{iist}{\string\makeindexsettings\space was called, but
      the `index' class option was not given, so no index was built.
      Add `index' to \string\documentclass[...]{iist} if this thesis
      uses \string\index{} entries.}
  \fi
}


%% ---- Draft / Review tooling (Phase 2.4, 2.5) ---- %%
% Deferred, conditional load: iist-draft.sty pulls in eso-pic (draft
% watermark) and/or lineno (review line numbering), so neither
% dependency is loaded for an ordinary final-mode build.
% \RequirePackage already no-ops on a package that is already loaded
% with the same (here: no) options, so calling it from both branches
% when draft+review are combined is safe and needs no extra guard.
\ifIIST@draft  \RequirePackage{iist-draft} \fi
\ifIIST@review \RequirePackage{iist-draft} \fi


%% ---- Chapter-only compilation (Phase 2.6) ---- %%
% Suppresses every macro that generates front matter, so that a
% document can be built from a single \include'd chapter (via
% \includeonly{chapters/chX} in doct.tex -- still required, since
% \includeonly is the LaTeX mechanism that makes cross-chapter
% \ref/\cite continue to resolve from previously-built .aux files; no
% class can remove that one line) without editing any chapter file or
% any of the front-matter calls in doct.tex. \makechaptersettings,
% \makebibsettings, and \makeappendixsettings are deliberately left
% active: the chapter cannot render without the first, and references/
% the bibliography must keep working, which is the entire point of
% this mode.
\ifIIST@chapteronly
  \ClassWarning{iist}{chapteronly mode is active -- front matter
    (title page, certificate, declaration, dedication, acknowledgements,
    abstract, ToC, lists, abbreviations, nomenclature, publications,
    index) is suppressed. This build is NOT a complete dissertation.}
  \newcommand{\IIST@chapteronlynotice}{%
    \begin{center}\small\itshape
      [IISTThesis: chapter-only compilation mode --
      front matter suppressed for this build]
    \end{center}%
  }
  \renewcommand{\maketitle}{\IIST@chapteronlynotice}
  \renewcommand{\makecertificate}{}
  \renewcommand{\makedeclaration}{}
  \renewcommand{\makededication}{}
  \renewcommand{\makeacknowledgements}{}
  \renewcommand{\makeabstract}{}
  \renewcommand{\maketableofcontents}{}
  \renewcommand{\makelistoftables}{}
  \renewcommand{\makelistoffigures}{}
  \renewcommand{\makelistofalgorithms}{}
  \renewcommand{\makeabbreviations}{}
  \renewcommand{\makenomenclature}{}
  \renewcommand{\makepublications}{}
  \renewcommand{\makeindexsettings}{}
\fi