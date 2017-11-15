#!/bin/bash

sudo yum remove docker docker-engine docker.io -y

a=$(cat << EOA
[ol7_addons]
name=Oracle Linux \$releasever Add ons (\$basearch)
baseurl=http://yum.oracle.com/repo/OracleLinux/OL7/addons/\$basearch/
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-oracle
gpgcheck=1
enabled=0
EOA
)

b=$(cat << EOB
[ol7_addons]
name=Oracle Linux \$releasever Add ons (\$basearch)
baseurl=http://yum.oracle.com/repo/OracleLinux/OL7/addons/\$basearch/
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-oracle
gpgcheck=1
enabled=1
EOB
)

input=$(cat /etc/yum.repos.d/public-yum-ol7.repo)
output=${input//"$a"/"$b"}

# enable [ol7_addons]
echo "$output" > /etc/yum.repos.d/public-yum-ol7.repo

sudo yum install docker-engine -y