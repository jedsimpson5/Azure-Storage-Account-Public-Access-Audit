# Azure-Storage-Account-Public-Access-Audit
## Usage
This powershell script will gather the public access level on containers in all storage accounts in a particular Azure subscription. The results are exported to a CSV. Possible values for the public access level output are container, blob, or off. The script takes two parameters- AzureSubscriptionName and OutputPath. An example commandline is below:
```
.\AzStorageAccountPublicAccessAudit.ps1 -AzureSubscriptionName "MyAzureSubscription" -OutputPath "C:\MyFolder\Results.csv"
```
## Prerequisites
You must have the Azure Powershell module installed. Microsoft documentation on this module is located here https://learn.microsoft.com/en-us/powershell/azure. The account you are using to login to Azure must have permissions to access storage accounts in your subscription.
