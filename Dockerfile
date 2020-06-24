FROM docker.io/library/centos:latest
RUN yum install java python38 gcc wget tar -y
RUN useradd -m -U -d /opt/tomcat -s /bin/false tomcat
RUN wget https://ftp.wayne.edu/apache/tomcat/tomcat-9/v9.0.36/bin/apache-tomcat-9.0.36.tar.gz
RUN tar -xvf apache-tomcat-9.0.36.tar.gz
RUN mv apache-tomcat-9.0.36 /usr/local/tomcat9
RUN chown -R tomcat:tomcat /usr/local/tomcat9
RUN /usr/local/tomcat9/bin/startup.sh
RUN mkdir /usr/local/tomcat9/webapps/uptime/
ADD exercise.py /root/exercise.py
ADD exercise.exe /root/exercise.exe
RUN chmod 755 /root/exercise.py
RUN chmod 755 /root/exercise.exe
#ADD secrets-entrypoint.sh /
#RUN chmod 755 /secrets-entrypoint.sh
#ENTRYPOINT ["/secrets-entrypoint.sh"]
CMD ["python3.8", "/root/exercise.py"]
