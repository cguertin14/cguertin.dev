.PHONY: src nginx

default: build

build:
	@docker build -t cguertz/cguertin.dev .

dev:
	@hugo serve --source=./src -D