#!/bin/bash
HOST=$(hostname -f)
DATE=$(date +"%d%m%Y-%H%M%S")
LOGFILE="/tmp/ag_ub_wg_${HOST}_${DATE}.log"
ARCH=$(sudo dpkg --print-architecture)
REPO_LIST=$(grep -Erh ^deb /etc/apt/sources.list*)

function os_actions() {
    # Prereqs and docker
    # 
    echo "starting os pre-requisites..." | tee -a $LOGFILE
    sudo apt-get update && sudo apt-get -yyq upgrade &&
        sudo apt-get install -yqq \
            curl \
            git \
            unzip \
            apt-transport-https \
            ca-certificates \
            gnupg-agent \
            software-properties-common | tee -a $LOGFILE

    # Install Docker repository and keys
    
    if [[ "$REPO_LIST" == *"docker"* ]];then
        :
    else
        curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
        sudo add-apt-repository \
            "deb [arch=${ARCH}] https://download.docker.com/linux/ubuntu \
                $(lsb_release -cs) \
                stable"
    fi
    echo "installing docker ..." | tee -a $LOGFILE
    sudo apt-get update && sudo apt-get install -yqq docker-ce docker-ce-cli containerd.io docker-compose -yqq | tee -a $LOGFILE
    
# 
}

function docker_actions() {
    if [[ -f $HOME/docker-adguard-unbound-wireguard.zip ]];then
        unzip -o $HOME/docker-adguard-unbound-wireguard.zip -d /home/ubuntu
        if [[ -d $HOME/docker-adguard-unbound-wireguard ]];then
            cd $HOME/docker-adguard-unbound-wireguard 
            if [[ "$ARCH" == *"arm"* ]];then
                sed -i 's/image: \"mvance\/unbound:latest\"/image: \"mvance\/unbound-rpi:latest\"/g' docker-compose.yml
                # sed -i 's/\/opt\/unbound\/etc\/unbound/\/etc\/unbound/g' docker-compose.yml
                # sed -i 's/\/opt\/unbound\/etc\/unbound/\/etc\/unbound/g' unbound/unbound.conf
            fi
            sudo docker-compose up -d 
            echo "sleeping till all containers and services  are up ..."
            sleep 50
            sudo docker logs wireguard
            if [[ $? -eq 0 ]];then
                echo "***********************"
                echo "1.Now configure wireguard vpn by scanning the QR code above"
                echo "2.Once connected, access AdGuard Home at http://10.2.0.100/admin"
            fi
        fi
    fi
}


function publish_log() {
    if [[ -f $LOGFILE ]];then
        oci os object put -bn ADGUARD_BUCKET --file $LOGFILE --auth instance_principal
        if [[ $? -eq 0 ]];then
            echo "successfully uploaded the log $LOGFILE ..."
        else
            echo "failed to upload log file $LOGFILE"
        fi
    fi
}

while true;do
    CHECK=$(ps -ef | grep -i apt | grep -v grep)
    if [[ ! -z $CHECK ]];then
        echo "waiting for apt to clear the lock"
        sleep 5
    else
        os_actions
        docker_actions
        break
    fi
done