.PHONY: docker clean docker-push

docker: consul webui nomad
	docker build -t brimstone/nomadconsul:$(shell git describe --always --tags --dirty).

docker-push:
	@docker login -e="${DOCKER_EMAIL}" -u="${DOCKER_USERNAME}" -p="${DOCKER_PASSWORD}"
	docker push brimstone/nomadconsul

travis: docker docker-push

consul:
	wget https://releases.hashicorp.com/consul/0.6.3/consul_0.6.3_linux_amd64.zip
	unzip -o consul_0.6.3_linux_amd64.zip
	rm consul_0.6.3_linux_amd64.zip 

webui:
	mkdir webui
	wget https://releases.hashicorp.com/consul/0.6.3/consul_0.6.3_web_ui.zip
	cd webui; unzip -o ../consul_0.6.3_web_ui.zip
	rm consul_0.6.3_web_ui.zip

nomad:
	tar c src \
	| docker run --rm -i -e TAR=1 brimstone/golang-musl github.com/hashicorp/nomad \
	| tar -x ./nomad

clean:
	-rm -rf webui
	-rm -rf consul
	-rm -rf nomad
