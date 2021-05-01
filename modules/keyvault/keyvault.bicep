// Location for all resources.
param location string = resourceGroup().location

param vaultName string = 'keyVault${uniqueString(resourceGroup().id)}' // must be globally unique
param sku string = 'Standard'
param accessPolicies array = []

param enabledForDeployment bool = true
param enabledForTemplateDeployment bool = true
param enabledForDiskEncryption bool = false
param enableRbacAuthorization bool = false
param softDeleteRetentionInDays int = 7

param keyName string = 'prodKey'
param secretName string = 'bankAccountPassword'
param secretValue string = '12345'

param networkAcls object = {
  ipRules: []
  virtualNetworkRules: []
}

resource keyvault 'Microsoft.KeyVault/vaults@2019-09-01' = {
  name: vaultName
  location: location
  properties: {
    tenantId: subscription().tenantId
    sku: {
      family: 'A'
      name: sku
    }
    accessPolicies: accessPolicies
    enabledForDeployment: enabledForDeployment
    enabledForDiskEncryption: enabledForDiskEncryption
    enabledForTemplateDeployment: enabledForTemplateDeployment
    softDeleteRetentionInDays: softDeleteRetentionInDays
    enableRbacAuthorization: enableRbacAuthorization
    networkAcls: networkAcls
  }
}

output kevaultid string = keyvault.id
