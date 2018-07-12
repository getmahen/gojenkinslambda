.PHONY: install deps clean build

install:
	go get github.com/golang/dep/cmd/dep

deps:
	go get -u -v ./...

clean: 
	rm -rf ./checkipaddress/checkipaddress && rm -rf ./checkipaddress/checkipaddress.zip
	
build: clean
	GOOS=linux GOARCH=amd64 go build -v -o checkipaddress/checkipaddress ./checkipaddress
	cd checkipaddress && zip checkipaddress.zip checkipaddress