module sqldiagwindowsvmext 'modules/vmextension/vmextension.bicep' = {
  name: 'sqldiagextvsdeployment'
  params: {
    vmExtName: 'azmhSQLSrv16/VMDiagnosticsSettings'
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
                      {
                        counterSpecifier: '\\SQLServer:Databases(tpcc)\\Active Transactions'
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
