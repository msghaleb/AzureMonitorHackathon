// Location for all resources.
param location string = resourceGroup().location

param appInsightsName string = toLower('appinsights-${newGuid()}')

param laWsId string = ''

param appInsightsPublicNetworkAccessForIngestion string = 'enabled'
param appInsightsPublicNetworkAccessForQuery string = 'enabled'

// webSrvPublicIP

resource appInsights 'Microsoft.Insights/components@2020-02-02-preview' = {
  name: appInsightsName
  location: location
  kind: 'web'
  properties: {
    Application_Type: 'web'
    Flow_Type: 'Bluefield'
    Request_Source: 'rest'
    //HockeyAppId: 'string'
    //SamplingPercentage: any('number')
    //DisableIpMasking: bool
    //ImmediatePurgeDataOn30Days: bool
    WorkspaceResourceId: laWsId
    publicNetworkAccessForIngestion: appInsightsPublicNetworkAccessForIngestion
    publicNetworkAccessForQuery: appInsightsPublicNetworkAccessForQuery
    //IngestionMode: 'string'
  }
}

output appInsightsResourceId string = appInsights.id 
