az account show -o table

# Find the server across the subscription
az resource list \
  --name wolff-application-db \
  --resource-type "Microsoft.Sql/servers" \
  --query "[].{name:name, rg:resourceGroup, id:id, location:location}" -o table
