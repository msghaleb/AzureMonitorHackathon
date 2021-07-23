
## Challenge 2: Monitoring Basics, Dashboards and Alerts

The aim of this first challenge is to understand how telemetry is collected from VMs running on Azure. Azure Monitor and the associated sink are leveraged to collect telemetry directly into Azure Monitor for dashboarding and alerting purposes.

Feel free to achieve this objective using the Azure Portal or by modifying the bicep code. 

> **Tip:** If you decide to use code think about managed identities and VM extensions.

### Main Objective:
Understand the concept of counters, how to collect them as well as how to configure Alerts and display them in a Dashboard.    

To do that you will have to stress the SQL using HammerDB and collect the DB counter as well as the CPU counters of the VMSS after loading the CPU and display them on a Dashboard.

### Tasks to finish the Challenge
- Create an empty DB "tpcc" in the SQL server
- Enable the collection of the following counter:
	- \SQLServer:Databases(*)\Active Transactions
- Stress the "tpcc" DB using HammerDB. For detailed instructions, see section [HammerDB Configuration]() below.
- Simulate a CPU load on the VM Scale Set using the [cpuGenLoadwithPS.ps1](https://github.com/msghaleb/AzureMonitorHackathon/blob/master/sources/Loadscripts/cpuGenLoadwithPS.ps1)
- Pin the metric of the above SQL counter as well as the average VMSS CPU utilization to your Dashboard
- Create an Alert to be notified in case the SQL active transactions went above 40
- Create an Alert to get notified if the average CPU load on the VMSS is above 75%
- Suppress the Alerts over the weekends


### Definition of Done:
Show the dashboard with the metric in it, which should also show a spike representing before and after the DB stress

![enter image description here](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/images/ch1_metric_spike.jpg)


### Helpful links:
- [HammerDB](https://www.hammerdb.com)
- [Finding the counter](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.diagnostics/get-counter?view=powershell-5.1)
- [In case you will modify the code (keep in mind you need to convert to bicep and match the syntax)](https://docs.microsoft.com/en-us/azure/azure-monitor/essentials/collect-custom-metrics-guestos-resource-manager-vm)
- [Converting to bicep and bicep playground](https://docs.microsoft.com/en-us/azure/azure-resource-manager/templates/bicep-decompile?tabs=azure-cli)


### HammerDB Configuration

#### Stress the Database using HammerDB 
- From the Visual Studio Server, download and install the latest version of [HammerDB](http://www.hammerdb.com/)
  ![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/images/image13.png)    
- Open HammerDB and double click on SQL Server to start configuring the transaction load. In the dialog that opens, click OK.
![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/images/image18.png)   

- Drill into SQL Server \\ TPC-C \\ Schema Build and double click on **Options**
- Modify the Build Options for the following:
	- SQL Server: Name of your SQL Server
	- SQL Server ODBC Driver: SQL Server
	- Authentication: SQL Server Authentication
	- SQL Server User ID: sqladmin
	- SQL Server User Password: \<password  you  used during the deployment\>
	- SQL Server Database: tpcc
	- Number of Warehouses: 50
	- Virtual Users to Build Schema: 50  
>**Note: **Setting the last two at 50 should generate enough load to trip a threshold and run long enough for you to graph to show a spike

  
![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/images/image19.png)
  
- Double click on Build and Click Yes to kick of a load test.
  

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/images/image20.png)
  
When the test is running it should look like the screenshot below:
>**TIP:** If you would like to run a second test you **must** first delete the database you created and recreate it. HammerDB will not run a test against a database that has data in it. When you run a test is fills the database with a bunch of sample data.
  

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/images/image21.png) 



### The Solution

Are you sure? finished trying? ;-) 
[Challenge 2: The solution](solution2.md)
