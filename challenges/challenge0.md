## Challenge 0: Initial deployment
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
az group create --location westeurope --resource-group azuremon-mogas-rg
 ```
> **Tip:** feel free to change the rg name and location as needed
- Open the `main.parameters.json` file in VS Code and modify the `envPrefixName` parameter value with your own unique 5 characters you used above
- By default you will be asked for a password during the deployment, this will be used for all VMs and the SQL DB. However, to ensure you don't have a typo, we recommend to add it to the `main.parameters.json` file (see the comments in the file).
- Now you can kick-off the initial deployment by running:
```
az deployment group create `
	--name firstbicep `
	-g azuremon-mogas-rg `
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

