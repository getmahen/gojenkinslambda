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

.PHONY: test
test:
	@echo "Running unit tests.."
	go test ./... -race -cover -v 2>&1

.PHONY: build
build: clean
	@echo "building..."
	GOOS=linux GOARCH=amd64 go build -v -o checkipaddress/checkipaddress ./checkipaddress

.PHONY: package
package: build
	cd checkipaddress && zip -v checkipaddress.zip checkipaddress

.PHONY: upload
upload: build
	@echo "$(TS_COLOR)$(shell date "+%Y/%m/%d %H:%M:%S")$(NO_COLOR)$(OK_COLOR)==> Deploying Zip to s3$(NO_COLOR)"
	cd checkipaddress
	aws s3 cp checkipaddress.zip s3://credo-dev-lambdas/checkipaddress.zip --metadata GitHash=`git rev-parse HEAD`

 