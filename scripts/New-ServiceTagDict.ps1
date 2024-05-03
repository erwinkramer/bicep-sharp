<#
The script creates a list of service tags. 
Splits the service tags into one file for global service tags, and one file for regional service tags.

Parameters:
- location - Filters the related regional service tags.

#>
[CmdletBinding()]
param (
    [Parameter(Mandatory = $true)]
    [string] $location
)

Write-Output "compiling service tags..."

$serviceTags = (Get-AzNetworkServiceTag -Location $location).Values
$serviceTagsGlobalForBicepSharp = [System.Collections.SortedList]::new()
$serviceTagsRegionalForBicepSharp = [System.Collections.SortedList]::new()

foreach ($serviceTag in $serviceTags) {

    # Make the name lower camel case
    $First, $Rest = $serviceTag.Name -Replace '[^0-9A-Z]', ' ' -Split ' ', 2
    $nameLowerCamelCase = $First.Tolower() + (Get-Culture).TextInfo.ToTitleCase($Rest) -Replace ' '

    # Append to dictionary
    # Azure Front Door is the only service that uses a seperator for own use and not for regional use
    if ($serviceTag.Id.Contains(".") -and -not $serviceTag.Id.Contains("AzureFrontDoor")) {

        # Reduce to service tags that are only in the supplied location 
        if ($serviceTag.Id -like "*.$location") {
            $serviceTagsRegionalForBicepSharp.Add($nameLowerCamelCase, $serviceTag.Id)
        }
    }
    else {
        $serviceTagsGlobalForBicepSharp.Add($nameLowerCamelCase, $serviceTag.Id)
    }
}

$serviceTagsGlobalForBicepSharp     | ConvertTo-Json | Out-File "./lib/private/variables/generated/serviceTagsGlobal.json"
$serviceTagsRegionalForBicepSharp   | ConvertTo-Json | Out-File "./lib/private/variables/generated/serviceTagsRegional.json"
