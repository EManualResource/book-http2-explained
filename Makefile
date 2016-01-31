main:
	-rm -rf dist
	# @rm -rf ./source

	# pre-build
	cp -r ./source/zh ./book
    # book.json
	gitbook-ext jsonmerge ./source/book.json ./_config/book.json > ./book/book.json
    
	# build
	gitbook build ./book ./dist/book
	gitbook-ext minify --verbose ./dist/book

	# package
	cp ./book/book.json ./dist/book
	cp -rf ./_license ./dist/book/_license
	# tar -cvzf ./dist/book.tar.gz ./dist/book/ #use zip instead
	cd dist && zip -vr ./book.zip ./book/ 

	# post package
	md5 -q ./dist/book.zip > ./dist/md5

	# clean up
	rm -rf ./book #./source

deploy:
	git push origin gh-pages
	# -git checkout -b gh-pages
	# -git push origin gh-pages
	# -git checkout master
	# -git branch -D gh-pages

update-source:
	git submodule update --remote source

serve:
	@echo "serve on ~> http://localhost:8000"
	cd dist/book && python -m SimpleHTTPServer 8000
	
.PHONY: main
