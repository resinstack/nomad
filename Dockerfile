FROM debian:buster-slim
ARG nomad_version=1.3.3
ARG cni_version=1.0.1
WORKDIR /
RUN apt-get update && \
apt-get -y install curl unzip iptables iproute2 && \
        curl -o nomad.zip https://releases.hashicorp.com/nomad/${nomad_version}/nomad_${nomad_version}_linux_amd64.zip && \
        unzip nomad.zip && \
        rm nomad.zip && \
        mv nomad /usr/local/bin && \
        curl -L -o cni-plugins.tgz https://github.com/containernetworking/plugins/releases/download/v${cni_version}/cni-plugins-linux-amd64-v${cni_version}.tgz && \
        mkdir -p /usr/libexec/cni && \
        tar -xvzf cni-plugins.tgz -C /usr/libexec/cni && \
        rm cni-plugins.tgz && \
        apt-get -y remove curl unzip  && \
        apt-get -y autoremove && \
        rm -rf /var/cache/apt

LABEL org.opencontainers.image.source https://github.com/resinstack/nomad
ENTRYPOINT ["/usr/local/bin/nomad"]
