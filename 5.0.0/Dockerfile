# pull base image
FROM elasticsearch:5.0

VOLUME /usr/share/elasticsearch/

EXPOSE 9200 9300
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["elasticsearch"]