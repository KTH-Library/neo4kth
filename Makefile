#! make

init:
	mkdir -p plugins && cd plugins && wget \
		https://repo1.maven.org/maven2/com/amazonaws/aws-java-sdk-core/1.11.250/aws-java-sdk-core-1.11.250.jar \
		https://repo1.maven.org/maven2/com/amazonaws/aws-java-sdk-s3/1.11.250/aws-java-sdk-s3-1.11.250.jar \
		https://repo1.maven.org/maven2/org/apache/httpcomponents/httpclient/4.5.4/httpclient-4.5.4.jar \
		https://repo1.maven.org/maven2/org/apache/httpcomponents/httpcore/4.4.8/httpcore-4.4.8.jar \
		https://repo1.maven.org/maven2/joda-time/joda-time/2.9.9/joda-time-2.9.9.jar

build:

	docker build --load -t kthb/neo4kth n10s

up:
	mkdir -p vols && docker-compose up -d

down:
	docker-compose down

browse:
	sleep 5 && firefox http://localhost:7474/ &
