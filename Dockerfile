FROM ubuntu:trusty

RUN \
	apt-get update && \
	apt-get -y install curl && \
	curl http://archive.apache.org/dist/activemq/apache-activemq/5.9.0/apache-activemq-5.9.0-bin.tar.gz | tar -xz
	
RUN apt-get -y install openjdk-7-jre 

RUN curl https://jdbc.postgresql.org/download/postgresql-9.3-1103.jdbc41.jar -o apache-activemq-5.9.0/lib/postgresql-9.3-1103.jdbc41.jar

EXPOSE 61616 8161

ADD files/run.sh apache-activemq-5.9.0/bin/
ADD files/activemq.xml apache-activemq-5.9.0/conf/


CMD apache-activemq-5.9.0/bin/run.sh

