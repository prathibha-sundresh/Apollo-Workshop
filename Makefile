GIT_COMMIT:=$(shell git rev-parse --short HEAD)

.PHONY: build
build :Dockerfile
	docker build -t prathisuni/apollo-workshop .

.PHONY: push
push: build
	docker tag prathisuni/apollo-workshop prathisuni/apollo-workshop:$(GIT_COMMIT)
	docker push prathisuni/apollo-workshop:$(GIT_COMMIT)

.PHONY: test
test: build
	bin/apollo vaildate

.PHONY:deploy
deploy: push
	bin/apollo deploy -e production -m bikroy -t $(GIT_COMMIT)
