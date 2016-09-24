# elasticsearch multicast and kopf
## Plugin
	+ elasticsearch-kopf
	+ discovery-multicast

## Environment variable
+ `cluster.name` : ${CLUSTER_NAME}
+ `node.name` : ${NODE_NAME}
+ `node.rack` : ${NODE_RACK}
+ `network.host` : ${NETWORK_HOST}
+ `discovery.zen.ping.unicast.hosts` : ${DISCOVERY_HOST}

```
docker run \
--name es0 \
-p 9200:9200 \
-p 9300:9300 \
-e "CLUSTER_NAME=es" \
-e "NODE_NAME=node0" \
-e "NODE_RACK=es1" \
-e "NETWORK_HOST=172.16.6.199" \
-e "DISCOVERY_HOST='"172.18.15.11","172.18.15.12"'" \
-d es
```