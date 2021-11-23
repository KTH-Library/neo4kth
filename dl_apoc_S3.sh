#!/bin/bash

# see https://github.com/neo4j-contrib/neo4j-apoc-procedures/issues/2198
wget -L -O apoc.jar.zip "https://github.com/neo4j-contrib/neo4j-apoc-procedures/files/7184769/apoc-4.0.0.19-all.jar.zip"
unzip apoc.jar.zip
rm apoc.jar.zip
mv apoc-4.0.0.19-all.jar apoc.jar
