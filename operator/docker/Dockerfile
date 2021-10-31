FROM ubuntu:21.04

ENV HVAC_VERSION=0.11.2
ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install python3-pip -y && rm -rf /var/apt/cache && pip3 install hvac==${HVAC_VERSION}

RUN rm -f /usr/bin/*sh* /usr/bin/*cat* /usr/bin/*less* /usr/bin/*grep* \
          /usr/bin/*more* /usr/bin/*sed* /usr/bin/*ls* /usr/bin/*head* \
          /usr/bin/*diff* /usr/bin/awk /usr/bin/*apt*

CMD ["/usr/bin/python3.9", "/data/scripts/validator-init.py"]
