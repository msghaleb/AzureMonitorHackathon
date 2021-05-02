
# Challenge 4: The Solution

This page will take you step by step through solving challenge four.

## Solution Steps:

From your Visual Studio Server, deploy the eShoponWeb application to AKS
- Install Docker Desktop and restart your Visual Studio VM. 
- This step is required before you can add Docker support to your eShoponWeb app in Visual Studio.    

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/images/image71.png)  
- Click the link  

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/images/image72.png)  
 - Follow the instructions to complete the WSL 2 installation and restart Docker Desktop  
 
![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/images/image73.png)  
  
- Navigate to c:\eshoponweb\eShopOnWeb-master
  
![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/images/image74.png)  
  
- Double-click on **eShopOnWeb.sln** solution file and select Visual Studio 2019 when prompted.
- Sign into Visual Studio if you have not already done so.
- Once Visual Studio opens and settles down.
- Update your DB connection strings in **appsettings.json** to use the SQL server IP address instead of hostname.  

>**Tip:** You can get the SQL private IP from the VM in Azure Portal.
  
![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/images/image75.png)      
- Right-click on **Web** the **Add** then **Add Docker Support**. 
  
![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/images/image76.png)  
- Leave the default option of Linux selected and click OK. 
- Regenerate a new Dockerfile and wait for task to complete.  
- When prompted click **Allow access** to your docker back-end to communicate with Private Networks.  

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/images/image77.png)  
When Docker support has been added, you should see a Docker option to run/debug your app.

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/images/image78.png)  
- Click to run your app. Wait a few minutes for your app to build and load. 
- When its complete Visual Studio will open the URL in the default browser. 
- Your app is now running in a local container, click **Stop** or close the Browser.

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/images/image79.png)  
#### From Azure Monitor, locate the container running the eShoponWeb application

Now, let's move on to publishing the app to AKS.
- Go to the Azure Portal and create an Azure Container registry with a Standard SKU in your workshop resource group.
  
![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/images/image80.png)  
- Once your Container Registry is created, return to Visual Studio and right click on Web to publish.
  
![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/images/image81.png)  
- Choose Azure, Azure Container Registry as your Publish target and select the Container Registry that you just created. 
- Click Finish.  

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/images/image82.png)     
- Next, navigate to the Connected Services for Web.
- Configure Application Insights to Azure Application Insights, select
- Your App Insights resource and **Save connection string value in None**
- Configure SQL DB CatalogConnection to point to SQL Server Database
- Update connection string(s) using the Catalog string found in **appsettings.json** and **Save connection string in None**.
- Configure SQL DB IdentityConnection to point to SQL Server Database  
- update connection string using the Identity string found in **appsettings.json** and **Save connection value string in None**  
- Update Secrets.json(Local)
  
![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/images/image83.png)  
- Return to Publish and click on Publish to push your app up to the Container Registry. This step will take several minutes. The final Visual Studio output should indicate successful push.

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/images/image84.png)  
- Open the provided **deployment.yml** file in **sources\aks** and update the image name to point to your Container Registry Login server and image.   

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/images/image85.png)  
- Update the server name as shown below 

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/images/image86.png)  
- Upload the **LogReaderRBAC.yml**, **deployment.yml** and **service.yml** files to your cloud shell or browse to the sources/aks folder
- Run the following commands:
```
az aks get-credentials --resource-group YOUR_RESOURCE_GROUP --name YOUR_AKS_NAME
```
>**Tip:** If you don't have **kubectl** installed run the command below:
>`az aks install-cli`

- Check connectivity to and the state of your AKS nodes, run: `kubectl get nodes`  

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/images/image87_2.png)  
You may not see all nodes, as this is also hosted on a VMSS.
>**Important:** You will need to give access to your AKS cluster on the Container Registry (ACR) to be able to pull the image and deploy it. To do so and for learning purposes give both the AKS and the Agent Pool Contributor rights on the ACR.
>The AKS and the Agentpool Manage Identities are called after the AKS name.  

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/images/image88.png)
- Run the following command to deploy the cluster role bindings:
`kubectl create -f LogReaderRBAC.yml`
- Run the following command to deploy your app
`kubectl apply -f deployment.yml`  

- Run the folowing command after few mints to check the status of the pods:
`kubectl get pods`

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/images/image89.png)
- Run the following command to expose your app front-end on port 8080
`kubectl apply -f service.yml`  

- After a few minutes, check on the status of your service
`kubectl get services`  

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/images/image91.png)  
- Use the external IP of the web-service and port 8080 to access your app deployed on AKS.

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/images/image92.png){width="6.5in" height="5.308333333333334in"}

  

  

Return to the Azure Portal. From the Kubernetes service you created,

  

click on Insights or you can navigate to Azure Monitor, click on

  

Containers, and select your cluster.

  

  

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/images/image93.png){width="6.5in" height="2.2180555555555554in"}

  

  

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/images/image94.png){width="6.5in" height="2.0347222222222223in"}

  

  

Or

  

  

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/images/image95.png){width="6.5in" height="3.571527777777778in"}

  

  

- Generate an exception in the eShoponWeb application\

  

(Hint: Try to change your password, similar to the exception

  

generated in the Application Insights challenge)

  

  

> Login

  

>

  

>  ![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/images/image96.png){width="6.5in" height="4.413888888888889in"}

  

>

  

> Enter the user and password provided on the page.

  

>

  

>  ![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/images/image97.png){width="3.339293525809274in"

  

> height="1.8263888888888888in"}

  

>

  

> Click on My account

  

>

  

>  ![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/images/image98.png){width="6.5in" height="2.9451388888888888in"}

  

>

  

> Click on Password

  

>

  

> Notice an exception is thrown\

  

>  ![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/images/image99.png){width="5.977912292213474in"

  

> height="3.7547167541557305in"}

  

>

  

> Click on the Web container and View container live logs.

  

>

  

>  ![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/images/image100.png){width="6.5in" height="3.545138888888889in"}

  

>

  

> Trip the password exception again once the Status has gone from Unk to

  

> Ok.

  

>

  

>  ![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/images/image101.png){width="6.5in" height="2.4916666666666667in"}

  

  

- First person to post a screen shot of the live log with the

  

exception message wins the challenge

  

  

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/images/image102.png){width="6.5in" height="3.5430555555555556in"}

  


