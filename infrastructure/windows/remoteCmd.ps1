# Powershell script to deploy a WSP file to a remote host.
#
# Reference: hugely useful: http://www.ravichaganti.com/blog/?p=1108
#
# Usage:
#   .\remoteCmd.ps1 <username> <hostname> <scriptName> [arg arg arg ...] 
#
# This uses an additional file "deploy-secrets.xml" with username/password pairs for
# accessing the remote server. The full path of the file can be specified with the
# environment variable DEPLOY_SECRETS="C:\Some\Path\my-deploy-secrets.xml"
#
# NOTE: CredSSP must be enabled on client and server. It's a complicated process, but these
# are some of the hints to get it started.
# enable CredSSP on a client computer; this command allows the client credentials to be delegated to the server01 computer.:
#    C:\PS>enable-wsmancredssp -role client -delegatecomputer server01.test.local
# enable CredSSP on a server computer; this command allows the server01 computer to act as a delegate for another:
#    C:\PS>connect-wsman server01
#    C:\PS>set-item wsman:\server01\service\auth\credSSP -value $true
#Or, if you prefer to run a command locally on the server01 computer, the following command will enable CredSSP on a server computer too:
#    C:\PS>enable-wsmancredssp -role server
param([string]$user = $(throw "Please supply a user name"),
	[string]$remoteHost = $(throw "Please supply a remote host"),
	[string]$command = $(throw "Please supply a command to run."))


#########################################
# Write Usage message and exit with error code
function Usage([string]$msg) {
	if ($msg -ne $null) { Write-host "ERROR: " $msg }
	Write-host "usage: .\remoteCmd.ps1 <username> <hostname> <scriptName> [arg arg arg ...]"
	exit 1
}

#########################################
# Display a debug message
[bool]$debugFlag=$false
function Debug([string]$msg) {
	if ($debugFlag -eq $true) { Write-Host "DEBUG: $msg" }
}

#########################################
# Display a debug message
[bool]$infoFlag=$true
function Info([string]$msg) {
	if ($infoFlag -eq $true) { Write-Host "INFO: $msg" }
}

#########################################
function Die([string]$msg) {
	Write-error $msg
	exit 1
}


########################################
# Load a secrets file with <UserName> and <Password> in it so we can
# use it for remote commands.
# 
function Read-Secrets-File([string]$secretsFile)
{

	Debug "Loading secrets file $secretsFile"

	if ([string]::IsNullOrEmpty($secretsFile)) 
	{
		Write-warning "No secrets file provided."
		return
	}

	if ((Test-Path $secretsFile) -ne $true) {
		Write-warning "Secrets file doesn't exist."
		return
	}

	$secrets = [xml] (Get-Content $secretsFile)

	# Secrets file now has two formats:
	# Old: Single "UserName" field
	# New: Multiple "UserPass" fields

	# Verify stuff is inside. (not actually used anywhere)
	$userName=$secrets.DeploySecrets.UserName
	if ($userName -eq $null -or $userName.Length -eq 0) {
		Debug "No user name provided in secrets file. Assuming new UserPass format."
	} else {

		$password=$secrets.DeploySecrets.Password
		$pwLen=$password.Length
		if ($password -eq $null -or $password.Length -eq 0) {
			Write-warning "No password provided for UserName in secrets file."
		}
		Debug "User name: $userName"
		Debug "Password: [ $pwLen characters ]"

	}

	# Return the whole XML file so others can use it.
	return $secrets
}

#####################################
# Look for a password in the secrets file to match a requested username and return it
# This is the primary interface for finding a secret. Eventually we'll find a way to make
# it more secure.
$constGetSecretsError=$null
function Get-Secret-Password([string]$userName) {
	Debug "Looking up password for $userName"

	# Default secrets file in current working dir.
	$secretsFile = "deploy-secrets.xml"
	
	# Check the environment to see if a file was sent to us.
	if ($Env:DEPLOY_SECRETS -ne $null) {
		$secretsFile = $Env:DEPLOY_SECRETS
		Debug "Overriding secrets with environment file [$secretsFile]"
	}
	Info "Using secrets file $secretsFile"

	Debug "Looking up password for user $userName"
	$file = $secretsFile

	$secrets = [xml](Read-Secrets-File $file)
	
	# First, try "old" format of lookup with single UserName field
	$user = $secrets.DeploySecrets.UserName
	$foundPassword = $constGetSecretsError
	if ($user -ne $null) { 
		Debug "Examining old user $userName"
		if ($user -ne $userName) {
			Debug "Warning: old style UserName in secrets file does not match requested username."
			# Keep searching
		} else {
		
			# Found the specified password. Return it.
			$foundPassword = $secrets.DeploySecrets.Password
			return $foundPassword
		}
    }

	# Otherwise, Try "new" format with multiple UserPass fields.
	$secrets.DeploySecrets.UserPass | foreach-Object {

		$user = $_.Name
		$pass = $_."#text"
		$pwLen=$pass.Length

		Debug "  Examining user $user / pass [ $pwLen characters ]"

		if ($user -eq $userName) {
			# Found the user name. Return the password.
			Debug "  Returning password for $user"
			# Record the password we found. Note that Foreach-Object always processes all elements without a
			# "break" or "return" capability from within the loop
			$foundPassword = $pass
		}
	}

	return $foundPassword
}

####################### MAIN FLOW ########################
	
# Set up credentials for the deployment user
$password = Get-Secret-Password $user "deploy-secrets.xml"
if ($password -eq $null) {
	Die "Cannot read password for user '$user'"
}

$secpasswd= ConvertTo-SecureString "$password" -AsPlainText -Force
#Debug "SECURITY: Building credentials for $user with $password"
$cred = New-Object System.Management.Automation.PSCredential("$user", $secpasswd)

$scriptFile = $command

Info "Remote execute $user@$remoteHost $scriptFile with args [ $args ]"
#if ((Test-Path $scriptFile) -ne $true) { Die "Script file $scriptfile in wrong place." }
Invoke-Command -ComputerName $remoteHost -credential $cred -Authentication Credssp -FilePath $scriptFile  -ArgumentList $args 


##############################################

