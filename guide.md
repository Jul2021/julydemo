# Update Storage Account with new key


az storage account update --name $tfStorageAccount --resource-group $tfStorageResourceGroup --assign-identity


storageAccountPrincipal=$(az storage account show --name $tfStorageAccount --resource-group $tfStorageResourceGroup --query identity.principalId -otsv)

az keyvault set-policy --name $keyVault \
                       --object-id $storageAccountPrincipal \
                       --key-permissions get unWrapKey wrapKey decrypt

az keyvault key create --name $sakey --vault-name $keyVault

keyVaultUri=$(az keyvault show --name $keyVault --resource-group $tfStorageResourceGroup --query properties.vaultUri -otsv)

az storage account update --name $tfStorageAccount --resource-group $tfStorageResourceGroup \
                          --encryption-key-source Microsoft.Keyvault --encryption-key-vault $keyVault\
                          --encryption-key-name $sakey
 


az keyvault storage sas-definition create --vault-name vault --account-name storageacct \
                                          -n rwallserviceaccess --validity-period P2D \
                                          --sas-type account --template-uri $sastoken

