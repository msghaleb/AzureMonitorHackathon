param vmExtName string

// Location for all resources.
param location string = resourceGroup().location

param vmExtPublisher string
param vmExtType string
param vmExttypeHandlerVersion string
param vmExtautoUpgradeMinorVersion bool = true
param vmExtenableAutomaticUpgrade bool = true
param vmExtsettings object = {}
param vmExtprotectedSettings object = {}

resource symbolicname 'Microsoft.Compute/virtualMachines/extensions@2020-12-01' = {
  name: vmExtName
  location: location
  properties: {
    publisher: vmExtPublisher
    type: vmExtType
    typeHandlerVersion: vmExttypeHandlerVersion
    autoUpgradeMinorVersion: vmExtautoUpgradeMinorVersion
    enableAutomaticUpgrade: vmExtenableAutomaticUpgrade
    settings: vmExtsettings
    protectedSettings: vmExtprotectedSettings
  }
}
