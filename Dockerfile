FROM alpine 
RUN apk add py3-pip build-base python3-dev libffi-dev openssl-dev nginx haproxy
RUN mkdir -p /opt/api 
WORKDIR /opt/api 
ADD api/requirements.txt /opt/api 
RUN pip3 install  -r /opt/api/requirements.txt 
ADD api/. /opt/api 

ADD docker-entrypoint.sh /bin/docker-entrypoint.sh
RUN chmod +x /bin/docker-entrypoint.sh
ENV FLASK_APP /opt/api/main.py
ADD haproxy.conf /etc/haproxy/haproxy.cfg 
EXPOSE 80 
ENTRYPOINT ["/bin/docker-entrypoint.sh"]
