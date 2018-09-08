OUT_DIR=build
STYLES_DIR=styles
STYLE=chmduquesne

ORG=resume.md

all: html

init:
	mkdir -p $(OUT_DIR)

pdf: init html
	wkhtmltopdf $(OUT_DIR)/index.html --disable-javascript $(OUT_DIR)/resume.pdf

html: init
	pandoc --standalone --include-in-header $(STYLES_DIR)/$(STYLE).css \
           --lua-filter=pdc-links-target-blank.lua \
           --from markdown --to html \
           --template template.html \
           --output $(OUT_DIR)/index.html $(ORG) metadata.yaml


clean:
	rm -f $(OUT_DIR)/*
