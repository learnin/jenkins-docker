FROM jenkins:2.7.1

COPY plugins.txt /usr/share/jenkins/
RUN /usr/local/bin/plugins.sh /usr/share/jenkins/plugins.txt
