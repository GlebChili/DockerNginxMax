#!/bin/bash

echo "Starting NGINX..."

/usr/local/nginx/nginx -c /app/nginx.conf

ret=$?

if [ $ret -ne 0 ]
then 
    exit $ret
fi

echo "NGINX is running..."

pid="$(cat /usr/local/nginx/nginx.pid)"

tail --pid=$pid -f /dev/null