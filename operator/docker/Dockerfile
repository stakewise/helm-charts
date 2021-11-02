FROM ubuntu:21.04

ENV PRYSM_VALIDATOR_VERSION=2.0.1
ENV LIGHTHOUSE_VALIDATOR_VERSION=2.0.1
ENV VAULT_VERSION=1.8.4
ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install curl unzip jq -y && rm -rf /var/apt/cache

RUN echo " ---> Install vault CLI" && \
    curl -sSLO "https://releases.hashicorp.com/vault/${VAULT_VERSION}/vault_${VAULT_VERSION}_linux_amd64.zip" && \
    unzip vault_${VAULT_VERSION}_linux_amd64.zip && \
    mv vault /usr/local/bin/vault && \
    rm -rf vault_${VAULT_VERSION}_linux_amd64.zip && \
    rm -rf vault_${VAULT_VERSION}_linux_amd64 && \
    chmod +x /usr/local/bin/vault

RUN echo " ---> Install prysm validator" && \
    curl -sSLO "https://github.com/prysmaticlabs/prysm/releases/download/v${PRYSM_VALIDATOR_VERSION}/validator-v${PRYSM_VALIDATOR_VERSION}-linux-amd64" && \
    mv validator-v${PRYSM_VALIDATOR_VERSION}-linux-amd64 /usr/local/bin/prysm-validator && \
    chmod +x /usr/local/bin/prysm-validator

RUN echo " ---> Install lighthouse validator" && \
    curl -sSLO "https://github.com/sigp/lighthouse/releases/download/v${LIGHTHOUSE_VALIDATOR_VERSION}/lighthouse-v${LIGHTHOUSE_VALIDATOR_VERSION}-x86_64-unknown-linux-gnu-portable.tar.gz" && \
    tar xzvf lighthouse-v${LIGHTHOUSE_VALIDATOR_VERSION}-x86_64-unknown-linux-gnu-portable.tar.gz && \
    mv lighthouse /usr/local/bin/lighthouse-validator && \
    rm -f lighthouse-v${LIGHTHOUSE_VALIDATOR_VERSION}-x86_64-unknown-linux-gnu-portable.tar.gz && \
    chmod +x /usr/local/bin/lighthouse-validator

RUN rm -f /usr/bin/sh /usr/bin/*less* /usr/bin/*grep* \
          /usr/bin/*more* /usr/bin/*sed* /usr/bin/*ls* /usr/bin/*head* \
          /usr/bin/*diff* /usr/bin/*apt*

ENTRYPOINT ["/usr/bin/bash", "/data/scripts/validator-init.sh"]
