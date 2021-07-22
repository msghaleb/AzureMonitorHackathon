
# Azure Monitor Hackathon

![Azure Monitor Hackathon](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/images/header.jpg)  
This hackathon walks you though the different features of Azure Monitor. Throughout the hackathon you will be working with Azure Monitor, Log Analytics and Application Insights.

At the end of the Hackathon you will understand Azure Monitor capabilities, facilitate an Azure Monitor conversation, and demo key features of Azure Monitor.
 
The design proposed here is not a recommendation, it's for learning purposes only.
  
> **Note**
- If you fork this Repo, and updated it feel free to open a Pull Request, we'll add your name into the BIG THANK YOU LIST below :)
- Please use **Firefox** when testing the eShop, wanna fix the bug? see above ;-)    
  

## Target Audience

  

This hackathon is designed specifically for DevOps engineers, administrators and IT architects who want to build their knowledge on Azure Monitor. However, anyone with a passion around Monitoring is more than welcome to attend.

  

## Prerequisites

We assume that you have a basic knowledge of Azure core services (e.g., networking, compute).

  

## Initial design

In the beginning of this hackathon, you will deploy an environment in Azure that consists of two Azure Resource Groups with different set of resources. These include the VNet, subnets, NSG(s), LB(s), NAT rules, scale set and a fully functional .NET Core Application (eShopOnWeb) to monitor, as you can see in the design below.

  

![enter image description here](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/images/initial_design.jpg)

  
## Initial Deployment
The initial deployment will create the components shown in the architecture above and is the basis for the challenges in this hackathon.
To deploy the components, please follow the steps in [this deployment section](deployment/README.md)

## The Challenges

This Hackathon consists of 8 challenges. Please complete the challenges in order.

-  [Challenge 1: Activity Log & Service Health](challenges/challenge1.md)

-  [Challenge 2: The Basics, Dashboards and Alerts](challenges/challenge2.md)

-  [Challenge 3: Workbooks](challenges/challenge3.md)

-  [Challenge 4: KQL Queries](challenges/challenge4.md)

-  [Challenge 5: Containers Monitoring](challenges/challenge5.md)

-  [Challenge 6: Grafana and Analytics](challenges/challenge6.md)

-  [Challenge 7: Application Insights](challenges/challenge7.md)

-  [Challenge 8: Update Management](challenges/challenge8.md)
  

## Useful links

  

### These links are your cheat sheet ;-) You can read them prior or during the hackathon

  

-  [Send Guest OS metrics to the Azure Monitor metric store](https://docs.microsoft.com/en-us/azure/azure-monitor/platform/collect-custom-metrics-guestos-resource-manager-vm)

-  [Get Started with Metrics Explorer](https://docs.microsoft.com/en-us/azure/azure-monitor/platform/metrics-getting-started)

-  [View and Manage Alerts in Azure Portal](https://docs.microsoft.com/en-us/azure/azure-monitor/platform/alerts-metric#view-and-manage-with-azure-portal)

-  [Create metric alerts with ARM templates](https://docs.microsoft.com/en-us/azure/azure-monitor/platform/alerts-metric-create-templates)

-  [Create Action Rules](https://docs.microsoft.com/en-us/azure/azure-monitor/platform/alerts-action-rules)

-  [Monitor your Kubernetes Cluster](https://docs.microsoft.com/en-us/azure/azure-monitor/insights/container-insights-analyze)

-  [View Kubernetes logs, events, and pod metrics in real-time](https://docs.microsoft.com/en-us/azure/azure-monitor/insights/container-insights-livedata-overview)

-  [Start Monitoring Your ASP.NET Core Web Application](https://docs.microsoft.com/en-us/azure/azure-monitor/learn/dotnetcore-quick-start)

-  [What does Application Insights Monitor](https://docs.microsoft.com/en-us/azure/azure-monitor/app/app-insights-overview#what-does-application-insights-monitor)

-  [Grafana Integration](https://grafana.com/grafana/plugins/grafana-azure-monitor-datasource)

-  [Create interactive reports with workbooks](https://docs.microsoft.com/en-us/azure/azure-monitor/app/usage-workbooks)

  
  

## Cleaning Up

If you're done and would like to delete the Azure resources associated with this hackathon, please perform the following steps:

- Delete the resource group `azuremon-xxxxx-rg`

- Delete the Azure Monitor resources like alerts, etc.

  

## Big Thanks to

-  [Martina Lang](https://www.linkedin.com/in/martina-lang-207912149/) for her help and support throughout our Azure Monitor Journey

-  [Rob Kuehfus](https://github.com/rkuehfus/pre-ready-2019-H1) for initiating the idea and creating the very first Azure Monitor Hack - Rob is the one who invented the Exception in the eShop ;-)

-  [Kayode Prince](https://github.com/kayodeprinceMS/AzureMonitorHackathon) for improving the original Azure Monitor Hack and supporting this one

-  [Joerg Jooss](https://www.linkedin.com/in/joergjooss/) for his help with the Application Insights part

>  **Tip:**  [StackEdit](https://stackedit.io/) is a great tool to write Markdown files

  

## TODO

- Add Network Watcher

- Azure Backup Reports
