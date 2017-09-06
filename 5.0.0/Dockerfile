FROM elasticsearch:alpine

MAINTAINER Tokyo Home SOC <github@homesoc.tokyo>

# Environment variable
ARG TIMEZONE=Asia/Tokyo

ENV ES_JAVA_OPTS="-Xms1g -Xmx1g"

RUN \
    # TIMEZONE
       apk add --no-cache \
        tzdata \
    && cp /usr/share/zoneinfo/${TIMEZONE} /etc/localtime \
    && apk del tzdata \
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

COPY ja_userdict.dic /usr/share/elasticsearch/config/analyzer/ja_userdict.dic
EXPOSE 9200 9300
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["elasticsearch"]
