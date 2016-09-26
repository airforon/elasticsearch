FROM elasticsearch:latest

MAINTAINER airforon <github@air-foron.com>

COPY config/elasticsearch.yml /usr/share/elasticsearch/config

RUN \
	   plugin install lmenezes/elasticsearch-kopf/master \
	&& plugin install discovery-multicast
#	&& chown -R elasticsearch:elasticsearch /usr/share/elasticsearch/config/elasticsearch.yml


COPY docker-entrypoint.sh /

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["elasticsearch"]