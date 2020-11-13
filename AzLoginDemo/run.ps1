# Input bindings are passed in via param block.
param($Timer)

Select-AzSubscription -SubscriptionName $ENV:AZURE_SUBSCRIPTION_NAME
$groups = Get-AzResourceGroup | Select-Object -Property ResourceGroupName, Location
Push-OutputBinding -Name outputBlob -Value $groups
