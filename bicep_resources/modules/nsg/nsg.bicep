param networkSecurityGroupName string
param location string = resourceGroup().location

@description('Specifies the Azure tags that will be assigned to the resource.')
param tags object = {
  environment: 'test'
}

param securityRules array = [
  {
    name: 'allow-ssh'
    properties: {
      priority: 1000
      sourceAddressPrefix: '*'
      protocol: 'Tcp'
      destinationPortRange: '22'
      access: 'Allow'
      direction: 'Inbound'
      sourcePortRange: '*'
      destinationAddressPrefix: '*'
    }
  }
]

resource nsg 'Microsoft.Network/networkSecurityGroups@2020-06-01' = {
  name: networkSecurityGroupName
  location: location
  tags: tags
  properties: {
    securityRules: [for securityRule in securityRules: {
      name: securityRule.name
      properties: {
        priority: securityRule.properties.priority
        sourceAddressPrefix: securityRule.properties.sourceAddressPrefix
        sourcePortRange: securityRule.properties.sourcePortRange
        access: securityRule.properties.access
        protocol: securityRule.properties.protocol
        destinationPortRange: securityRule.properties.destinationPortRange
        direction: securityRule.properties.direction
        destinationAddressPrefix: securityRule.properties.destinationAddressPrefix
      }
    }]
  }
}

output id string = nsg.id
