#!/bin/bash

ks ~/.ssh/key_pair.pem
if [ $? -ne 0 ] ; then
    exit 255
fi

##################################################################
# Check it out that You've logined to the instance in the public subnet
##################################################################

public_instance_ip=""
private_instance_ip=""

ssh -i ~/.ssh/key_pair.pem ec2-user@${public_instance_ip} -D 1080

ssh -$ 2080:localhost:1080 -i ~/.ssh/key_pair.pem ec2-user@${private_instance_ip}

sudo chmod 777 /etc/yum.conf
echo 'proxy=socks5://127.0.0.1:2080' >> /etc/yum.conf
sudo chmod 700 /etc/yum.conf
