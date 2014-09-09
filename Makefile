SHELL=bash

SUBJECTS=groupth danalysis diff_equations formal_langs probabilities
PDFS_DIR=pdfs

SOURCES=$(foreach subj,$(SUBJECTS),$(subj)/$(subj).tex)
AUXS=$(SOURCES:.tex=.aux)
TEMP_TARGETS=$(SOURCES:.tex=.pdf)
TARGETS=$(addprefix $(PDFS_DIR)/,$(addsuffix .pdf,$(SUBJECTS)))

.SECONDARY:

all: $(TEMP_TARGETS)
	cp -u $(TEMP_TARGETS) -t $(PDFS_DIR)

commit: all
	git add header.tex template.tex .gitignore $(SOURCES)
	git commit

%.pdf: %.aux %.tex
	cd $(dir $@) && pdflatex -interaction=nonstopmode $(notdir $(@:.pdf=.tex))

%.aux: %.tex
	cd $(dir $@) && pdflatex -interaction=nonstopmode $(notdir $(@:.aux=.tex))

clean:
	rm -f $(SOURCES:.tex=.{out,log,aux,pdf,toc,dvi})

