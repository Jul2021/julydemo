#!/bin/bash

sps=$(az ad sp list --query "[?appOwnerTenantId=='6acd597a-76b5-4908-ab09-f0180c308d3e'].{ObjectID:objectId}" -otsv 2> /dev/null)

for sp in $sps
do
	az ad sp delete --id $sp
done
