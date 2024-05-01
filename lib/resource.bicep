import * as _resourceType from 'private/types/resource.bicep'
import * as _locationType from 'private/types/location.bicep'
import * as _locationVar from 'private/variables/location.bicep'

/* ----------------------------------------

      🤠 Bicep# - Public variables 🤠

------------------------------------------- */

@description('''
Value of a location to deploy resources to. An individual value matches the `location` type.
''')
@export()
var locations = _locationVar.locations

/* ----------------------------------------

      😎 Bicep# - Public types 😎

------------------------------------------- */

@export()
type resourceGroupName = _resourceType.resourceGroupName

@description('''
Location or region in Azure.
''')
@export()
type location = _locationType.location

@description('''
Location or region in Azure. NSG Rule Service tag 'Azure Cloud' requires different naming for some locations, following is the complete list of compatible locations or regions.

Please see https://learn.microsoft.com/en-us/azure/virtual-network/service-tags-overview#discover-service-tags-by-using-downloadable-json-files for more info.
''')
@export()
type locationAzureCloud = _locationType.locationAzureCloud

/* ---------------------------------------- 

      💪 Bicep# - Public functions 💪

------------------------------------------- */

@description('''
Get the resource name from a resource id.
''')
@export()
func getResourceName(resourceId string) string => last(split(resourceId, '/'))

@description('''
Get the resource resource group name from a resource id.
''')
@export()
func getResourceGroupName(resourceId string) _resourceType.resourceGroupName => split(resourceId, '/')[4]

@description('''
Build a resource group.
''')
@export()
func buildResourceGroup(resourceGroupPostFix string) _resourceType.resourceFormat => {
  name: 'rg-${resourceGroupPostFix}'
  properties: {}
}

@description('''
Create a module name. Chain module names by providing the previousModuleName parameter with your own name, or create it automatically with `deployment().name`.
''')
@export()
func createModuleName(modulePostFix string, previousModuleName string?) string =>
  empty(previousModuleName) ? '${deployment().name}-${modulePostFix}' : '${previousModuleName}-${modulePostFix}'

@description('''
Get the primary location
''')
@export()
func getPrimaryLocation() location => loadTextContent('./private/variables/generated/primaryLocation.txt')
