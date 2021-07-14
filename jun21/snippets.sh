az vm list --resource-group ProjectA-RG --query "[].[name, hardwareProfile.vmSize, storageProfile.imageReference.offer ]" --output tsv


az vm list --resource-group ProjectA-RG  \
--query "[].{VMPeru:name, VMbaruvu:hardwareProfile.vmSize, OS:storageProfile.imageReference.offer}" --output table


az vm list --show-details --resource-group ProjectA-RG  \
--query "[].{VMName:name, VMSize:hardwareProfile.vmSize, PrivateIP:privateIps, OS:storageProfile.imageReference.offer}" --output table


az vm list --show-details --resource-group ProjectA-RG  \
--query "[].{VMName:name, State: powerState, VMSize:hardwareProfile.vmSize, PrivateIP:privateIps, OS:storageProfile.imageReference.offer}" --output table



az vm list --show-details --resource-group ProjectA-RG  --query "[?powerState=='VM deallocated']"


az vm list --show-details \
 --resource-group ProjectA-RG \
--query "[?powerState=='VM Running'].{VMName:name, State: powerState, VMSize:hardwareProfile.vmSize, PrivateIP:privateIps, OS:storageProfile.imageReference.offer}" --output table



az vm list --show-details \
 --resource-group ProjectA-RG \
--query "[?storageProfile.imageReference.offer=='UbuntuServer'].{VMName:name, State: powerState, VMSize:hardwareProfile.vmSize, PrivateIP:privateIps, OS:storageProfile.imageReference.offer}" --output table

az vm list --show-details  --resource-group ProjectA-RG --query "[?contains(name, 'bastion')].{VMName:name, State: powerState, VMSize:hardwareProfile.vmSize, PrivateIP:privateIps, OS:storageProfile.imageReference.offer}" --output table


# Find the Virtual Machine sizes in a Regions
az vm list-sizes --location "eastus"  -otable

# Find the Virtual Machine sizes matching a particular number of cores

az vm list-sizes --location "eastus" --query "[? numberOfCores == \`8\`]" -otable
az vm list-sizes --location "eastus" --query "[? numberOfCores >= \`8\`]" -otable



az vm list-sizes --location "eastus" --query "[? numberOfCores >= \`8\` && memoryInMb == "8192"]" -otable

az vm list-sizes --location "eastus" --query "[? numberOfCores >= \`2\` && memoryInMb == \`8192\`]" -otable
