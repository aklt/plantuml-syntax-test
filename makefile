
UML=$(wildcard uml/*.uml)
PNG=$(patsubst %.uml, %.png, $(UML))
PRE=$(patsubst %.uml, %.pre.html, $(UML))
CSS=$(patsubst %.uml, %.syntax.css, $(UML))

info:
	@echo "Warning: The screen will blink a lot!"
	@echo "Press Enter to continue, CTRL-c to stop"
	@mkdir -p build
	@read USER_INPUT
	$(MAKE) -C . all

all: style.css index.html $(PNG)

style.css: $(CSS) $(UML)
	cat $(CSS) | sort | uniq > $@

index.html: index.sh $(PRE) $(UML)
	./index.sh $(PRE) > $@

%.pre.html %.syntax.css: %.uml
	./tohtml.sh $< uml/$$(basename $< .uml)

.PHONY: dev clean uml

dev:
	npm run dev

clean:
	rm -f $(PNG) $(PRE) $(CSS) index.html style.css

# %.png: %.uml
# 	cat $< | plantuml -tpng -p > "$$(basename '$<').png"

%.png: %.uml
	plantuml -tpng $<
