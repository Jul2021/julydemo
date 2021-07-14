#!/bin/bash

RG="Infrabase"
VMNAME="imgtest"
IMAGE="UbuntuLTS"
SIZE="Standard_B1s"
az vm create --name $VMNAME --resource-group $RG --image $IMAGE --size $SIZE
