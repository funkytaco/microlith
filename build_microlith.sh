#!/bin/sh
docker rm -f web
docker rm -f soa
echo \*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\* Building MVC Docker image.
docker build -t php-mvc-nginx:latest ./php-mvc/

echo \*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\* Building Microservice Docker image.
docker build -t php-soa-example:latest ./php-soa/

echo \*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\* Running Docker ... name web...
docker run -v `pwd`/php-mvc/:/opt -p 8000:80 -d --name web --hostname=web   -t php-mvc-nginx:latest
echo \*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*  Running Docker ... name soa ..
docker run -v `pwd`/php-soa/:/opt -p 8001:80 -d --name soa --hostname=soa --link web:web -t php-soa-example:latest
