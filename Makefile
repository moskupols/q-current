SHELL=bash

SUBJECTS:=optimization
PDFS_DIR=pdfs

SOURCES=$(foreach subj,$(SUBJECTS),$(subj)/$(subj).tex)
TEMP_TARGETS=$(SOURCES:.tex=.pdf)
TARGETS=$(addprefix $(PDFS_DIR)/,$(addsuffix .pdf,$(SUBJECTS)))

.SECONDARY:

all: $(TEMP_TARGETS)
	cp -u $(TEMP_TARGETS) -t $(PDFS_DIR)

commit: all
	git add header.tex template.tex .gitignore $(SOURCES)
	git commit

%.pdf: %.tex
	cd $(dir $@) && latexmk -pdf -interaction=nonstopmode $(notdir $(@:.pdf=.tex))

clean:
	rm -f $(SOURCES:.tex=.{out,log,aux,pdf,toc,dvi,fls,fdb_latexmk})

