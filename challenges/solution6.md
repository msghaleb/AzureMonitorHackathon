


# Challenge 6: Dashboard and Analytics

  

  

- Deploy Grafana using Web App for Container

  

  

<https://github.com/grafana/azure-monitor-datasource/blob/master/README.md>

  

  

- Hint: <http://docs.grafana.org/installation/docker/>

  

  

Create a Web App for Linux and configure as recommended below.

  

  

Create a new App service plan and select B1 Basic. It's under Dev /

  

Test.![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/images/image105.png){width="5.357808398950131in"

  

height="3.6875in"}\

  

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/images/image106.png){width="2.8311767279090114in"

  

height="2.513888888888889in"}

  

  

Select Container and specify Docker Hub, Public and Grafana/Grafana for

  

the image (this should deploy the latest version by default)\

  

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/images/image107.png){width="5.011681977252843in" height="2.75in"}

  

  

Should look like this when complete:\

  

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/images/image108.png){width="2.5277777777777777in"

  

height="4.423611111111111in"}

  

  

Click Create

  

  

After the Web App deploys, we need to configure some settings to enable

  

Azure Monitor Plugin.

  

  

From the Azure Portal navigate to your newly created App Service,

  

Settings, Application Settings

  

  

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/images/image109.png){width="6.5in" height="3.8652777777777776in"}

  

  

Under Always On, change the value to On.

  

  

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/images/image110.png){width="5.645127952755906in"

  

height="1.4060739282589676in"}

  

  

Under Application Settings, click on Show Values

  

  

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/images/image111.png){width="6.5in" height="1.2138888888888888in"}

  

  

Change the value for WEBSITES_ENABLE_APP_SERVICE_STORAGE to true (from

  

false)

  

  

Click Add new Setting and add the following:

  

  

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/images/image112.png){width="6.5in" height="1.7208333333333334in"}

  

  

Click Save

  

  

Note: For the Application settings to take effect you may need to

  

restart your Web App

  

  

**To Login to Grafana**

  

  

Click on Overview and copy the URL for your Web App

  

  

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/images/image113.png){width="6.5in" height="1.4513888888888888in"}

  

  

Navigate to the URL in your browser

  

  

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/images/image114.jpeg){width="5.119064960629921in" height="3.8125in"}

  

  

The username is "admin" lowercase and the password is whatever you

  

configured in Application Settings. Notice the version of Grafana as you

  

need 5.2.0 or newer if you are querying Azure Log Analytics.

  

  

Once logged into Grafana you should notice Azure Monitor is installed\

  

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/images/image115.png){width="5.258929352580927in"

  

height="3.9166666666666665in"}

  

  

- Configure the Azure Monitor Data Source for Azure Monitor, Log

  

Analytics and Application Insights

  

  

Configure Azure Monitor data source

  

  

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/images/image116.png){width="2.4371948818897637in"

  

height="2.426780402449694in"}

  

  

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/images/image117.png){width="6.5in" height="5.298611111111111in"}

  

  

Fill out the Azure Monitor API Details

  

  

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/images/image118.png){width="6.5in" height="4.8597222222222225in"}

  

  

For Tenant Id, go to Azure AD, properties to find the Directory ID.

  

  

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/images/image119.png){width="5.0in" height="4.083333333333333in"}

  

  

For Client Id, use the same client Id (Service Principal) you used in

  

the AKS deployment for terraform. Note: Azure best practices would be to

  

generate a new service principal and only grant the required

  

permissions.

  

  

Sample: ready-mws02-aks-preday Client Id =

  

0bd13b1d-2ddb-41e9-a286-d81328e9a72d

  

  

For Client Secret, use the same password you set in the Azure Key Vault

  

during the deployment

  

  

Note: Make sure to add the service principal created during the

  

deployment to your Log Analytics as a reader

  

  

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/images/image120.png){width="3.075353237095363in"

  

height="7.173611111111111in"}

  

  

Click Save & Test and you should see a message like below.

  

  

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/images/image121.png){width="6.5in" height="1.5263888888888888in"}

  

  

To configure Application Insights, find your API Id and generate a key

  

  

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/images/image122.png){width="6.5in" height="5.636805555555555in"}

  

  

Copy the Application ID and paste in Grafana. Click on Create API Key

  

  

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/images/image123.png){width="6.5in" height="4.7125in"}

  

  

Copy the key and paste in the Grafana Application Insights Details.

  

Note: you cannot retrieve this key again.

  

  

Click Save & Test. Should like this now.

  

  

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/images/image124.png){width="6.5in" height="2.3131944444444446in"}

  

  

- Create a CPU Chart with a Grafana variable used to select Computer

  

Name

  

  

Create a new dashboard

  

  

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/images/image125.png){width="2.593426290463692in"

  

height="2.353872484689414in"}

  

  

Add Graph

  

  

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/images/image126.png){width="6.5in" height="3.310416666666667in"}

  

  

Edit the Panel Title

  

  

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/images/image127.png){width="6.5in" height="3.24375in"}

  

  

Under General change to the name to something like Computer CPU

  

  

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/images/image128.png){width="6.5in" height="2.8847222222222224in"}

  

  

Under Metrics, make sure service is Azure Log Analytics, your workspace

  

is selected, and build out a Log Analytics query (answer query below for

  

your reference).

  

  

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/images/image129.png){width="6.490641951006125in"

  

height="3.612846675415573in"}

  

  

Sample query:

  

  

Perf

  

  

\| where \$\_\_timeFilter(TimeGenerated)

  

  

\| where CounterName == \"% Processor Time\" and InstanceName ==

  

\"\_Total\"

  

  

\| summarize percentile(CounterValue,50) by bin(TimeGenerated,

  

\$\_\_interval), Computer

  

  

\| order by TimeGenerated asc

  

  

Click Run to test

  

  

Now let's make a few changes. Click on Axes and change the Unit to

  

percent and Y-Max to 100.\

  

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/images/image130.png){width="6.5in" height="2.459722222222222in"}

  

  

Run it again

  

  

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/images/image131.jpeg){width="6.5in" height="1.0097222222222222in"}

  

  

Let's save it by click on the disk in the upper right side.

  

  

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/images/image132.png){width="6.5in" height="3.2930555555555556in"}

  

  

Should look something like this:

  

  

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/images/image133.png){width="6.5in" height="3.7777777777777777in"}

  

  

[Advanced features]{.ul}

  

  

[ ]{.ul}

  

  

-  **Variables**

  

  

> Some query values can be selected through UI dropdowns, and updated in

  

> the query.

  

>

  

> For example, a "Computer" variable can be defined, and then a dropdown

  

> will appear on the dashboard, showing a list of possible values:

  

  

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/images/image134.png){width="6.5in" height="4.8493055555555555in"}

  

  

Now let's add a variable that lets us select computers in the chart.

  

Click on the gear in the upper right corner.\

  

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/images/image135.png){width="6.5in" height="1.5604166666666666in"}

  

  

Click on Add Variable

  

  

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/images/image136.png){width="6.5in" height="2.83125in"}

  

  

Configure the Variable to look like the screen below. Note: In my case I

  

make sure to specify the Workspace name as I have many workspaces and

  

wanted to make sure we only returned values that would work in our

  

chart.

  

  

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/images/image137.png){width="6.5in" height="5.161111111111111in"}

  

  

Click Add.

  

  

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/images/image138.png){width="6.5in" height="1.3701388888888888in"}

  

  

Make sure to Save your dashboard

  

  

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/images/image139.png){width="6.5in" height="2.884027777777778in"}

  

  

Now go back and edit your Computer CPU chart to update the query to use

  

the new variable.

  

  

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/images/image140.png){width="6.5in" height="1.3972222222222221in"}

  

  

Sample update Computer CPU query to support variable \$ComputerName

  

  

Perf

  

  

\| where \$\_\_timeFilter(TimeGenerated) and Computer in

  

(\$ComputerName)

  

  

\| where (CounterName == \"% Processor Time\" and InstanceName ==

  

\"\_Total\") or CounterName == \"% Used Memory\"

  

  

\| summarize AVGPROCESSOR = avg(CounterValue) by bin(TimeGenerated,

  

\$\_\_interval), Computer

  

  

\| order by TimeGenerated asc

  

  

Make sure to Save

  

  

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/images/image141.png){width="6.5in" height="2.842361111111111in"}

  

  

Try it out!

  

  

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/images/image142.png){width="6.5in" height="4.354861111111111in"}

  

  

Try creating a variable that accepts percentiles (50, 90 and 95).

  

  

-  **Annotations**

  

  

> Another cool Grafana feature is annotations -- which marks points in

  

> time that you can overlay on top of charts.

  

>

  

> Below, you can see the same chart shown above, with an annotation of

  

> Heartbeats. Hovering on a specific annotation shows informative text

  

> about it.

  

>

  

>  **Configuration** is very similar to Variables:

  

>

  

> Click the dashboard Settings button (on the top right area), select

  

> "Annotations", and then "+New".

  

>

  

> This page shows up, where you can define the data source (aka

  

> "Service") and query to run in order to get the list of values (in

  

> this case a list of computer heartbeats).

  

>

  

> Note that the output of the query should include a date-time value, a

  

> Text field with interesting info (in this case we used the computer

  

> name) and possibly tags (here we just used "test").

  

  

Add an Annotation to your chart overlaying Computer Heartbeat

  

  

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/images/image143.png){width="6.5in" height="4.418055555555555in"}

  

  

FYI... Annotations provide a way to mark points on the graph with rich

  

events. When you hover over an annotation you can get event description

  

and event tags. The text field can include links to other systems with

  

more detail.

  

  

Navigate to settings from your dashboard (the gear in the upper right),

  

click on Annotations, Add Annotation Query

  

  

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/images/image144.png){width="6.5in" height="4.651388888888889in"}

  

  

HINT: Use the sample Kusto/Data explorer queries to create more

  

dashboard scenarios.

  

  

- First Team to email me a screenshot with your chart wins the

  

challenge. Good luck!

  

  


