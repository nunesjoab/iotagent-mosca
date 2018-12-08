FROM node:8.14.0-alpine

RUN apk --no-cache add git gcc g++ musl-dev make python bash zlib-dev

WORKDIR /opt

# the following is required for mosca to install correctly

RUN apk update \
	&& apk add -y --no-install-recommends py-openssl py-pip \
	&& pip install requests kafka\
	&& rm -rf /var/lib/apt/lists/*

ADD ./*.json /opt/

#Create dir for allocate tls auth files
RUN mkdir -p /opt/mosca/certs/

RUN npm install
ADD . /opt/



EXPOSE 8883
EXPOSE 1883
CMD ["/opt/entrypoint.sh"]
