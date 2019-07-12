build: stack_build
	stack exec site -- $@
rebuild: stack_build
	stack exec site -- $@
watch: stack_build
	stack exec site -- $@
.PHONY: build rebuild watch

stack_build:
	stack build
.PHONY: stack_build

isEverythingCommitted:
	./src/isEverythingCommitted.sh
.PHONY: isEverythingCommitted


push: isEverythingCommitted rebuild
	git submodule update --remote --merge
	rsync -avr --delete --exclude='.git' --exclude="CNAME" _site/ site/
	cd site \
		&& git checkout master \
		&& git add . \
		&& git commit -m 'site update' \
		&& git push origin master
	git add site
	git commit -m 'site update'
	git push origin master
.PHONY: push
