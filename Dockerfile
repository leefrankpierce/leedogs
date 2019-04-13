FROM centos
MAINTAINER “Lee Pierce" <lee.pierce@aa.com>
run yum -y update
run yum -y install openssh-clients 
run yum -y install postfix 
run yum -y install telnet 
run yum -y install mailx
run yum -y install wget
RUN chmod 777 /opt; \
    groupadd tomcat; useradd --home-dir /opt/tomcat --create-home --shell /bin/bash -g tomcat  -p Tomcat123 tomcat; 
USER tomcat
#COPY ./openjdk-11.0.1_linux-x64_bin.tar /opt
#COPY ./apache-tomcat-9.0.12.tar /opt
WORKDIR /opt 
RUN     wget -q https://download.java.net/java/GA/jdk11/9/GPL/openjdk-11.0.2_linux-x64_bin.tar.gz; gunzip openjdk-11.0.2_linux-x64_bin.tar.gz; tar xvfp openjdk-11.0.2_linux-x64_bin.tar; rm openjdk-11.0.2_linux-x64_bin.tar; \ 
    	wget -q http://mirror.metrocast.net/apache/tomcat/tomcat-9/v9.0.16/bin/apache-tomcat-9.0.16.tar.gz; gunzip apache-tomcat-9.0.16.tar; tar xvfp apache-tomcat-9.0.16.tar; rm apache-tomcat-9.0.16.tar
USER root
RUN chmod -R +rX .; chmod 777 /opt/apache-tomcat-9.0.16/logs
USER tomcat
COPY ./webapp /opt/apache-tomcat-9.0.16/webapps/webapp
ENV JRE_HOME=/opt/jdk-11.0.2
ENV CATALINA_BASE=/opt/apache-tomcat-9.0.16
CMD ["/opt/apache-tomcat-9.0.16/bin/catalina.sh","run"]
EXPOSE 8080
