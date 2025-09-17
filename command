git remote -v
git remote set-url origin https://dev.azure.com/samcado/DEVOPS_Platform_as_a_Service/_git/rds-aurora

git config --global credential.helper manager-core

# Clear any cached bad creds (both hosts)
@("dev.azure.com","samcado.visualstudio.com") | %{
  @"
protocol=https
host=$_
"@ | git credential-manager-core erase 2>$null
}
