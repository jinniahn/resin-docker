build: Dockerfile
	sudo docker build --tag resin:3.1.16 .

run:
	sudo docker run --rm -p 8080:8080 --name test-resin resin:3.1.16

console:
	sudo docker run --rm -it --name console  --entrypoint=bash resin:3.1.16
