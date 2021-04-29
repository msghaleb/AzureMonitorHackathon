param storageAccountName string {
  metadata: {
    description: 'storage account to use'
  }
}

param shareName string {
  default: 'main'
  metadata: {
    description: 'storage account to use'
  }
}

param protocol string {
  allowed: [
    'SMB'
    'NFS'
  ]
  default: 'NFS'
  metadata: {
    description: 'Specifies the kind of the Azure Storage account.'
  }
}

var fileShareName = '${storageAccountName}/default/${shareName}'

resource fileShare 'Microsoft.Storage/storageAccounts/fileServices/shares@2020-08-01-preview' = {
  name: fileShareName
  properties:{
    enabledProtocols: protocol
  }
}