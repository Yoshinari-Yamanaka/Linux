#!/bin/bash

SOURCE_DIR=$(cd $(dirname ${BASH_SOURCE:-$0}) && pwd)

endtime=$(($(date +%s) + 1800))

access_url="https://example.com/*"

policy='{"Statement":[{"Resource":"'${access_url}'","Condition":{"DateLessThan":{"AWS:EpochTime":'${endtime}'}}}]}'


#######################################
# create CloudFront canned URL
#######################################
Policy=$(echo ${policy} | openssl base64 | tr '+=/' '-_~')

Signature=$(echo ${policy} | sed -e 's/\s//g' | openssl sha1 -sign ${SOURCE_DIR}/cloudfront_private_key.pem | openssl base64 | tr '+=/' '-_~')

Key_Pair_Id=""

s3_contents_path="index.html"

echo "${access_url:0:-1}${s3_contents_path}?Policy=${Policy}&Signature=${Signature}&Key-Pair-Id${Key_Pair_Id}"