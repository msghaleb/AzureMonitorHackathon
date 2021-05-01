// Location for all resources.
param location string = resourceGroup().location

param laName string = toLower('laworkspace-${newGuid()}')

param laPublicNetworkAccessForIngestion string = 'enabled'
param laPublicNetworkAccessForQuery string = 'enabled'

param lasolution object = {
  solutions: []
}

param ladatasource object = {
  datasources: []
}

resource laworkspace 'Microsoft.OperationalInsights/workspaces@2020-08-01' = {
  name: laName
  location: location
  properties: {
    /*
    sku: {
      name: 'string'
      capacityReservationLevel: int
    }
    retentionInDays: int
    workspaceCapping: {
      dailyQuotaGb: any('number')
    }
    */
    publicNetworkAccessForIngestion: laPublicNetworkAccessForIngestion
    publicNetworkAccessForQuery: laPublicNetworkAccessForQuery
  }
}

resource laworkspacedatasource 'Microsoft.OperationalInsights/workspaces/datasources@2015-11-01-preview' = [for d in range(0, length(ladatasource.datasources)): {
  //name: '${laworkspace.name}/${ladatasource.datasources[d].name}'
  name: ladatasource.datasources[d].name
  kind: ladatasource.datasources[d].kind
  properties: ladatasource.datasources[d].properties
  dependsOn:[
    laworkspace
  ]
}]

resource laworkspacesolutions 'Microsoft.OperationsManagement/solutions@2015-11-01-preview' = [for s in range(0, length(lasolution.solutions)): {
  name: lasolution.solutions[s].name
  location: location
  properties: {
    workspaceResourceId: laworkspace.id
  }
  plan: {
    name: lasolution.solutions[s].name
    product: 'OMSGallery/${lasolution.solutions[s].marketplaceName}'
    promotionCode: ''
    publisher: 'Microsoft'
  }
  dependsOn:[
    laworkspace
  ]
}]

output laWsResourceId string = laworkspace.id
output laWsId string =  laworkspace.properties.customerId
output laWsKey string = listKeys(laworkspace.id,'2020-08-01').primarySharedKey
