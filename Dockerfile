FROM quay.io/coreos/etcd:v3.3

RUN apk add --update \
        py-pip \
		bash \
    && pip install \
        awscli \
    && rm -rf /var/cache/apk/*

ENV \
    ETCDCTL_API=3 \
    ETCDCTL_CERT=/etc/kubernetes/secrets/etcd-client.crt \
    ETCDCTL_KEY=/etc/kubernetes/secrets/etcd-client.key \
    ETCDCTL_CACERT=/etc/kubernetes/secrets/etcd-client-ca.crt

COPY ./snapshot.sh /app/snapshot.sh
RUN chmod 755 /app/snapshot.sh
WORKDIR /app

CMD ["/app/snapshot.sh"]
