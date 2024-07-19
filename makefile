
UML=$(wildcard uml/*.uml)
PNG=$(patsubst %.uml, %.png, $(UML))
SVG=$(patsubst %.uml, %.svg, $(UML))
PRE=$(patsubst %.uml, %.pre.html, $(UML))
CSS=$(patsubst %.uml, %.syntax.css, $(UML))

.PHONY: all build dev install clean par-png par-svg

info:
	@echo "Warning: The screen will blink a lot!"
	@echo "Press Enter to continue, CTRL-c to stop"
	@mkdir -p build
	@read USER_INPUT
	$(MAKE) -C . all

all: build

par-png: $(UML)
	$(MAKE) $(PNG)

par-svg: $(UML)
	$(MAKE) $(SVG)

build: style.css par-svg index.html

style.css: $(CSS) $(UML)
	cat $(CSS) | sort | uniq > $@

index.orig.html: index.sh $(PRE) $(UML)
	bash ./index.sh $(PRE) > $@

index.html: index.orig.html
	npx html-minifier-terser --collapse-whitespace --remove-comments --remove-optional-tags --remove-redundant-attributes --remove-script-type-attributes --remove-tag-whitespace --use-short-doctype \
	                         --minify-urls --minify-js true --minify-css true $< > $@

%.pre.html %.syntax.css: %.uml
	bash ./tohtml.sh $< uml/$$(basename $< .uml)

dev:
	npm run dev

install:
	git submodule update --init --recursive
	npm install

clean:
	rm -f $(PRE) $(CSS)

distclean:
	rm -fv $(PNG) $(SVG) index.html style.css

%.png: %.uml
	plantuml -tpng $<

%.svg: %.uml
	plantuml -tsvg $<
