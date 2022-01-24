FROM eclipse-temurin:17 as jre-build

# Create a custom Java runtime
RUN JAVA_TOOL_OPTIONS="-Djdk.lang.Process.launchMechanism=vfork" $JAVA_HOME/bin/jlink \
         --add-modules ALL-MODULE-PATH \
         --strip-debug \
         --no-man-pages \
         --no-header-files \
         --compress=2 \
         --output /javaruntime

FROM consensys/teku:21.12.1 as teku

FROM ubuntu:21.04

ENV JAVA_HOME=/opt/java/openjdk
ENV PATH "${JAVA_HOME}/bin:${PATH}"
ENV PRYSM_VALIDATOR_VERSION=2.0.1
ENV LIGHTHOUSE_VALIDATOR_VERSION=2.0.1
ENV VAULT_VERSION=1.8.4
ENV DEBIAN_FRONTEND=noninteractive

COPY --from=jre-build /javaruntime $JAVA_HOME
COPY --from=teku /opt/teku /opt/teku

RUN apt update && apt install curl unzip jq -y && rm -rf /var/apt/cache /var/lib/api/lists/*

RUN echo " ---> Install vault CLI" && \
    curl -sSLO "https://releases.hashicorp.com/vault/${VAULT_VERSION}/vault_${VAULT_VERSION}_linux_$(dpkg --print-architecture).zip" && \
    unzip vault_${VAULT_VERSION}_linux_$(dpkg --print-architecture).zip && \
    mv vault /usr/local/bin/vault && \
    rm -rf vault_${VAULT_VERSION}_linux_$(dpkg --print-architecture).zip && \
    rm -rf vault_${VAULT_VERSION}_linux_$(dpkg --print-architecture) && \
    chmod +x /usr/local/bin/vault

RUN echo " ---> Install prysm validator" && \
    curl -sSLO "https://github.com/prysmaticlabs/prysm/releases/download/v${PRYSM_VALIDATOR_VERSION}/validator-v${PRYSM_VALIDATOR_VERSION}-linux-$(dpkg --print-architecture)" && \
    mv validator-v${PRYSM_VALIDATOR_VERSION}-linux-$(dpkg --print-architecture) /usr/local/bin/prysm-validator && \
    chmod +x /usr/local/bin/prysm-validator

RUN echo " ---> Install lighthouse validator" && \
    curl -sSLO "https://github.com/sigp/lighthouse/releases/download/v${LIGHTHOUSE_VALIDATOR_VERSION}/lighthouse-v${LIGHTHOUSE_VALIDATOR_VERSION}-$(uname -i)-unknown-linux-gnu-portable.tar.gz" && \
    tar xzvf lighthouse-v${LIGHTHOUSE_VALIDATOR_VERSION}-$(uname -i)-unknown-linux-gnu-portable.tar.gz && \
    mv lighthouse /usr/local/bin/lighthouse-validator && \
    rm -f lighthouse-v${LIGHTHOUSE_VALIDATOR_VERSION}-$(uname -i)-unknown-linux-gnu-portable.tar.gz && \
    chmod +x /usr/local/bin/lighthouse-validator

RUN rm -f /usr/bin/*less* /usr/bin/*grep* \
          /usr/bin/*more* /usr/bin/*head* \
          /usr/bin/*diff* /usr/bin/*apt*

ENTRYPOINT ["/usr/bin/bash", "/data/scripts/validator-init.sh"]
