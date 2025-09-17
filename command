# One-shot ADO Git setup (Windows)
param(
  [string]$UserName  = "Brenda Kenne",
  [string]$UserEmail = "brendakenne@situsamc.com",
  [string]$AzdoUser  = "brendakenne@situsamc.com",  # username shown to ADO
  [string]$PAT       = ""                           # paste via prompt if left empty
)

if (-not $PAT) {
  $sec = Read-Host "Paste your Azure DevOps PAT" -AsSecureString
  $bstr = [Runtime.InteropServices.Marshal]::SecureStringToBSTR($sec)
  $PAT  = [Runtime.InteropServices.Marshal]::PtrToStringBSTR($bstr)
  [Runtime.InteropServices.Marshal]::ZeroFreeBSTR($bstr)
}

git config --global user.name  "$UserName"
git config --global user.email "$UserEmail"
git config --global credential.helper manager-core

# Clear any cached creds
@("dev.azure.com","samcado.visualstudio.com") | ForEach-Object {
  @"
protocol=https
host=$_
"@ | git credential-manager-core erase 1>$null 2>$null
}

# Store PAT for both hosts
@("dev.azure.com","samcado.visualstudio.com") | ForEach-Object {
  @"
protocol=https
host=$_
username=$AzdoUser
password=$PAT
"@ | git credential-manager-core store
}

# Optional: trigger an auth to verify (no output on success)
$remote = git remote get-url origin 2>$null
if ($remote) { git ls-remote $remote | Out-Null }

Write-Host "Git user set and PAT stored in Windows Credential Manager."
