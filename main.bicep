@maxLength(5)
@minLength(2)
param envPrefixName string = toLower('mogas')

param adminUserName string = 'vmadmin'

@secure()
param adminUserPass string
param laName string = toLower(substring('logaworks${uniqueString(resourceGroup().id)}', 0, 20))
//param keyvaultName string = toLower(substring(concat('keyvault', uniqueString(resourceGroup().id)), 0, 20))
param appInsightsName string = toLower('${envPrefixName}az-mo-ht-appinsights')
param location string = resourceGroup().location

@allowed([
  1
  2
])
param numberOfWebSrvs int = 2
param ladatasource object = {
  datasources: [
    //{
      //name: '${laName}/AzureActivityLog'
      //kind: 'AzureActivityLog'
      //properties: {
        //linkedResourceId: '${subscription().id}/providers/Microsoft.Insights/eventTypes/management'
      //}
    //}
    {
      name: '${laName}/LogicalDisk1'
      kind: 'WindowsPerformanceCounter'
      properties: {
        objectName: 'LogicalDisk'
        instanceName: '*'
        intervalSeconds: 10
        counterName: 'Avg Disk sec/Read'
      }
    }
    {
      name: '${laName}/LogicalDisk2'
      kind: 'WindowsPerformanceCounter'
      properties: {
        objectName: 'LogicalDisk'
        instanceName: '*'
        intervalSeconds: 10
        counterName: 'Avg Disk sec/Write'
      }
    }
    {
      name: '${laName}/LogicalDisk3'
      kind: 'WindowsPerformanceCounter'
      properties: {
        objectName: 'LogicalDisk'
        instanceName: '*'
        intervalSeconds: 10
        counterName: 'Current Disk Queue Length'
      }
    }
    {
      name: '${laName}/LogicalDisk4'
      kind: 'WindowsPerformanceCounter'
      properties: {
        objectName: 'LogicalDisk'
        instanceName: '*'
        intervalSeconds: 10
        counterName: 'Disk Reads/sec'
      }
    }
    {
      name: '${laName}/LogicalDisk5'
      kind: 'WindowsPerformanceCounter'
      properties: {
        objectName: 'LogicalDisk'
        instanceName: '*'
        intervalSeconds: 10
        counterName: 'Disk Transfers/sec'
      }
    }
    {
      name: '${laName}/LogicalDisk6'
      kind: 'WindowsPerformanceCounter'
      properties: {
        objectName: 'LogicalDisk'
        instanceName: '*'
        intervalSeconds: 10
        counterName: 'Disk Writes/sec'
      }
    }
    {
      name: '${laName}/LogicalDisk7'
      kind: 'WindowsPerformanceCounter'
      properties: {
        objectName: 'LogicalDisk'
        instanceName: '*'
        intervalSeconds: 10
        counterName: 'Free Megabytes'
      }
    }
    {
      name: '${laName}/LogicalDisk8'
      kind: 'WindowsPerformanceCounter'
      properties: {
        objectName: 'LogicalDisk'
        instanceName: '*'
        intervalSeconds: 10
        counterName: '% Free Space'
      }
    }
    {
      name: '${laName}/Memory1'
      kind: 'WindowsPerformanceCounter'
      properties: {
        objectName: 'Memory'
        instanceName: '*'
        intervalSeconds: 10
        counterName: 'Available MBytes'
      }
    }
    {
      name: '${laName}/Memory2'
      kind: 'WindowsPerformanceCounter'
      properties: {
        objectName: 'Memory'
        instanceName: '*'
        intervalSeconds: 10
        counterName: '% Committed Bytes In Use'
      }
    }
    {
      name: '${laName}/Network1'
      kind: 'WindowsPerformanceCounter'
      properties: {
        objectName: 'Network Adapter'
        instanceName: '*'
        intervalSeconds: 10
        counterName: 'Bytes Received/sec'
      }
    }
    {
      name: '${laName}/Network2'
      kind: 'WindowsPerformanceCounter'
      properties: {
        objectName: 'Network Adapter'
        instanceName: '*'
        intervalSeconds: 10
        counterName: 'Bytes Sent/sec'
      }
    }
    {
      name: '${laName}/Network3'
      kind: 'WindowsPerformanceCounter'
      properties: {
        objectName: 'Network Adapter'
        instanceName: '*'
        intervalSeconds: 10
        counterName: 'Bytes Total/sec'
      }
    }
    {
      name: '${laName}/CPU1'
      kind: 'WindowsPerformanceCounter'
      properties: {
        objectName: 'Processor'
        instanceName: '_Total'
        intervalSeconds: 10
        counterName: '% Processor Time'
      }
    }
    {
      name: '${laName}/CPU2'
      kind: 'WindowsPerformanceCounter'
      properties: {
        objectName: 'System'
        instanceName: '*'
        intervalSeconds: 10
        counterName: 'Processor Queue Lenght'
      }
    }
    {
      name: '${laName}/System'
      kind: 'WindowsEvent'
      properties: {
        eventLogName: 'System'
        eventTypes: [
          {
            eventType: 'Error'
          }
          {
            eventType: 'Warning'
          }
        ]
      }
    }
    {
      name: '${laName}/Application'
      kind: 'WindowsEvent'
      properties: {
        eventLogName: 'Application'
        eventTypes: [
          {
            eventType: 'Error'
          }
          {
            eventType: 'Warning'
          }
        ]
      }
    }
    {
      name: '${laName}/Linux'
      kind: 'LinuxPerformanceObject'
      properties: {
        performanceCounters: [
          {
            counterName: '% Used Inodes'
          }
          {
            counterName: 'Free Megabytes'
          }
          {
            counterName: '% Used Space'
          }
          {
            counterName: 'Disk Transfers/sec'
          }
          {
            counterName: 'Disk Reads/sec'
          }
          {
            counterName: 'Disk Writes/sec'
          }
        ]
        objectName: 'Logical Disk'
        instanceName: '*'
        intervalSeconds: 10
      }
    }
    {
      name: '${laName}/LinuxPerfCollection'
      kind: 'LinuxPerformanceCollection'
      properties: {
        state: 'Enabled'
      }
    }
    {
      name: '${laName}/IISLog'
      kind: 'IISLogs'
      properties: {
        state: 'OnPremiseEnabled'
      }
    }
    {
      name: '${laName}/Syslog'
      kind: 'LinuxSyslog'
      properties: {
        syslogName: 'kern'
        syslogSeverities: [
          {
            severity: 'emerg'
          }
          {
            severity: 'alert'
          }
          {
            severity: 'crit'
          }
          {
            severity: 'err'
          }
          {
            severity: 'warning'
          }
        ]
      }
    }
    {
      name: '${laName}/SyslogCollection'
      kind: 'LinuxSyslogCollection'
      properties: {
        state: 'Enabled'
      }
    }    
  ]
}

param lasolution object = {
  solutions: [
    {
      name: 'Security(${laName})'
      marketplaceName: 'Security'
    }
    {
      name: 'AgentHealthAssessment(${laName})'
      marketplaceName: 'AgentHealthAssessment'
    }
    {
      name: 'ContainerInsights(${laName})'
      marketplaceName: 'ContainerInsights'
    }
    {
      name: 'AzureSQLAnalytics(${laName})'
      marketplaceName: 'AzureSQLAnalytics'
    }
    {
      name: 'ChangeTracking(${laName})'
      marketplaceName: 'ChangeTracking'
    }
    {
      name: 'Updates(${laName})'
      marketplaceName: 'Updates'
    }
    {
      name: 'AzureActivity(${laName})'
      marketplaceName: 'AzureActivity'
    }
    {
      name: 'AzureAutomation(${laName})'
      marketplaceName: 'AzureAutomation'
    }
    {
      name: 'ADAssessment(${laName})'
      marketplaceName: 'ADAssessment'
    }
    {
      name: 'SQLAssessment(${laName})'
      marketplaceName: 'SQLAssessment'
    }
    {
      name: 'ServiceMap(${laName})'
      marketplaceName: 'ServiceMap'
    }
    {
      name: 'InfrastructureInsights(${laName})'
      marketplaceName: 'InfrastructureInsights'
    }
    /*
    {
      name: 'AzureAppGatewayAnalytics(${laName})'
      marketplaceName: 'AzureAppGatewayAnalytics'
    }
    */
    {
      name: 'AzureNSGAnalytics(${laName})'
      marketplaceName: 'AzureNSGAnalytics'
    }
    {
      name: 'KeyVaultAnalytics(${laName})'
      marketplaceName: 'KeyVaultAnalytics'
    }
  ]
}

param dbNsgsecurityRules array = [
  {
    name: 'Allow_FE'
    properties: {
      priority: 100
      sourceAddressPrefix: '10.0.0.0/24'
      sourcePortRange: '*'
      destinationAddressPrefix: '*'
      destinationPortRange: '1433'
      protocol: 'Tcp'
      access: 'Allow'
      direction: 'Inbound'
    }
  }
  {
    name: 'Allow_AKS'
    properties: {
      priority: 101
      sourceAddressPrefix: '10.0.3.0/24'
      sourcePortRange: '*'
      destinationAddressPrefix: '*'
      destinationPortRange: '1433'
      protocol: 'Tcp'
      access: 'Allow'
      direction: 'Inbound'
    }
  }
  {
    name: 'rdp_rule'
    properties: {
      priority: 110
      sourceAddressPrefix: '*'
      sourcePortRange: '*'
      destinationAddressPrefix: '*'
      destinationPortRange: '3389'
      protocol: 'Tcp'
      access: 'Allow'
      direction: 'Inbound'
    }
  }
  {
    name: 'Block_FE'
    properties: {
      priority: 121
      sourceAddressPrefix: '10.0.0.0/24'
      sourcePortRange: '*'
      destinationAddressPrefix: '*'
      destinationPortRange: '*'
      protocol: '*'
      access: 'Deny'
      direction: 'Inbound'
    }
  }
]

param feNsgsecurityRules array = [
  {
    name: 'web_rule'
    properties: {
      priority: 100
      sourceAddressPrefix: '*'
      sourcePortRange: '*'
      destinationAddressPrefix: '*'
      destinationPortRange: '80'
      protocol: 'Tcp'
      access: 'Allow'
      direction: 'Inbound'
    }
  }
  {
    name: 'Publish_rule'
    properties: {
      priority: 101
      sourceAddressPrefix: '*'
      sourcePortRange: '*'
      destinationAddressPrefix: '*'
      destinationPortRange: '8172'
      protocol: 'Tcp'
      access: 'Allow'
      direction: 'Inbound'
    }
  }
  {
    name: 'rdp_rule'
    properties: {
      priority: 110
      sourceAddressPrefix: '*'
      sourcePortRange: '*'
      destinationAddressPrefix: '*'
      destinationPortRange: '3389'
      protocol: 'Tcp'
      access: 'Allow'
      direction: 'Inbound'
    }
  }
]

param vmssName string = '${envPrefixName}azmonvmss'
param namingInfix string = toLower(substring('${vmssName}${uniqueString(resourceGroup().id)}', 0, 9))

var webSrvSubnetRef = resourceId('Microsoft.Network/virtualNetworks/subnets', '${envPrefixName}azmhVnet', 'FESubnetName')

var appName = appInsightsName
var priceCode = 1
var priceArray = [
  'Basic'
  'Application Insights Enterprise'
]
var pricePlan = take(priceArray, priceCode)
var billingplan_var = '${appName}/${pricePlan[0]}'
var dailyQuota = 100
var dailyQuotaResetTime = 24
var warningThreshold = 90

// var pingname_var = 'eShopPingTest'
// var pingguid = guid(subscription().id)
// var pingexpected = 200
/*
param testlocations array = [
  {
    Id: 'us-il-ch1-azr'
  }
  {
    Id: 'us-ca-sjc-azr'
  }
  {
    Id: 'us-tx-sn1-azr'
  }
]
*/

module storage 'modules/sa/sa.bicep' = {
  name: 'storagedeployment'
  params: {
    storagePrefix: envPrefixName
  }
}

module dbnsg 'modules/nsg/nsg.bicep' = {
  name: 'dbnsgdeployment'
  params: {
    networkSecurityGroupName: '${envPrefixName}dbNsg'
    securityRules : dbNsgsecurityRules
  }
}

resource dbNSGN_Microsoft_Insights_setForSecurity 'Microsoft.Network/networkSecurityGroups/providers/diagnosticSettings@2017-05-01-preview' = {
  name: '${envPrefixName}dbNsg/Microsoft.Insights/setForSecurity'
  location: resourceGroup().location
  properties: {
    workspaceId: lawsdeployment.outputs.laWsResourceId
    storageAccountId: storage.outputs.storageAccountId
    logs: [
      {
        category: 'NetworkSecurityGroupEvent'
        enabled: true
        retentionPolicy: {
          days: 31
          enabled: true
        }
      }
      {
        category: 'NetworkSecurityGroupRuleCounter'
        enabled: true
        retentionPolicy: {
          days: 31
          enabled: true
        }
      }
    ]
  }
}

module fensg 'modules/nsg/nsg.bicep' = {
  name: 'fensgdeployment'
  params: {
    networkSecurityGroupName: '${envPrefixName}feNsg'
    securityRules : feNsgsecurityRules
  }
}

resource feNSG_Microsoft_Insights_setForSecurity 'Microsoft.Network/networkSecurityGroups/providers/diagnosticSettings@2017-05-01-preview' = {
  name: '${envPrefixName}feNsg/Microsoft.Insights/setForSecurity'
  location: resourceGroup().location
  properties: {
    workspaceId: lawsdeployment.outputs.laWsResourceId
    storageAccountId: storage.outputs.storageAccountId
    logs: [
      {
        category: 'NetworkSecurityGroupEvent'
        enabled: true
        retentionPolicy: {
          days: 31
          enabled: true
        }
      }
      {
        category: 'NetworkSecurityGroupRuleCounter'
        enabled: true
        retentionPolicy: {
          days: 31
          enabled: true
        }
      }
    ]
  }
}

module vnet 'modules/vnet/vnet.bicep' = {
  name: 'vnetdeployment'
  params: {
    virtualNetworkName: '${envPrefixName}azmhVnet'
    addressPrefixes: [
      '10.0.0.0/16'
    ]
    subnets: [
      {   
        name: 'FESubnetName'
        prefix: '10.0.0.0/24'
        endpoints: []
        networkSecurityGroupId: fensg.outputs.id
      }
      {
        name: 'DBSubnetName'
        prefix: '10.0.2.0/24'
        endpoints: []
        networkSecurityGroupId: dbnsg.outputs.id

      }
      {
        name: 'aksSubnetName'
        prefix: '10.0.3.0/24'
        endpoints: []
      }
    ]
  }
}

module sqlPip 'modules/pip/pip.bicep' = {
  name: 'sqlpipdeployment'
  params: {
    publicIpName: '${envPrefixName}azmhSqlPip'
    publicIPAllocationMethod : 'Dynamic'
  }
}

module vsPip 'modules/pip/pip.bicep' = {
  name: 'vspipdeployment'
  params: {
    publicIpName: '${envPrefixName}azmhVsPip'
    publicIPAllocationMethod : 'Dynamic'
  }
}

module webScaleSetPip 'modules/pip/pip.bicep' = {
  name: 'wsspipdeployment'
  params: {
    publicIpName: '${envPrefixName}azmhWebScaleSetPip'
    publicIPAllocationMethod : 'Dynamic'
  }
}

resource webSrvPublicIP_Microsoft_Insights_setByARM 'Microsoft.Network/publicIpAddresses/providers/diagnosticSettings@2017-05-01-preview' = {
  name: '${envPrefixName}azmhWebScaleSetPip/Microsoft.Insights/setByARM'
  location: resourceGroup().location
  properties: {
    workspaceId: lawsdeployment.outputs.laWsResourceId
    metrics: [
      {
        timeGrain: 'PT1M'
        enabled: true
        retentionPolicy: {
          enabled: false
          days: 31
        }
      }
    ]
    logs: [
      {
        category: 'DDoSProtectionNotifications'
        enabled: true
      }
    ]
  }
}

module vswindows 'modules/windows/windows.bicep' = {
  name: 'vsdeployment'
  params: {
    vmName              : '${envPrefixName}azmhVSSrv'
    vmSize              : 'Standard_D4s_v3'
    windowsOSVersion    : 'vs-2019-ent-ws2019'
    MicrosoftWindowsPublisher : 'MicrosoftVisualStudio'
    WindowsOffer : 'visualStudio2019'
    adminPasswordOrKey  : adminUserPass
    adminUsername       : adminUserName
    useSystemManagedIdentity : true
    publicIPID          : vsPip.outputs.id
    //storageAccountUri   :
    subnetRef           : vnet.outputs.subnetRef[0]
  }
}

module vswindowsvmext 'modules/vmextension/vmextension.bicep' = {
  name: 'vmextvsdeployment'
  params: {
    vmExtName: '${envPrefixName}azmhVSSrv/VSSrvCustomScriptExtension'
    vmExtPublisher: 'Microsoft.Compute'
    vmExtType: 'CustomScriptExtension'
    vmExttypeHandlerVersion: '1.9'
    vmExtenableAutomaticUpgrade: false
    vmExtsettings: {
      fileUris: [
        'https://raw.githubusercontent.com/msghaleb/AzureMonitorHackathon/master/sources/SetupVSServer.ps1'
      ]
      commandToExecute: 'powershell.exe -ExecutionPolicy Unrestricted -File SetupVSServer.ps1 ${envPrefixName}azmhSQLSrv ${adminUserPass}'
    } 
  }
  dependsOn:[
    vswindows
    sqlwindows
  ]
}

module sqlwindows 'modules/windows/windows.bicep' = {
  name: 'sqldeployment'
  params: {
    vmName                    : '${envPrefixName}azmhSQLSrv'
    vmSize                    : 'Standard_DS3_v2'
    windowsOSVersion          : 'Standard'
    MicrosoftWindowsPublisher : 'MicrosoftSQLServer'
    WindowsOffer              : 'SQL2016SP1-WS2016'
    adminPasswordOrKey        : adminUserPass
    adminUsername             : adminUserName
    useSystemManagedIdentity  : true
    // publicIPID             : sqlPip.outputs.id
    subnetRef                 : vnet.outputs.subnetRef[0]
  }
}

module sqlwindowsvmext 'modules/vmextension/vmextension.bicep' = {
  name: 'vmextsqldeployment'
  params: {
    vmExtName: '${envPrefixName}azmhSQLSrv/WADExtensionSetup'
    vmExtPublisher: 'Microsoft.ManagedIdentity'
    vmExtType: 'ManagedIdentityExtensionForWindows'
    vmExttypeHandlerVersion: '1.0'
    vmExtenableAutomaticUpgrade: false
    vmExtsettings: {
      port: 50342
    }
  }
  dependsOn:[
    sqlwindows
  ]
}

module sqldiagwindowsvmext 'modules/vmextension/vmextension.bicep' = {
  name: 'sqldiagextvsdeployment'
  params: {
    vmExtName: '${envPrefixName}azmhSQLSrv/VMDiagnosticsSettings'
    vmExtPublisher: 'Microsoft.Azure.Diagnostics'
    vmExtType: 'IaaSDiagnostics'
    vmExttypeHandlerVersion: '1.5'
    vmExtenableAutomaticUpgrade: false
    vmExtsettings: {
      WadCfg: {
          DiagnosticMonitorConfiguration: {
              overallQuotaInMB: 4096
              DiagnosticInfrastructureLogs: {
                  scheduledTransferLogLevelFilter: 'Error'
              }
              Directories: {
                  scheduledTransferPeriod: 'PT1M'
                  IISLogs: {
                      containerName: 'wad-iis-logfiles'
                  }
                  FailedRequestLogs: {
                      containerName: 'wad-failedrequestlogs'
                  }
              }
              PerformanceCounters: {
                  scheduledTransferPeriod: 'PT1M'
                  sinks: 'AzMonSink'
                  PerformanceCounterConfiguration: [
                      {
                          counterSpecifier: '\\Memory\\Available Bytes'
                          sampleRate: 'PT15S'
                      }
                      {
                          counterSpecifier: '\\Memory\\% Committed Bytes In Use'
                          sampleRate: 'PT15S'
                      }
                      {
                          counterSpecifier: '\\Memory\\Committed Bytes'
                          sampleRate: 'PT15S'
                      }
                  ]
              }
              WindowsEventLog: {
                  scheduledTransferPeriod: 'PT1M'
                  DataSource: [
                      {
                          name: 'Application!*'
                      }
                  ]
              }
              Logs: {
                  scheduledTransferPeriod: 'PT1M'
                  scheduledTransferLogLevelFilter: 'Error'
              }
          }
          SinksConfig: {
              Sink: [
                  {
                      name: 'AzMonSink'
                      AzureMonitor: {}
                  }
              ]
          }
      }
      StorageAccount: storage.outputs.storageAccountName
    }
    vmExtprotectedSettings: {
      storageAccountName: storage.outputs.storageAccountName
      storageAccountKey: storage.outputs.storageAccountKey
      storageAccountEndPoint: 'https://core.windows.net/'
    }
  }
  dependsOn:[
    sqlwindows
  ]
}

module sqliaaswindowsvmext 'modules/vmextension/vmextension.bicep' = {
  name: 'vmextsqliaasdeployment'
  params: {
    vmExtName: '${envPrefixName}azmhSQLSrv/SqlIaasExtension'
    vmExtPublisher: 'Microsoft.SqlServer.Management'
    vmExtType: 'SqlIaaSAgent'
    vmExttypeHandlerVersion: '1.2'
    vmExtenableAutomaticUpgrade: false
    vmExtsettings: {
      AutoTelemetrySettings: {
          Region: resourceGroup().location
      }
      AutoPatchingSettings: {
          PatchCategory: 'WindowsMandatoryUpdates'
          Enable: false
      }
      KeyVaultCredentialSettings: {
          Enable: false
          CredentialName: ''
      }
      ServerConfigurationsManagementSettings: {
          SQLConnectivityUpdateSettings: {
              ConnectivityType: 'Private'
              Port: 1433
          }
          AdditionalFeaturesServerConfigurations: {
              IsRServicesEnabled: false
          }
      }
    }
    vmExtprotectedSettings: {
      SQLAuthUpdateUserName: 'sqladmin'
      SQLAuthUpdatePassword: adminUserPass
    }
  }
  dependsOn:[
    sqlwindows
  ]
}

module sqldepagentwindowsvmext 'modules/vmextension/vmextension.bicep' = {
  name: 'sqldepagentextvsdeployment'
  params: {
    vmExtName: '${envPrefixName}azmhSQLSrv/DependencyAgent'
    vmExtPublisher: 'Microsoft.Azure.Monitoring.DependencyAgent'
    vmExtType: 'DependencyAgentWindows'
    vmExttypeHandlerVersion: '9.4'
    vmExtenableAutomaticUpgrade: false
  }
  dependsOn:[
    sqlwindows
  ]
}

module sqllapwindowsvmext 'modules/vmextension/vmextension.bicep' = {
  name: 'sqllapextvsdeployment'
  params: {
    vmExtName: '${envPrefixName}azmhSQLSrv/laPolicy'
    vmExtPublisher: 'Microsoft.EnterpriseCloud.Monitoring'
    vmExtType: 'MicrosoftMonitoringAgent'
    vmExttypeHandlerVersion: '1.0'
    vmExtenableAutomaticUpgrade: false
    vmExtsettings: {
      workspaceId: lawsdeployment.outputs.laWsId
    }
    vmExtprotectedSettings: {
      workspaceKey: lawsdeployment.outputs.laWsKey
    }
  }
  dependsOn:[
    sqlwindows
  ]
}

module lawsdeployment 'modules/loganalytics/loganalytics.bicep' = {
  name: 'lawsdeployment'
  params:{
    laName:laName
    lasolution: lasolution
    ladatasource: ladatasource
  }
}

resource laworkspacesolutions 'Microsoft.OperationsManagement/solutions@2015-11-01-preview' = [for s in range(0, length(lasolution.solutions)): {
  name: lasolution.solutions[s].name
  location: location
  properties: {
    workspaceResourceId: lawsdeployment.outputs.laWsResourceId
  }
  plan: {
    name: lasolution.solutions[s].name
    product: 'OMSGallery/${lasolution.solutions[s].marketplaceName}'
    promotionCode: ''
    publisher: 'Microsoft'
  }
  dependsOn:[
    lawsdeployment
  ]
}]

module appinsightsdeployment 'modules/appinsights/appinsights.bicep' = {
  name: 'appinsightsdeployment'
  params:{
    appInsightsName: appInsightsName
    laWsId: lawsdeployment.outputs.laWsResourceId
  }
}

resource billingplan 'microsoft.insights/components/CurrentBillingFeatures@2015-05-01' = {
  name: billingplan_var
  location: resourceGroup().location
  properties: {
    CurrentBillingFeatures: pricePlan
    DataVolumeCap: {
      Cap: dailyQuota
      WarningThreshold: warningThreshold
      ResetTime: dailyQuotaResetTime
    }
  }
  dependsOn: [
    appinsightsdeployment
  ]
}

/*
resource pingname 'Microsoft.Insights/webtests@2015-05-01' = {
  name: pingname_var
  tags: {
    'hidden-link:${resourceId('microsoft.insights/components/', appInsightsName)}': 'Resource'
  }
  location: resourceGroup().location
  kind: 'ping'
  properties: {
    SyntheticMonitorId: 'eShopPingTest'
    Name: 'eShopPingTest'
    Description: 'eShopPingTest'
    Enabled: true
    Frequency: 300
    Timeout: 30
    Kind: 'ping'
    //RetryEnabled: bool
    Locations: testlocations
    Configuration: {
      WebTest: concat('<WebTest Name="', pingname_var, '"',  ' Id="', pingguid ,'"    Enabled="True" CssProjectStructure="" CssIteration="" Timeout="0" WorkItemIds="" xmlns="http://microsoft.com/schemas/VisualStudio/TeamTest/2010" Description="" CredentialUserName="" CredentialPassword="" PreAuthenticate="True" Proxy="default" StopOnError="False" RecordedResultFile="" ResultsLocale="">        <Items>        <Request Method="GET" Guid="a5f10126-e4cd-570d-961c-cea43999a200" Version="1.1" Url="', concat('http://', webScaleSetPip.outputs.fqdn) ,'" ThinkTime="0" Timeout="300" ParseDependentRequests="True" FollowRedirects="True" RecordResult="True" Cache="False" ResponseTimeGoal="0" Encoding="utf-8" ExpectedHttpStatusCode="', pingexpected ,'" ExpectedResponseUrl="" ReportingName="" IgnoreHttpStatusCode="False" /></Items></WebTest>')
    } 
  }
  dependsOn:[
    appinsightsdeployment
  ]
}
*/

module loadbalancerdeployment 'modules/loadbalancer/loadbalancer.bicep' = {
  name: 'loadbalancerdeployment'
  params:{
    webLbName: '${envPrefixName}vmsswebsrvlb'
    webLbPipId: webScaleSetPip.outputs.id
    skuName: 'Basic'
  }
}

resource webLbName_Microsoft_Insights_setByARM 'Microsoft.Network/loadBalancers/providers/diagnosticSettings@2017-05-01-preview' = {
  name: '${envPrefixName}vmsswebsrvlb/Microsoft.Insights/setByARM'
  location: resourceGroup().location
  properties: {
    workspaceId: lawsdeployment.outputs.laWsResourceId
    metrics: [
      {
        category: 'AllMetrics'
        enabled: true
        retentionPolicy: {
          enabled: false
          days: 31
        }
      }
    ]/*
    logs: [
      {
        category: 'Alert'
        enabled: true
      }
      {
        category: 'ResourceHealth'
        enabled: true
      }
    ]*/
  }
  dependsOn:[
    loadbalancerdeployment
  ]
}

resource vmssdeployment 'Microsoft.Compute/virtualMachineScaleSets@2020-06-01' = {
  name: vmssName
  location: location
  identity: {
    type: 'SystemAssigned'
  }
  sku: {
    name: 'Standard_DS3_v2'
    tier: 'Standard'
    capacity: int(numberOfWebSrvs)
  }
  properties: {
    overprovision: true
    upgradePolicy: {
      mode: 'Manual'
    }
    singlePlacementGroup: true
    virtualMachineProfile: {
      storageProfile: {
        osDisk: {
          createOption: 'FromImage'
          caching: 'ReadWrite'
        }
        imageReference: {
          publisher: 'MicrosoftWindowsServer'
          offer: 'WindowsServer'
          sku: '2016-Datacenter'
          version: 'latest'
        }
      }
      osProfile: {
        computerNamePrefix: namingInfix
        adminUsername: adminUserName
        adminPassword: adminUserPass
      }
      networkProfile: {
        networkInterfaceConfigurations: [
          {
            name: '${vmssName}Nic'
            properties: {
              primary: true
              ipConfigurations: [
                {
                  name: '${vmssName}IpConfig'
                  properties: {
                    subnet: {
                      id: webSrvSubnetRef
                    }
                    loadBalancerBackendAddressPools: [
                      {
                        id: loadbalancerdeployment.outputs.lbBackendAddressPools[0].id
                      }
                    ]
                    loadBalancerInboundNatPools: [
                      {
                        id: loadbalancerdeployment.outputs.lbInboundNatPools[0].id
                      }
                    ]
                  }
                }
              ]
            }
          }
        ]
      }
      extensionProfile: {
        extensions: [
          {
            name: 'CustomScriptExtension'
            properties: {
              publisher: 'Microsoft.Compute'
              type: 'CustomScriptExtension'
              typeHandlerVersion: '1.9'
              autoUpgradeMinorVersion: true
              settings: {
                fileUris: [
                  'https://raw.githubusercontent.com/msghaleb/AzureMonitorHackathon/master/sources/SetupWebServers.ps1'
                ]
                commandToExecute: 'powershell.exe -ExecutionPolicy Unrestricted -File SetupWebServers.ps1 ${envPrefixName}azmhVSSrv ${adminUserName} ${adminUserPass}'
              }
            }
          }
          {
            name: 'logAnalyticsPolicy'
            properties: {
              publisher: 'Microsoft.EnterpriseCloud.Monitoring'
              type: 'MicrosoftMonitoringAgent'
              typeHandlerVersion: '1.0'
              autoUpgradeMinorVersion: true
              settings: {
                workspaceId: lawsdeployment.outputs.laWsId
              }
              protectedSettings: {
                workspaceKey: lawsdeployment.outputs.laWsKey
              }
            }
          }
          {
            name: 'VMSSWADextension'
            properties: {
              publisher: 'Microsoft.ManagedIdentity'
              type: 'ManagedIdentityExtensionForWindows'
              typeHandlerVersion: '1.0'
              autoUpgradeMinorVersion: true
              settings: {
                port: 50342
              }
              protectedSettings: {}
            }
          }
          {
            name: 'DependencyAgent'
            properties: {
              publisher: 'Microsoft.Azure.Monitoring.DependencyAgent'
              type: 'DependencyAgentWindows'
              typeHandlerVersion: '9.4'
              autoUpgradeMinorVersion: true
            }
          }
          {
            name: 'IaaSDiagnostics'
            properties: {
              publisher: 'Microsoft.Azure.Diagnostics'
              type: 'IaaSDiagnostics'
              typeHandlerVersion: '1.5'
              autoUpgradeMinorVersion: true
              enableAutomaticUpgrade: false
              settings: {
                StorageAccount: storage.outputs.storageAccountName
                WadCfg: {
                  DiagnosticMonitorConfiguration: {
                    overallQuotaInMB: 50000
                    Metrics: {
                      resourceId: '/subscriptions/${subscription().subscriptionId}/resourceGroups/${resourceGroup().name}/providers/Microsoft.Compute/virtualMachineScaleSets/${namingInfix}'
                      MetricAggregation: [
                        {
                          scheduledTransferPeriod: 'PT1H'
                        }
                        {
                          scheduledTransferPeriod: 'PT1M'
                        }
                      ]
                    }
                    DiagnosticInfrastructureLogs: {
                      scheduledTransferLogLevelFilter: 'Error'
                    }
                    PerformanceCounters: {
                      scheduledTransferPeriod: 'PT1M'
                      sinks: 'AzMonSink'
                      PerformanceCounterConfiguration: [
                        {
                          counterSpecifier: '\\Processor Information(_Total)\\% Processor Time'
                          sampleRate: 'PT1M'
                        }
                        {
                          counterSpecifier: '\\Processor Information(_Total)\\% Privileged Time'
                          sampleRate: 'PT1M'
                        }
                        {
                          counterSpecifier: '\\Processor Information(_Total)\\% User Time'
                          sampleRate: 'PT1M'
                        }
                        {
                          counterSpecifier: '\\Processor Information(_Total)\\Processor Frequency'
                          sampleRate: 'PT1M'
                        }
                        {
                          counterSpecifier: '\\System\\Processes'
                          sampleRate: 'PT1M'
                        }
                        {
                          counterSpecifier: '\\Process(_Total)\\Thread Count'
                          sampleRate: 'PT1M'
                        }
                        {
                          counterSpecifier: '\\Process(_Total)\\Handle Count'
                          sampleRate: 'PT1M'
                        }
                        {
                          counterSpecifier: '\\System\\System Up Time'
                          sampleRate: 'PT1M'
                        }
                        {
                          counterSpecifier: '\\System\\Context Switches/sec'
                          sampleRate: 'PT1M'
                        }
                        {
                          counterSpecifier: '\\System\\Processor Queue Length'
                          sampleRate: 'PT1M'
                        }
                        {
                          counterSpecifier: '\\Memory\\% Committed Bytes In Use'
                          sampleRate: 'PT1M'
                        }
                        {
                          counterSpecifier: '\\Memory\\Available Bytes'
                          sampleRate: 'PT1M'
                        }
                        {
                          counterSpecifier: '\\Memory\\Committed Bytes'
                          sampleRate: 'PT1M'
                        }
                        {
                          counterSpecifier: '\\Memory\\Cache Bytes'
                          sampleRate: 'PT1M'
                        }
                        {
                          counterSpecifier: '\\Memory\\Pool Paged Bytes'
                          sampleRate: 'PT1M'
                        }
                        {
                          counterSpecifier: '\\Memory\\Pool Nonpaged Bytes'
                          sampleRate: 'PT1M'
                        }
                        {
                          counterSpecifier: '\\Memory\\Pages/sec'
                          sampleRate: 'PT1M'
                        }
                        {
                          counterSpecifier: '\\Memory\\Page Faults/sec'
                          sampleRate: 'PT1M'
                        }
                        {
                          counterSpecifier: '\\Process(_Total)\\Working Set'
                          sampleRate: 'PT1M'
                        }
                        {
                          counterSpecifier: '\\Process(_Total)\\Working Set - Private'
                          sampleRate: 'PT1M'
                        }
                        {
                          counterSpecifier: '\\LogicalDisk(_Total)\\% Disk Time'
                          sampleRate: 'PT1M'
                        }
                        {
                          counterSpecifier: '\\LogicalDisk(_Total)\\% Disk Read Time'
                          sampleRate: 'PT1M'
                        }
                        {
                          counterSpecifier: '\\LogicalDisk(_Total)\\% Disk Write Time'
                          sampleRate: 'PT1M'
                        }
                        {
                          counterSpecifier: '\\LogicalDisk(_Total)\\% Idle Time'
                          sampleRate: 'PT1M'
                        }
                        {
                          counterSpecifier: '\\LogicalDisk(_Total)\\Disk Bytes/sec'
                          sampleRate: 'PT1M'
                        }
                        {
                          counterSpecifier: '\\LogicalDisk(_Total)\\Disk Read Bytes/sec'
                          sampleRate: 'PT1M'
                        }
                        {
                          counterSpecifier: '\\LogicalDisk(_Total)\\Disk Write Bytes/sec'
                          sampleRate: 'PT1M'
                        }
                        {
                          counterSpecifier: '\\LogicalDisk(_Total)\\Disk Transfers/sec'
                          sampleRate: 'PT1M'
                        }
                        {
                          counterSpecifier: '\\LogicalDisk(_Total)\\Disk Reads/sec'
                          sampleRate: 'PT1M'
                        }
                        {
                          counterSpecifier: '\\LogicalDisk(_Total)\\Disk Writes/sec'
                          sampleRate: 'PT1M'
                        }
                        {
                          counterSpecifier: '\\LogicalDisk(_Total)\\Avg. Disk sec/Transfer'
                          sampleRate: 'PT1M'
                        }
                        {
                          counterSpecifier: '\\LogicalDisk(_Total)\\Avg. Disk sec/Read'
                          sampleRate: 'PT1M'
                        }
                        {
                          counterSpecifier: '\\LogicalDisk(_Total)\\Avg. Disk sec/Write'
                          sampleRate: 'PT1M'
                        }
                        {
                          counterSpecifier: '\\LogicalDisk(_Total)\\Avg. Disk Queue Length'
                          sampleRate: 'PT1M'
                        }
                        {
                          counterSpecifier: '\\LogicalDisk(_Total)\\Avg. Disk Read Queue Length'
                          sampleRate: 'PT1M'
                        }
                        {
                          counterSpecifier: '\\LogicalDisk(_Total)\\Avg. Disk Write Queue Length'
                          sampleRate: 'PT1M'
                        }
                        {
                          counterSpecifier: '\\LogicalDisk(_Total)\\% Free Space'
                          sampleRate: 'PT1M'
                        }
                        {
                          counterSpecifier: '\\LogicalDisk(_Total)\\Free Megabytes'
                          sampleRate: 'PT1M'
                        }
                        {
                          counterSpecifier: '\\Network Interface(*)\\Bytes Total/sec'
                          sampleRate: 'PT1M'
                        }
                        {
                          counterSpecifier: '\\Network Interface(*)\\Bytes Sent/sec'
                          sampleRate: 'PT1M'
                        }
                        {
                          counterSpecifier: '\\Network Interface(*)\\Bytes Received/sec'
                          sampleRate: 'PT1M'
                        }
                        {
                          counterSpecifier: '\\Network Interface(*)\\Packets/sec'
                          sampleRate: 'PT1M'
                        }
                        {
                          counterSpecifier: '\\Network Interface(*)\\Packets Sent/sec'
                          sampleRate: 'PT1M'
                        }
                        {
                          counterSpecifier: '\\Network Interface(*)\\Packets Received/sec'
                          sampleRate: 'PT1M'
                        }
                        {
                          counterSpecifier: '\\Network Interface(*)\\Packets Outbound Errors'
                          sampleRate: 'PT1M'
                        }
                        {
                          counterSpecifier: '\\Network Interface(*)\\Packets Received Errors'
                          sampleRate: 'PT1M'
                        }
                      ]
                    }
                    WindowsEventLog: {
                      scheduledTransferPeriod: 'PT1M'
                      DataSource: [
                        {
                          name: 'Application!*[System[(Level = 1 or Level = 2 or Level = 3)]]'
                        }
                        {
                          name: 'Security!*[System[band(Keywords,4503599627370496)]]'
                        }
                        {
                          name: 'System!*[System[(Level = 1 or Level = 2 or Level = 3)]]'
                        }
                      ]
                    }
                  }
                  SinksConfig: {
                    Sink: [
                      {
                        name: 'AzMonSink'
                        AzureMonitor: {}
                      }
                    ]
                  }
                }
              }
              protectedSettings: {
                storageAccountName: storage.outputs.storageAccountName
                storageAccountKey: storage.outputs.storageAccountKey
                storageAccountEndPoint: 'https://core.windows.net/'
              }
            }
          }
        ]
      }
    }
  }
  dependsOn:[
    vswindowsvmext
    lawsdeployment
  ]
}
resource cpuautoscale_namingInfix 'microsoft.insights/autoscalesettings@2015-04-01' = {
  name: 'cpuautoscale${namingInfix}'
  location: location
  properties: {
    name: 'cpuautoscale${namingInfix}'
    targetResourceUri: vmssdeployment.id
    enabled: true
    profiles: [
      {
        name: 'Profile1'
        capacity: {
          minimum: '2'
          maximum: '4'
          default: '2'
        }
        rules: [
          {
            metricTrigger: {
              metricName: 'Percentage CPU'
              metricNamespace: ''
              metricResourceUri: vmssdeployment.id
              timeGrain: 'PT1M'
              statistic: 'Average'
              timeWindow: 'PT5M'
              timeAggregation: 'Average'
              operator: 'GreaterThan'
              threshold: 75
            }
            scaleAction: {
              direction: 'Increase'
              type: 'ChangeCount'
              value: '1'
              cooldown: 'PT1M'
            }
          }
          {
            metricTrigger: {
              metricName: 'Percentage CPU'
              metricNamespace: ''
              metricResourceUri: vmssdeployment.id
              timeGrain: 'PT1M'
              statistic: 'Average'
              timeWindow: 'PT5M'
              timeAggregation: 'Average'
              operator: 'LessThan'
              threshold: 25
            }
            scaleAction: {
              direction: 'Decrease'
              type: 'ChangeCount'
              value: '1'
              cooldown: 'PT1M'
            }
          }
        ]
      }
    ]
  }
}

module aksdeployment 'modules/aks/aks.bicep' = {
  name: 'aksdeployment'
  params:{
    subnetRef: vnet.outputs.subnetRef[2]
    omsWorkspaceId: lawsdeployment.outputs.laWsResourceId
    dnsPrefix: '${envPrefixName}azhtaksdnsname'
    clusterName: envPrefixName
    nodeResourceGroup: 'MC_${envPrefixName}-AKS-nodes-rg'
  
  }
}
