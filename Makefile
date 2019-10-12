NAME=dev

.SILENT:

all: run

build:
	docker build -t $(NAME) $(OPTS) .

run: build
	docker run -it --rm $(NAME) bash

test: build
	docker run -it --rm $(NAME) goss -g /util/goss.yaml validate
