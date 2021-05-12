# Challenge 6: The Solution

This page will take you step by step through solving challenge six.

## Solution Steps:
Deploying Grafana using Web App for Container.
First we will create a Web App for Linux and configure as recommended below.

- Create a new App service plan and select B1 Basic. It's under Dev /Test.
   ![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/images/image105.png)    
- Now create a new WebApp on this App Service Plan and select Container and specify Docker Hub, Public and Grafana/Grafana for the image (this should deploy the latest version by default)
  
![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/images/image106.png)
   
 - Type the name of the image to be grafana/grafana
   

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/images/image107.png)    
- Click Create

- After the Web App deploys, we need to configure some settings to enable Azure Monitor Plugin.
- From the Azure Portal navigate to your newly created App Service, Settings, Application Settings  

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/images/image109.png)  
- Under Always On, change the value to On.
- Under Application Settings, click on Show Values, change the value for WEBSITES_ENABLE_APP_SERVICE_STORAGE to true
  
![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/images/image111.png)    
- Click Add new Setting and add the following: (The password should be complex)  

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/images/image112.png)  
- Click Save

>**Note:** For the Application settings to take effect you may need to restart your Web App

**To Login to Grafana**

- Click on Overview and copy the URL for your Web App


![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/images/image113.png)  
Navigate to the URL in your browser

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/images/image114.jpeg)  
The username is "admin" lowercase and the password is whatever you configured in Application Settings. Notice the version of Grafana as you need 5.2.0 or newer if you are querying Azure Log Analytics.

Once logged into Grafana you can install Azure Monitor data source

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/images/image115.png)  
- Search for Azure and click select
  
![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/images/image115_2.png)

- Configure the Azure Monitor Data Source for Azure Monitor, Log Analytics and Application Insights 

>**Note:** Berfore adding the details, go back to Azure and do the following: 
> - Create a service principal and assign it "Log Analytics Reader" onto theSubscription.
> - Under "API Permissions" -> "Add a permission" -> "APIs my organizations uses", search for "Log Analytics API"
> - Add it as shown below:
>![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/images/image118_2.png)
> - Finish the second step, "Select permissions", by selecting "Delegated Permissions" and "Read Log Analytics data as user". Then click "Select" and then "Done". 
>  ![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/images/image118_3.png)
> - Go to your Application Insights, under API Access, note down the App ID and generate an API Key (you will need them below) - Read Telemetry is enough
> **If you face problems loading subscriptions, stop and start the webapp (not restart - stop then start), you may also need to add the SP as a reader on the subscription for testing**
  

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/images/image118.png)  
- Click Save & Test and you should see a message like above.  

**Now we will create a CPU Chart with a Grafana variable used to select Computer Name**

- Create a new dashboard

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/images/image125.png)  
- Add Panel
- On the right side, give it a name "Computer CPU"
- On the bottom part, choose "Logs" and use the sample query below  
```
Perf                                                             
| where $__timeFilter(TimeGenerated) 
| where CounterName == "% Processor Time" and InstanceName == "_Total"
| summarize percentile(CounterValue,50) by bin(TimeGenerated, $__interval), Computer 
| order by TimeGenerated asc
```  
![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/images/image126.png)
- Click Run to test

Now let's make a few changes. On the top right, click field, change the Unit to percent (0-100)  

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/images/image130.png)  
- Run it again
- Click "Save on the top right corner"
- Give it a name e.g. "Ready Dashboard"
- It should look like this:   

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/images/image132.png)    

  

Should look something like this:

  

  

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/images/image133.png)  
**Advanced Featuers**
Some query values can be selected through UI dropdowns, and updated in the query.

For example, a "Computer" variable can be defined, and then a dropdown will appear on the dashboard, showing a list of possible values. 

Now let's add a variable that lets us select computers in the chart.  
- Click on the gear in the upper right corner.

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/images/image135.png)  
- Click on Add Variable  

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/images/image136.png)  
- Configure the Variable to look like the screen below. 
>**Note:** Make sure to specify the Workspace name if you have many workspaces and wanted to make sure you only returned values that would work in the chart.  

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/images/image137.png)  
- Click Update.  
- Make sure to Save your dashboard   

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/images/image139.png)  
- Now go back and edit your Computer CPU chart to update the query to use the new variable.  

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/images/image140.png)  
```
Perf                                                       
| where $__timeFilter(TimeGenerated) and Computer in ($ComputerName)
| where (CounterName == "% Processor Time" and InstanceName == "_Total") or CounterName == "% Used Memory"                                       
| summarize AVGPROCESSOR = avg(CounterValue) by bin(TimeGenerated, $__interval), Computer 
| order by TimeGenerated asc
```

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/images/image140_2.png)
  

- Make sure to Save   

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/images/image141.png)  
- Try it out!
   

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/images/image142.png)  

**Annotations**
Another cool Grafana feature is annotations – which marks points in time that you can overlay on top of charts.
Below, you can see the same chart shown above, with an annotation of Heartbeats. Hovering on a specific annotation shows informative text about it.  
  
**Configuration** is very similar to Variables:
- Click the dashboard Settings button (on the top right area)
- Select “**Annotations**”, and then “**Add Annotation Query**”    n

A page shows up, where you can define the data source (aka “Service”) and query to run in order to get the list of values (in this case a list of computer heartbeats).

>**Note:** The output of the query should include a date-time value, a Text field with interesting info (in this case we used the computer name) and possibly tags (here we just used “test”).

- Add an Annotation to your chart overlaying Computer Heartbeat by configuring the new Annotation page as shown below, using the following query:  
```
Heartbeat
|  where $__timeFilter()  and Computer in  ($ComputerName)
|  project TimeGenerated, Text=Computer, Tags="test"
```
  

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/images/image143.png)  
- Again press Update then save to your Dashboard.
  
>**Note:**  Annotations provide a way to mark points on the graph with rich events. When you hover over an annotation you can get event description and event tags. The text field can include links to other systems with more detail.

- Go and check your Dashboard and check it

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/images/image144.png)  

>**Tip:** You can use the sample Kusto/Data explorer queries to create more dashboard scenarios.

 First to show the screenshot with the chart wins the challenge. 
 Good luck!

  

  


