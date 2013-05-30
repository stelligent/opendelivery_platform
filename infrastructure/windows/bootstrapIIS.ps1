# Script to install the basic IIS stack using Chef, then prepare to receive 
# assets.
#
# This is expected to be invoked via "Invoke-Command" remotely from another 
# windows host. Invoke-Command will transfer this script to the host, then
# execute it.


param (
    [Parameter(Mandatory=$true, Position=0)]
    [string]$CDOPGitRepoUrl,

    [Parameter(Mandatory=$false, Position=1)]
    [string]$Branch
  )

$chef = "C:\chef"
$opscode = "C:\opscode"
$git = "C:\Program Files (x86)\Git"
$bootstrap = "C:\bootstrap"

$Env:PATH += ";$opscode\bin;$git\bin"

mkdir -force $bootstrap
cd $bootstrap

if ([string]::IsNullOrEmpty($Branch)) 
{
  git clone $CDOPGitRepoUrl cdop
} else {
  git clone -b $Branch $CDOPGitRepoUrl cdop
}
cd "cdop\infrastructure\windows"

invoke-expression -Command .\chef-iis.ps1

   

