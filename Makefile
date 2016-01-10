main:
	# @rm -rf ./remote
	-git clone git@github.com:bagder/http2-explained.git remote
	cp -r ./remote/zh ./book
	cp ./remote/book.json ./book
	gitbook build ./book ./dist/book
	tar -cvzf ./dist/book.tar.gz ./dist/book/
	rm -rf ./book #./source

    
.PHONY: main
