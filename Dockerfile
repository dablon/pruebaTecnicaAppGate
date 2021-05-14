FROM alpine 
RUN apk add py3-pip build-base python3-dev libffi-dev openssl-dev nginx haproxy
RUN mkdir -p /opt/api 
WORKDIR /opt/api 
ADD api/requirements.txt /opt/api 
RUN ls -la
RUN pip3 install  -r /opt/api/requirements.txt 
ADD api/. /opt/api 
## haproxy
# RUN wget http://us.archive.ubuntu.com/ubuntu/pool/main/a/apt/apt_1.9.3_amd64.deb && dpkg -i apt_1.9.3_amd64.deb
# RUN apt update &&  apt install -y haproxy

ADD docker-entrypoint.sh /bin/docker-entrypoint.sh
RUN chmod +x /bin/docker-entrypoint.sh
ENV FLASK_APP /opt/api/main.py
ADD haproxy.conf /etc/haproxy/haproxy.cfg 
EXPOSE 80 
ENTRYPOINT ["/bin/docker-entrypoint.sh"]
#CMD ["/bin/docker-entrypoint"] 
