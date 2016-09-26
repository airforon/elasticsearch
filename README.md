# elasticsearch multicast and kopf
## Plugin
	+ elasticsearch-kopf
	+ discovery-multicast

## Environment variable
| Name | variable | Default |
| :----|:---------|:------------|
| `cluster.name` | ${CLUSTER_NAME} | 
| `node.name` | ${NODE_NAME} |
| `node.rack` | ${NODE_RACK} |

```
docker run \
--name es0 \
-p 9200:9200 \
-p 9300:9300 \
-e "CLUSTER_NAME=es" \
-e "NODE_NAME=node0" \
-e "NODE_RACK=es1" \
-d airforon/elasticsearch
```