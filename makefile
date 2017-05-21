
UML=$(wildcard *.uml)
PNG=$(patsubst %.uml, %.png, $(UML))
PRE=$(patsubst %.uml, %.pre.html, $(UML))
CSS=$(patsubst %.uml, %.syntax.css, $(UML))

all: style.css index.html $(PNG)

style.css: $(CSS) $(UML)
	cat $(CSS) | sort | uniq > $@

index.html: index.sh $(PRE) $(UML)
	./index.sh $(PRE) > $@

%.pre.html %.syntax.css: %.uml
	./tohtml.sh $< $$(basename $< .uml)

.PHONY: dev clean

dev:
	npm run dev

clean:
	rm -f $(PNG) $(PRE) $(CSS) index.html style.css

%.png: %.uml
	plantuml -tpng $<
