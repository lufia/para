FROM openjdk:8-jre
MAINTAINER lufia <lufia@lufia.org>

ENV	VERSION=1.25.4 \
	ARCHIVE_URL=https://oss.sonatype.org/service/local/repositories/releases/content/com/erudika

RUN	useradd -s /bin/rbash -u 10000 para && \
	mkdir -p /usr/local/bin && \
	mkdir -p /app/lib && \
	mkdir -p /data && \
	touch /app/para.log /app/para-access.log && \
	touch /app/application.conf && \
	chown -R para /data /app
WORKDIR /app
RUN	curl -L $ARCHIVE_URL/para-war/$VERSION/para-war-$VERSION.war >para.war
ADD install_plugin startup.bash /usr/local/bin/
RUN	chmod +x /usr/local/bin/*

EXPOSE 8080
VOLUME ["/data"]

USER para
CMD ["/usr/local/bin/startup.bash"]
