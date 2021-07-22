## Challenge 7:  Application Insights

The aim of the first challenge is to understand....

### Main Objective:


### Tasks to finish the Challenge
- Create a URL ping availability test for your eShopWeb webpage
- Enable Application Insights server-side telemetry in the eShopOnWeb Web Project in the Solution.
	- Install the Application Insights SDK NuGet package for ASP .NET Core. 
	- Add you Application Insights Key to your code
	- Make sure if you use the web shop locally (try Firefox) that it write data to Application Insights in Azure
	- Generate an exception (can you change your password?)
	- Create an Alert to be triggered once this exception happened
- Enable client-side telemetry collection for your eShoponWeb application.
	- Inject the App Insights .NET Core JavaScript snippet
	
#### Bonus task:
- Can you hit the VMSS to cause an Auto Scale?
- Can you publish your code to your VMSS?

### Definition of Done:
- Show the exception Azure Portal App Insights and the Alert cause by it
- Show that the client browser data is showing up in App Insights  

#### Helpful links:
- [Application Insights for ASP. NET Core applications](https://docs.microsoft.com/en-us/azure/azure-monitor/app/asp-net-core#enable-application-insights-server-side-telemetry-no-visual-studio)
- [Monitor the availability of any website](https://docs.microsoft.com/en-us/azure/azure-monitor/app/monitor-web-app-availability)
- [Debug your applications with Azure Application Insights in Visual Studio](https://docs.microsoft.com/en-us/azure/azure-monitor/app/visual-studio)
- [Microsoft.ApplicationInsights.AspNetCore](https://www.nuget.org/packages/Microsoft.ApplicationInsights.AspNetCore)
- [Disable SSL while debugging](https://codetolive.in/ide/how-to-disable-https-or-ssl-in-visual-studio-2019-for-web-project/)
- [Enable client-side telemetry for web applications](https://docs.microsoft.com/en-us/azure/azure-monitor/app/asp-net-core#enable-client-side-telemetry-for-web-applications)  

### The Solution

Are you sure? finished trying? ;-) 
[Challenge 7: The solution](solution7.md)
