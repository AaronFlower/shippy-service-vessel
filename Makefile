PROJ_PATH = $(GOPATH)/src/github.com/aaronflower/dzone-shipping
build:
	protoc -I. --go_out=plugins=micro:$(PROJ_PATH)/service.vessel proto/vessel/vessel.proto
	GOOS=linux GOARCH=amd64 go build -o service.vessel
	docker build --rm -t service.vessel .

run:
	docker run -p 50052:50051  \
		-e MICRO_SERVER_ADDRESS=:50051 \
		-e MICRO_REGISTRY=mdns service.vessel
	
clean:
	go clean
	rm service.vessel
