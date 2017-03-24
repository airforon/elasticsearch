FROM elasticsearch:alpine

MAINTAINER Tokyo Home SOC <github@homesoc.tokyo>

ENV ES_JAVA_OPTS="-Xms1g -Xmx1g"

RUN \
       bin/elasticsearch-plugin install analysis-kuromoji \
    && bin/elasticsearch-plugin install analysis-icu \
    && bin/elasticsearch-plugin install --batch x-pack \
    && echo "xpack.security.enabled: false" >> /usr/share/elasticsearch/config/elasticsearch.yml \
    && echo "xpack.monitoring.enabled: true" >> /usr/share/elasticsearch/config/elasticsearch.yml \
    && echo "xpack.graph.enabled: false" >> /usr/share/elasticsearch/config/elasticsearch.yml \
    && echo "xpack.watcher.enabled; false" >> /usr/share/elasticsearch/config/elasticsearch.yml \
    && echo "xpack.reporting.enabled: false" >> /usr/share/elasticsearch/config/elasticsearch.yml

VOLUME /usr/share/elasticsearch/

EXPOSE 9200 9300
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["elasticsearch"]