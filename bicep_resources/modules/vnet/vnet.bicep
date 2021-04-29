// Azure virtual network

// virtual network name'
param virtualNetworkName string = 'vnet'

// Resource Name
param location string = resourceGroup().location

@description('Specifies the Azure tags that will be assigned to the resource.')
param tags object = {
  environment: 'test'
}

@description('Specifies the Azure vnet address where the resource should be created.')
param addressPrefixes array = [
  '192.168.0.0/16'
]

@description('Specifies the Azure vnet address where the resource should be created.')
param subnets array = [
  {
    name: 'subnet01'
    prefix: '192.168.0.0/16'
    endpoints: []
    networkSecurityGroupId: ''
  }
]

resource vnet 'Microsoft.Network/virtualNetworks@2020-07-01' = {
  name: virtualNetworkName
  location: location
  tags: tags
  properties: {
    addressSpace: {
      addressPrefixes: addressPrefixes
    }
    subnets: [for subnet in subnets: {
      name: subnet.name
      properties: {
        addressPrefix: subnet.prefix
        serviceEndpoints: subnet.endpoints
        networkSecurityGroup: any(contains(subnet, 'networkSecurityGroupId') == false ? null : {
          id: subnet.networkSecurityGroupId
        })
      }
    }]
  }
}

output vnetID string = '${vnet.id}'
output subnetRef array = [for s in subnets: '${vnet.id}/subnets/${s.name}']
