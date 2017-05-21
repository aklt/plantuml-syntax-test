
UML=$(wildcard *.uml)
PNG=$(patsubst %.uml, %.png, $(UML))
PRE=$(patsubst %.uml, %.pre.html, $(UML))
CSS=$(patsubst %.uml, %.syntax.css, $(UML))

all: style.css index.html

style.css: $(CSS)
	cat $< | sort | uniq > $@

index.html: index.sh $(PRE)
	./index.sh $(PRE) > $@

.PHONY: dev clean

dev:
	freshen

clean:
	rm -f $(PNG) $(PRE) $(CSS)

%.png: %.uml
	plantuml -tpng $<
