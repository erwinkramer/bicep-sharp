<#
The script creates framework global settings into their own seperate text files.

Parameters:
- allowPublicResources - Sets the public network access property on resources.
- primaryLocation - Sets the primary location on resources.
- tlsVersion - Sets the required TLS version on resources.

#>
[CmdletBinding()]
param (
    [Parameter(Mandatory = $true)]
    [bool] $allowPublicResources,

    [Parameter(Mandatory = $true)]
    [string] $primaryLocation,

    [Parameter(Mandatory = $false)]
    [string] $tlsVersion = "TLS1_2"
)

Write-Output "compiling framework globals..."

$tlsVersion                                     | Out-File -NoNewline "./lib/private/variables/generated/tls.txt"
$allowPublicResources ? "Enabled" : "Disabled"  | Out-File -NoNewline "./lib/private/variables/generated/publicNetworkAccess.txt"
$primaryLocation                                | Out-File -NoNewline "./lib/private/variables/generated/primaryLocation.txt"
