<#
Builds the Bicep# library artifacts.

Parameters:
- location - Filters the related regional service tags.
- allowPublicResources - Sets the public network access property on resources.

#>
[CmdletBinding()]
param (
    [Parameter(Mandatory = $true)]
    [string] $location,

    [Parameter(Mandatory = $true)]
    [bool] $allowPublicResources
)

Write-Output "🤠 😎 💪 Bicep# compiler"

$global:ErrorActionPreference = 'Stop'

./scripts/New-FrameworkGlobals -primaryLocation $location -allowPublicResources $allowPublicResources
./scripts/New-PeConnectionDict
./scripts/New-RolesDict
./scripts/New-EntraIdEntAppDict
./scripts/New-ServiceTagDict -location $location