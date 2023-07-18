<#
DESCRIPTION:
   This will gather the public access level on containers in all storage accounts in a particular Azure subscription.
#>

param(
    [Parameter(Mandatory)]
    [string]$AzureSubscriptionName, #Allows the user to select which Azure suscription they want to connect to with Azure Powershell

    [Parameter(Mandatory)]
    [string]$OutputPath #Allows the user to specify an output file path
)

$AzureContext = Get-AzContext

if($AzureContext -eq $null) #Checks whether a new Azure Powershell session is needed based on whether there is a current value for the Azure context
{
    Connect-AzAccount
}

Set-AzContext -Subscription $AzureSubscriptionName #Sets the Azure context based on the Azure subscription input from the user

$ResourceGroup = (Get-AzStorageAccount).ResourceGroupName | Select-Object -Unique #Gathers a unique list of resource groups from the Azure subscription

foreach($Group in $ResourceGroup) #Loops through each resource group
{
    $StorageAccount = (Get-AzStorageAccount | Where-Object {$_.ResourceGroupName -eq $Group}).StorageAccountName #Gathers a list of storage account names from each resource group
    
    foreach($Account in $StorageAccount) #Loops through each storage account, retrieves the public access setting from the container(s) in the storage account, and appends the info to a CSV
    {
        $StorageAccountContext = (Get-AzStorageAccount -ResourceGroupName $Group -Name $Account).Context

        Get-AzStorageContainer -Context $StorageAccountContext | Select-Object @{Name = "StorageAccountName"; Expression = {$Account}},@{Name = "ContainerName"; Expression = {$_.Name}},PublicAccess |
        Export-Csv -Path $OutputPath -Append -NoTypeInformation
    }
}
