// Location for all resources.
param location string = resourceGroup().location

// The name of your Virtual Machine.
param vmName string 

// Username for the Virtual Machine.
param adminUsername string = 'vmadmin'

// NSG ID
param nsgID string = ''

// Type of authentication to use on the Virtual Machine. SSH key is recommended.
@allowed([
  'password'
])
param authenticationType string = 'password'

// SSH Key or password for the Virtual Machine. SSH key is recommended.
param adminPasswordOrKey string

// The Windows version for the VM. This will pick a fully patched image of this given Windows version.
@allowed([
  '2008-R2-SP1'
  '2012-Datacenter'
  '2012-R2-Datacenter'
  '2016-Nano-Server'
  '2016-Datacenter-with-Containers'
  '2016-Datacenter'
  '2019-Datacenter'
  'rs5-enterprise'
  'rs5-enterprise-g2'
  'rs5-enterprise-standard'
  'rs5-enterprise-standard-g2'
  'rs5-enterprisen'
  'rs5-enterprisen-g2'
  'rs5-enterprisen-standard'
  'rs5-enterprisen-standard-g2'
  'vs-2019-comm-latest-win10-n'
  'Standard'
])
param windowsOSVersion string = '2016-Datacenter'

@allowed([
  'MicrosoftWindowsServer'
  'MicrosoftWindowsDesktop'
  'MicrosoftVisualStudio'
  'MicrosoftSQLServer'
])
param MicrosoftWindowsPublisher string = 'MicrosoftWindowsServer'

@allowed([
  'WindowsServer'
  'Windows-10'
  'VisualStudio2019latest'
  'SQL2016SP1-WS2016'
])
param WindowsOffer string = 'WindowsServer'

// The size of the VM.
param vmSize string = 'Standard_D2_v3'

// Name of the VNET.
param virtualNetworkName string = 'vNet'

// Name of the subnet reference
param subnetRef string

// Name of the Public IP reference
param publicIPID string = ''

//param customData string = ''

param bootDiagnostics bool = false
param storageAccountUri string = ''
param useSystemManagedIdentity bool = false

var networkInterfaceName = '${vmName}NetInt'
var osDiskType = 'Standard_LRS'

var publicIPobject = {
  id: publicIPID
}

var nsgObject = {
  id: nsgID
}

var SystemAssigned= {
  type: 'SystemAssigned'
}

resource nic 'Microsoft.Network/networkInterfaces@2020-06-01' = {
  name: networkInterfaceName
  location: location
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          subnet: {
            id: subnetRef
          }
          privateIPAllocationMethod: 'Dynamic'
          publicIPAddress: any(publicIPID == '' ? null : publicIPobject) 
        }
      }
    ]
    networkSecurityGroup: any(nsgID == '' ? null : nsgObject)  
  }
}

resource vm 'Microsoft.Compute/virtualMachines@2020-06-01' = {
  name: vmName
  location: location
  identity: any(useSystemManagedIdentity == false ? null : SystemAssigned)
  properties: {
    hardwareProfile: {
      vmSize: vmSize
    }
    storageProfile: {
      osDisk: {
        createOption: 'FromImage'
        managedDisk: {
          storageAccountType: osDiskType
        }
      }
      imageReference: {
        publisher: MicrosoftWindowsPublisher
        offer: WindowsOffer
        sku: windowsOSVersion
        version: 'latest'
      }
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: nic.id
        }
      ]
    }
    osProfile: {
      computerName: vmName
      adminUsername: adminUsername
      adminPassword: adminPasswordOrKey
      //customData: base64(customData)
    }
    diagnosticsProfile: {
      bootDiagnostics: {
        enabled: bootDiagnostics
        storageUri: storageAccountUri
      }
    }
  }
}

output vmName string = vmName
output user string = adminUsername
