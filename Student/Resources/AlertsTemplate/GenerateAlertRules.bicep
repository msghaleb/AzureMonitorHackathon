@description('')
param alertVMs array

@allowed([
  0
  1
  2
  3
  4
])
@description('Sev 0 = Critical, Sev 1 = Error, Sev 2 = Warning, Sev 3 = Informational, Sev 4 = Verbose')
param alertSeverity int = 2
param isEnabled bool = true

@description('')
param actionGroupId string

resource Network_In_Alert_alertVMs 'Microsoft.Insights/metricAlerts@2018-03-01' = [for item in alertVMs: {
  name: 'Network_In_Alert-${item}'
  location: 'global'
  tags: {}
  //scale: null
  properties: {
    description: 'Network In metric has detected a large amount of  inbound traffic'
    severity: alertSeverity
    enabled: isEnabled
    scopes: [
      resourceId('Microsoft.Compute/virtualMachines', item)
    ]
    evaluationFrequency: 'PT5M'
    windowSize: 'PT5M'
    criteria: {
      'odata.type': 'Microsoft.Azure.Monitor.SingleResourceMultipleMetricCriteria'
      allOf: [
        {
          name: 'MetricNetIn'
          metricName: 'Network In'
          dimensions: []
          operator: 'GreaterThan'
          threshold: 4000000
          timeAggregation: 'Average'
          criterionType: 'StaticThresholdCriterion'
        }
      ]
    }
    actions: [
      {
        actionGroupId: actionGroupId
        webHookProperties: {}
      }
    ]
  }
  dependsOn: []
}]

resource CPU_Alert_alertVMs 'Microsoft.Insights/metricAlerts@2018-03-01' = [for item in alertVMs: {
  name: 'CPU_Alert-${item}'
  location: 'global'
  properties: {
    description: 'Alert for CPU Usage over 75 percent'
    severity: alertSeverity
    enabled: isEnabled
    scopes: [
      resourceId('Microsoft.Compute/virtualMachines', item)
    ]
    evaluationFrequency: 'PT1M'
    windowSize: 'PT5M'
    templateType: 8
    templateSpecificParameters: {}
    criteria: {
      allOf: [
        {
          name: 'MetricCPU'
          metricNamespace: 'Microsoft.Compute/virtualMachines'
          metricName: 'Percentage CPU'
          dimensions: []
          operator: 'GreaterThan'
          threshold: 75
          monitorTemplateType: 8
          timeAggregation: 'Average'
          criterionType: 'StaticThresholdCriterion'
        }
      ]
      'odata.type': 'Microsoft.Azure.Monitor.SingleResourceMultipleMetricCriteria'
    }
    autoMitigate: true
    actions: [
      {
        actionGroupId: actionGroupId
      }
    ]
  }
}]

// The below is part of challenge 2 and must be deleted
resource Disk_Write_Alert_alertVMs 'Microsoft.Insights/metricAlerts@2018-03-01' = [for item in alertVMs: {
  name: 'Disk_Write_Alert-${item}'
  location: 'global'
  properties: {
    description: 'Disk Write metric has detected a large amount of disk operations'
    severity: alertSeverity
    enabled: isEnabled
    scopes: [
      resourceId('Microsoft.Compute/virtualMachines', item)
    ]
    evaluationFrequency: 'PT5M'
    windowSize: 'PT5M'
    criteria: {
      allOf: [
        {
          name: 'MetricDiskWriteOper'
          metricNamespace: 'Microsoft.Compute/virtualMachines'
          metricName: 'Disk Write Operations/Sec'
          dimensions: []
          operator: 'GreaterThan'
          threshold: 10
          timeAggregation: 'Average'
          criterionType: 'StaticThresholdCriterion'
        }
      ]
      'odata.type': 'Microsoft.Azure.Monitor.SingleResourceMultipleMetricCriteria'
    }
    autoMitigate: true
    actions: [
      {
        actionGroupId: actionGroupId
      }
    ]
  }
}]
