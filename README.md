# Azure Monitor Hackathon

![Azure Monitor Hackathon](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/images/header.jpg)
## About the Hackathon
This hackathon walks you though the different features of Azure Monitor. Throughout the hackathon you will be working with Azure Monitor, Log Analytics and Application Insights. 
At the end of the Hackathon you will understand Azure Monitor capabilities, facilitate an Azure Monitor conversation, and demo key features of Azure Monitor.

The design proposed here is not a recommendation, it's for learning purposes only.

## Target Audience

This hackathon is designed specifically for DevOps engineers, administrators and IT architects who want to build their knowledge on Azure Monitor. However, anyone with a passion around Monitoring is more than welcome to attend.

## Prerequisites
We assume that you have a basic knowledge of Azure core services (e.g., networking, compute).

## Initial design
Once you deploy the Hackathon you will see two Azure Resource Groups with different set of resources. These include the VNet, subnets, NSG(s), LB(s), NAT rules, scale set and a fully functional .NET Core Application (eShopOnWeb) to monitor, as you can see in the design below.

![enter image description here](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/images/initial_design.jpg)

## Initial deployment
This micro Hackathon is designed to be deployed on a subscription level to roll out a set of resources that are used throughout the challenges. 
Follow the below step to run the initial deployment:

 - Download and install Git ([click here](https://git-scm.com/downloads))
 - Download and install VS Code ([click here](https://code.visualstudio.com/Download))
 - Install the Bicep extension for VS Code
 - Use VS Code to clone this repository ([click here for instructions](https://docs.microsoft.com/en-us/azure/developer/javascript/how-to/with-visual-studio-code/clone-github-repository))

> **Tip:** if you receive an error due to a key verification, then clone using https instead of ssh
 - Install Azure CLI ([click here](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli)). If you already installed it in the past, make sure that the version is v2.20.0 or higher (run `az --version` to check).
 - Open the repository and open a terminal in VS Code
 - Install bicep by running: `az bicep install` in the command line
 - Login to an azure subscription where you can create a resource group by running: `az login`. If you need to change the currently active subscription, use `az account set --subscription "<SubscriptionNameOrID"`
 - Create a resource group, please use 5 unique (small letters/numbers) of your choice within the RG name, e.g. `azuremon-mogas-rg` in this case my 5 characters are `mogas`.
To create the resource group run: 
```
az group create --location westus --resource-group azuremon-mogas-rg
 ```
> **Tip:** feel free to change the rg name and location as needed
- Open the `main.parameters.json` file in VS Code and modify the `envPrefixName` parameter value with your own unique 5 characters you used above
- By default you will be asked for a password during the deployment, this will be used for all VMs and the SQL DB. However, to ensure you don't have a typo, we recommend to add it to the `main.parameters.json` file. You can use a KeyVault reference for that if you like.
- Now you can kick-off the initial deployment by running:
```
az deployment group create `
	--name firstbicep `
	-g azuremon-mogas-rg `
	-f main.bicep `
	-p main.parameters.json
```
> **Tip:** the name above is the deployment name, you will see this under deployments in the RG properties if you face problems.

>**Note:** if you get the following error:
>```
>type object 'datetime.datetime' has no attribute 'fromisoformat'
>```
>This is due to a [reported bug](https://github.com/Azure/bicep/issues/2243) there is a workaround [here](https://github.com/Azure/bicep/issues/2243#issuecomment-818914668).

- Now relax - it's gonna take sometime.

> **Important:** 
> once finished, please go to your resource group -> deployments and make sure that there are no errors.
> If you face any problems check the troubleshooting section at the end of this page

![enter image description here](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/images/good_deployment.jpg)

- Once finished check and note the Public IP fqdn of the scale set 
>it should be named something like: `mogasWebScaleSetPip` where `mogas` is your unique 5 characters

Open the fqdn in your browser and you should see the shop

![enter image description here](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/images/eshop.jpg)


## The Challenges
Once finished you can start with the challenges.
- [Challenge 1: The Basics, Dashboards and Alerts](challenges/challenge1.md)
- [Challenge 2: Activity Logs and Update Management](challenges/challenge2.md)
- [Challenge 3: Application Insights](challenges/challenge3.md)
- [Challenge 4: Containers Monitoring](challenges/challenge4.md)
- [Challenge 5: KQL Queries](challenges/challenge5.md)
- [Challenge 6: Grafana and Analytics](challenges/challenge6.md)
- [Challenge 7: Workbooks](challenges/challenge7.md)

## Useful links

### These links are your cheat sheet ;-) You can read them prior or during the hackathon

- [Send Guest OS metrics to the Azure Monitor metric store](https://docs.microsoft.com/en-us/azure/azure-monitor/platform/collect-custom-metrics-guestos-resource-manager-vm)
- [Get Started with Metrics Explorer](https://docs.microsoft.com/en-us/azure/azure-monitor/platform/metrics-getting-started)
- [View and Manage Alerts in Azure Portal](https://docs.microsoft.com/en-us/azure/azure-monitor/platform/alerts-metric#view-and-manage-with-azure-portal)
- [Create metric alerts with ARM templates](https://docs.microsoft.com/en-us/azure/azure-monitor/platform/alerts-metric-create-templates)
- [Create Action Rules](https://docs.microsoft.com/en-us/azure/azure-monitor/platform/alerts-action-rules)
- [Monitor your Kubernetes Cluster](https://docs.microsoft.com/en-us/azure/azure-monitor/insights/container-insights-analyze)
- [View Kubernetes logs, events, and pod metrics in real-time](https://docs.microsoft.com/en-us/azure/azure-monitor/insights/container-insights-livedata-overview)
- [Start Monitoring Your ASP.NET Core Web Application](https://docs.microsoft.com/en-us/azure/azure-monitor/learn/dotnetcore-quick-start)
- [What does Application Insights Monitor](https://docs.microsoft.com/en-us/azure/azure-monitor/app/app-insights-overview#what-does-application-insights-monitor)
- [Grafana Integration](https://grafana.com/grafana/plugins/grafana-azure-monitor-datasource)
- [Create interactive reports with workbooks](https://docs.microsoft.com/en-us/azure/azure-monitor/app/usage-workbooks)

## Troubleshooting

-	If the eShop is not logging in, use [Firefox](https://www.mozilla.org/en-US/firefox/new/).
-	If you get the below error, you can enable Azure Defender for VMs on this subscription, if you can't then ignore the error:
`Subscription is not in the Standard or Standard Trial subscription plan. Please upgrade to use this feature`
![enter image description here](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/images/bad_deployment.jpg)
-	Make sure the 5-character name does not contain any uppercase letters
-	Make sure the password used adheres to the Azure password policy
-	Make sure you are logged into the correct subscription and you have the at least contributors role access.  
-	Make sure you have the compute capacity in the region you are deploying to and request an increase to the limit if needed.
-	Can't get Azure CLI working? use the Azure Cloud Shell.  Remember to copy up the bicep template and parameters JSON files before kicking off the deployment.
-	If you get a deployment error `Enabling solution of type #### is not allowed` you can ignore it, we are moving away from Solutions towards Workbooks and thus some are retired.
-	If you notice the deployment taking a long time (over 60 mins).  Note: this issue has been fixed but I’m leaving it in hear in case it ever surfaces again.
	1.	Look at the deployment details to figure out where it’s stuck
	2.	If you are stuck on the Visual Studio Custom Script extension (CSE)this is because the Microsoft Image was created with an older version of the CSE and has a bug.  
		a.	Workaround 1:The workaround has been to log on to the Visual Studio Server and navigate to “C:\Packages\Plugins\Microsoft.Compute.CustomScriptExtension\1.9.2” and double click on “enable” this will kick off the extension and the deployment should continue from here.  If the script times out just rerun after you manually kick off the extension and it should finish
		b.	Workaround 2: From the Azure Portal uninstall the CustomScriptExtension (which will fail your deployment).
		![enter image description here](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/images/uninstall_ext.jpg)
		 
		c.	Then rerun the ARM template and it will pick up where it left off.

## Cleaning Up
If you're done and would like to delete the Azure resources associated with this hackathon, please perform the following steps:
- Delete the resource group `azuremon-xxxxx-rg`
- Delete the Azure Monitor resources like alerts, etc.

## Big Thanks to
- [Martina Lang](https://www.linkedin.com/in/martina-lang-207912149/) for her help and support throughout our Azure Monitor Journey
- [Rob Kuehfus](https://github.com/rkuehfus/pre-ready-2019-H1) for initiating the idea and creating the very first Azure Monitor Hack - Rob is the one who invented the Exception in the eShop ;-)
- [Kayode Prince](https://github.com/kayodeprinceMS/AzureMonitorHackathon) for improving the original Azure Monitor Hack and supporting this one
- [Joerg Jooss](https://www.linkedin.com/in/joergjooss/) for his help with the Application Insights part
> **Tip:** [StackEdit](https://stackedit.io/) is a great tool to write Markdown files

## TODO
- Add Network Watcher
- Azure Backup Reports
