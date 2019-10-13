NAME=dev
USER=ksaito
VOLUME=$(NAME)_$(USER):/home/$(USER):cached

.SILENT:

all: run

build:
	docker build $(OPTS) --build-arg user=$(USER) -t $(NAME) $(OPTS) .
	docker run --rm -v $(VOLUME) -u root $(NAME) bash -c "touch .setup && chown -R ksaito:ksaito ."

up:
	-docker-compose rm -s -f
	docker-compose up -d

exec:
	docker-compose exec -u ksaito dev bash -l

run:
	docker run --rm -v $(VOLUME) -it $(NAME) bash

.venv:
	@echo Setup python venv
	python3 -m venv .venv
	$(MAKE) pipupgrade

pipupgrade:
	. .venv/bin/activate; pip install -U pip; pip install -r requirements.txt
