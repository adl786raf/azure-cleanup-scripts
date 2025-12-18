Start-Transcript -Path "C:\Users\Administrator\cleanup-azure.log" -Append

Write-Host "Listing all resources..."
az resource list --output table

$resources = az resource list --query "[].{id:id}" -o tsv
foreach ($res in $resources) {
    Write-Host "Deleting resource: $res"
    az resource delete --ids $res --only-show-errors
}

Write-Host "Listing all resource groups..."
az group list --output table

$groups = az group list --query "[].name" -o tsv
foreach ($grp in $groups) {
    Write-Host "Deleting resource group: $grp"
    az group delete --name $grp --yes --no-wait --only-show-errors
}

Write-Host "Listing all storage accounts..."
az storage account list --output table

$storageAccounts = az storage account list --query "[].name" -o tsv
foreach ($sa in $storageAccounts) {
    $rg = az storage account show --name $sa --query "resourceGroup" -o tsv
    Write-Host "Deleting storage account: $sa in resource group: $rg"
    az storage account delete --name $sa --resource-group $rg --yes --only-show-errors
}

Stop-Transcript
