
# Challenge 6a: Workbooks

  

  

Workbook documentation is available here:

  

<https://docs.microsoft.com/en-us/azure/azure-monitor/app/usage-workbooks>

  

  

Navigate to your Application Insights resource in the Portal

  

  

Click on Workbooks New

  

  

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/images/image145.png){width="6.5in" height="2.0194444444444444in"}

  

  

Click Edit in the New Workbook section to describe the upcoming content

  

in the workbook. Text is edited using Markdown syntax.

  

  

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/images/image146.png){width="6.5in" height="4.261805555555555in"}

  

  

Use **Add text** to describe the upcoming table

  

  

Use **Add parameters** to create the time selector

  

  

Use **Add query** to retrieve data from pageViews

  

  

Use **Column Settings** to change labels of column headers and use Bar

  

and Threshold visualizations.

  

  

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/images/image147.png){width="6.5in" height="3.8756944444444446in"}

  

  

Query used for section Browser Statistics

  

  

pageViews

  

  

\| summarize pageSamples = count(itemCount), pageTimeAvg = avg(duration), pageTimeMax = max(duration) by name

  

  

\| sort by pageSamples desc

  

  

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/images/image148.png){width="6.5in" height="1.74375in"}

  

  

Query used for Request Failures

  

  

requests

  

  

\| where success == false

  

  

\| summarize total_count=sum(itemCount), pageDurationAvg=avg(duration) by name, resultCode

  

  

Use **Add Metric** to create a metric chart

  

  

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/images/image149.png){width="6.5in" height="3.888888888888889in"}

  

  

Change your **Resource Type** to Virtual Machine

  

  

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/images/image150.png){width="6.5in" height="0.7201388888888889in"}

  

  

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/images/image151.png){width="6.5in" height="1.5569444444444445in"}

  

  

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/images/image152.png){width="6.5in" height="1.645138888888889in"}

  

  

Change the Resource Type to **Log Analytics**

  

  

Change your workspace to the LA workspace with your AKS container logs

  

  

![](https://github.com/msghaleb/AzureMonitorHackathon/raw/master/images/image153.png){width="6.5in" height="3.5868055555555554in"}

  

  

Query used for section Disk Used Percentage

  

  

InsightsMetrics

  

  

\| where Namespace == \"container.azm.ms/disk\"

  

  

\| where Name == \"used_percent\"

  

  

\| project TimeGenerated, Computer, Val

  

  

\| summarize avg(Val) by Computer, bin(TimeGenerated, 1m)

  

  

\| render timechart

  

  

Save your workbook.
