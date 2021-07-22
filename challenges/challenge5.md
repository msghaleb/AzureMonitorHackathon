## Challenge 4:  KQL Queries

The aim of this challenge is to understand the Kusto Query Language (KQL)

### Main Objective:
We will learn to write and save queries, which we can run on our Log Analytics Workspace

### Tasks to finish the Challenge
- Write a performance query that renders a time chart for the last 4 hours for both the Web Servers and the SQL Server for the following perf metrics:
	- Processor Utilization: Processor / % Processor Time
	- Memory Utilization: Memory / % Committed Bytes In Use
	- Disk Utilization (IO): Disk Reads/sec and Disk Writes/sec
- Create a heartbeat query for the Web and SQL Server
- Write a performance query that renders a time chart for the last hour of the max percentage CPU usage of the AKS Cluster nodes
- Combine infrastructure and application logs to create a single timeseries chart that includes:
	- CPU usage from the node in your AKS cluster hosting the eshoponweb app
	- Duration of page views on your eshoponweb app hosted on the cluster
- Save each query to your favorites.

### Bonus question:
How can we save our log queries and share them across multiple workspaces?

### Definition of Done:
- Show the above 3 charts
- Show the saved queries

#### Helpful links:
- [Getting started with Kusto](https://docs.microsoft.com/en-us/azure/data-explorer/kusto/concepts/)


### The Solution

Are you sure? finished trying? ;-) 
[Challenge 4: The solution](solution4.md)
