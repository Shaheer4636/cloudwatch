# Try ARM first
az resource list \
  --subscription "$SUB" \
  --resource-type "Microsoft.Sql/servers" \
  --query "[?name=='$SERVER'].{rg:resourceGroup,id:id}" -o table

# If that returns nothing, use Resource Graph too:
az extension add -n resource-graph -y >/dev/null 2>&1
az graph query --subscriptions "$SUB" -q "
Resources
| where type =~ 'microsoft.sql/servers'
| where name =~ '$SERVER'
| project rg=resourceGroup, id
" -o table
