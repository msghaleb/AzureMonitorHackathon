
# Challenge 4: The Solution

This page will take you step by step through solving challenge four.

## Solution Steps:

  

- From your Visual Studio Server, deploy the eShoponWeb application to

  

AKS

  

  

Install Docker Desktop and restart your Visual Studio VM. This step is

  

required before you can add Docker support to your eShoponWeb app in

  

Visual Studio.

  

  

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/images/image71.png){width="5.028301618547681in"

  

height="2.388980752405949in"}

  

  

Complete the WSL 2 installation and restart Docker Desktop

  

  

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/images/image72.png){width="4.339622703412074in"

  

height="1.5976859142607174in"}

  

  

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/images/image73.png){width="3.2924529746281714in"

  

height="2.575547900262467in"}

  

  

Navigate to c:\\eshoponweb\\eShopOnWeb-master

  

  

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/images/image74.png){width="6.5in" height="2.607638888888889in"}

  

  

Double-click on eShopOnWeb.sln solution file and select Visual Studio

  

2019 when prompted.

  

  

Sign into Visual Studio if you have not already done so.

  

  

Once Visual Studio opens and settles down.

  

  

Update your DB connection strings in appsettings.json to use the SQL

  

server IP address instead of hostname.

  

  

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/images/image75.png){width="6.5in" height="2.745138888888889in"}

  

  

Right-click on Web and Add Docker Support. Leave the default option of

  

Linux selected and click OK. Regenerate a new Dockerfile and wait for

  

task to complete.

  

  

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/images/image76.png){width="6.5in" height="4.3909722222222225in"}

  

  

When prompted All your docker backend to communicate with Private

  

Networks.

  

  

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/images/image77.png){width="4.132075678040245in"

  

height="2.995949256342957in"}

  

  

When Docker support has been added, you should see a Docker option to

  

run/debug your app.

  

  

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/images/image78.png){width="6.5in" height="1.7in"}

  

  

Click to run your app. Wait a few minutes for your app to build and

  

load. When its complete Visual Studio will open the URL in the default

  

browser. Your app is now running in a local container, click Stop.

  

  

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/images/image79.png){width="6.5in" height="2.448611111111111in"}

  

  

- From Azure Monitor, locate the container running the eShoponWeb

  

application

  

  

Now, let's move on to publishing the app to AKS.

  

  

Go to the Azure Portal and create an Azure Container registry with a

  

Standard SKU in your workshop resource group.

  

  

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/images/image80.png){width="6.5in" height="4.58125in"}

  

  

Once your Container Registry is created, return to Visual Studio and

  

right click on Web to publish.

  

  

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/images/image81.png){width="3.358490813648294in"

  

height="3.2250929571303586in"}

  

  

Choose Azure, Azure Container Registry as your Publish target and select

  

the Container Registry that you just created. Click Finish.

  

  

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/images/image82.png){width="5.773584864391951in"

  

height="2.664730971128609in"}

  

  

Next, navigate to the Connected Services for Web.

  

  

Configure Application Insights to Azure Application Insights, select

  

your App Insights resource and **Save connection string in None**.

  

  

Configure SQL DB CatalogConnection to point to SQL Server Database,

  

update connection string using the Catalog string found in

  

appsettings.json and **Save connection string in None**.

  

  

Configure SQL DB IdentityConnection to point to SQL Server Database,

  

update connection string using the Identity string found in

  

appsettings.json and **Save connection string in None**.

  

  

Update Secrets.json(Local) **Ignore for all profiles**.

  

  

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/images/image83.png){width="6.5in" height="1.426388888888889in"}

  

  

Return to Publish and click on Publish to push your app up to the

  

Container Registry. This step will take several minutes. The final

  

Visual Studio output should indicate successful push.

  

  

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/images/image84.png){width="6.5in" height="1.4465277777777779in"}

  

  

Open the provided deployment.yml file in Student\\Resources and update

  

the image name to point to your Container Registry Login server and

  

image.

  

  

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/images/image85.png){width="6.5in" height="2.0527777777777776in"}

  

  

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/images/image86.png){width="5.760416666666667in"

  

height="4.864583333333333in"}

  

  

Upload the deployment.yml and service.yml files to your cloud shell.

  

  

Check connectivity to and the state of your AKS nodes

  

  

kubectl get nodes

  

  

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/images/image87.png){width="4.416666666666667in" height="0.90625in"}

  

  

Run the following command to deploy your app

  

  

kubectl apply -f deployment.yml

  

  

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/images/image88.png){width="3.5729166666666665in" height="0.375in"}

  

  

After a few minutes, check the status of your pods

  

  

kubectl get pods

  

  

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/images/image89.png){width="4.927083333333333in"

  

height="0.7395833333333334in"}

  

  

Run the following command to expose your app front-end on port 8080

  

  

kubectl apply -f service.yml

  

  

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/images/image90.png){width="3.5104166666666665in"

  

height="0.3854166666666667in"}

  

  

After a few minutes, check on the status of your service

  

  

kubectl get services

  

  

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/images/image91.png){width="6.21875in" height="0.7075470253718286in"}

  

  

Use the external IP of the web-service and port 8080 to access your app

  

deployed on AKS.

  

  

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

  


