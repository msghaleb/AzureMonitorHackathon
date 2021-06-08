// params

@description('The DNS prefix to use with hosted Kubernetes API server FQDN.')
param dnsPrefix string = 'cl01'

@description('The name of the Managed Cluster resource.')
param clusterName string = 'aks101'

param nodeResourceGroup string = 'rg-${dnsPrefix}-${clusterName}'

@description('The subnet to use for the AKS')
param subnetRef string

@description('Specifies the Azure location where the key vault should be created.')
param location string = resourceGroup().location

@minValue(1)
@maxValue(50)
@description('The number of nodes for the cluster.')
param agentCount int = 1

@description('The size of the Virtual Machine.')
param agentVMSize string = 'Standard_D2_v3'

@description('OS Disk Size in GB to be used to specify the disk size for every machine. 0 is for vmsize default')
param osDiskSizeGB int = 0

@allowed([
  'Paid'
  'Free'
])
@description('The AKS tier')
param aksTier string = 'Free'

@description('Whether to enable auto-scale')
param enableAutoScaling bool = false

@description('Specifies the Azure tags that will be assigned to the resource.')
param tags object = {
  environment: 'test'
}

// param kubernetesVersion string = '1.20.2'

param enableHttpApplicationRouting bool = true

@allowed([
  'azure'
  'kubenet'
])
param networkPlugin string = 'kubenet'
param maxPods int = 30
param serviceCidr string = '10.240.0.0/16'

param dnsServiceIP string = '10.240.0.10'

param dockerBridgeCidr string = '172.17.0.1/16'

param enableOmsAgent bool = true

param omsWorkspaceId string = ''

var agentPoolName = 'agentpool01'

// Azure kubernetes service
resource aks 'Microsoft.ContainerService/managedClusters@2021-02-01' = {
  name: clusterName
  location: location
  tags: tags
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    // kubernetesVersion: kubernetesVersion
    enableRBAC: true
    dnsPrefix: dnsPrefix
    addonProfiles:{
      httpApplicationRouting: {
        enabled: enableHttpApplicationRouting
      }
      omsagent: {
        enabled: enableOmsAgent
        config: {
          logAnalyticsWorkspaceResourceID: omsWorkspaceId
        }
      }
    }
    agentPoolProfiles: [
      {
        name: agentPoolName
        count: agentCount
        mode: 'System'
        vmSize: agentVMSize
        type: 'VirtualMachineScaleSets'
        osType: 'Linux'
        osDiskSizeGB: osDiskSizeGB
        enableAutoScaling: enableAutoScaling
        vnetSubnetID: subnetRef
        //storageProfile: 'ManagedDisks'
        maxPods: maxPods
        // availabilityZones
      }
    ]
    servicePrincipalProfile: {
      clientId: 'msi'
    }
    nodeResourceGroup: nodeResourceGroup
    networkProfile: {
      networkPlugin: networkPlugin
      loadBalancerSku: 'standard'
      serviceCidr: serviceCidr
      dnsServiceIP: dnsServiceIP
      dockerBridgeCidr: dockerBridgeCidr

    }
  }
  sku: {
    name: 'Basic'
    tier: aksTier
  }
}

output id string = aks.id
output apiServerAddress string = aks.properties.fqdn
output aksName string = aks.name
