FROM elasticsearch:alpine

MAINTAINER Tokyo Home SOC <github@homesoc.tokyo>

# Environment variable
ARG TIMEZONE=Asia/Tokyo
ARG JOLOKIA_VERSION=1.3.5

ENV ES_JAVA_OPTS="-Xms1g -Xmx1g -javaagent:/opt/jolokia/jolokia-jvm-agent.jar=port=8778,host=0.0.0.0"

RUN \
    # TIMEZONE
       apk add --no-cache \
        tzdata \
    && cp /usr/share/zoneinfo/${TIMEZONE} /etc/localtime \
    && apk del tzdata \
    \
    && apk add --no-cache --virtual .jolokia-deps \
            curl \
    && mkdir -p /opt/jolokia/ \
    && curl -fSL https://repo1.maven.org/maven2/org/jolokia/jolokia-jvm/${JOLOKIA_VERSION}/jolokia-jvm-${JOLOKIA_VERSION}-agent.jar \
        -o /opt/jolokia/jolokia-jvm-agent.jar \
    && apk del .jolokia-deps \
    \
    && bin/elasticsearch-plugin install analysis-kuromoji \
    && bin/elasticsearch-plugin install analysis-icu \
    && bin/elasticsearch-plugin install --batch x-pack \
    && echo "### x-pack functions" >> /usr/share/elasticsearch/config/elasticsearch.yml \
    && echo "xpack.security.enabled: false" >> /usr/share/elasticsearch/config/elasticsearch.yml \
    && echo "xpack.monitoring.enabled: true" >> /usr/share/elasticsearch/config/elasticsearch.yml \
    && echo "xpack.graph.enabled: false" >> /usr/share/elasticsearch/config/elasticsearch.yml \
    && echo "xpack.watcher.enabled: false" >> /usr/share/elasticsearch/config/elasticsearch.yml

VOLUME /usr/share/elasticsearch/

EXPOSE 9200 9300 8778/tcp
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["elasticsearch"]