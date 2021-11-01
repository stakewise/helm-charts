FROM python:3-alpine

ENV HVAC_VERSION=0.11.2

RUN pip3 install hvac==${HVAC_VERSION}

RUN rm -f /usr/bin/*sh* /usr/bin/*cat* /usr/bin/*less* /usr/bin/*grep* \
          /usr/bin/*more* /usr/bin/*sed* /usr/bin/*ls* /usr/bin/*head* \
          /usr/bin/*diff* /usr/bin/awk /usr/bin/*apt*

CMD ["python", "/data/scripts/validator-init.py"]
