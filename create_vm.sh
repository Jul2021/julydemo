#!/bin/bash

# This is a script to create a VM in Azure

# THe vars are updated within the same file

RG="Infrabase"
VMNAME="imgtest"
IMAGE="UbuntuLTS"
SIZE="Standard_B1s"
az vm create --name $VMNAME --resource-group $RG --image $IMAGE --size $SIZE
