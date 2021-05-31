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


## The Challenges
This Hackathon consists of 8 challenges. Challenge 0 is the initial deployment that will be the basis for all the other challenges.
Please complete the challenges in order.

- [Challenge 0: Initial deployment](challenges/challenge0.md)
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
-	Make sure you are logged in to the correct subscription and you have at least *Contributor* access.  
-	Make sure the needed compute capacity is available in the region you are deploying to or request a quota increase if needed.
-	Can't get Azure CLI working? You can also use the [Azure Cloud Shell] (https://shell.azure.com).  Remember to copy the bicep template and parameters JSON files before kicking off the deployment.
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
