
# Challenge 2: The Solution

This page will take you step by step through solving challenge two.

## Solution Steps:
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

### Now let's keep our VMs up-to-date
First we will make sure they are all reporting to our demo Log Analytics Workspace.
- To do that go to our Resource group, open the Log Analytics Workspace
- Go to Virtual Machines and put your 5 unique characters, and see if all reporting to this one
  
![enter image description here](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/images/otherws.png)
  
- If not, click the VM, disconnected it and re-connected to this LA WS.
- Now create a new Automation Account ([here is how](https://docs.microsoft.com/en-us/azure/automation/automation-quickstart-create-account))
- Link the Automation Account to your Log Analytics Workspace, go to the newly created Azure Automation Account, go to update management and link the LA WS as shown below
  
![enter image description here](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/images/azautoaccount.png)  
- Enable the Azure Update Management on your VMs, on the same page (you may need to refresh it) go to "Add Azure VMs"
- Make sure you are on the correct region
- Check your VMs and click enable (see below)
  
![enter image description here](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/images/enableazautoaccount.png)  
>**Tip:** If you want to enable all VMs connected to the LA WS automatically (current or current and future, to to Azure Automation Account, then click on "Update Management" on the left, click on "Manage machines" 
>![enter image description here](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/images/managevms.png)> Pick the option suitable for your environment
  
>**Note:** You may need to wait sometime for the VMs to show up
  
- The next step is to schedule an update deployment. Open the automation account. In the left menu, select **Update Management**.

- Under the **Machines** tab. Under the **Update Deployments** tab, you can see the status of past scheduled deployments. Under the **Deployment schedules** tab, you can see a list of upcoming and completed deployments.
  
- Select **Schedule update deployment**. The **New update deployment** window will open, and you can specify the needed information.

Here is more information about the different options ([click here](https://docs.microsoft.com/en-us/azure/automation/update-management/deploy-updates))

Once you specify all settings, select **Create**.

![enter image description here](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/images/updateschdule.png)
Fill it up, click create - you are all set ;-)

To see the status of an update deployment, select the **Update deployments** tab under **Update management**. **In progress** indicates that deployment is currently running. When the deployment is completed, the status will show either “Succeeded” if each update was deployed successfully or “Partially failed” if there were errors for one or more of the updates.

To see all the details of the update deployment, click on the update deployment from available list.


  
**The Bonus part (Optional)**

**Will the Alert get fired if the VM was turned off from the OS? or if the VM was not available? why?**
No, as opposed to deallocation, powering off a Microsoft Azure virtual machine (VM) will release the hardware but it will preserve the network resources (internal and public IPs) provisioned for it. Even if the VM`s network components are preserved, once the virtual machine is powered off, the cloud application(s) installed on it will become unavailable. The only scenario in which you should ever choose the stopped state instead of the deallocated state for a VM in Azure is if you are only briefly stopping the server and would like to keep the dynamic IP address for your testing. If that doesn’t perfectly describe your use case, or you don’t have an opinion one way or the other, then you’ll want to deallocate instead so you aren’t being charged for the VM.

**How to install just a single specific update**
If you checked the link in the challenge you should be all set, however the link it for Linux.
For Windows (very similar) also create a schedule as described above and deselect all update classifications.
In the include type your KB ID you would like to install (you can get it from the missing updates tab)

  
First team to a screenshot of the new Alert Rules and New Action Rule wins the challenge!!
Good luck!

  

  


