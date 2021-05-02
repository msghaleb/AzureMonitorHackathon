
# Challenge 2: Monitoring and Alert Rule Automation

  

  

- Update the parameters file and deployment script for the

  

GenerateAlertRules.json template located in the AlertTemplates

  

folder

  

  

- Add the names of your VMs and ResouceId for your Action Group

  

  

To find the ResourceId for your Action group navigate to the Resource

  

Group where you are stored the action group and make sure to check off

  

"Show hidden types".

  

  

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/images/image39.png){width="5.6936417322834645in"

  

height="2.3048304899387575in"}

  

  

Click on your Action Group and copy the ResourceId

  

  

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/images/image40.png){width="6.5in" height="3.9125in"}

  

  

Then update the deployAlertRules.parameters.json file as it shows below.

  

  

Or

  

  

In the deployAlertRulesTemplates.ps1 script update the resourcegroup and

  

run the first few lines then run the code to get the Azure Monitor

  

Action Group

  

  

\#Get Azure Monitor Action Group

  

  

(Get-AzActionGroup -ResourceGroup \"Default-activityLogAlerts\").Id

  

  

Copy and paste the resource Id for the Action Group you would like to

  

use.

  

  

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/images/image41.png){width="6.5in" height="1.325in"}

  

  

Save the parameters file and update the deployAlertRulesTemplate.ps1

  

file with the name of your Resource Group (and save it).

  

  

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/images/image42.png){width="6.5in" height="1.7673611111111112in"}

  

  

- Deploy the GenerateAlertRules.json template using the sample

  

PowerShell script (deployAlertRulesTemplate.ps1) or create a Bash

  

script (look at the example from the initial deployment)

  

  

>  \#Update Path to files as needed

  

>

  

>  \#Update the parameters file with the names of your VMs and the

  

> ResourceId of your Action Group (use command above to find ResourceId)

  

>

  

> \$template=\".\\AlertsTemplate\\GenerateAlertRules.json\"

  

>

  

> \$para=\".\\AlertsTemplate\\deployAlertRules.parameters.json\"

  

>

  

> \$job = \'job.\' +

  

> ((Get-Date).ToUniversalTime()).tostring(\"MMddyy.HHmm\")

  

>

  

> New-AzureRmResourceGroupDeployment \`

  

>

  

> -Name \$job \`

  

>

  

> -ResourceGroupName \$rg.ResourceGroupName \`

  

>

  

> -TemplateFile \$template \`

  

>

  

> -TemplateParameterFile \$para

  

  

- Verify you have new Monitor Alert Rules in the Portal or from the

  

command line (sample command is in the deployment script)

  

  

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/images/image43.png){width="6.5in" height="1.1458333333333333in"}

  

  

- Modify the GenerateAlertsRules.json to include "Disk Write

  

Operations/Sec" and set a threshold of 10\

  

**Tip:** Go here to view the list of metrics available by resource

  

type -

  

<https://docs.microsoft.com/en-us/azure/monitoring-and-diagnostics/monitoring-supported-metrics#microsoftcomputevirtualmachines>

  

  

> Use this link to see the ARM schema -

  

> <https://docs.microsoft.com/en-us/rest/api/monitor/metricalerts/update>

  

>

  

> {

  

>

  

> \"type\": \"Microsoft.Insights/metricAlerts\",

  

>

  

> \"name\":

  

> \"\[concat(\'Disk_Write_Alert\',\'-\',parameters(\'alertVMs\')\[copyIndex()\])\]\",

  

>

  

> \"copy\": {

  

>

  

> \"name\": \"iterator\",

  

>

  

> \"count\": \"\[length(parameters(\'alertVMs\'))\]\"

  

>

  

> },

  

>

  

> \"apiVersion\": \"2018-03-01\",

  

>

  

> \"location\": \"global\",

  

>

  

> \"tags\": {},

  

>

  

> \"scale\": null,

  

>

  

> \"properties\": {

  

>

  

> \"description\": \"Disk Write metric has detected a large amount of

  

> disk operations\",

  

>

  

> \"severity\": \"\[parameters(\'alertSeverity\')\]\",

  

>

  

> \"enabled\": \"\[parameters(\'isEnabled\')\]\",

  

>

  

> \"scopes\": \[

  

>

  

> \"\[resourceId(\'Microsoft.Compute/virtualMachines\',

  

> parameters(\'alertVMs\')\[copyIndex()\])\]\"

  

>

  

>  \],

  

>

  

> \"evaluationFrequency\": \"PT5M\",

  

>

  

> \"windowSize\": \"PT5M\",

  

>

  

> \"criteria\": {

  

>

  

> \"odata.type\":

  

> \"Microsoft.Azure.Monitor.SingleResourceMultipleMetricCriteria\",

  

>

  

> \"allOf\": \[

  

>

  

> {

  

>

  

> \"name\": \"MetricDiskWriteOper\",

  

>

  

> \"metricName\": \"Disk Write Operations/Sec\",

  

>

  

> \"dimensions\": \[\],

  

>

  

> \"operator\": \"GreaterThan\",

  

>

  

> \"threshold\": 10,

  

>

  

> \"timeAggregation\": \"Average\"

  

>

  

> }

  

>

  

>  \]

  

>

  

> },

  

>

  

> \"actions\": \[

  

>

  

> {

  

>

  

> \"actionGroupId\": \"\[parameters(\'actionGroupId\')\]\",

  

>

  

> \"webHookProperties\": {}

  

>

  

> }

  

>

  

>  \]

  

>

  

> },

  

>

  

> \"dependsOn\": \[\]

  

>

  

> },

  

  

- Rerun your template and verify your new Alert Rules are created for

  

each of your VMs

  

  

>  ![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/images/image44.png){width="6.5in" height="1.3319444444444444in"}

  

  

- Create a new Action Rule that suppress alerts from the scale set and

  

virtual machines on Saturday and Sunday

  

  

>  ![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/images/image45.png){width="4.972222222222222in"

  

> height="2.1896905074365702in"}\

  

> Click on Manage actions

  

>

  

>  ![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/images/image46.png){width="3.5476432633420822in"

  

> height="1.1594433508311461in"}\

  

> Navigate to Action rules (preview)

  

>

  

>  ![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/images/image47.png){width="3.1494510061242345in"

  

> height="4.111111111111111in"}

  

>

  

> Under Scope, click on Select a resource and make sure you have your

  

> subscription selected. Then search for the name of the resource group

  

> that was created in the deployment of the workshop. Select your

  

> resource group when it comes up. Click Done

  

>

  

>  ![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/images/image48.png){width="3.888888888888889in"

  

> height="5.223824365704287in"}

  

>

  

> Under Filter Criteria, click on filters and select Resource type

  

> Equals Virtual Machines and Virtual Machine scales sets.

  

>

  

>  ![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/images/image49.png){width="4.1712959317585305in"

  

> height="2.3191688538932635in"}

  

>

  

> Under Suppression Config, click on Configure Suppression and configure

  

> the screen like the screen shot above.

  

>

  

>  ![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/images/image50.png){width="4.1840682414698165in"

  

> height="4.152777777777778in"}

  

>

  

> Add an Action Rule Name and Description, check off enable action Rule.

  

  

- First team to me a screenshot of the new Alert Rules and New Action

  

Rule wins the challenge!!

  

  

- Good luck!

  

  



> Written with [StackEdit](https://stackedit.io/).
