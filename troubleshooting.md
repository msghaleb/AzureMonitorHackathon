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
