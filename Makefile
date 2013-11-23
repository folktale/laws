bin        = $(shell npm bin)
lsc        = $(bin)/lsc
browserify = $(bin)/browserify
groc       = $(bin)/groc
uglify     = $(bin)/uglifyjs
version    = node -e 'console.log(require("./package.json").version)'

lib: src/*.ls
	$(lsc) -o lib -c src/*.ls

dist:
	mkdir -p dist

dist/folktale.laws.umd.js: compile dist
	$(browserify) lib/index.js --standalone Laws > $@

dist/folktale.laws.umd.min.js: dist/folktale.laws.umd.js
	$(uglify) --mangle - < $^ > $@

# ----------------------------------------------------------------------
bundle: dist/folktale.laws.umd.js

minify: dist/folktale.laws.umd.min.js

compile: lib

documentation:
	$(groc) --index "README.md"                                              \
          --out "docs/literate"                                            \
          src/*.ls README.md

clean:
	rm -rf dist build lib *.tar.gz

test:
	$(lsc) test/node.ls

package: compile documentation bundle
	mkdir -p dist/laws-`$(version)`
	cp -r docs/literate dist/laws-`$(version)`
	cp -r lib dist/laws-`$(version)`
	cp dist/*.js dist/laws-`$(version)`
	cp package.json dist/laws-`$(version)`
	cp README.md dist/laws-`$(version)`
	cp LICENCE dist/laws-`$(version)`
	tar -czf laws-`$(version)`.tar.gz dist/laws-`$(version)`

.PHONY: test
