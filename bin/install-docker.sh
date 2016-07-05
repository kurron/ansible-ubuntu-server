#!/bin/bash

if [ "$1" = "" ]
then
 echo "Usage: $0 username host-ip host-name"
 exit
fi


if [ "$2" = "" ]
then
 echo "Usage: $0 username host-ip host-name"
 exit
fi

if [ "$3" = "" ]
then
 echo "Usage: $0 username host-ip host-name"
 exit
fi

USERNAME=$1
HOST=$2
MACHINE_NAME=$3

# Uses Docker Machine to install Docker
docker-machine create \
               --driver generic \
               --generic-ip-address=$HOST \
               --generic-ssh-user $USERNAME \
               $MACHINE_NAME
