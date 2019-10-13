%% -----------'iist.cls' Thesis/Report Template for IIST------------ %%
%%                  Copyright (C) 2018  Sarath Babu                  %%

% This program is free software: you can redistribute it and/or modify 
% it under the terms of the GNU General Public License as published by 
% the Free Software Foundation, either version 3 of the License, or 
% (at your option) any later version.

% This program is distributed in the hope that it will be useful, but 
% WITHOUT ANY WARRANTY; without even the implied warranty of 
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU 
% General Public License for more details.

% You should have received a copy of the GNU General Public License 
% along with this program.  If not, see <http://www.gnu.org/licenses/>.

% Contact email: 4sarathbabu@gmail.com
% URL: https://github.com/4sarathbabu/IISTThesis


%%---- Identification ---- %%
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{iist}[2017/12/01 IIST LaTeX Class]


%% ---- Declarations ---- %%
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


%% ---- Options ---- %%
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

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}
\ProcessOptions\relax


%% ---- Preliminaries (Base class for the template) ---- %%
\LoadClass[12pt]{report}


%% ---- Required Package Initializations ---- %%
\usepackage[inner=1.5in, outer=1in, top=1in, bottom=1.25in]{geometry}
\usepackage[english]{babel}
\usepackage{setspace}
\usepackage{graphicx}
\usepackage{longtable}
\usepackage[T1]{fontenc}
\usepackage{ifthen}
\usepackage[ruled, algochapter, linesnumbered]{algorithm2e}
\usepackage{titlesec}
\usepackage{xcolor}
\usepackage{imakeidx}
\usepackage{hyperref}
\usepackage{emptypage}
\usepackage[labelfont=bf]{caption}
\usepackage{amsmath}
\usepackage{amssymb}
\usepackage{amsthm}


%% ---- Content Styles ---- %%
\onehalfspacing   % Line spacing
\hypersetup{ % Hyperlink set up
    linkbordercolor = blue!30,
    citebordercolor = lime!70,
    urlbordercolor = red!50,
}
\titleformat{\chapter}[display]{\LARGE\bfseries}{\chaptertitlename\ 
\thechapter}{1mm}{\huge} % Chapter title 
\titleformat*{\section}{\Large\bfseries} % Section title
\titleformat*{\subsection}{\large\bfseries} % Subsection title
\titleformat*{\subsubsection}{\bfseries} % Subsubsection title

\makeindex[options= -s indexstyle.ist] % Make index

\setcounter{secnumdepth}{4} % Setting section numbering to 4 levels
\setcounter{tocdepth}{1} % Set section numbering depth in ToC to 2 levels


%% ---- Assumption, Definition, Remark, Theorem, Proposition, and
%% Lemma ---- %%
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


%% ---- Custom Commands ---- %%
\renewcommand{\title}[2][]
{
  \newcommand{\Title}{#2}
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
  \newcommand{\Author}{#2}
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

% \newcommand{\Title}{\@title}
% \newcommand{\Author}{\@author}
\newcommand{\Date}{\@date}

%% ---- Design of Title Page ---- %%
\renewcommand{\maketitle}
{	
  \renewcommand{\thepage}{CP-\arabic{page}}
  \begin{center}
    \thispagestyle{empty}
    \vspace*{-5mm}
    \vfill
    \begin{spacing}{1}
      \LARGE \bf \CPTitle
    \end{spacing}
    \vspace{6mm}
    \ifthenelse{\equal{\Doctype}{internship report}}
    {An}{A}
    \Doctype\ submitted \\\vspace{1mm} in partial fulfillment for 
    the award of the degree of	
    \\\vspace{8mm}
    \textbf{\large{\Degreetext}}\\\vspace{4mm}
    \ifthenelse{\equal{\Degree}{phd}}
    {
      \vspace{2mm}
    }
    {
      in\\\vspace{4mm}
      \textbf{\large{\CPSpecialization}}\\\vspace{4mm}
    }
    by\\\vspace{4mm}
    \ifthenelse{\equal{\Degree}{phd}}
    {
      \vspace{2mm}
    }{}
    \textbf{\large{\CPAuthor}}
    \\ \vspace{15mm}
    \includegraphics[scale=0.2]{logo.pdf}
    \\ \vspace{10mm}
    \begin{spacing}{1.25}
      \large
      \textbf{Department of \Department}\\
      \textbf{Indian Institute of Space Science and Technology}\\
      \textbf{Thiruvananthapuram, India}
    \end{spacing}
    \vspace{4mm}
    \textbf{\large \Date}
    \vfill
  \end{center}
  \newpage~\thispagestyle{empty}\newpage
  \pagenumbering{roman}
}


%% ---- Design of Certificate Page ---- %%
\newcommand{\makecertificate}
{
  \cleardoublepage
  \newpage
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
  \vspace*{0.3\textheight}
  \input{dedication}
  \vfill
}


%% ---- Design of Acknowledgements ---- %%
\newcommand{\makeacknowledgements}
{
  \newpage \cleardoublepage
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
  \vspace*{1cm}
  \begin{center}
    {\LARGE \bf Abstract}
  \end{center}
  \input{abstract}
}


%% ---- Design of Table of Contents ---- %%
\newcommand{\maketableofcontents}
{
  % --- Basic Table of Contents --- %
  \newpage \cleardoublepage
  \tableofcontents
}

%% ---- List of Tables ---- %%
\newcommand{\makelistoftables}
{
  \newpage \cleardoublepage
  \phantomsection
  \addcontentsline{toc}{chapter}{List of Tables}
  \listoftables
}

%% ---- List of Figures ---- %%
\newcommand{\makelistoffigures}
{
  \newpage \cleardoublepage
  \phantomsection
  \addcontentsline{toc}{chapter}{List of Figures}
  \listoffigures
}

%% ---- List of Algorithms ---- %%
\newcommand{\makelistofalgorithms}
{
  \newpage \cleardoublepage
  \phantomsection
  \addcontentsline{toc}{chapter}{List of Algorithms}
  \listofalgorithms
}

%% ---- Abbreviations ---- %%
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
\newcommand{\makenomenclature}
{
  \newpage \cleardoublepage
  \phantomsection
  \addcontentsline{toc}{chapter}{Nomenclature}
  \chapter*{Nomenclature}
  \vspace*{-5mm}
  \input{nomenclature}
}


%% ---- Initialize Pages Format for Chapters ---- %%
\newcommand{\makechaptersettings}
{	
  \newpage  
  \cleardoublepage
  \setcounter{page}{0}
  \pagenumbering{arabic}
  \ifthenelse{\equal{\Doctype}{synopsis}}
  {
    \renewcommand{\thesection}{\arabic{section}}
    \setcounter{table}{0}
  }
  {}
}


%% ---- Initialize Bibliography Settings ---- %%
\newcommand{\makebibsettings}
{
  \phantomsection
  \addcontentsline{toc}{chapter}{Bibliography}
}


%% ---- Initialize Publications Settings ---- %%
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
\newcommand{\makeindexsettings}
{
  \newpage
  \ifthenelse{\equal{\Doctype}{synopsis}}{}{\cleardoublepage}
  \phantomsection
  \openup -3.25mm
  \addcontentsline{toc}{chapter}{Index}
  \printindex
  \onehalfspacing
}
