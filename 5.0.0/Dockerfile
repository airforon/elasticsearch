FROM elasticsearch:5.5.2

MAINTAINER HomeSOC <github@homesoc.tokyo>

# Environment variable
ARG TIMEZONE=Asia/Tokyo

ENV ES_JAVA_OPTS="-Xms1g -Xmx1g"
ENV TZ='Asia/Tokyo'

RUN \
    # TIMEZONE
       apt update -y \
    && apt upgrade -y \
    && apt-get install -y \
          tzdata \
    \
    && bin/elasticsearch-plugin install analysis-icu \
    && bin/elasticsearch-plugin install analysis-kuromoji \
    && bin/elasticsearch-plugin install --batch x-pack \
    && echo "### x-pack functions" >> /usr/share/elasticsearch/config/elasticsearch.yml \
    && echo "xpack.graph.enabled: false" >> /usr/share/elasticsearch/config/elasticsearch.yml \
    && echo "xpack.ml.enabled: false" >> /usr/share/elasticsearch/config/elasticsearch.yml \
    && echo "xpack.monitoring.enabled: true" >> /usr/share/elasticsearch/config/elasticsearch.yml \
    && echo "xpack.security.enabled: false" >> /usr/share/elasticsearch/config/elasticsearch.yml \
    && echo "xpack.watcher.enabled: false" >> /usr/share/elasticsearch/config/elasticsearch.yml \
    \
    # Clean up
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

VOLUME /usr/share/elasticsearch/

COPY ja_userdict.dic /usr/share/elasticsearch/config/analyzer/ja_userdict.dic
EXPOSE 9200 9300
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["elasticsearch"]
