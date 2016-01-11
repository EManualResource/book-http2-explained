main:
	-rm -rf dist
	# @rm -rf ./remote
	-git clone git@github.com:bagder/http2-explained.git remote
	# pre-build
	cp -r ./remote/zh ./book
	# build
	gitbook build ./book ./dist/book
	gitbook-ext minify --verbose ./dist/book
	# package
	cp ./remote/book.json ./dist/book
	cp -rf ./_license ./dist/book/_license
	tar -cvzf ./dist/book.tar.gz ./dist/book/
	# post package
	md5 -q ./dist/book.tar.gz > ./dist/md5
	# clean up
	rm -rf ./book #./source

deploy:
	-git checkout -b gh-pages
	-git push origin gh-pages
	-git checkout master
	-git branch -D gh-pages

    
.PHONY: main
