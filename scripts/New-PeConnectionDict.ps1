<#
The script creates a list of private endpoint connection names. Found in any resource under privateEndpointConnections[*].name

#>
[CmdletBinding()]
param (
)

Write-Output "compiling private endpoint connections..."

$privateEndpoints = Search-AzGraph -Query @"
resources
| where array_length(properties.privateEndpointConnections) > 0
| mv-expand properties.privateEndpointConnections
| extend id2 = properties_privateEndpointConnections.id
| mv-expand properties_privateEndpointConnections.properties.privateLinkServiceConnectionState.status
| mv-expand properties_privateEndpointConnections.properties.privateEndpoint.id
| extend state = properties_privateEndpointConnections_properties_privateLinkServiceConnectionState_status
| extend peName = split(properties_privateEndpointConnections_properties_privateEndpoint_id, '`/')[-1]
| extend name2 = split(id2, '`/')
| extend connectionName = name2[-1]
| project name, connectionName, state, peName
"@

$connectionNamesApproved = [System.Collections.SortedList]::new()
$connectionNamesPending = [System.Collections.SortedList]::new()
$connectionNamesPendingLookup = [System.Collections.Generic.SortedSet[string]]::new()

foreach ($privateEndpoint in $privateEndpoints) {

    # Make the name lower camel case
    # For these values, replace dots with underscores to preserve readable names
    $First, $Rest = $privateEndpoint.peName -Replace '[^0-9A-Z.]', ' ' -Split ' ', 2
    $nameLowerCamelCase = $First.Tolower() + (Get-Culture).TextInfo.ToTitleCase($Rest) -Replace ' ' -Replace '\.', '_'

    if ($privateEndpoint.state -eq "Approved") {
        $connectionNamesApproved.Add($nameLowerCamelCase, $privateEndpoint.connectionName )
    }
    else {
        $connectionNamesPending.Add($nameLowerCamelCase, $privateEndpoint.connectionName )
        $connectionNamesPendingLookup.Add($privateEndpoint.connectionName) | Out-Null
    }
}

$connectionNamesApproved    | ConvertTo-Json | Out-File "./lib/private/variables/generated/peConApproved.json"
$connectionNamesPending     | ConvertTo-Json | Out-File "./lib/private/variables/generated/peConPending.json"

# Don't use a pipeline operator or else it does not handle empty arrays nicely
ConvertTo-Json -InputObject $connectionNamesPendingLookup | Out-File "./lib/private/variables/generated/peConPendingLookup.json"