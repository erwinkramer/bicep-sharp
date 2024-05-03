<#
Publish the Bicep# library artifacts to an Azure Container Registry.

Parameters:
- acrLoginServer - The login server of an Azure Container Registry
- versionPostfix - Sets the version of the files to publish, if the version already exists, it will overwrite

#>
[CmdletBinding()]
param (
    [Parameter(Mandatory = $true)]
    [string] $acrLoginServer,

    [Parameter(Mandatory = $false)]
    [int] $versionPostfix = 1
)

Write-Output "🤠 😎 💪 Bicep# publisher"

$global:ErrorActionPreference = 'Stop'

$libFiles = Get-ChildItem -Path "./lib/" -File

foreach ($libFile in $libFiles) {
    $target = "br:$acrLoginServer/bicepsharp/$($libFile.Basename):v$versionPostfix"
    Write-Output "publishing $target..."
    Publish-AzBicepModule -FilePath $libFile.FullName -Target $target -DocumentationUri "" -Force
}
