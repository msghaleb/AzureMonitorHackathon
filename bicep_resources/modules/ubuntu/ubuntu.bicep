// The name of your Virtual Machine.
param vmName string 

// Username for the Virtual Machine.
param adminUsername string = 'ubuntu'

// NSG ID
param nsgID string = ''

// Type of authentication to use on the Virtual Machine. SSH key is recommended.
@allowed([
  'sshPublicKey'
  'password'
])
param authenticationType string = 'password'

// SSH Key or password for the Virtual Machine. SSH key is recommended.
param adminPasswordOrKey string

// The Ubuntu version for the VM. This will pick a fully patched image of this given Ubuntu version.
@allowed([
  '16.04.0-LTS'
  '18.04-LTS'
])
param ubuntuOSVersion string = '18.04-LTS'

// Location for all resources.
param location string = resourceGroup().location

// The size of the VM.
param vmSize string = 'Standard_B2s'

// Name of the VNET.
param virtualNetworkName string = 'vNet'

// Name of the subnet reference
param subnetRef string

// Name of the subnet reference
param publicIPID string = ''

param customData string = ''

var networkInterfaceName = '${vmName}NetInt'
var osDiskType = 'Standard_LRS'

var linuxConfiguration = {
  disablePasswordAuthentication: true
  ssh: {
    publicKeys: [
      {
        path: '/home/${adminUsername}/.ssh/authorized_keys'
        keyData: adminPasswordOrKey
      }
    ]
  }
}

var publicIPobject = {
  id: publicIPID
}

var nsgObject = {
  id: nsgID
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
        publisher: 'Canonical'
        offer: 'UbuntuServer'
        sku: ubuntuOSVersion
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
      customData: base64(customData)
      linuxConfiguration: any(authenticationType == 'password' ? null : linuxConfiguration) // TODO: workaround for https://github.com/Azure/bicep/issues/449
    }
  }
}

output vmName string = vmName
output user string = adminUsername
// output sshCommand string = 'ssh${adminUsername}@${publicIP.properties.dnsSettings.fqdn}'
