FROM ubuntu:16.04 as builder
RUN apt-get update 
RUN apt-get install -y wget
RUN apt-get install -y build-essential default-jdk libssl-dev
RUN mkdir /working; \
	cd /working; \
	wget http://caucho.com/download/resin-3.1.16.tar.gz; \
	tar xvfz resin-3.1.16.tar.gz; \
	cd resin-3.1.16; \
	./configure; \
	make; \
	make install

FROM ubuntu:16.04
RUN apt-get update
RUN	apt-get install -y default-jdk libssl-dev

RUN mkdir /resin
WORKDIR /resin
COPY --from=builder /working/resin-3.1.16/bin/ bin/
COPY --from=builder /working/resin-3.1.16/conf/ conf/
COPY --from=builder /working/resin-3.1.16/lib/ lib/
COPY --from=builder /working/resin-3.1.16/webapps webapps/

ENV PORT 8000                         
VOLUME ["/resin/webapps", "/resin/conf"]

WORKDIR /resin
ENTRYPOINT ["bin/httpd.sh"]
