#!/bin/bash
HOST=$(hostname -f)
DATE=$(date +"%d%m%Y-%H%M%S")
LOGFILE="/tmp/ag_ub_wg_${HOST}_${DATE}.log"
ARCH=$(sudo dpkg --print-architecture)
function os_actions() {
    # Prereqs and docker
    echo "starting os pre-requisites..." | tee -a $LOGFILE
    sudo apt-get update &&
        sudo apt-get install -yqq \
            curl \
            git \
            unzip \
            apt-transport-https \
            ca-certificates \
            gnupg-agent \
            software-properties-common | tee -a $LOGFILE

    # Install Docker repository and keys
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    # 

    # 
    sudo add-apt-repository \
        "deb [arch=${ARCH}] https://download.docker.com/linux/ubuntu \
            $(lsb_release -cs) \
            stable" &&
        echo "installing docker ..." | tee -a $LOGFILE
        sudo apt-get update &&
        sudo apt-get install docker-ce docker-ce-cli containerd.io -yqq | tee -a $LOGFILE
    
    #    install oci cli
    # echo "installing oci-cli ..." | tee -a $LOGFILE
    # sudo apt-get install build-essential libssl-dev libffi-dev python3-dev python3-venv python3-pip -yqq | tee -a $LOGFILE
    # sudo pip3 install oci-cli | tee -a $LOGFILE
    # oci -v | tee -a $LOGFILE

    # docker-compose
    echo "installing docker-compose ..." | tee -a $LOGFILE
    sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose &&
        sudo chmod +x /usr/local/bin/docker-compose &&
        sudo ln -s -f /usr/local/bin/docker-compose /usr/bin/docker-compose
# 
}

function docker_actions() {
    if [[ -d $HOME/docker-adguard-unbound-wireguard ]];then
        cd $HOME/docker-adguard-unbound-wireguard && sudo docker-compose up -d 
        sleep 20
        sudo docker logs wireguard
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

os_actions
docker_actions

