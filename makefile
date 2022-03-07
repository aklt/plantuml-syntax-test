
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
	$(MAKE) -j $(nproc) $(PNG)

par-svg: $(UML)
	$(MAKE) -j $(nproc) $(SVG)

build: style.css index.html par-png

style.css: $(CSS) $(UML)
	cat $(CSS) | sort | uniq > $@

index.html: index.sh $(PRE) $(UML)
	bash ./index.sh $(PRE) > $@

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
