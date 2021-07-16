
## Challenge 1: Activity Log & Service Health

**Activity Logs** are everything happening to your resources on the API level. The Activity log is a platform log in Azure that provides insights into subscription-level events. This includes information such as when a resource is modified or when a virtual machine is started.

**Service Health** notifies you about Azure service incidents and planned maintenance so you can take action to mitigate downtime. It is composed of Azure status, the Service health service, and Resource Health. 


### Main Objectives:
- Understand the Activity Log, connect it to your LA workspace and configure an alert to get notified if a VM has been turned off.
- Understand Service Health and search the log for recent events

### Tasks to finish the Challenge
1) Activity Log integration with Log Analytics
  - Send your Azure Activity Log to your Log Analytics workspace 
2) Activity Log alerts
  - Start / Stop a VM
  - Check the Activity Logs to see the events of starting or stopping a VM
  - Create an Alert for the VM to be notified if the VM has been stopped
  - Stop the VM, and see if you got the alert
3) Service Health
  - Pin the Service issues map to your dashboard
  - Perform a custom log query on your Activity Logs to see if there's any recent entries regarding Resource Health.

#### Bonus question/task:
- Will the Activity Log Alert get fired if the VM was turned off from the OS? Or if the VM was not available? Why/why not?
- Does sending the Activity Log to your Log Analytics workspace cause costs?

### Definition of Done:
- You have successfully integrated Azure Activity Log with your LAW 
- Show the Alerts which got fired and explain what you have done.

#### Helpful links:
- [Alerts on activity log](https://docs.microsoft.com/en-us/azure/azure-monitor/alerts/activity-log-alerts)
- [Understand Azure Service Health](https://docs.microsoft.com/en-us/azure/service-health/overview)

### The Solution

Are you sure? finished trying? ;-) 
[Challenge 1: The solution](solution1.md)
