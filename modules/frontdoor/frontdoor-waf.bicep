param frontDoorWafName string = 'AzFd-TestingBicep-999'
param frontDoorWafEnabledState bool = true

@allowed([
  'Prevention'
  'Detection'
])
param frontDoorWafMode string = 'Prevention'

@allowed([
  'Allow'
  'Block'
  'Log'
])
@description('Type of Action based on the match filter. Must be Allow, Block or Log.')
param rateLimitAction string = 'Log'

// "matchVariable": "RequestUri",
// "selector": null,
// "operator": "Any",
// "negateCondition": false,
// "matchValue": [],
// "transforms": []

param customRuleLimit object = {
  name: 'limitRule'
  enabledState: 'Enabled'
  priority: 1
  ruleType: 'RateLimitRule'
  rateLimitDurationInMinutes: 1
  rateLimitThreshold: 10
  matchConditions: [
    {
      matchVariable: 'RequestUri'
      operator: 'Any'
      negateCondition: false
      matchValue: []
      transforms: []
    }
  ]
  action: 'Block'
}

resource waf 'Microsoft.Network/FrontDoorWebApplicationFirewallPolicies@2019-10-01' = {
  name: frontDoorWafName
  location: 'Global'
  properties: {
    policySettings: {
      enabledState: frontDoorWafEnabledState ? 'Enabled' : 'Disabled'
      mode: frontDoorWafMode
      customBlockResponseStatusCode: 403
    }
    customRules: {
      rules: [
        customRuleLimit
      ]
    }
    managedRules: {
      managedRuleSets: [
        {
          ruleSetType: 'DefaultRuleSet'
          ruleSetVersion: '1.0'
          ruleGroupOverrides: []
          exclusions: []
        }
      ]
    }
  }
}
output wafID string = waf.id
