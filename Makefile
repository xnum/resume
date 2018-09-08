OUT_DIR=output
IN_DIR=markdown
STYLES_DIR=styles
STYLE=chmduquesne

ORG=resume.md
FILE_NAME=resume

all: html

pdf: init html
	pandoc --standalone --template=styles/chmduquesne.tex \
		   --pdf-engine=xelatex \
           --from markdown \
           --variable papersize=A4 \
           --output resume.pdf resume.md > /dev/null

html: init
	pandoc --standalone --include-in-header $(STYLES_DIR)/$(STYLE).css \
           --lua-filter=pdc-links-target-blank.lua \
           --from markdown --to html \
           --template template.html \
           --output index.html $(ORG) metadata.yaml

init: dir version

dir:
	mkdir -p $(OUT_DIR)

version:
	PANDOC_VERSION=`pandoc --version | head -1 | cut -d' ' -f2 | cut -d'.' -f1`; \
	if [ "$$PANDOC_VERSION" -eq "2" ]; then \
		SMART=-smart; \
	else \
		SMART=--smart; \
	fi \

clean:
	rm -f $(OUT_DIR)/*
