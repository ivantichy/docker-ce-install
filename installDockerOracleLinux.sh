#!/bin/bash

#sudo apt-get install yum yum-utils -y
#cd /etc/yum.repos.d/
#sudo wget http://yum.oracle.com/public-yum-ol7.repo
#sudo yum-config-manager --enable /etc/yum.repos.d//public-yum-ol7.repo

sudo yum remove docker docker-engine docker.io -y
# Remove obsolete config. Use daemon.json instead
sudo mv /etc/default/docker /etc/default/doc_ker.bak 2> /dev/null

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
sudo systemctl start docker
sudo systemctl enable docker
