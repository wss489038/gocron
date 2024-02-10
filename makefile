GO111MODULE=on

.PHONY: build
build: gocron node

.PHONY: build-race
build-race: enable-race build

.PHONY: run
run: build kill
	./bin/gocron-node &
	./bin/gocron web -e dev

.PHONY: run-race
run-race: enable-race run

.PHONY: kill
kill:
	-killall gocron-node

.PHONY: gocron
gocron:
	go build $(RACE) -o bin/gocron ./cmd/gocron

.PHONY: node
node:
	go build $(RACE) -o bin/gocron-node ./cmd/node

.PHONY: test
test:
	go test $(RACE) ./...

.PHONY: test-race
test-race: enable-race test

.PHONY: enable-race
enable-race:
	$(eval RACE = -race)

# 本地编译
.PHONY: package
package: build-vue statik
	bash ./package.sh

# 交叉编译 amd64, armv7l, arm64, riscv64

# amd64 (x86_64)
# Go环境变量:GOAMD64=v1
.PHONY: package-amd64
package-amd64: build-vue statik
	bash ./package-amd64.sh

# armv7l (armv7)
# Go环境变量:GOARM=7
.PHONY: package-armv7l
package-armv7l: build-vue statik
	bash ./package-armv7l.sh

# arm64 (aarch64)
# 最低要求:ARMv8-A
.PHONY: package-arm64
package-arm64: build-vue statik
	bash ./package-arm64.sh

# riscv64
# 最低要求:rv64g (rv64imafd)
.PHONY: package-riscv64
package-riscv64: build-vue statik
	bash ./package-riscv64.sh

# 无法使用, 需分开配置对应的交叉编译工具链
# .PHONY: package-all
# package-all: build-vue statik
# 	bash ./package.sh -p 'linux darwin windows'

.PHONY: build-vue
build-vue:
	cd web/vue && yarn run build
	cp -r web/vue/dist/* web/public/

.PHONY: install-vue
install-vue:
	cd web/vue && yarn install

.PHONY: run-vue
run-vue:
	cd web/vue && yarn run dev

.PHONY: statik
statik:
	go install github.com/rakyll/statik
	go generate ./...

.PHONY: lint
	golangci-lint run

.PHONY: clean
clean:
	rm bin/gocron
	rm bin/gocron-node
