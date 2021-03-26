# neo4j with n10s, apoc and graph-data-science

Run `make build` and start the server with "docker-compose up -d".

Open http://localhost:7474/browser and login with credentials neo4j / password.

## Custom Dockerfile

The custom Dockerfile is used to preinstall apoc, neosemantics (n10s) and graph-data-science functionality.

Use this statement to check that plugins have loaded:

		CALL dbms.procedures()

## TODO

See https://neo4j.com/labs/apoc/4.1/import/web-apis/#_using_s3_protocol for adding S3 protocol support:

https://repo1.maven.org/maven2/com/amazonaws/aws-java-sdk-core/1.11.250/aws-java-sdk-core-1.11.250.jar
https://repo1.maven.org/maven2/com/amazonaws/aws-java-sdk-s3/1.11.250/aws-java-sdk-s3-1.11.250.jar
https://repo1.maven.org/maven2/org/apache/httpcomponents/httpclient/4.5.4/httpclient-4.5.4.jar
https://repo1.maven.org/maven2/org/apache/httpcomponents/httpcore/4.4.8/httpcore-4.4.8.jar
https://repo1.maven.org/maven2/joda-time/joda-time/2.9.9/joda-time-2.9.9.jar
