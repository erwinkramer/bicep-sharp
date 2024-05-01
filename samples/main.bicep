import * as sharpResource from '../lib/resource.bicep'
import * as sharpTag from '../lib/tag.bicep'

targetScope = 'subscription'

param environment sharpTag.env

@minLength(2)
@maxLength(5)
@description('Project short name. A unique identifier (2 to 5 characters) for a project')
param projectShortName string

@minLength(2)
@maxLength(7)
@description('Functional name for composing resource names. Only alphanumeric.')
param functionalName string

@minLength(3)
@maxLength(3)
param revision string

@description('Assign a role to a EntraID principal')
param principalId string

@description('CIDR, address space of a subnet')
param subnetAddressPrefix string

@description('CIDR, address space of a vnet')
param vnetAddressPrefix array

@description('Id of a Log Analytics workspace')
param workspaceId string = ''

param tagsDevOpsServices sharpTag.collectionDevOpsServices

param tagsServiceNow sharpTag.collectionServiceNow

param tagsEnterprise sharpTag.collectionEnterprise

var tags = union(
  tagsDevOpsServices,
  tagsServiceNow,
  tagsEnterprise,
  {
    env: environment
  }
)

var contentPostFix = '${projectShortName}-${functionalName}-${environment}-${revision}'

var sharpContentResourceGroup = sharpResource.buildResourceGroup(contentPostFix)

var sharpNetworkResourceGroup = sharpResource.buildResourceGroup('${contentPostFix}-infra')

resource vnetResourceGroup 'Microsoft.Resources/resourceGroups@2023-07-01' = {
  name: sharpNetworkResourceGroup.name
  properties: sharpNetworkResourceGroup.properties
  location: sharpResource.getPrimaryLocation()
  tags: tags
}

module network 'modules/vnet.bicep' = {
  name: sharpResource.createModuleName(sharpNetworkResourceGroup.name, null)
  scope: vnetResourceGroup
  params: {
    tags: tags
    vnetPostFix: contentPostFix
    vnetAddressPrefix: vnetAddressPrefix
    subnetAddressPrefix: subnetAddressPrefix
    subnetPostfix: contentPostFix
  }
}

resource contentResourceGroup 'Microsoft.Resources/resourceGroups@2023-07-01' = {
  name: sharpContentResourceGroup.name
  properties: sharpContentResourceGroup.properties
  location: sharpResource.getPrimaryLocation()
  tags: tags
}

module storageAccount 'modules/storage-account.bicep' = {
  name: sharpResource.createModuleName(sharpContentResourceGroup.name, null)
  scope: contentResourceGroup
  params: {
    storagePostfix: contentPostFix
    tags: tags
    workspaceId: workspaceId
    blobContainerName: '${projectShortName}-container'
    principalId: principalId
    subnetId: network.outputs.subnetId
  }
}

output resourceGroupName string = contentResourceGroup.name
output storageAccountName string = storageAccount.outputs.name
output storageAccountBlobUrl string = storageAccount.outputs.blobEndpoint
output storageAccountDfsUrl string = storageAccount.outputs.dfsEndpoint
