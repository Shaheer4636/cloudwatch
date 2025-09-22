az extension add -n resource-graph -y

# 1) See all subscriptions you can use
az account list --all -o table

# 2) Search every subscription you can access for the SQL server
az graph query -q "
Resources
| where type =~ 'microsoft.sql/servers'
| project name, resourceGroup, subscriptionId, id
" -o table
