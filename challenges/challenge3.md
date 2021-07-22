## Challenge 3:  Workbooks

The aim of the first challenge is to understand what is Azure Workbooks and how to create them

### Main Objective:
The aim of this challenge is to create a report that combines browser, web server and infrastructure performance in a single page. 

### Tasks to finish the Challenge
Create a workbook with sections that report on the performance of your eShopWeb application from five different perspectives

1. Web page performance as observed from the client-side browser using Page View records.
>Visualizations: Time Selector, Table with columns for Page Titles. Page Views with Bar underneath, Average Page Time with Thresholds and Maximum Page time with Bar underneath.

2. Request failures reported by the web server using Request records.
>Visualization: Table with columns for Request Name. HTTP Return Code, Failure Count with Heatmap and Page Time with Heatmap.

3. Server response time as observed from the server-side using Request metrics.
>Visualization: Line Chart of Average and Max Senver Response Time.

4. Infrastructure performance as observed from the nodes in the AKS cluster on which the application is deployed using Average and Maximum CPU usage metrics.
>Visualization: Line Chart of Average CPU usage percentage by AKS cluster node

5. Infrastructure performance from AKS nodes showing disk used percentage based on Log Analytics records.
>Visualization: Line Chart of Average Disk used percentage by AKS cluster node.

### Definition of Done:
- Show your Workbook

#### Helpful links:
-[Azure Workbooks](https://docs.microsoft.com/en-us/azure/azure-monitor/app/usage-workbooks)


### The Solution

Are you sure? finished trying? ;-) 
[Challenge 3: The solution](solution3.md)
