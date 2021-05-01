# Azure Monitor Hackathon

![Azure Monitor Hackathon](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/images/header.jpg)
## About the Hackathon
This hackathon is aiming to walk you though the different features of Azure Monitor, the design proposed here is not a recommendation its for learning purposes only. Through out the hackathon you will be working Azure Monitor, Log Analytics and Application Insights.

At the end of the Hackathon you will understand Azure Monitor capabilities, facilitate an Azure Monitor conversation, and demo key features of Azure Monitor.

## Target Audience

This hackathon has been designed for DevOps engineers, administrators and IT Architects to build their knowledge on Azure Monitor. However anyone else who has a passion around Monitoring are more than welcome to attend.

## Initial design
Once you deployed the Hackathon you will see two Azure Resource Groups with different set of resources, this includes the VNet, subnets, NSG(s), LB(s), NAT rules, scales set and a fully functional .NET Core Application (eShopOnWeb) to monitor. (see the design below)

![enter image description here](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/images/initial_design.jpg)

## Initial deployment
This micro Hackathon is designed to be deployed on a subscription level to roll out a set of resources that are used throughout the challenges. 
Follow the below step to run the initial deployment:

 - Download and install git ([cllick here](https://git-scm.com/downloads))
 - Download and install VS code ([click here](https://code.visualstudio.com/Download))
 - Install the Bicep extension
 - Use VS Code to clone this repository

> **Tip:** if you got an error due to a key verification, then clone using the https not the ssh
 - Install Azure CLI ([click here](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli))
 - Open the repository and open a terminal in VS Code
 - Install bicep by running: `az bicep install` in the command line
 - Login to an azure subscription where you can create a resource group by running: `az login`
 - Create a resource group, please use 5 unique (small letters/numbers) of your choice within the RG name, e.g. `azuremon-mogas-rg` in this case my 5 characters are `mogas`
 - To create the resource group run: 
```
az group create --location westus --resource-group azuremon-mogas-rg
 ```
> **Tip:** feel free to change the rg name and location as needed
- Open the `main.parameters.json` file in code and modify the `envPrefixName` parameter value with your own unique 5 characters you used above
- By default you will be asked for a password during the deployment, this will be used for all VMs and the SQL DB, if you prefer to add it to the `main.parameters.json` feel free to do you
- Now you can kick-off the initial deployment by running:
```
az deployment group create \ 
	--name firstbicep \
	-g azuremon-mogas-rg \
	-f main.bicep \
	-p main.parameters.json
```
> **Tip:** the name above is the deployment name, you will see this under deployments in the RG properties if you face problems.

>**Note:** if you get the following error:
>```
>type object 'datetime.datetime' has no attribute 'fromisoformat'
>```
>This is due to a [reported bug](https://github.com/Azure/bicep/issues/2243) there is a workaround [here](https://github.com/Azure/bicep/issues/2243#issuecomment-818914668).

Now relax - its gonna take sometime.


## The Challenges
One finished you can start with the challenges.
- [Challenge 1: Monitoring Basics and Dashboards]()
- [Challenge 2: Alert and Alert Rules]()
- [Challenge 3: Application Insights]()
- [Challenge 4: Containers Monitoring]()
- [Challenge 5: KQL Queries]()
- [Challenge 6: Grafana and Analytics]()
- [Challenge 7: Workbooks]()

## Useful links

### These links are you cheat sheet ;-) it's recommended to read before or during the Hackathon

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


> **Tip:** [StackEdit](https://stackedit.io/) is a great tool to write Markdown files