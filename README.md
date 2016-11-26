# elasticsearch 5.0

[Install Elasticsearch on Windows | Elasticsearch Reference [5.0] | Elastic](https://www.elastic.co/guide/en/elasticsearch/reference/5.0/windows.html#windows-configuring "Install Elasticsearch on Windows | Elasticsearch Reference [5.0] | Elastic")

```
./bin/elasticsearch \
    -Ecluster.name=my_cluster \
    -Enode.name=node_1 \
    -Enode.attr.rack=DC1 \
    -Ediscovery.zen.ping.unicast.hosts="['192.168.0.1', '192.168.0.2']" \
    -Ediscovery.zen.minimum_master_nodes=3
```

| Value | Description |
|:------|:------------|
| `cluster.name` | Cluster Name |
| `node.name` | Node Name |
| `node.attr.rack` | Node Attr Rack |
| `discovery.zen.ping.unicast.hosts` | discovery zen ping unicast hosts |
| `discovery.zen.minimum_master_nodes` | discovery zen minimum_master_nodes |