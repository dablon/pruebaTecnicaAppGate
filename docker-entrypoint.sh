#!/bin/sh
echo"Starting gunicorn..."
gunicorn -w 5 -b 127.0.0.1:9000 main:app --daemon
#gunicorn --chdir app app:app -w 2 --threads 2 -b 0.0.0.0:80
# gunicorn --chdir app main:app -w 2 --threads 2 -b 0.0.0.0:8000

sleep 3
echo"Starting haproxy..."
# haproxy
# cat /etc/haproxy/haproxy.cfg
haproxy -f "/etc/haproxy/haproxy.cfg" 
