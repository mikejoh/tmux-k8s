# Makefile

GOOS ?= $(shell go env GOOS)

build: tmux-k8s
build-docker: tmux-k8s-docker

tmux-k8s:
	CGO_ENABLED=0 GOOS=$(GOOS) \
	go build \
		-o scripts/tmux-k8s \
		scripts/main.go

tmux-k8s-docker:
	docker run --rm -v "${PWD}":/usr/src/tmux-k8s -w /usr/src/tmux-k8s golang:1.12 go mod download && make build