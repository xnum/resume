OUT_DIR=output
IN_DIR=markdown
STYLES_DIR=styles
STYLE=chmduquesne

ORG=resume.md
FILE_NAME=resume

all: html

pdf: init html
	./node_modules/.bin/chrome-headless-render-pdf --url file:///home/num/resume/index.html --pdf resume.pdf

html: init
	pandoc --standalone --include-in-header $(STYLES_DIR)/$(STYLE).css \
           --lua-filter=pdc-links-target-blank.lua \
           --from markdown --to html \
           --template template.html \
           --output index.html $(ORG) metadata.yaml

init: version

version:
	PANDOC_VERSION=`pandoc --version | head -1 | cut -d' ' -f2 | cut -d'.' -f1`; \
	if [ "$$PANDOC_VERSION" -eq "2" ]; then \
		SMART=-smart; \
	else \
		SMART=--smart; \
	fi \

clean:
	rm -f $(OUT_DIR)/*
