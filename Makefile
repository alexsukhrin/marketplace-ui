build:
	docker buildx build --platform linux/amd64 -t alexandrvirtual/flutter-web-app:latest --push .

login:
	docker login

tag:
	docker tag flutter-web-app alexandrvirtual/flutter-web-app:latest

push:
	docker push alexandrvirtual/flutter-web-app:latest

pull:
	docker pull alexandrvirtual/flutter-web-app:latest

run:
	docker run --restart=on-failure:3 -d -it -p 80:80 --name flutter-web-app alexandrvirtual/flutter-web-app:latest
