#!/bin/bash

set -e
CONFIG_FILE=/usr/share/elasticsearch/config/elasticsearch.yml

# Add elasticsearch as command if needed
if [ "${1:0:1}" = '-' ]; then
	set -- elasticsearch "$@"
fi

# Drop root privileges if we are running elasticsearch
# allow the container to be started with `--user`
if [ "$1" = 'elasticsearch' -a "$(id -u)" = '0' ]; then
	# Change the ownership of /usr/share/elasticsearch/data to elasticsearch
	chown -R elasticsearch:elasticsearch /usr/share/elasticsearch/data
	
	set -- gosu elasticsearch "$@"
	#exec gosu elasticsearch "$BASH_SOURCE" "$@"
fi

# =============================================================================
echo "bootstrap.memory_lock: true"                          >   $CONFIG_FILE
echo "indices.fielddata.cache.size: 75%"                    >>  $CONFIG_FILE
echo "network.host: _eth0:ipv4_"                            >>  $CONFIG_FILE


if [ ! "$CLUSTER_HOST" ];then
	echo "Discovery Zen Ping Unicast Hosts"
	echo "discovery.zen.ping.unicast.hosts: "${CLUSTER_HOST}"" >>  $CONFIG_FILE
fi
# =============================================================================
if [ ! -n "$CLUSTER_NAME" ];then
	echo "Default CLUSTER_NAME : elasticsearch"
	echo "cluster.name: elasticsearch" >>  $CONFIG_FILE
else
	echo "cluster.name: $CLUSTER_NAME" >>  $CONFIG_FILE
fi
# =============================================================================
if [ ! -n "$NODE_NAME" ];then
	echo "Default NODE_NAME : random"
else
	echo "node.name: $NODE_NAME"       >> $CONFIG_FILE
fi

echo =-------------------------------------------------------------------------
cat $CONFIG_FILE
echo =-------------------------------------------------------------------------

# As argument is not related to elasticsearch,
# then assume that user wants to run his own process,
# for example a `bash` shell to explore this image
exec "$@"