SERVER="wolff-application-db"

# find the resource group
RG=$(az resource list \
  --name "$SERVER" \
  --resource-type "Microsoft.Sql/servers" \
  --query "[0].resourceGroup" -o tsv)

# get the full resource ID (scope)
SCOPE=$(az sql server show -g "$RG" -n "$SERVER" --query id -o tsv)

echo "RG=$RG"
echo "SCOPE=$SCOPE"
