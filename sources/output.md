![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/sources/images/image1.png){width="6.5in" height="5.618055555555555in"}

Version 1.1

# Contents {#contents .TOC-Heading}

[Workshop Setup 3](#workshop-setup)

[Guidance 3](#guidance)

[Challenge 1: Monitoring and Alert Rule
3](#challenge-1-monitoring-and-alert-rule)

[Challenge 2: Monitoring and Alert Rule Automation
25](#challenge-2-monitoring-and-alert-rule-automation)

[Challenge 3: Application Insights
32](#challenge-3-application-insights)

[Challenge 4: Azure Monitor for Containers
46](#challenge-4-azure-monitor-for-containers)

[Challenge 5: Log Analytics Query 56](#challenge-5-log-analytics-query)

[Challenge 6: Dashboard and Analytics
60](#challenge-6-dashboard-and-analytics)

[Challenge 6a: Workbooks 82](#challenge-6a-workbooks)

# Workshop Setup

-   Deploy Infra using Bash Cloud Shell and Azure CLI with an ARM
    Template

    -   Setup Azure CLI\
        <https://docs.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest>

    -   Install Visual Studio Code and Extensions (depending on your
        tool of choice)

        -   Azure Resource Manager Tools -
            <https://marketplace.visualstudio.com/items?itemName=msazurermtools.azurerm-vscode-tools>

        -   Azure Account and Sign-In (adds the Azure Cloud Shell for
            Bash) -
            <https://marketplace.visualstudio.com/items?itemName=ms-vscode.azure-account>\
            Azure CLI Tools --\
            <https://marketplace.visualstudio.com/items?itemName=ms-vscode.azurecli>

    -   Download Azure Monitoring Workshop Setup Guide and follow the
        instructions to deploy.\
        <https://github.com/rkuehfus/pre-ready-2019-H1/blob/master/Student/Guides/Deployment%20Setup%20Guide.docx?raw=true>

## Guidance

Biggest issues I have seen when deploying the workshop are around
compute quotas, changing the region to one that does not support the
Azure Monitor preview, not having contributor role membership to the
subscription and local machine issues. If you run into a student who
cannot seem to get her or his computer working with the Azure CLI, have
them use the Azure Cloud Shell. Remember to copy up the ARM template and
parameters JSON files before kicking off the deployment.

I highly recommend your students make sure they have an Azure
Subscription they have contributor role access to before day one of the
hack.

# Challenge 1: Monitoring and Alert Rule

-   Create an empty database called "tpcc" on the SQL Server\
    Note: Use SQL Auth with the username being sqladmin and password
    being whatever you used during deployment

    -   Connect (RDP) to the Visual Studio Server (xxxxxVSSrv17) using
        its public IP address and open Visual Studio. Create an account
        if you don't have one.

    -   VS has view called SQL Server Object Explorer that can be used
        to create and delete SQL databases on the SQL server\
        ![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/sources/images/image2.png){width="3.176686351706037in"
        height="2.8850557742782152in"}

    -   Connect to the database server VM, make sure to use sqladmin and
        the password you stored in the key vault during deployment\
        ![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/sources/images/image3.png){width="3.9385247156605425in"
        height="4.799445538057743in"}\
        ![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/sources/images/image4.png){width="4.0448009623797025in"
        height="2.74002624671916in"}\
        Once connected create a new database called "tpcc"

> ![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/sources/images/image5.png){width="3.020456036745407in"
> height="3.4162390638670166in"}

-   From the ARM template, send the below guest OS metric to Azure
    Monitor for the SQL Server

    -   Add a Performance Counter Metric for

        -   Object: SQLServer:Databases

        -   Counter: Active Transactions

        -   Instance:tpcc

    -   Hint:
        <https://docs.microsoft.com/en-us/azure/monitoring-and-diagnostics/metrics-store-custom-guestos-resource-manager-vm>

    -   First, figure out the correct format for the counter use the run
        command on the SQL Server in the Azure portal and run --

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/sources/images/image6.png){width="5.069566929133858in"
height="3.1343569553805772in"}

Run the command - (Get-Counter -ListSet SQLServer:Databases).Paths

Once its finished, review the results (scroll up) and copy the output
for the SQLServer:Databases counter.\
![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/sources/images/image7.png){width="5.916515748031496in"
height="3.8381496062992126in"}

\\SQLServer:Databases(\*)\\Active Transactions

Then change it to target just your specific database

\\SQLServer:Databases(tpcc)\\Active Transactions

**Tip:** Share the following link to help lead them to how to find the
counter

> <https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.diagnostics/get-counter?view=powershell-5.1>

Next, once you have the counter you need to modify the ARM template for
the SQL Server to add the collection of this counter that sends it to
Azure Monitor using the Azure monitor data sink

Add this JSON to the SQL Server code

Verify the identity is present in the template (add it if its missing)

\"identity\": {

\"type\": \"SystemAssigned\"

},

And the missing counter below

\"resources\":\[

{

\"type\": \"extensions\",

\"name\": \"Microsoft.Insights.VMDiagnosticsSettings\",

\"apiVersion\": \"2015-05-01-preview\",

\"location\": \"\[resourceGroup().location\]\",

\"dependsOn\": \[

\"\[concat(\'Microsoft.Compute/virtualMachines/\',
concat(parameters(\'envPrefixName\'), \'sqlSrv16\'))\]\"

\],

\"properties\": {

\"publisher\": \"Microsoft.Azure.Diagnostics\",

\"type\": \"IaaSDiagnostics\",

\"typeHandlerVersion\": \"1.5\",

\"autoUpgradeMinorVersion\": true,

\"settings\": {

\"WadCfg\": {

\"DiagnosticMonitorConfiguration\": {

\"overallQuotaInMB\": 4096,

\"DiagnosticInfrastructureLogs\": {

\"scheduledTransferLogLevelFilter\": \"Error\"

},

\"Directories\": {

\"scheduledTransferPeriod\": \"PT1M\",

\"IISLogs\": {

\"containerName\": \"wad-iis-logfiles\"

},

\"FailedRequestLogs\": {

\"containerName\": \"wad-failedrequestlogs\"

}

},

\"PerformanceCounters\": {

\"scheduledTransferPeriod\": \"PT1M\",

\"sinks\": \"AzMonSink\",

\"PerformanceCounterConfiguration\": \[

{

\"counterSpecifier\": \"\\\\Memory\\\\Available Bytes\",

\"sampleRate\": \"PT15S\"

},

{

\"counterSpecifier\": \"\\\\Memory\\\\% Committed Bytes In Use\",

\"sampleRate\": \"PT15S\"

},

{

\"counterSpecifier\": \"\\\\Memory\\\\Committed Bytes\",

\"sampleRate\": \"PT15S\"

},

{

\"counterSpecifier\": \"\\\\SQLServer:Databases(tpcc)\\\\Active
Transactions\",

\"sampleRate\": \"PT15S\"

}

\]

},

\"WindowsEventLog\": {

\"scheduledTransferPeriod\": \"PT1M\",

\"DataSource\": \[

{

\"name\": \"Application!\*\"

}

\]

},

\"Logs\": {

\"scheduledTransferPeriod\": \"PT1M\",

\"scheduledTransferLogLevelFilter\": \"Error\"

}

},

\"SinksConfig\": {

\"Sink\": \[

{

\"name\": \"AzMonSink\",

\"AzureMonitor\": {}

}

\]

}

},

\"StorageAccount\": \"\[variables(\'storageAccountName\')\]\"

},

\"protectedSettings\": {

\"storageAccountName\": \"\[variables(\'storageAccountName\')\]\",

\"storageAccountKey\":
\"\[listKeys(variables(\'accountid\'),\'2015-06-15\').key1\]\",

\"storageAccountEndPoint\": \"https://core.windows.net/\"

}

}

},

{

\"type\": \"extensions\",

\"name\": \"WADExtensionSetup\",

\"apiVersion\": \"2015-05-01-preview\",

\"location\": \"\[resourceGroup().location\]\",

\"dependsOn\": \[

\"\[concat(\'Microsoft.Compute/virtualMachines/\',
concat(parameters(\'envPrefixName\'), \'sqlSrv16\'))\]\"

\],

\"properties\": {

\"publisher\": \"Microsoft.ManagedIdentity\",

\"type\": \"ManagedIdentityExtensionForWindows\",

\"typeHandlerVersion\": \"1.0\",

\"autoUpgradeMinorVersion\": true,

\"settings\": {

\"port\": 50342

}

}

}

\]

Save and redeploy.

Once redeployed, go to metrics and check to make sure you are seeing the
new metrics.\
![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/sources/images/image8.png){width="6.5in" height="2.4229166666666666in"}

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/sources/images/image9.png){width="6.5in" height="1.8354166666666667in"}

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/sources/images/image10.png){width="6.5in" height="2.5590277777777777in"}

**Tip:** A bunch of OS metrics are configured already under the scale
set as a sample.

-   Download and Install HammerDB tool on the Visual Studio VM. Note: I
    copy of these instructions are in the student folder under
    "AzureMonitoringHackathon\\Student\\Guides\\Day-1"

    -   [www.hammerdb.com](http://www.hammerdb.com/)

**Note:** HammerDB does not have native support for Windows Display
Scaling. This may result in a smaller than usual UI that is difficult to
read over high resolution RDP sessions. If you run into this issue
later, close and re-open your RDP session to the VSServer with a lower
display resolution. After the RDP session connects, you can zoom into to
adjust the size.

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/sources/images/image11.png){width="2.2708333333333335in"
height="2.6446576990376203in"} ![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/sources/images/image12.png){width="3.375in"
height="2.6445898950131235in"}

From the Visual Studio Server, download the latest version of HammerDB\
![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/sources/images/image13.png){width="6.5in" height="3.95625in"}

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/sources/images/image14.png){width="3.063583770778653in"
height="1.371907261592301in"}

If you get this Security Warning, go to Internet Options.

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/sources/images/image15.png){width="4.639721128608924in"
height="4.815197944006999in"}

Security \\ Security Settings \\ Downloads \\ File download \\ Enable

Click OK

Try again

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/sources/images/image16.png){width="6.5in" height="0.475in"}

Click Actions and accept the warnings

Tip: If you end up closing HammerDB you have to go to C:\\Program
Files\\HammerDB-3.1 and run the batch file

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/sources/images/image17.png){width="3.8647331583552056in"
height="2.204054024496938in"}

-   Use HammerDB to create transaction load

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/sources/images/image18.png){width="6.5in" height="5.456944444444445in"}

Double click on SQL Server and click OK, and OK on the confirm popup

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/sources/images/image19.png){width="6.5in" height="5.524305555555555in"}

Drill into SQL Server \\ TPC-C \\ Schema Build and double click on
Options

Modify the Build Options for the following:

SQL Server: Name of your SQL Server

SQL Server ODBC Driver: SQL Server

Authentication: SQL Server Authentication

SQL Server User ID: sqladmin

SQL Server User Password: \<password you stored in the Key Vault\>

SQL Server Database: tpcc

Number of Warehouses: 50

Virtual Users to Build Schema: 50

Note: Setting the last two at 50 should generate enough load to trip a
threshold and run long enough for you to graph

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/sources/images/image20.png){width="6.5in" height="4.574305555555555in"}

Double click on Build and Click Yes to kick of a load test.

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/sources/images/image21.png){width="6.5in" height="5.559027777777778in"}

When the test is running it should like this.

TIP: If you would like to run a second test you **must** first delete
the database you created and recreate it. HammerDB will not run a test
against a database that has data in it. When you run a test is fills the
database with a bunch of sample data.

-   From Azure Monitor,

    -   Create a graph for the SQL Server Active Transactions and
        Percent CPU and pin to your Azure Dashboard

    -   Note: I had to customize the dashboard once I pinned it to a new
        Azure Dashboard\
        ![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/sources/images/image22.png){width="5.311639326334208in"
        height="2.549132764654418in"}

> ![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/sources/images/image23.png){width="5.415277777777778in"
> height="2.479109798775153in"}\
> ![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/sources/images/image24.png){width="5.415764435695538in"
> height="4.359806430446194in"}
>
> Dashboard should look something like this.

-   From Azure Monitor, create an Action group, to send email to your
    address

> ![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/sources/images/image25.png){width="5.516665573053368in"
> height="5.011560586176728in"}

-   Create an Alert if Active Transactions goes over 40 on the SQL
    Server tpcc database.

> ![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/sources/images/image26.png){width="5.768175853018373in"
> height="3.1965310586176727in"}
>
> ![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/sources/images/image27.png){width="4.416185476815398in"
> height="2.4836318897637795in"}
>
> ![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/sources/images/image28.png){width="4.213872484689414in"
> height="6.078104768153981in"}
>
> ![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/sources/images/image29.png){width="5.4739884076990375in"
> height="1.9942629046369205in"}
>
> ![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/sources/images/image30.png){width="5.9190748031496065in"
> height="1.3090266841644795in"}
>
> ![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/sources/images/image31.png){width="6.0809251968503935in"
> height="0.200748031496063in"}
>
> ![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/sources/images/image32.png){width="4.8217661854768155in"
> height="4.502890419947507in"}

-   Create an Alert Rule for CPU over 75% on the Virtual Scale Set that
    emails me when you go over the threshold.

> First create a dashboard to watch the Scale Set CPU
>
> ![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/sources/images/image33.png){width="6.5in" height="2.761111111111111in"}
>
> Navigate to the folder called "Loadscripts" under the Resources folder
> in Student and copy the cpuGenLoadwithPS.ps1 script to both instances
> running in the Scale Set and run them.
>
> This may be a bit of a challenge to those not used to working with a
> scale set. If your student just grabs the public IP address and then
> RDP to it. They will end up on one of the instances but because they
> are going through the Load Balancer, they cannot control which one. Or
> can they?
>
> If you look at the configuration of the LB it is configured with an
> inbound NAT rule that will map starting at port 50000 to each instance
> in the Scale Set. So if they RDP using the PIP:50000 for instance 1
> and PIP:50001 for instance 2.

\"inboundNatPools\": \[

{

\"name\": \"natpool\",

\"properties\": {

\"frontendIPConfiguration\": {

\"id\": \"\[concat(variables(\'webLbId\'),
\'/frontendIPConfigurations/loadBalancerFrontEnd\')\]\"

},

\"protocol\": \"Tcp\",

\"frontendPortRangeStart\": 50000,

\"frontendPortRangeEnd\": 50119,

\"backendPort\": 3389

}

}

\],

> For Example,
>
> ![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/sources/images/image34.png){width="3.393063210848644in"
> height="3.037832458442695in"}

Jump on to both VMs in the Scale Set, Open the PowerShell ISE, Copy the
script in the window and run it. You may need to run it more then once
to really add the pressure. This script will pin each core on the VM no
matter how many you have.

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/sources/images/image35.png){width="6.375722878390201in"
height="2.5448403324584428in"}

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/sources/images/image36.png){width="5.447732939632546in"
height="2.6994214785651796in"}

The trick to getting the alert to fire is to pin both instances at the
same time as the CPU metric is an aggregate of the scale set. If you
just max the CPU on one server to 100% the Scale Set is only at 50% and
till not trip the alert threshold of 75%. Also, if they run the script
and then setup the Alert Rule then to back to run another test to trip
the alert, they have scaled out to a third instance and not realized it.
They may need to jump on that box and max it out as well.

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/sources/images/image37.png){width="6.5in" height="1.5083333333333333in"}

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/sources/images/image38.png){width="5.146409667541557in"
height="4.011560586176728in"}

-   First team to send me both alerts wins the challenge!!

-   Good luck!

# Challenge 2: Monitoring and Alert Rule Automation

-   Update the parameters file and deployment script for the
    GenerateAlertRules.json template located in the AlertTemplates
    folder

    -   Add the names of your VMs and ResouceId for your Action Group

To find the ResourceId for your Action group navigate to the Resource
Group where you are stored the action group and make sure to check off
"Show hidden types".

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/sources/images/image39.png){width="5.6936417322834645in"
height="2.3048304899387575in"}

Click on your Action Group and copy the ResourceId

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/sources/images/image40.png){width="6.5in" height="3.9125in"}

Then update the deployAlertRules.parameters.json file as it shows below.

Or

In the deployAlertRulesTemplates.ps1 script update the resourcegroup and
run the first few lines then run the code to get the Azure Monitor
Action Group

\#Get Azure Monitor Action Group

(Get-AzActionGroup -ResourceGroup \"Default-activityLogAlerts\").Id

Copy and paste the resource Id for the Action Group you would like to
use.

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/sources/images/image41.png){width="6.5in" height="1.325in"}

Save the parameters file and update the deployAlertRulesTemplate.ps1
file with the name of your Resource Group (and save it).

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/sources/images/image42.png){width="6.5in" height="1.7673611111111112in"}

-   Deploy the GenerateAlertRules.json template using the sample
    PowerShell script (deployAlertRulesTemplate.ps1) or create a Bash
    script (look at the example from the initial deployment)

> \#Update Path to files as needed
>
> \#Update the parameters file with the names of your VMs and the
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

-   Verify you have new Monitor Alert Rules in the Portal or from the
    command line (sample command is in the deployment script)

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/sources/images/image43.png){width="6.5in" height="1.1458333333333333in"}

-   Modify the GenerateAlertsRules.json to include "Disk Write
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
> \],
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
> \]
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
> \]
>
> },
>
> \"dependsOn\": \[\]
>
> },

-   Rerun your template and verify your new Alert Rules are created for
    each of your VMs

> ![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/sources/images/image44.png){width="6.5in" height="1.3319444444444444in"}

-   Create a new Action Rule that suppress alerts from the scale set and
    virtual machines on Saturday and Sunday

> ![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/sources/images/image45.png){width="4.972222222222222in"
> height="2.1896905074365702in"}\
> Click on Manage actions
>
> ![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/sources/images/image46.png){width="3.5476432633420822in"
> height="1.1594433508311461in"}\
> Navigate to Action rules (preview)
>
> ![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/sources/images/image47.png){width="3.1494510061242345in"
> height="4.111111111111111in"}
>
> Under Scope, click on Select a resource and make sure you have your
> subscription selected. Then search for the name of the resource group
> that was created in the deployment of the workshop. Select your
> resource group when it comes up. Click Done
>
> ![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/sources/images/image48.png){width="3.888888888888889in"
> height="5.223824365704287in"}
>
> Under Filter Criteria, click on filters and select Resource type
> Equals Virtual Machines and Virtual Machine scales sets.
>
> ![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/sources/images/image49.png){width="4.1712959317585305in"
> height="2.3191688538932635in"}
>
> Under Suppression Config, click on Configure Suppression and configure
> the screen like the screen shot above.
>
> ![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/sources/images/image50.png){width="4.1840682414698165in"
> height="4.152777777777778in"}
>
> Add an Action Rule Name and Description, check off enable action Rule.

-   First team to me a screenshot of the new Alert Rules and New Action
    Rule wins the challenge!!

-   Good luck!

# Challenge 3: Application Insights 

Enable Application Insights server-side telemetry in the eShopOnWeb Web
Project in the Solution.

Hint:
<https://docs.microsoft.com/en-us/azure/azure-monitor/app/asp-net-core#enable-application-insights-server-side-telemetry-no-visual-studio>

From the Visual Studio Server, navigate to
C:\\eshoponweb\\eShopOnWeb-master and double-click on eShopOnWeb.sln

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/sources/images/image51.png){width="6.5in" height="2.747916666666667in"}

If this is the first time you are opening Visual Studio, please log in
or create an account and log in.

Select Web

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/sources/images/image52.png){width="6.5in" height="1.8354166666666667in"}

Right-click on Web in Solutions Explorer and select properties. Under
Debug unselect the checkbox for Enable SSL.

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/sources/images/image53.png){width="6.5in" height="4.65625in"}

Click Save.

Click on IIS Express to test the eShopOnWeb application.

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/sources/images/image54.jpeg){width="6.5in" height="4.052083333333333in"}

You should see the eShop app open locally. Close it and let's Enable
Application Insights server-side telemetry collection.

Install the Application Insights SDK NuGet package for ASP.NET Core. We
recommend that you always use the latest stable version. Open Web.csproj
and add the following line:

\<PackageReference Include=\"Microsoft.ApplicationInsights.AspNetCore\"
Version=\"2.13.1\" /\>

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/sources/images/image55.png){width="6.5in" height="2.1256944444444446in"}

Add services.AddApplicationInsightsTelemetry(); to the
ConfigureServices() method in your Startup class

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/sources/images/image56.png){width="6.5in" height="2.8555555555555556in"}

Specify an instrumentation key in appsettings.json

You can find your App Insights Instrumentation key in the Overview blade
of your Application Insights resource in the Portal.

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/sources/images/image57.png){width="6.5in" height="1.8180555555555555in"}

\"ApplicationInsights\": {

\"InstrumentationKey\": \"putinstrumentationkeyhere\"

},

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/sources/images/image58.png){width="6.5in" height="2.6777777777777776in"}

-   Run the eShopOnWeb Web project and check out the App Insights
    tooling

Test the application by running it and verify it's working.

While its running you can navigate to Application Insights and view the
telemetry while you are interacting with eShop running on the local
machine. Add something to the shopping cart, log in and check out.

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/sources/images/image59.png){width="6.5in" height="2.2784722222222222in"}

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/sources/images/image60.png){width="6.5in" height="2.8854166666666665in"}

-   Generate some load and check out the results

-   Now you have the app running locally instrumented with Application
    Insights

> To trip an exception in the app, login with the demo account provided
> and try to change your password.

1.  Open your eShop site in your browser and login to the site running
    locally.\
    ![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/sources/images/image61.png){width="5.345844269466316in"
    height="4.226415135608049in"}\
    ![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/sources/images/image62.png){width="6.5in" height="4.233333333333333in"}

2.  Try to change your password\
    ![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/sources/images/image63.png){width="4.4277449693788276in"
    height="0.9702252843394575in"}\
    ![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/sources/images/image64.png){width="4.6473982939632545in"
    height="3.524277121609799in"}

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/sources/images/image65.png){width="6.5in" height="2.490972222222222in"}

-   Find the exception in App Insights

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/sources/images/image66.png){width="6.5in" height="3.8430555555555554in"}

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/sources/images/image67.png){width="2.547209098862642in"
height="3.751444663167104in"}

-   Create Alerts based on Availability and exceptions

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/sources/images/image68.png){width="6.5in" height="5.579861111111111in"}

-   First team to share a screenshot with the alert email of the
    exception based on the App Insights metric wins the challenge. Good
    luck.

**Client Telemetry**

Enable client-side telemetry collection for your eShoponWeb application.

Hint:
<https://docs.microsoft.com/en-us/azure/azure-monitor/app/asp-net-core#enable-client-side-telemetry-for-web-applications>

Inject the App Insights .NET Core JavaScript snippet

Add the following line of code to Web\\Views\\ \_ViewImports.cshtml

\@inject Microsoft.ApplicationInsights.AspNetCore.JavaScriptSnippet
JavaScriptSnippet

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/sources/images/image69.png){width="6.5in" height="3.1798611111111112in"}

Insert HtmlHelper at the end of the \<head\> section in

Add the following line of code to Web\\Views\\Shared\\\_Layout.cshtml

\@Html.Raw(JavaScriptSnippet.FullScript)

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/sources/images/image70.png){width="6.5in" height="3.6666666666666665in"}

Run the app locally and explore a few pages to generate page views.
After a few minutes, verify that page views are being collected by App
Insights.

In the Portal, navigate to the Performance blade of your App Insights
resource and switch the toggle from Server to Browser.

Stop the app running locally and save a copy of your updated Solution in
a new location.

**Autoscale**

Your app is also hosted on the VMSS deployed as part of the workshop
environment. Generate test load on the VMSS app url to cause a scale out
event.

From your Visual Studio Server copy the code in the LoadScripts folder
and modify it to your VMSS app URL

for (\$i = 0 ; \$i -lt 100; \$i++)

{

Invoke-WebRequest -uri http://
mon19webscalesetlb.eastus.cloudapp.azure.com/

}

Run the code to generate some load on your eShopOnWeb site running on
the VMSS. If the load is high enough, it may cause a scale out
operation.

Share a screenshot with your scaleset scale out operation.

# Challenge 4: Azure Monitor for Containers

-   From your Visual Studio Server, deploy the eShoponWeb application to
    AKS

Install Docker Desktop and restart your Visual Studio VM. This step is
required before you can add Docker support to your eShoponWeb app in
Visual Studio.

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/sources/images/image71.png){width="5.028301618547681in"
height="2.388980752405949in"}

Complete the WSL 2 installation and restart Docker Desktop

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/sources/images/image72.png){width="4.339622703412074in"
height="1.5976859142607174in"}

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/sources/images/image73.png){width="3.2924529746281714in"
height="2.575547900262467in"}

Navigate to c:\\eshoponweb\\eShopOnWeb-master

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/sources/images/image74.png){width="6.5in" height="2.607638888888889in"}

Double-click on eShopOnWeb.sln solution file and select Visual Studio
2019 when prompted.

Sign into Visual Studio if you have not already done so.

Once Visual Studio opens and settles down.

Update your DB connection strings in appsettings.json to use the SQL
server IP address instead of hostname.

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/sources/images/image75.png){width="6.5in" height="2.745138888888889in"}

Right-click on Web and Add Docker Support. Leave the default option of
Linux selected and click OK. Regenerate a new Dockerfile and wait for
task to complete.

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/sources/images/image76.png){width="6.5in" height="4.3909722222222225in"}

When prompted All your docker backend to communicate with Private
Networks.

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/sources/images/image77.png){width="4.132075678040245in"
height="2.995949256342957in"}

When Docker support has been added, you should see a Docker option to
run/debug your app.

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/sources/images/image78.png){width="6.5in" height="1.7in"}

Click to run your app. Wait a few minutes for your app to build and
load. When its complete Visual Studio will open the URL in the default
browser. Your app is now running in a local container, click Stop.

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/sources/images/image79.png){width="6.5in" height="2.448611111111111in"}

-   From Azure Monitor, locate the container running the eShoponWeb
    application

Now, let's move on to publishing the app to AKS.

Go to the Azure Portal and create an Azure Container registry with a
Standard SKU in your workshop resource group.

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/sources/images/image80.png){width="6.5in" height="4.58125in"}

Once your Container Registry is created, return to Visual Studio and
right click on Web to publish.

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/sources/images/image81.png){width="3.358490813648294in"
height="3.2250929571303586in"}

Choose Azure, Azure Container Registry as your Publish target and select
the Container Registry that you just created. Click Finish.

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/sources/images/image82.png){width="5.773584864391951in"
height="2.664730971128609in"}

Next, navigate to the Connected Services for Web.

Configure Application Insights to Azure Application Insights, select
your App Insights resource and **Save connection string in None**.

Configure SQL DB CatalogConnection to point to SQL Server Database,
update connection string using the Catalog string found in
appsettings.json and **Save connection string in None**.

Configure SQL DB IdentityConnection to point to SQL Server Database,
update connection string using the Identity string found in
appsettings.json and **Save connection string in None**.

Update Secrets.json(Local) **Ignore for all profiles**.

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/sources/images/image83.png){width="6.5in" height="1.426388888888889in"}

Return to Publish and click on Publish to push your app up to the
Container Registry. This step will take several minutes. The final
Visual Studio output should indicate successful push.

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/sources/images/image84.png){width="6.5in" height="1.4465277777777779in"}

Open the provided deployment.yml file in Student\\Resources and update
the image name to point to your Container Registry Login server and
image.

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/sources/images/image85.png){width="6.5in" height="2.0527777777777776in"}

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/sources/images/image86.png){width="5.760416666666667in"
height="4.864583333333333in"}

Upload the deployment.yml and service.yml files to your cloud shell.

Check connectivity to and the state of your AKS nodes

kubectl get nodes

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/sources/images/image87.png){width="4.416666666666667in" height="0.90625in"}

Run the following command to deploy your app

kubectl apply -f deployment.yml

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/sources/images/image88.png){width="3.5729166666666665in" height="0.375in"}

After a few minutes, check the status of your pods

kubectl get pods

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/sources/images/image89.png){width="4.927083333333333in"
height="0.7395833333333334in"}

Run the following command to expose your app front-end on port 8080

kubectl apply -f service.yml

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/sources/images/image90.png){width="3.5104166666666665in"
height="0.3854166666666667in"}

After a few minutes, check on the status of your service

kubectl get services

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/sources/images/image91.png){width="6.21875in" height="0.7075470253718286in"}

Use the external IP of the web-service and port 8080 to access your app
deployed on AKS.

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/sources/images/image92.png){width="6.5in" height="5.308333333333334in"}

Return to the Azure Portal. From the Kubernetes service you created,
click on Insights or you can navigate to Azure Monitor, click on
Containers, and select your cluster.

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/sources/images/image93.png){width="6.5in" height="2.2180555555555554in"}

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/sources/images/image94.png){width="6.5in" height="2.0347222222222223in"}

Or

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/sources/images/image95.png){width="6.5in" height="3.571527777777778in"}

-   Generate an exception in the eShoponWeb application\
    (Hint: Try to change your password, similar to the exception
    generated in the Application Insights challenge)

> Login
>
> ![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/sources/images/image96.png){width="6.5in" height="4.413888888888889in"}
>
> Enter the user and password provided on the page.
>
> ![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/sources/images/image97.png){width="3.339293525809274in"
> height="1.8263888888888888in"}
>
> Click on My account
>
> ![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/sources/images/image98.png){width="6.5in" height="2.9451388888888888in"}
>
> Click on Password
>
> Notice an exception is thrown\
> ![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/sources/images/image99.png){width="5.977912292213474in"
> height="3.7547167541557305in"}
>
> Click on the Web container and View container live logs.
>
> ![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/sources/images/image100.png){width="6.5in" height="3.545138888888889in"}
>
> Trip the password exception again once the Status has gone from Unk to
> Ok.
>
> ![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/sources/images/image101.png){width="6.5in" height="2.4916666666666667in"}

-   First person to post a screen shot of the live log with the
    exception message wins the challenge

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/sources/images/image102.png){width="6.5in" height="3.5430555555555556in"}

# Challenge 5: Log Analytics Query

Write a performance query that renders a time chart for the last 4 hours
for both of the Web Servers and the SQL Server for the following perf
metrics. Save each query to your favorites.

-   Processor Utilization: Processor / % Processor Time

> Perf
>
> \| where ObjectName == \"Processor\" and CounterName == \"% Processor
> Time\" and TimeGenerated \> ago(4h)
>
> \| summarize AVGPROCESSOR = avg(CounterValue) by bin(TimeGenerated,
> 5m), Computer
>
> \| sort by AVGPROCESSOR desc
>
> \| render timechart

-   Memory Utilization: Memory / % Committed Bytes In Use

> Perf
>
> \| where ObjectName == \"Memory\" and CounterName == \"% Committed
> Bytes In Use\" and TimeGenerated \> ago(4h)
>
> \| summarize AVGMEMORY = avg(CounterValue) by bin(TimeGenerated, 5m),
> Computer
>
> \| sort by AVGMEMORY desc
>
> \| render timechart

-   Disk Utilization (IO): Disk Reads/sec and Disk Writes/sec

> Perf
>
> \| where CounterName == \"Disk Reads/sec\" and ObjectName ==
> \"LogicalDisk\" and TimeGenerated \> ago(4h)
>
> \| summarize AvgReadsDiskIO = avg(CounterValue) by bin(TimeGenerated,
> 5m), Computer
>
> \| sort by AvgReadsDiskIO desc
>
> \| render timechart

Perf

\| where CounterName == \"Disk Writes/sec\" and ObjectName ==
\"LogicalDisk\" and TimeGenerated \> ago(4h)

\| summarize AvgDiskWritesIO = avg(CounterValue) by bin(TimeGenerated,
5m), Computer

\| sort by AvgDiskWritesIO desc

\| render timechart

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/sources/images/image103.png){width="4.431621828521434in"
height="3.5590277777777777in"}

-   Create a heartbeat query for Web and SQL Server

> Heartbeat
>
> \| summarize max(TimeGenerated) by Computer
>
> \| where max_TimeGenerated \< ago(15m)
>
> \| count

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/sources/images/image104.png){width="5.172877296587926in"
height="4.211805555555555in"}

Write a performance query that renders a time chart for the last hour of
the max percentage CPU usage of the AKS Cluster nodes

Solution 1 using maxif

// Declare time range variable

let timerange = 1h;

Perf

\| where Computer startswith \"aks\"

\| where TimeGenerated \> ago(timerange)

//Aggregate maximum values of usage and capacity in 1 minute intervals
for each node

\| summarize CPUUsage = maxif(CounterValue, CounterName
==\"cpuUsageNanoCores\"),

CPUCapacity = maxif(CounterValue,CounterName ==
\"cpuCapacityNanoCores\")

by bin(TimeGenerated, 1m), Computer

//Calculate Percent Usage

\| extend PercentUsage = (CPUUsage / CPUCapacity) \*100.0

\| project TimeGenerated, PercentUsage, Computer

\| render timechart

Solution 2 using let and join

//Store last 1hr snapshot of Perf table

let myPerf = materialize (Perf

\| where Computer startswith \"aks\"

\| where TimeGenerated \> ago(1h));

//Store max CPU Usaqe per min values from Perf snapshot in usage table

let myUsage = myPerf

\| where CounterName == \"cpuUsageNanoCores\"

\| summarize CPUUsage = max(CounterValue) by bin(TimeGenerated, 1m),
Computer;

//Store max CPU capacity per min values from Perf snapshot in capacity
table

let myCapacity = myPerf

\| where CounterName == \"cpuCapacityNanoCores\"

\| summarize CPUCapacity = max(CounterValue) by bin(TimeGenerated, 1m),
Computer;

//Join usage and capacity tables

myUsage

\| join myCapacity on TimeGenerated, Computer

//Calculate percent usage

\| extend PercentUsage = (CPUUsage / CPUCapacity) \*100.0

\| project TimeGenerated, PercentUsage, Computer

\| render timechart

Combine infrastructure and application logs to create a single
timeseries chart that includes:

-   CPU usage from the node in your AKS cluster hosting the eshoponweb
    app

-   Duration of page views on your eshoponweb app hosted on the cluster

Solution 1

// Declare time range variable

let timerange = 5h;

//Find the node running your eshoponweb app container

let myNode = ContainerInventory

\| where Image == \"web\"

\| distinct Computer;

let PercentTable = Perf

\| where Computer in (myNode)

\| where TimeGenerated \> ago(timerange)

//Aggregate maximum values of usage and capacity in 1 minute intervals
for each node

\| summarize CPUUsage = maxif(CounterValue, CounterName
==\"cpuUsageNanoCores\"),

CPUCapacity = maxif(CounterValue,CounterName ==
\"cpuCapacityNanoCores\")

by bin(TimeGenerated, 1m)

//Calculate Percent Usage and rename TimeGenerated

\| extend PercentUsage = (CPUUsage / CPUCapacity) \*100.0, timestamp =
TimeGenerated

\| project timestamp, PercentUsage;

//Add AppInsights Data

let AppInsights = app(\"kjp17hackAppInsights\").pageViews

\| where timestamp \> ago(timerange)

\| summarize responsetime = avg(duration) by bin(timestamp, 1m)

\| extend responsetimeseconds = responsetime / 1000.0

\| project timestamp, responsetimeseconds;

// Join Percent Usage and AppInsights

PercentTable

\| join AppInsights on timestamp

\| project timestamp, PercentUsage, responsetimeseconds

\| render timechart

Solution 2 with hardcoding node name and using let and join statements

// Declare time range variable

let timerange = 5h;

//Store snapshot of Perf table for the node where the app container is
running

let myPerf = materialize ( Perf

\| where TimeGenerated \> ago(timerange)

\| where Computer == \"aks-agentpool-10755307-2\"

);

//Store Usage Values

let myUsage = myPerf

\| where CounterName == \"cpuUsageNanoCores\"

\| summarize CPUUsage = max(CounterValue) by bin(TimeGenerated, 1m);

//Store Capacity Values

let myCapacity = myPerf

\| where CounterName == \"cpuCapacityNanoCores\"

\| summarize CPUCapacity = max(CounterValue) by bin(TimeGenerated, 1m);

//Calculate Percentage and rename TimeGenerated to timestamp

let Percent = myUsage

\| join myCapacity on TimeGenerated

\| extend PercentUsage = (CPUUsage / CPUCapacity) \*100.0, timestamp =
TimeGenerated

\| project timestamp, PercentUsage;

//Add AppInsights Data

let AppInsights = app(\"kjp17hackAppInsights\").pageViews

\| where timestamp \> ago(timerange)

\| summarize responsetime = avg(duration) by bin(timestamp, 1m)

\| extend responsetimeseconds = responsetime/1000.0

\| project timestamp, responsetimeseconds

\| sort by timestamp asc;

// Join Percent Usage and AppInsights

Percent

\| join AppInsights on timestamp

\| project timestamp, PercentUsage, responsetimeseconds

\| sort by timestamp asc

\| render timechart

# Challenge 6: Dashboard and Analytics

-   Deploy Grafana using Web App for Container

<https://github.com/grafana/azure-monitor-datasource/blob/master/README.md>

-   Hint: <http://docs.grafana.org/installation/docker/>

Create a Web App for Linux and configure as recommended below.

Create a new App service plan and select B1 Basic. It's under Dev /
Test.![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/sources/images/image105.png){width="5.357808398950131in"
height="3.6875in"}\
![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/sources/images/image106.png){width="2.8311767279090114in"
height="2.513888888888889in"}

Select Container and specify Docker Hub, Public and Grafana/Grafana for
the image (this should deploy the latest version by default)\
![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/sources/images/image107.png){width="5.011681977252843in" height="2.75in"}

Should look like this when complete:\
![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/sources/images/image108.png){width="2.5277777777777777in"
height="4.423611111111111in"}

Click Create

After the Web App deploys, we need to configure some settings to enable
Azure Monitor Plugin.

From the Azure Portal navigate to your newly created App Service,
Settings, Application Settings

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/sources/images/image109.png){width="6.5in" height="3.8652777777777776in"}

Under Always On, change the value to On.

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/sources/images/image110.png){width="5.645127952755906in"
height="1.4060739282589676in"}

Under Application Settings, click on Show Values

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/sources/images/image111.png){width="6.5in" height="1.2138888888888888in"}

Change the value for WEBSITES_ENABLE_APP_SERVICE_STORAGE to true (from
false)

Click Add new Setting and add the following:

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/sources/images/image112.png){width="6.5in" height="1.7208333333333334in"}

Click Save

Note: For the Application settings to take effect you may need to
restart your Web App

**To Login to Grafana**

Click on Overview and copy the URL for your Web App

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/sources/images/image113.png){width="6.5in" height="1.4513888888888888in"}

Navigate to the URL in your browser

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/sources/images/image114.jpeg){width="5.119064960629921in" height="3.8125in"}

The username is "admin" lowercase and the password is whatever you
configured in Application Settings. Notice the version of Grafana as you
need 5.2.0 or newer if you are querying Azure Log Analytics.

Once logged into Grafana you should notice Azure Monitor is installed\
![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/sources/images/image115.png){width="5.258929352580927in"
height="3.9166666666666665in"}

-   Configure the Azure Monitor Data Source for Azure Monitor, Log
    Analytics and Application Insights

Configure Azure Monitor data source

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/sources/images/image116.png){width="2.4371948818897637in"
height="2.426780402449694in"}

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/sources/images/image117.png){width="6.5in" height="5.298611111111111in"}

Fill out the Azure Monitor API Details

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/sources/images/image118.png){width="6.5in" height="4.8597222222222225in"}

For Tenant Id, go to Azure AD, properties to find the Directory ID.

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/sources/images/image119.png){width="5.0in" height="4.083333333333333in"}

For Client Id, use the same client Id (Service Principal) you used in
the AKS deployment for terraform. Note: Azure best practices would be to
generate a new service principal and only grant the required
permissions.

Sample: ready-mws02-aks-preday Client Id =
0bd13b1d-2ddb-41e9-a286-d81328e9a72d

For Client Secret, use the same password you set in the Azure Key Vault
during the deployment

Note: Make sure to add the service principal created during the
deployment to your Log Analytics as a reader

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/sources/images/image120.png){width="3.075353237095363in"
height="7.173611111111111in"}

Click Save & Test and you should see a message like below.

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/sources/images/image121.png){width="6.5in" height="1.5263888888888888in"}

To configure Application Insights, find your API Id and generate a key

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/sources/images/image122.png){width="6.5in" height="5.636805555555555in"}

Copy the Application ID and paste in Grafana. Click on Create API Key

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/sources/images/image123.png){width="6.5in" height="4.7125in"}

Copy the key and paste in the Grafana Application Insights Details.
Note: you cannot retrieve this key again.

Click Save & Test. Should like this now.

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/sources/images/image124.png){width="6.5in" height="2.3131944444444446in"}

-   Create a CPU Chart with a Grafana variable used to select Computer
    Name

Create a new dashboard

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/sources/images/image125.png){width="2.593426290463692in"
height="2.353872484689414in"}

Add Graph

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/sources/images/image126.png){width="6.5in" height="3.310416666666667in"}

Edit the Panel Title

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/sources/images/image127.png){width="6.5in" height="3.24375in"}

Under General change to the name to something like Computer CPU

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/sources/images/image128.png){width="6.5in" height="2.8847222222222224in"}

Under Metrics, make sure service is Azure Log Analytics, your workspace
is selected, and build out a Log Analytics query (answer query below for
your reference).

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/sources/images/image129.png){width="6.490641951006125in"
height="3.612846675415573in"}

Sample query:

Perf

\| where \$\_\_timeFilter(TimeGenerated)

\| where CounterName == \"% Processor Time\" and InstanceName ==
\"\_Total\"

\| summarize percentile(CounterValue,50) by bin(TimeGenerated,
\$\_\_interval), Computer

\| order by TimeGenerated asc

Click Run to test

Now let's make a few changes. Click on Axes and change the Unit to
percent and Y-Max to 100.\
![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/sources/images/image130.png){width="6.5in" height="2.459722222222222in"}

Run it again

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/sources/images/image131.jpeg){width="6.5in" height="1.0097222222222222in"}

Let's save it by click on the disk in the upper right side.

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/sources/images/image132.png){width="6.5in" height="3.2930555555555556in"}

Should look something like this:

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/sources/images/image133.png){width="6.5in" height="3.7777777777777777in"}

[Advanced features]{.ul}

[ ]{.ul}

-   **Variables**

> Some query values can be selected through UI dropdowns, and updated in
> the query.
>
> For example, a "Computer" variable can be defined, and then a dropdown
> will appear on the dashboard, showing a list of possible values:

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/sources/images/image134.png){width="6.5in" height="4.8493055555555555in"}

Now let's add a variable that lets us select computers in the chart.
Click on the gear in the upper right corner.\
![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/sources/images/image135.png){width="6.5in" height="1.5604166666666666in"}

Click on Add Variable

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/sources/images/image136.png){width="6.5in" height="2.83125in"}

Configure the Variable to look like the screen below. Note: In my case I
make sure to specify the Workspace name as I have many workspaces and
wanted to make sure we only returned values that would work in our
chart.

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/sources/images/image137.png){width="6.5in" height="5.161111111111111in"}

Click Add.

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/sources/images/image138.png){width="6.5in" height="1.3701388888888888in"}

Make sure to Save your dashboard

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/sources/images/image139.png){width="6.5in" height="2.884027777777778in"}

Now go back and edit your Computer CPU chart to update the query to use
the new variable.

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/sources/images/image140.png){width="6.5in" height="1.3972222222222221in"}

Sample update Computer CPU query to support variable \$ComputerName

Perf

\| where \$\_\_timeFilter(TimeGenerated) and Computer in
(\$ComputerName)

\| where (CounterName == \"% Processor Time\" and InstanceName ==
\"\_Total\") or CounterName == \"% Used Memory\"

\| summarize AVGPROCESSOR = avg(CounterValue) by bin(TimeGenerated,
\$\_\_interval), Computer

\| order by TimeGenerated asc

Make sure to Save

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/sources/images/image141.png){width="6.5in" height="2.842361111111111in"}

Try it out!

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/sources/images/image142.png){width="6.5in" height="4.354861111111111in"}

Try creating a variable that accepts percentiles (50, 90 and 95).

-   **Annotations**

> Another cool Grafana feature is annotations -- which marks points in
> time that you can overlay on top of charts.
>
> Below, you can see the same chart shown above, with an annotation of
> Heartbeats. Hovering on a specific annotation shows informative text
> about it.
>
> **Configuration** is very similar to Variables:
>
> Click the dashboard Settings button (on the top right area), select
> "Annotations", and then "+New".
>
> This page shows up, where you can define the data source (aka
> "Service") and query to run in order to get the list of values (in
> this case a list of computer heartbeats).
>
> Note that the output of the query should include a date-time value, a
> Text field with interesting info (in this case we used the computer
> name) and possibly tags (here we just used "test").

Add an Annotation to your chart overlaying Computer Heartbeat

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/sources/images/image143.png){width="6.5in" height="4.418055555555555in"}

FYI... Annotations provide a way to mark points on the graph with rich
events. When you hover over an annotation you can get event description
and event tags. The text field can include links to other systems with
more detail.

Navigate to settings from your dashboard (the gear in the upper right),
click on Annotations, Add Annotation Query

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/sources/images/image144.png){width="6.5in" height="4.651388888888889in"}

HINT: Use the sample Kusto/Data explorer queries to create more
dashboard scenarios.

-   First Team to email me a screenshot with your chart wins the
    challenge. Good luck!

# Challenge 6a: Workbooks

Workbook documentation is available here:
<https://docs.microsoft.com/en-us/azure/azure-monitor/app/usage-workbooks>

Navigate to your Application Insights resource in the Portal

Click on Workbooks New

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/sources/images/image145.png){width="6.5in" height="2.0194444444444444in"}

Click Edit in the New Workbook section to describe the upcoming content
in the workbook. Text is edited using Markdown syntax.

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/sources/images/image146.png){width="6.5in" height="4.261805555555555in"}

Use **Add text** to describe the upcoming table

Use **Add parameters** to create the time selector

Use **Add query** to retrieve data from pageViews

Use **Column Settings** to change labels of column headers and use Bar
and Threshold visualizations.

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/sources/images/image147.png){width="6.5in" height="3.8756944444444446in"}

Query used for section Browser Statistics

pageViews

\| summarize pageSamples = count(itemCount), pageTimeAvg = avg(duration), pageTimeMax = max(duration) by name

\| sort by pageSamples desc

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/sources/images/image148.png){width="6.5in" height="1.74375in"}

Query used for Request Failures

requests

\| where success == false

\| summarize total_count=sum(itemCount), pageDurationAvg=avg(duration) by name, resultCode

Use **Add Metric** to create a metric chart

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/sources/images/image149.png){width="6.5in" height="3.888888888888889in"}

Change your **Resource Type** to Virtual Machine

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/sources/images/image150.png){width="6.5in" height="0.7201388888888889in"}

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/sources/images/image151.png){width="6.5in" height="1.5569444444444445in"}

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/sources/images/image152.png){width="6.5in" height="1.645138888888889in"}

Change the Resource Type to **Log Analytics**

Change your workspace to the LA workspace with your AKS container logs

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/sources/images/image153.png){width="6.5in" height="3.5868055555555554in"}

Query used for section Disk Used Percentage

InsightsMetrics

\| where Namespace == \"container.azm.ms/disk\" 

\| where Name == \"used_percent\"

\| project TimeGenerated, Computer, Val 

\| summarize avg(Val) by Computer, bin(TimeGenerated, 1m)

\| render timechart

Save your workbook.
