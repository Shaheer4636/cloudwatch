SERVER="wolff-application-db"

# Find the RG
RG=$(az resource list \
  --name "$SERVER" \
  --resource-type "Microsoft.Sql/servers" \
  --query "[0].resourceGroup" -o tsv)

# Full resource ID (scope for RBAC)
SCOPE=$(az sql server show -g "$RG" -n "$SERVER" --query id -o tsv)

echo "RG=$RG"
echo "SCOPE=$SCOPE"
