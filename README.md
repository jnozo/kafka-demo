Kafka Demo Chart
=====

# What does this chart do?

This chart deploys the following resources:

- Deploys a Kafka cluster using the Strimzi Kakfa Operator.
- Adds three topics:
  - upstream
  - upstream_be
  - upstream_st
- Deploys an `Ingress` for the brokers with `spec.IngressClassName` set to "internal".
- Deploys CMAK (Kafka Manager) using the CMAK Operator which can be exposed on port 80/443.


# Prerequisites

- Helm 3.x
- kcat (optional; for testing)


# How to Deploy

Update the configuration values in [values.yaml](values.yaml) to ones appropriate for your environment, in particular the following values:
- `kafka.clusters.kafka.listeners.[].configuration.bootstrap.host`
- `kafka.clusters.kafka.listeners.[].configuration.brokers.[].host`

These host values should be CNAME records set to the endpoint of ingress controller that manages the `Ingress` resource deployed by this chart.

After making the appropriate configuration updates, run the commands below:

```
# Install
helm dep update
helm install --create-namespace -n kafka-demo my-release-name .

# Uninstall
helm uninstall my-release-name
```


# How was this chart tested?

This chart was tested in AWS EKS. The ingress controller used was the Kubernetes nginx-ingress with the `--enable-ssl-passthrough` flag.


# Known Issues

- Strimzi does not expose Zookeeper so a workaround called [Zookeeper Entrance](https://github.com/scholzj/zoo-entrance) was added to facilitate access for CMAK since this is just a demo chart. This should not be used for any serious workloads.
  - Only the bare minimum templating was done on [these objects](templates/zoo_entrance.yaml).
- Strimzi does not support underscores in `KafkaTopic` names due to Kubernetes limitations. See [values.yaml](values.yaml#L59) for more details.
  - https://github.com/strimzi/strimzi-kafka-operator/issues/2931
  - https://strimzi.io/docs/operators/latest/full/using.html#kafka_topic_naming_conventions
- There is no auth configured for either Kafka or CMAK endpoints out of the box.
- SSL certificates are not configured out of the box. This deployment relies on the built-in self-signed certificates for any TLS endpoints. Adjust your clients accordingly to ignore SSL hostname/cert checking.
- Kafka cluster version is set to 2.8.0 because that appears to be the last semi-supported version by CMAK. The latest version officially supported by CMAK is 2.4.0.
