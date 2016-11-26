# pull base image
FROM elasticsearch:5.0

ENV ES_JAVA_OPTS="-Xms1g -Xmx1g"

VOLUME /usr/share/elasticsearch/

EXPOSE 9200 9300
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["elasticsearch"]