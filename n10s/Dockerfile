FROM openjdk:11-jdk-slim

ENV NEO4J_SHA256=95738119ccc2f6518cc9f57295acf7560dbf90473c87d006d6b508d1971f1b46 \
    NEO4J_TARBALL=neo4j-community-4.0.7-unix.tar.gz \
    NEO4J_EDITION=community \
    NEO4J_HOME="/var/lib/neo4j"
ARG NEO4J_URI=https://dist.neo4j.org/neo4j-community-4.0.7-unix.tar.gz
ARG TINI_SHA256="12d20136605531b09a2c2dac02ccee85e1b874eb322ef6baf7561cd93f93c855"
ARG TINI_URI="https://github.com/krallin/tini/releases/download/v0.18.0/tini"

# use other default uid/gid to be more developer friendly with mount permissions
RUN addgroup --gid 1000 --system neo4j && adduser --uid 1000 --system --no-create-home --home "${NEO4J_HOME}" --ingroup neo4j neo4j

RUN export NEO4J_DEPS=https://raw.githubusercontent.com/neo4j/docker-neo4j-publish/d42c3ac9cde66e2a1dcb3f667fe73878dbf2218c/4.0.7/community/local-package/neo4jlabs-plugins.json \
    && export NEO4J_EP=https://raw.githubusercontent.com/neo4j/docker-neo4j-publish/d42c3ac9cde66e2a1dcb3f667fe73878dbf2218c/4.0.7/community/docker-entrypoint.sh \
    && apt-get update \
    && apt-get install -y curl wget gosu jq \
    && curl -L --fail --silent --show-error ${TINI_URI} > /sbin/tini \
    && echo "${TINI_SHA256}  /sbin/tini" | sha256sum -c --strict --quiet \
    && chmod +x /sbin/tini \
    && curl --fail --silent --show-error --location --remote-name ${NEO4J_URI} \
    && echo "${NEO4J_SHA256}  ${NEO4J_TARBALL}" | sha256sum -c --strict --quiet \
    && tar --extract --file ${NEO4J_TARBALL} --directory /var/lib \
    && mv /var/lib/neo4j-* "${NEO4J_HOME}" \
    && rm ${NEO4J_TARBALL} \
    && mv "${NEO4J_HOME}"/data /data \
    && mv "${NEO4J_HOME}"/logs /logs \
    && chown -R neo4j:neo4j /data \
    && chmod -R 777 /data \
    && chown -R neo4j:neo4j /logs \
    && chmod -R 777 /logs \
    && chown -R neo4j:neo4j "${NEO4J_HOME}" \
    && chmod -R 777 "${NEO4J_HOME}" \
    && ln -s /data "${NEO4J_HOME}"/data \
    && ln -s /logs "${NEO4J_HOME}"/logs \
    && curl --fail --silent --show-error --location --remote-name $NEO4J_DEPS -o /neo4jlabs-plugins.json \
    && curl --fail --silent --show-error --location --remote-name $NEO4J_EP -o /docker-entrypoint.sh \
    && unset NEO4J_DEPS \
    && unset NEO4J_EP \
    && chmod +x /docker-entrypoint.sh \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get -y purge --auto-remove curl

ENV PATH "${NEO4J_HOME}"/bin:$PATH

WORKDIR "${NEO4J_HOME}"

VOLUME /data /logs 
EXPOSE 7474 7473 7687

ENTRYPOINT ["/sbin/tini", "-g", "--", "/docker-entrypoint.sh"]
CMD ["neo4j"]

#ENV NEO4JLABS_PLUGINS '["apoc", "n10s", "graph-data-science", "streams"]'
ENV NEO4JLABS_PLUGINS '["apoc", "n10s", "graph-data-science"]'

VOLUME /var/lib/neo4j/plugins
RUN cd / && /docker-entrypoint.sh echo "Installed plugins: ${NEO4JLABS_PLUGINS}"

# prevent runtime reinstallation of plugins
ENV NEO4JLABS_PLUGINS=

# now set default envvars understood by docker-entrypoint.sh

#ENV NEO4J_dbms_security_procedures_unrestricted 'apoc.*,gds.*,semantics.*,streams.*'
ENV NEO4J_dbms_security_procedures_unrestricted 'apoc.*,gds.*,semantics.*'
ENV NEO4J_dbms_directories_plugins=/var/lib/neo4j/plugins
ENV NEO4J_dbms_memory_pagecache_size 1G
ENV NEO4J_dbms_memory_heap_max__size 4G
ENV NEO4J_apoc_import_file_enabled true
ENV NEO4J_apoc_export_file_enabled true
ENV NEO4J_apoc_import_file_use__neo4j__config true
ENV NEO4J_dbms_unmanaged__extension__classes 'n10s.endpoint=/rdf'

#ENV GDS_VERSION 1.4.1
#ENV GDS_URI https://s3-eu-west-1.amazonaws.com/com.neo4j.graphalgorithms.dist/graph-data-science/neo4j-graph-data-science-${GDS_VERSION}-standalone.jar

#RUN cd plugins && wget $GDS_URI
RUN echo "done"
