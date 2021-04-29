//Define Azure Files parmeters
@description('Specifies the Azure location where the resource should be created.')
param location string = resourceGroup().location

@description('Specifies the prefix')
param storagePrefix string = 'prefix'

@description('Specifies the name of the Azure Storage account.')
param storageaccountName string = '${storagePrefix}${uniqueString(resourceGroup().id)}'


@allowed([
  'Standard'
  'Premium'
])
@description('Specifies the name of the Azure Storage account.')
param storageTier string = 'Standard'

@description('Specifies the subnet id to limit traffic from')
param storageSubnet string = ''

var networkAclsOn = {
  bypass: 'AzureServices'
  defaultAction: 'Deny'
  virtualNetworkRules: [
    {
      id: storageSubnet
      action: 'Allow'
    }
  ]
}

var networkAclsOff = {
  defaultAction: 'Allow'
}

@description('Specifies https traffic only to storage service if sets to true')
param httpsTrafficOnly bool = true

@description('Specifies the if HNS is enabled')
param storageHNS bool = false

@description('Specifies the if nfs3 is enabled')
param blobNFS3 bool = false

@allowed([
  'Storage'
  'StorageV2'
  'BlobStorage'
  'FileStorage'
  'BlockBlobStorage'
])
@description('Specifies the kind of the Azure Storage account.')
param storageaccountkind string = 'StorageV2'

@allowed([
  'Standard_LRS'
  'Standard_GRS'
  'Standard_RAGRS'
  'Standard_ZRS'
  'Premium_LRS'
  'Premium_ZRS'
  'Standard_GZRS'
  'Standard_RAGZRS'
])
@description('Specifies the redundancy of the Azure Storage account.')
param storgeaccountRedundancy string = 'Standard_LRS'

//Create Storage account
resource sa 'Microsoft.Storage/storageAccounts@2021-01-01' = {
  name: storageaccountName
  location: location
  kind: storageaccountkind
  sku: {
    name: storgeaccountRedundancy
    tier: storageTier
  }
  properties: {
    minimumTlsVersion: 'TLS1_2'
    isHnsEnabled: storageHNS
    supportsHttpsTrafficOnly: httpsTrafficOnly
    isNfsV3Enabled: blobNFS3
    networkAcls: length(storageSubnet) > 1 ? networkAclsOn : networkAclsOff
  }
}

output storageAccountName string = '${storageaccountName}'
output storageAccountKey  string = listKeys(sa.name, sa.apiVersion).keys[0].value
output storageAccountUri  string = sa.properties.primaryEndpoints.blob
output storageAccountId string = sa.id
