METEOR_GIT = "git@github.com:meteor/meteor.git"
METEOR_SOURCES = build/meteor/packages/base64/base64.js \
								 build/meteor/packages/ejson/ejson.js \
								 build/meteor/packages/tracker/tracker.js \
								 build/meteor/packages/reactive-dict/reactive-dict.js \
								 build/meteor/packages/reactive-var/reactive-var.js

SOURCES = src/intro.js \
					src/outro.js

dist/meteor-reactive.js: build/lodash.custom.js build/meteor-sources.js
	@@echo "Making [$@]..."
	@@echo "(function() {" > $@
	@@cat $^ >> $@
	@@echo "})();" >> $@

build/lodash.custom.js: build/meteor-sources.js
	@@echo "Making [$@]..."
	$(eval LODASH_FN=$(shell grep -oh "_\.[[:alpha:]]*" build/meteor-sources.js | sort | uniq))
	@@echo "Included functions: $(LODASH_FN)"
	$(eval comma=,)
	@@lodash modern include=$(subst $(eval) ,$(comma),$(subst _.,,$(LODASH_FN))),noConflict \
		iife=";(function(){%output%}).call(this);_=this._.noConflict();" -d -o $@

build/meteor-sources.js: $(METEOR_SOURCES)
	@@echo "Making [$@]..."
	@@echo "Meteor = {_noYieldsAllowed: function(f) {return f();}};" > $@
	@@for f in $^; do \
			echo "/** start of $$f **/" >> $@; \
			cat $$f >> $@; \
			echo "/** end of $$f **/" >> $@; \
		done

meteor:
	@@echo "Updating Meteor source code..."
	@@if [ -d ./build/meteor ]; then \
			cd build/meteor && git pull; \
		else \
			cd build && git clone $(METEOR_GIT); \
		fi

clean:
	@@rm build/*.js

.PHONY: meteor clean
