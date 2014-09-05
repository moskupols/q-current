SHELL=bash

SUBJECTS=groupth danalysis
PDFS_DIR=pdfs

SOURCES=$(foreach subj,$(SUBJECTS),$(subj)/$(subj).tex)
AUXS=$(SOURCES:.tex=.aux)
TEMP_TARGETS=$(SOURCES:.tex=.pdf)
TARGETS=$(addprefix $(PDFS_DIR)/,$(addsuffix .pdf,$(SUBJECTS)))

all: $(TEMP_TARGETS)
	cp -f $(TEMP_TARGETS) -t $(PDFS_DIR)

commit: all
	git add header.tex template.tex .gitignore $(SOURCES)
	git commit

%.pdf: %.aux %.tex
	cd $(dir $@) && pdflatex -interaction=nonstopmode $(notdir $(@:.pdf=.tex))

%.aux: %.tex
	cd $(dir $@) && pdflatex -interaction=nonstopmode $(notdir $(@:.aux=.tex))

clean:
	rm -f $(SOURCES:.tex=.{out,log,aux,pdf,toc,dvi})

