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
 - Create a resource group, please use up to 5 unique characters (small letters or numbers) of your choice within the RG name, e.g. `azuremon-mogas-rg`. In this case, the 5 characters are `mogas`.
To create the resource group run: 
```
az group create --location westeurope --resource-group azuremon-[your-5-unique-characters]-rg
 ```
> **Tip:** feel free to change the rg name and location as needed
- Open the `main.parameters.json` file in VS Code and modify the `envPrefixName` parameter value with your own unique 5 characters [yourPrefix] you used above
- By default you will be asked for a password during the deployment, this will be used for all VMs and the SQL DB. However, to ensure you don't have a typo, we recommend to add it to the `main.parameters.json` file (see the comments in the file).
- Now you can kick-off the initial deployment by running:
```
az deployment group create `
	--name firstbicep `
	-g azuremon-[your-5-unique-characters]-rg `
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


### Troubleshooting

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

