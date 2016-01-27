main:
	-rm -rf dist
	# @rm -rf ./source
	# -git clone git@github.com:bagder/http2-explained.git source
	# pre-build
	cp -r ./source/zh ./book
	# build
	gitbook build ./book ./dist/book
	gitbook-ext minify --verbose ./dist/book
	# package
	cp ./source/book.json ./dist/book
	cp -rf ./_license ./dist/book/_license
	# tar -cvzf ./dist/book.tar.gz ./dist/book/ #use zip instead
	cd dist && zip -vr ./book.zip ./book/ # 用数名做包名
	# post package
	# md5 -q ./dist/book.tar.gz > ./dist/md5
	md5 -q ./dist/book.zip > ./dist/md5
	# clean up
	rm -rf ./book #./source

deploy:
	git push origin gh-pages
	# -git checkout -b gh-pages
	# -git push origin gh-pages
	# -git checkout master
	# -git branch -D gh-pages

    
.PHONY: main
