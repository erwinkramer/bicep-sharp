<#
The script creates a list of Enterprise apps. 
Splits the apps into one file for built-in apps, and one file for custom apps.

#>
[CmdletBinding()]
param (
)

Write-Output "compiling apps..."

$enterpriseApps = Get-AzADServicePrincipal
$customEnterpriseAppsForBicepSharp = [System.Collections.SortedList]::new()
$builtInEnterpriseAppsForBicepSharp = [System.Collections.SortedList]::new()

foreach ($enterpriseApp in $enterpriseApps) {

    $appName = $enterpriseApp.AppDisplayName ? $enterpriseApp.AppDisplayName : $enterpriseApp.DisplayName
    # Make the name lower camel case
    $First, $Rest = $appName -Replace '[^0-9A-Z]', ' ' -Split ' ', 2
    $nameLowerCamelCase = $First.Tolower() + (Get-Culture).TextInfo.ToTitleCase($Rest) -Replace ' '

    # Append to dictionary
    # f8cdef31-a31e-4b4a-93e4-5f571e91255a is the Microsoft Service's Microsoft Entra tenant ID.
    if ($enterpriseApp.AppOwnerOrganizationId -eq "f8cdef31-a31e-4b4a-93e4-5f571e91255a") {
        $builtInEnterpriseAppsForBicepSharp.Add($nameLowerCamelCase, $enterpriseApp.AppId)
    }
    else {
        $customEnterpriseAppsForBicepSharp.Add($nameLowerCamelCase, $enterpriseApp.AppId)
    }
}

$customEnterpriseAppsForBicepSharp     | ConvertTo-Json | Out-File "./lib/private/variables/generated/entraIdAppsCustom.json"
$builtInEnterpriseAppsForBicepSharp    | ConvertTo-Json | Out-File "./lib/private/variables/generated/entraIdAppsBuiltIn.json"