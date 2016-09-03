ROOT = $(dir $(abspath $(lastword $(MAKEFILE_LIST))))

default: build

$(ROOT)Dockerfile: $(ROOT)Dockerfile.PL
	$(ROOT)Dockerfile.PL

build: $(ROOT)Dockerfile
	docker-compose -f $(ROOT)docker-compose.yml up --build -d

shell: build
	docker-compose -f $(ROOT)docker-compose.yml run --rm code /bin/bash

test: build
	docker-compose -f $(ROOT)docker-compose.yml run --rm code /bin/sh -c 'perl Makefile.PL && make test TEST_VERBOSE=1'

clean:
	docker-compose -f $(ROOT)docker-compose.yml down
	rm $(ROOT)Dockerfile

realclean: clean
	docker-compose -f $(ROOT)docker-compose.yml down --rmi local --volumes --remove-orphans

