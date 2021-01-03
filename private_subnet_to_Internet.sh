#!/bin/bash

ls ~/.ssh/key_pair.pem
if [ $? -ne 0 ] ; then
    exit 255
fi

##################################################################
# Check it out that You've logined to the instance in the public subnet
##################################################################

public_instance_ip=""
private_instance_ip=""

ssh -i ~/.ssh/key_pair.pem ec2-user@${public_instance_ip} -D 1080

ssh -R 2080:localhost:1080 -i ~/.ssh/key_pair.pem ec2-user@${private_instance_ip}

sudo chmod 777 /etc/yum.conf
echo 'proxy=socks5://127.0.0.1:2080' >> /etc/yum.conf
sudo chmod 700 /etc/yum.conf

################################
# On the Local Client like PC
# Use "Local Port Forwarding"
################################
public_instance_global_ip=""
ssh -i ~/.ssh/key_pair.pem ec2-user@${public_instance_global_ip} -L 8080:${private_instance_ip}:80

# you can access private instance on your Browser like this
# http://localhost:8080
