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
| mv-expand properties_privateEndpointConnections.properties.privateLinkServiceConnectionState.description
| mv-expand properties_privateEndpointConnections.properties.privateEndpoint.id
| extend state = properties_privateEndpointConnections_properties_privateLinkServiceConnectionState_description
| extend peName = split(properties_privateEndpointConnections_properties_privateEndpoint_id, '`/')[-1]
| extend name2 = split(id2, '`/')
| extend connectionName = name2[-1]
| project name, connectionName, state, peName
"@

$connectionNamesAutoApproved = [System.Collections.SortedList]::new()
$connectionNamesManual = [System.Collections.SortedList]::new()

foreach ($privateEndpoint in $privateEndpoints) {

    # Make the name lower camel case
    # For these values, replace dots with underscores to preserve readable names
    $First, $Rest = $privateEndpoint.peName -Replace '[^0-9A-Z.]', ' ' -Split ' ', 2
    $nameLowerCamelCase = $First.Tolower() + (Get-Culture).TextInfo.ToTitleCase($Rest) -Replace ' ' -Replace '\.', '_'

    if ($privateEndpoint.state -eq "Auto-Approved") {
        $connectionNamesAutoApproved.Add($nameLowerCamelCase, $privateEndpoint.connectionName )
    }
    else {
        $connectionNamesManual.Add($nameLowerCamelCase, $privateEndpoint.connectionName )
    }
}

$connectionNamesAutoApproved    | ConvertTo-Json | Out-File "./lib/private/variables/generated/peConnectionsAutoAppr.json"
$connectionNamesManual          | ConvertTo-Json | Out-File "./lib/private/variables/generated/peConnectionsManual.json"
