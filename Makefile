PROJ_PATH = $(GOPATH)/src/github.com/aaronflower/shippy-service-vessel
build:
	protoc -I. --go_out=plugins=micro:$(PROJ_PATH) proto/vessel/vessel.proto
	GOOS=linux GOARCH=amd64 go build -o service.vessel
	docker build --rm -t service.vessel .

run:
	docker run --net="host" \
		-p 50053 \
		-e MICRO_SERVER_ADDRESS=:50053 \
		-e MICRO_REGISTRY=mdns service.vessel
	
clean:
	go clean
	rm service.vessel
