FROM elasticsearch:5.6.4

LABEL maintainer "Naoki Aoyama<github@homesoc.io>"
LABEL Description="Elasticsearch docker image" Vendor="HomeSOC Organization" Version="1.1"

# Environment variable
ENV XPACK_GRAPH_ENABLED='false'
ENV XPACK_ML_ENABLED='false'
ENV XPACK_MONITORING_ENABLED='true'
ENV XPACK_REPORTING_ENABLED='false'
ENV XPACK_SECURITY_ENABLED='false'
ENV XPACK_WATCHER_ENABLED='false'

ENV ES_JAVA_OPTS="-Xms256m -Xmx256m"

RUN \
       bin/elasticsearch-plugin install analysis-icu \
    && bin/elasticsearch-plugin install analysis-kuromoji \
    && bin/elasticsearch-plugin install --batch x-pack

VOLUME /usr/share/elasticsearch/

COPY ja_userdict.dic /usr/share/elasticsearch/config/analyzer/ja_userdict.dic
EXPOSE 9200 9300
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["elasticsearch"]
