FROM java:8-jre-alpine

MAINTAINER airforon <github@homesoc.tokyo>

ARG ELASTICSEARCH_VERSION=5.0.0
ARG GOSU_VERSION=1.10
ENV PATH /usr/share/elasticsearch/bin:$PATH

RUN \
           apk add --no-cache bash \
        && apk add --no-cache --virtual .build-elasticsearch \
                        curl \
                        ca-certificates \
                        coreutils \
                        tar \
                        gnupg \
        \
        # grab gosu for easy step-down from root
        && curl -fSL "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-amd64" \
                -o /usr/local/bin/gosu \
        && curl -fSL "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-amd64.asc" \
                -o /usr/local/bin/gosu.asc \
        && export GNUPGHOME="$(mktemp -d)" \
        && gpg --keyserver ha.pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4 \
        && gpg --batch --verify /usr/local/bin/gosu.asc /usr/local/bin/gosu \
        && rm -r "$GNUPGHOME" /usr/local/bin/gosu.asc \
        && chmod +x /usr/local/bin/gosu \
        && gosu nobody true \
        \
        && addgroup -S elasticsearch \
        && adduser -D -S -s /sbin/nologin -G elasticsearch elasticsearch \
        && mkdir -p /usr/src \
        && cd /usr/src \
        && curl -fSL https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-$ELASTICSEARCH_VERSION.tar.gz \
                -o elasticsearch-$ELASTICSEARCH_VERSION.tar.gz \
        && curl -fSL https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-$ELASTICSEARCH_VERSION.tar.gz.sha1 \
                -o elasticsearch-$ELASTICSEARCH_VERSION.tar.gz.sha1 \
        && echo "`cat elasticsearch-$ELASTICSEARCH_VERSION.tar.gz.sha1` *elasticsearch-$ELASTICSEARCH_VERSION.tar.gz" | sha1sum -c - \
        && mkdir -p /usr/share/elasticsearch/data \
        && mkdir -p /usr/share/elasticsearch/logs \
        && mkdir -p /usr/share/elasticsearch/config \
        && mkdir -p /usr/share/elasticsearch/config/scripts \
        && tar xzf /usr/src/elasticsearch-$ELASTICSEARCH_VERSION.tar.gz -C /usr/share/elasticsearch --strip=1 \
        && rm -f /usr/src/elasticsearch-$ELASTICSEARCH_VERSION.tar.gz \
        && chown -R elasticsearch:elasticsearch /usr/share/elasticsearch/ \
        && plugin install discovery-multicast \
        && apk del .build-elasticsearch

WORKDIR /usr/share/elasticsearch
COPY config/elasticsearch.yml /usr/share/elasticsearch/config
COPY docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["elasticsearch"]