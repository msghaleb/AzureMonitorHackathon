
param publicIpName string
param publicIpDnsLabel string = toLower(substring(concat('${publicIpName}', uniqueString(resourceGroup().id)), 0, 15))

param location string = resourceGroup().location

@allowed([
  'Dynamic'
  'Static'
])
param publicIPAllocationMethod string = 'Static'

@description('Specifies the Azure tags that will be assigned to the resource.')
param tags object = {
  environment: 'test'
}

resource publicIp 'Microsoft.Network/publicIPAddresses@2020-06-01' = {
  name: publicIpName
  location: location
  properties: {
    publicIPAllocationMethod: publicIPAllocationMethod
    dnsSettings: {
      domainNameLabel: publicIpDnsLabel
    }
  }
  tags: tags
}

output fqdn string = publicIp.properties.dnsSettings.fqdn
output ip string =  publicIPAllocationMethod == 'Static' ? publicIp.properties.ipAddress : ''
output id string = publicIp.id
