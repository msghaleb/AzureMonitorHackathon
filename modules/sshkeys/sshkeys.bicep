param name string
param location string
param key string

resource ssh 'Microsoft.Compute/sshPublicKeys@2020-06-01' = {
  name: name
  location: location
  tags: {}
  properties: {
    publicKey: key
  }
}
