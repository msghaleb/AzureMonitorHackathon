
# Challenge 1: The Solution
This page will take you step by step through solving challenge 1.

## Solution Steps:

### Activity Log integration with Log Analytics

To send the Activity log to Azure Monitor Logs you should use Diagnostic Settings.
In the Azure Portal, search for and then select 'Activity log'. You should see recent events for the current subscription. Click 'Diagnostic settings' and then 'Add diagnostic setting' to create a new setting.
Type in a name, select each of the categories, and choose 'Send to Log Analytics', where you can select your workspace. Click 'Save' to create the setting.
In Log Analytics, you can check the integration by selecting the 'Azure Activity log' option below 'Workspace Data Sources'. Your subscription should show as 'Connected'.


### Activity Log alerts

- Login to your portal and stop you Visual Studio VM  

![enter image description here](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/images/stopVM.png)
- Then Start it again
- Now check the Activity Log and see the new events (may take a min or two to show up)

![enter image description here](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/images/vmactivitylog.png)
Now there are two way to create an alert, either from the same screen, click on **Deallocate Virtual Machine** and then click on **New Alert rule**  

![enter image description here](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/images/newalertruleal.png)
  
Or you can go to **Alerts**, and create a **new Alert Rule**, in this case you need to pick your VM as the resource

![enter image description here](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/images/newalertrule.png)

Then you will need to **Add condition**, filter for **Activity log - Administrative** and pick the **Deallocate Virtual Machine**

![enter image description here](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/images/addconditiondeallocate.png)  

### Service Health

To pin the Service issues map to your dashboard, in the Azure Portal search for 'Service Health', click on 'Service issues', select your subscription and region and click on the pin icon.

To perform a custom log query, go to your log analytics workspace, click on 'Logs' and use the following Kusto query:
``` 
AzureActivity | where CategoryValue == 'ResourceHealth'
 ```

### The Bonus question

**Will the Alert get fired if the VM was turned off from the OS? or if the VM was not available? why?**
No, as opposed to deallocation, powering off a Microsoft Azure virtual machine (VM) will release the hardware but it will preserve the network resources (internal and public IPs) provisioned for it. Even if the VM`s network components are preserved, once the virtual machine is powered off, the cloud application(s) installed on it will become unavailable. The only scenario in which you should ever choose the stopped state instead of the deallocated state for a VM in Azure is if you are only briefly stopping the server and would like to keep the dynamic IP address for your testing. If that doesn’t perfectly describe your use case, or you don’t have an opinion one way or the other, then you’ll want to deallocate instead so you aren’t being charged for the VM.

**Does sending the Activity Log to your Log Analytics workspace cause costs?**
Although Activity Logs are available for a 90-day period at no charge and associated alerts & API calls are also for free, sending the Activity Log to a Log analytics workspace will incurr charges. You will get billed for every GB that you ingest into the workspace as well as for every GB of data retention beyond the free 31-day period.
  

  


