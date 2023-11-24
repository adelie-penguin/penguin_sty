% vim: set tabstop=4 : 
%***********************************************************
%	  ぺんぎん すたいるふぁいる ver.2023 
%***********************************************************

\LoadClass[a4j,twoside]{jarticle}
\typeout{>> ぺんぎん すたいるふぁいる ver.2023}

\usepackage{geometry}	% 余白楽々設定
\usepackage{titlesec}	% sectoinデザイン変更
\usepackage{fancyhdr}	% ヘッダーの設定
\usepackage{lastpage}	% 最終ページ番号の表示
\usepackage{url}    	% URLのアンダーバー表示(参考文献で利用)
\usepackage[fleqn]{mathtools}	% 数式用
\usepackage[dvipdfmx]{graphicx}	% 画像ファイル用
\usepackage[dvipdfmx]{color} 	% PNG画像表示/文字彩色
\usepackage{enumitem}	% 箇条書きのフォーマットを編集できる
\usepackage{listings}	%ソースコード貼付
\usepackage{sty/jlisting} %listingsの日本語拡張
\usepackage{multirow}	% 表のセル連結
\usepackage{ascmac}	% タイトル付き囲み線
%\usepackage{layout}	% レイアウト表示 
%-----------------------------------------------------------

% オプションフラグの変数宣言
\newif\if@zemi\@zemifalse
\newif\if@meiryo\@meiryofalse


% ゼミ用TeX設定
\DeclareOption{zemi}{%
	\@twocolumntrue		% 2段組
	\@zemitrue
}

% フォント変更
\DeclareOption{meiryo}{\@meiryotrue}


\ProcessOptions\relax % クラスファイルのオプション実行

%-----------------------------------------------------------
% 余白設定
%-----------------------------------------------------------
% geometry.styを利用

\if@zemi
\geometry{
	%ページ全体の余白
	left=25mm, 
	right=10mm, 
	top=20mm, 
	bottom=10mm,
	%ヘッダーの余白
	headheight=2em, 
	headsep=1em
}
\else	
\geometry{
	%ページ全体の余白
	left=30mm, 
	right=30mm, 
	top=30mm, 
	bottom=30mm,
}
\fi

%-----------------------------------------------------------
% 文字サイズの設定
%-----------------------------------------------------------
% 一般的な設定
%  5pt \tiny
%  7pt \scriptsize
%  8pt \footnotesize
%  9pt \small
% 10pt \normalsize
% 12pt \large

\newdimen\@Q \@Q=0.25mm 	% 文字サイズの単位(現段階では未使用)
\def\baselinestretch{1.0} 	% 行間隔調整

\if@zemi
% 文字サイズ設定
%   1つ目の文字サイズ引数:文字サイズ
%   2つ目の文字サイズ引数:1行辺りのサイズ(行間余白含む)
\renewcommand{\normalsize}{\@setfontsize\normalsize{9pt}{12pt}}
\renewcommand{\small}{\@setfontsize\small{8pt}{11pt}}
\renewcommand{\footnotesize}{\@setfontsize\footnotesize{7pt}{9pt}}
\renewcommand{\scriptsize}{\@setfontsize\scriptsize{6pt}{7pt}}
\renewcommand{\tiny}{\@setfontsize\tiny{5pt}{6pt}}
\renewcommand{\large}{\@setfontsize\large{10pt}{14pt}}
\renewcommand{\Large}{\@setfontsize\Large{14pt}{16pt}}
\fi

\let\fs@caption\footnotesize
\let\fs@subcaption\scriptsize
\let\fs@table\footnotesize
\let\fs@header\tiny
\let\fs@bibliography\scriptsize 
\let\fs@listing\scriptsize
\let\fs@title\Large
\let\fs@author\normalsize
\let\fs@section\large



%-----------------------------------------------------------
% 図表・数式・箇条書き
%-----------------------------------------------------------
% captionのところの設定
%
\long\def\@makecaption#1#2{
	\setbox\@tempboxa\hbox{\fs@caption #1. #2}
	\ifdim \wd\@tempboxa >\hsize #1. #2\par 
	\else \hbox to\hsize{\hfil\box\@tempboxa\hfil} 
	\fi
}

\newcounter{c@subfigure}
\newcommand{\subcaption}[1]{%
	\stepcounter{c@subfigure} %カウントアップ
	\setbox\@tempboxa\hbox{\fs@subcaption (\alph{c@subfigure})#1}
	\ifdim \wd\@tempboxa >\hsize (\alph{c@subfigure})#1\par 
	\else \hbox to\hsize{\hfil\box\@tempboxa\hfil} 
	\fi
}

\def\theequation{\arabic{equation}}	% 参照番号(式)
\def\thetable{\@arabic\c@table} 	% 参照番号(表)
\def\thefigure{\@arabic\c@figure} 	% 参照番号(図)

%表の横の余白設定 + 文字サイズ変更
\newcommand{\tbspace}[1]{
	\centering		%中央揃え
	\fs@table		%文字サイズ
	\tabcolsep=#1cm	%左右余白
}

%図を保存するディレクトリを登録
\graphicspath{{./figure/}}

%箇条書きの行間
\setlist{itemsep=0pt, parsep=0pt}

%引用されていない数式に番号を付けない
\mathtoolsset{showonlyrefs=true}


%-----------------------------------------------------------
% タイトル部分
%-----------------------------------------------------------
% jarticleの定義から必要部分のみ変更
% 余計な行があるのは仕方ない

%タイトル部分には日付を入れない
\renewcommand\@maketitle{
	\begin{center}
	\fs@title{\bfseries\sffamily\@title\leavevmode\\}
	\vspace{0.5em}
	\fs@author{\@author\leavevmode\\}
	\end{center}
	\vspace{1em}
}

\renewcommand\maketitle{\par
	\begingroup
	\def\thefootnote{\fnsymbol{footnote}}
	\def\@makefnmark{\hbox
	to 0pt{$^{\@thefnmark}$\hss}}
	\if@zemi
		\twocolumn[\@maketitle]
		\thispagestyle{toppage}
	\else
		\@maketitle
	\fi
  	\endgroup
	\setcounter{footnote}{0}
	\let\maketitle\relax
	\let\@maketitle\relax
}

%-----------------------------------------------------------
% ヘッダーの設定
%-----------------------------------------------------------
% fancyhdr.styを利用

\renewcommand{\today}{\the\year/\two@digits\month/\two@digits\day} %日付のフォーマット変更
\renewcommand{\headrulewidth}{0pt} 	%ヘッダーは線なし

% 1ページ目
\fancypagestyle{toppage}
{
	\fancyhead{}	%ヘッダーリセット
	\fancyfoot{}	%フッターリセット
	\fancyhead[RO]{\small{\@date}}
}

% 2ページ目以降 (RO: 奇数ページのみ表示)
\pagestyle{fancy}
\fancyhead{}	%ヘッダーリセット
\fancyfoot{}	%フッターリセット
\if@zemi
\fancyhead[RO]{\fs@header{\@author：\@title(\thepage/\pageref{LastPage})}} 
\fi

%-----------------------------------------------------------
% 章タイトルの設定
%-----------------------------------------------------------
% titlesec.styを利用	
%

\titleformat{\section}[block]{\bfseries\fs@section}{\textbf{\thesection.}}{0.5em}{}
\titleformat{\subsection}[block]{\bfseries\normalsize}{\textbf{\thesubsection.}}{0.5em}{}
\titleformat{\subsubsection}[block]{\bfseries\normalsize}{\textbf{\thesubsubsection.}}{0.5em}{}
\if@zemi
\titlespacing{\section}{0em}{0.5em}{0em}		%sectionタイトルの左・上・下の余白
\titlespacing{\subsection}{0em}{0em}{0em}	
\titlespacing{\subsubsection}{0em}{0em}{0em}
\else	
\titlespacing{\section}{0em}{1.0em}{0em}		%sectionタイトルの左・上・下の余白
\titlespacing{\subsection}{0em}{0.5em}{0em}	
\titlespacing{\subsubsection}{0em}{0.5em}{0em}
\fi

%-----------------------------------------------------------
% ソースコードの表示設定
%-----------------------------------------------------------
% listing.styの設定
%
\lstset{
	basicstyle=\fs@listing\ttfamily,	%文字サイズ(ソースコード)
	columns=fixed,
	basewidth=0.5em,
	frame=single, 		%囲み線
	numbers=left, 		%行番号
	numberstyle=\tiny,	%文字サイズ(行番号)
	xleftmargin=2em, 	%
	tabsize=2, 			%タブ幅
	breaklines=true,	%行末で折返
	breakindent=1em		%折返のインデント幅
}



%-----------------------------------------------------------
% 参考文献
%-----------------------------------------------------------
%

\def\thebibliography#1{
	\vspace{0.5em}
	\subsection*{参考文献}
	% list環境を使うよ
	\list{(\arabic{enumi})}{		% デフォルトの[1]から(1)に変更
		\settowidth\labelwidth{(#1)}% 文献番号の桁合わせ
		\leftmargin\labelwidth
		\advance\leftmargin\labelsep
		\usecounter{enumi}
		\fs@bibliography			%文字サイズ
		\setlength{\itemsep}{-3pt}	%行間
	}
	\let\endthebibliography=\endlist
}

% 参考文献の引用形式(\citeは上付き文字にする)
\def\@cite#1#2{$^{\mbox{\scriptsize ({#1\if@tempswa,#2\fi})}}$} 

%
% 参考文献の引用形式(別定義の変数作成は難しいので一時的な再定義でしのぐ)
\newcommand{\Cite}[1]{
\def\@cite##1##2{[{##1\if@tempswa,##2\fi}]} % tmpフォーマット
\cite{#1}									% コマンド実行
\def\@cite##1##2{$^{\mbox{\scriptsize ({##1\if@tempswa,##2\fi})}}$} %現状復帰
}

% [実装断念]
% 理想的な実装：bibflgを参考文献の\citeコマンド内に追加したい
% 断念理由：\citeの\def定義が分からない
% 現状　　：\citeの有無に関係なくbibflgを定義/makefileで引用件数を確認
\gdef\bibflg{1}
\newcommand{\inputbibliography}[1]{
	\@ifundefined{bibflg}{\relax}{\bibliography{#1}}
}

% bibtexスタイルファイル
\bibliographystyle{sty/penguin} 

%-----------------------------------------------------------											
% 色の定義
%-----------------------------------------------------------
\definecolor{ppink}{rgb}{0.85, 0.20, 0.247} %紅赤
\definecolor{pgreen}{rgb}{0.44, 0.68, 0.24} %鶸萌黄色(ひわもえぎ)

											
%-----------------------------------------------------------
% 図番号のない囲み
%-----------------------------------------------------------
%	本当は1つの\begin{}～\end{}にしたかったのだけどorz
%
\newenvironment{lstbox}[1]{\vspace{0.5em}\begin{itembox}[l]{{\fs@caption #1}} }{\end{itembox}\vspace{0.5em}}
\lstnewenvironment{minilst}{\vspace{-10pt}\lstset{frame=none, numbers=none}}{\vspace{-10pt}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 簡単コマンド
%**********************************************************
%

%----------------------------------------------------------
%オワタ
%----------------------------------------------------------
%	\owataと入力すると\(^o^)/を表示  (現実逃避用)
%
\newcommand{\owata}{$\backslash ( \hat{\ } o \hat{\ } ) / $}

%----------------------------------------------------------
% 文字に色を付ける
%----------------------------------------------------------
% color.styの短縮コマンド
\newcommand{\red}[1]{\textcolor{red}{#1}}
\newcommand{\blue}[1]{\textcolor{blue}{#1}}
\newcommand{\white}[1]{\textcolor{white}{#1}}
%\renewcommand{\red}[1]{#1}		% コメントアウトを外すと彩色を中止する
%\renewcommand{\blue}[1]{#1}	% コメントアウトを外すと彩色を中止する
%\renewcommand{\white}[1]{#1}	% コメントアウトを外すと彩色を中止する

%----------------------------------------------------------
%図の貼り付け(ショートカットコマンド)
%	個人の好みに合わせた改造推奨
%----------------------------------------------------------
%	1枚だけ
% 		\fig{タイトル}{epsファイル名}{図の横幅}
% 		\fig[拡張子]{タイトル}{拡張子付ファイル名}{図の横幅}
%
%	2枚並べて
% 		\doublefig{タイトル1}{ファイル名1}{図の横幅1}{図と図の間隔}{title_2}{file_name2}{size_2}
% 		\subfig{全体タイトル}{タイトル1}{ファイル名1}{図の横幅1}{図と図の間隔}{title_2}{file_name2}{size_2}
%
%	横幅はcm単位で指定する(小数点使えます)
%	参照ラベルが"fig:ファイル名"になる
%
%	   [例] ./figure/penguin.epsを貼り付ける
%			   本文: \figref{fig:penguin}に，横幅が4.3cmになるようにペンギンの図を貼り付ける．
%			   貼付: \fig{ペンギンの図}{penguin}{4.3}
%
%	現在の設定の注意点
%  ・図は必ず./figureディレクトリ内に保存する必要あり
%  ・同じ名前のファイルを2回貼り付できない(ラベルの重複)
%

\newcommand{\fig}[4][eps]{
\begin{figure}[th]
\centering
\includegraphics[width=#4cm,clip]{#3.#1}	  %画像ファイルを保存したディレクトリを指定
\caption{#2}
\label{fig:#3}  
\end{figure}
}

\newcommand{\doublefig}[8][eps]{
\begin{figure}[th]
\begin{tabular}{lr}
%-[1枚目]------------------
\begin{minipage}[b]{0.45\hsize}
\centering
\includegraphics[width=#4cm,clip]{#3.#1}
\caption{#2}
\label{fig:#3}
\end{minipage}
%-[2枚目]------------------
\hspace*{#5cm}
\begin{minipage}[b]{0.45\hsize}
\centering
\includegraphics[width=#8cm,clip]{#7.#1}	
\caption{#6}
\label{fig:#7}
\end{minipage}
%--------------------------
\end{tabular}
\end{figure}
}

\newcommand{\subfig}[9][eps]{
\setcounter{c@subfigure}{0}
\begin{figure}[th]
\begin{tabular}{lr}
%-[1枚目]------------------
\begin{minipage}[b]{0.45\hsize}
\centering
\includegraphics[width=#5cm,clip]{#4.#1}
\subcaption{#3}
\end{minipage}
%-[2枚目]------------------
\hspace*{#6cm}
\begin{minipage}[b]{0.45\hsize}
\centering
\includegraphics[width=#9cm,clip]{#8.#1}	
\subcaption{#7}
\end{minipage}
%--------------------------
\end{tabular}
\vspace{-2em}
\caption{#2}
\label{fig:#4#8}
\end{figure}
}


%表の簡単設定
\newenvironment{ttable}[5][th]%
	{\begin{table}[#1]\caption{#2}\label{tb:#3}\tbspace{#5}\begin{tabular}{#4}\hline\hline}%
	{\end{tabular}\end{table}}

%----------------------------------------------------------
% IPSJの参照コマンドを再現
%----------------------------------------------------------
%	   図表は初参照時のみ太字表示
%

\newcommand{\figref}[1]{\@ifundefined{used@#1}{{\bf 図\ref{#1}}\expandafter\gdef\csname used@#1\endcsname{\relax}}{図\ref{#1}}\relax}
\newcommand{\tabref}[1]{\@ifundefined{used@#1}{{\bf 表\ref{#1}}\expandafter\gdef\csname used@#1\endcsname{\relax}}{表\ref{#1}}\relax}

%初回の太字化を解除したい場合はコメント解除
%\renewcommand{\figref}[1]{図\ref{#1}}	
%\renewcommand{\tabref}[1]{表\ref{#1}}	
\renewcommand{\eqref}[1]{式(\refeq{#1})}


%%%%%%%%%%%%%%% END %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
