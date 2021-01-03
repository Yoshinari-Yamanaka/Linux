#!/bin/bash

PORT=80

function response() 
{
    echo "HTTP/1.0 200 OK"
    echo "Content-Type: application/json"
    echo ""
    echo '{"message" : "OK"}'
}

while true; do
    response | sudo nc -l ${PORT} -w 10
done
