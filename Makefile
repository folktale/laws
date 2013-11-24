bin        = $(shell npm bin)
lsc        = $(bin)/lsc
browserify = $(bin)/browserify
groc       = $(bin)/groc
uglify     = $(bin)/uglifyjs
VERSION    = $(shell node -e 'console.log(require("./package.json").version)')


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
	        src/*.ls test/*.ls test/**/*.ls README.md

clean:
	rm -rf dist build lib

test:
	$(lsc) test/node.ls

package: compile documentation bundle minify
	mkdir -p dist/laws-$(VERSION)
	cp -r docs/literate dist/laws-$(VERSION)/docs
	cp -r lib dist/laws-$(VERSION)
	cp dist/*.js dist/laws-$(VERSION)
	cp package.json dist/laws-$(VERSION)
	cp README.md dist/laws-$(VERSION)
	cp LICENCE dist/laws-$(VERSION)
	cd dist && tar -czf laws-$(VERSION).tar.gz laws-$(VERSION)


.PHONY: test
