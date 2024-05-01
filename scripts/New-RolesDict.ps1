<#
The script creates a list of role definitions. 
Splits the definitions into one file for built-in roles, and one file for custom roles.

#>
[CmdletBinding()]
param (
)

Write-Output "compiling roles..."

$roleDefinitions = Get-AzRoleDefinition
$customRoleDefinitionsForBicepSharp = [ordered]@{}
$builtInroleDefinitionsForBicepSharp = [ordered]@{}

foreach ($roleDefinition in $roleDefinitions) {

    # Make the name lower camel case
    $First, $Rest = $roleDefinition.Name -Replace '[^0-9A-Z]', ' ' -Split ' ', 2
    $nameLowerCamelCase = $First.Tolower() + (Get-Culture).TextInfo.ToTitleCase($Rest) -Replace ' '

    # Append to dictionary
    if ($roleDefinition.IsCustom -eq "True") {
        $customRoleDefinitionsForBicepSharp.Add($nameLowerCamelCase, $roleDefinition.Id)
    }
    else {
        $builtInroleDefinitionsForBicepSharp.Add($nameLowerCamelCase, $roleDefinition.Id)
    }
}

$customRoleDefinitionsForBicepSharp     | ConvertTo-Json | Out-File "./lib/private/variables/generated/rolesCustom.json"
$builtInroleDefinitionsForBicepSharp    | ConvertTo-Json | Out-File "./lib/private/variables/generated/rolesBuiltIn.json"