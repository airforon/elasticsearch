FROM elasticsearch:alpine

MAINTAINER Tokyo Home SOC <github@homesoc.tokyo>

ENV ES_JAVA_OPTS="-Xms1g -Xmx1g"

RUN \
       bin/elasticsearch-plugin install analysis-kuromoji \
    && bin/elasticsearch-plugin install analysis-icu

VOLUME /usr/share/elasticsearch/

EXPOSE 9200 9300
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["elasticsearch"]