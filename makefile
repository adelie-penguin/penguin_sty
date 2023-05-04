# vim: set tabstop=2 :
#***********************************************************************
# penguin_sty makefile
#
#***********************************************************************
#
#  make         main.texをコンパイルしてmain.pdfを作成
#  make clean   PDFファイルを作るために生成したファイルを消去
#
#***********************************************************************

#骨格になるtexファイル (.tex拡張子は書かないこと)
MAIN=main

#参考文献のbibファイル(.bibの拡張子は記述しないこと)
REF=bibfile

#--[コンパイルコマンド]--------------------------------

#コンパイル環境に合わせて変更
PLATEX=platex
BIBTEX=pbibtex
DVIPDFM=dvipdfmx

#--[普通に使うならここから下は書き換え不要なはず]------

SRC 		= $(MAIN).tex $(REF).bib 
DELFILE = $(MAIN).aux $(MAIN).blg $(MAIN).dvi $(MAIN).log
TEXOPT1	= -interaction=nonstopmode
TEXOPT23= -interaction=batchmode 
BIB0LINE = 3

#------------------------------------------------------

all:COMPILE3
	@echo 
	@echo ---------------------------------------
	@echo $(DVIPDFM) $(MAIN) 
	@echo ---------------------------------------
	@$(DVIPDFM) $(MAIN)

COMPILE3:COMPILE2
	@echo 
	@echo ---------------------------------------
	@echo [3rd compile] $$ $(PLATEX) $(MAIN) 
	@echo ---------------------------------------
	$(PLATEX) $(TEXOPT23) $(MAIN) 

COMPILE2:BIBCHECK
	@echo 
	@echo ---------------------------------------
	@echo [2nd compile] $$ $(PLATEX) $(MAIN) 
	@echo ---------------------------------------
	$(PLATEX) $(TEXOPT23) $(MAIN) 


# 引用数が0のときにmain.bblが3行になることを利用してbblファイルを削除
BIBCHECK:BIBCOMPILE
	$(eval BIBLINE := $(shell wc -l < $(MAIN).bbl))
	@if [ $(BIBLINE) -eq $(BIB0LINE) ]; then\
			rm $(MAIN).bbl;\
	fi

BIBCOMPILE:$(REF).bib COMPILE 
	@echo 
	@echo ---------------------------------------
	@echo [make bbl file] $$ $(BIBTEX) $(MAIN) 
	@echo ---------------------------------------
	-@ $(BIBTEX) $(MAIN)

COMPILE:$(SRC) 
	@echo ---------------------------------------
	@echo [1st compile] $$ $(PLATEX) $(MAIN) 
	@echo ---------------------------------------
	$(PLATEX) $(TEXOPT1)  $(MAIN) 

#------------------------------------------------------

.PHONY:clean
clean:$(DELFILE) 
	-@ rm -f $^


