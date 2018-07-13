#.PHONY: deps clean build

# install:
# 	echo "Installing..."
# 	go get github.com/golang/dep/cmd/dep

# deps:
# 	go get -u -v ./...

# clean: 
# 	rm -rf ./checkipaddress/checkipaddress && rm -rf ./checkipaddress/checkipaddress.zip
	
# build: clean
# 	echo "building..."
# 	GOOS=linux GOARCH=amd64 go build -v -o checkipaddress/checkipaddress ./checkipaddress



#NEW
BIN_DIR := $(GOPATH)/bin
DEP := $(BIN_DIR)

# $(DEP):
# 	@echo "Getting DEP"
# 	go get -u github.com/golang/dep/cmd/dep
# 	dep --install &> /dev/null

.PHONY: clean
clean:
	@go clean
	rm -rf ./checkipaddress/checkipaddress && rm -rf ./checkipaddress/checkipaddress.zip

.PHONY: build
build: clean
	@echo "Installing dependencies.."
	#go get -u github.com/golang/dep/cmd/dep
	go get -u -v ./...
	#cd $(HOME)/go go get -u -v ./...

	#dep ensure -v

	@echo "building..."
	GOOS=linux GOARCH=amd64 go build -v -o checkipaddress/checkipaddress ./checkipaddress
	cd checkipaddress && zip checkipaddress.zip checkipaddress



 