
## Challenge 1: Monitoring Basics, Dashboards and Alerts

The aim of the first challenge is to understand how telemetry is collected from VMs running on Azure. Azure monitor and the associated sink are leveraged to collect telemetry directly into Azure monitor for dashboarding and alerting purposes.

Feel free to achieve this objective using the Azure Portal or by modifying the bicep code. 

> **Tip:** If you decided to use code think about managed identities and VM extensions.

### Main Objective:
Understand the concept of counters, how to collect them as well as how to configure Alerts and display them in a Dashboard.    

To do that you will have to stress the SQL using HammerDB and collect the DB counter as well as the CPU counters of the VMSS after loading the CPU and display them on a Dashboard.

### Tasks to finish the Challenge
- Create an empty DB "tpcc" in the SQL server
- Enable the collection of the following counter:
	- \SQLServer:Databases(*)\Active Transactions
- Stress the "tpcc" DB using HammerDB
- Simulate a CPU load on the VM Scale Set using the [cpuGenLoadwithPS.ps1](https://github.com/msghaleb/AzureMonitorHackathon/blob/master/sources/Loadscripts/cpuGenLoadwithPS.ps1)
- Pin the metric of the above SQL counter as well as the average VMSS CPU utilization to your Dashboard
- Create an Alert to be notified in case the SQL active transactions went above 40
- Create an Alert to get notified if the average CPU load on the VMSS is above 75%
- Suppress the Alerts over the weekends


### Definition of Done:
Show the dashboard with the metric in it, which should also show a spike representing before and after the DB stress

![enter image description here](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/images/ch1_metric_spike.jpg)


#### Helpful links:
- [HammerDB](www.hammerdb.com)
- [Finding the counter](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.diagnostics/get-counter?view=powershell-5.1)
- [In case you will modify the code (keep in mind you need to convert to bicep and match the syntax)](https://docs.microsoft.com/en-us/azure/azure-monitor/essentials/collect-custom-metrics-guestos-resource-manager-vm)
- [Converting to bicep and bicep playground](https://docs.microsoft.com/en-us/azure/azure-resource-manager/templates/bicep-decompile?tabs=azure-cli)


### The Solution

Are you sure? finished trying? ;-) 
[Challenge 1: The solution](https://github.com/msghaleb/AzureMonitorHackathon/blob/master/challenges/solution1.md)


> Written with [StackEdit](https://stackedit.io/).
