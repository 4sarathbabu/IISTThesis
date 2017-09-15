%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% ----------------Thesis/Report Template for IIST---------------- %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Author - Sarath Babu
%%% Email: 4sarathbabu@gmail.com

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
\usepackage[T1]{fontenc}
\usepackage{ifthen}
\usepackage{algorithm}
\usepackage{algpseudocode}
\usepackage{titlesec}
\usepackage{xcolor}
\usepackage{imakeidx}
\usepackage{hyperref}
\usepackage{emptypage}
\usepackage[labelfont=bf]{caption}


%% ---- Content Styles ---- %%
\onehalfspacing   % Line spacing
\hypersetup{ % Hyperlink set up
    linkbordercolor = blue!30,
    citebordercolor = lime!70,
    urlbordercolor = red!50,
}
\titleformat{\chapter}[display]{\Large\bfseries}{\chaptertitlename\ 
\thechapter}{1mm}{\huge} % Chapter title 
\titleformat*{\section}{\Large\bfseries} % Section title
\titleformat*{\subsection}{\large\bfseries} % Subsection title
\titleformat*{\subsubsection}{\bfseries} % Subsubsection title

\makeindex[options= -s indexstyle.ist] % Make index

\setcounter{secnumdepth}{4} % Setting section numbering to 4 levels
\setcounter{tocdepth}{1} % Set section numbering depth in ToC to 2 levels


%% ---- Custom Commands ---- %%
\newcommand{\department}[1]
{
	\renewcommand{\Department}{#1}
}

\newcommand{\specialization}[1]
{
	\renewcommand{\Specialization}{#1}
}

\newcommand{\advisor}[1]
{
	\renewcommand{\Advisor}{#1}
}

\newcommand{\studentid}[1]
{
	\renewcommand{\Studentid}{#1}
}

\newcommand{\Title}{\@title}
\newcommand{\Author}{\@author}
\newcommand{\Date}{\@date}

\renewcommand{\thealgorithm}{\arabic{chapter}.\arabic{algorithm}} 


%% ---- Design of Title Page ---- %%
\renewcommand{\maketitle}
{	
	\begin{center}
          \thispagestyle{empty}
                \vspace*{1cm}
		\begin{spacing}{1}
		\LARGE \bf \Title
		\end{spacing}
		\vspace{8mm}
		\ifthenelse{\equal{\Doctype}{internship report}}
		{An}{A}
		\Doctype\ submitted \\\vspace{1mm} in partial fulfillment for 
		the award of the degree of	
		\\\vspace{8mm}
		\textbf{\Degreetext}
		\\ \vspace{4mm}
		in
		\\ \vspace{4mm}
		\textbf{\Specialization}
		\\ \vspace{4mm}
		by
		\\ \vspace{4mm}
		\textbf{\Author}
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
                \textbf{\Date}
	\end{center}
	\newpage	
}


%% ---- Design of Certificate Page ---- %%
\newcommand{\makecertificate}
{
	\pagenumbering{roman} 
	\setcounter{page}{0}
	\newpage \cleardoublepage
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
	\setcounter{page}{0}
	\cleardoublepage
	\pagenumbering{arabic} 	
}


%% ---- Add a New Chapter ---- %%
\newcommand{\makechapter}[1]
{
	\setcounter{algorithm}{0}
	\include{#1}
}


%% ---- Initialize Bibliography Settings ---- %%
\newcommand{\makebibsettings}
{
	\phantomsection
	\addcontentsline{toc}{chapter}{Bibliography}
}


%% ---- Initialize Appendix Settings ---- %%
\newcommand{\makeappendixsettings}
{
	\phantomsection
	\appendix
	\addcontentsline{toc}{chapter}{Appendices}
	\renewcommand{\thechapter}{A}
}


%% ---- Initialize Index Settings ---- %%
\newcommand{\makeindexsettings}
{
	\phantomsection
	\openup -3.25mm
	\addcontentsline{toc}{chapter}{Index}
	\printindex
	\onehalfspacing	
}


