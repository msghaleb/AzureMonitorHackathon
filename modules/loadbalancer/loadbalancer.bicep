// Location for all resources.
param location string = resourceGroup().location
param webLbName string = 'webLbName'
param webLbPipId string = ''
param webLbId string = resourceId('Microsoft.Network/loadBalancers',webLbName)
param skuName string = 'Basic'
param skuTier string = 'Regional'

resource loadbalancer 'Microsoft.Network/loadBalancers@2020-07-01' = {
  name: webLbName
  location: location
  sku: {
    name: skuName
    tier: skuTier
  }
  properties: {
    frontendIPConfigurations: [
      {
        name: 'LoadBalancerFrontEnd'
        properties: {
          publicIPAddress: {
            id: webLbPipId
          }
        }
      }
    ]
    backendAddressPools: [
      {
        name: 'BackendPool1'
      }
    ]
    inboundNatPools: [
      {
        name: 'natpool'
        properties: {
          frontendIPConfiguration: {
            id: '${webLbId}/frontendIPConfigurations/loadBalancerFrontEnd'
          }
          protocol: 'Tcp'
          frontendPortRangeStart: 50000
          frontendPortRangeEnd: 50119
          backendPort: 3389
        }
      }
    ]
    probes: [
      {
        name: 'tcpProbe'
        properties: {
          protocol: 'Tcp'
          port: 80
          intervalInSeconds: 5
          numberOfProbes: 2
        }
      }
    ]
    loadBalancingRules: [
      {
        name: 'LBRule'
        properties: {
          frontendIPConfiguration: {
            id: '${webLbId}/frontendIPConfigurations/LoadBalancerFrontEnd'
          }
          backendAddressPool: {
            id: '${webLbId}/backendAddressPools/BackendPool1'
          }
          protocol: 'Tcp'
          frontendPort: 80
          backendPort: 80
          enableFloatingIP: false
          idleTimeoutInMinutes: 5
          probe: {
            id: '${webLbId}/probes/tcpProbe'
          }
        }
      }
    ]
  }
}

output lbBackendAddressPools array = loadbalancer.properties.backendAddressPools
output lbInboundNatPools array = loadbalancer.properties.inboundNatPools
