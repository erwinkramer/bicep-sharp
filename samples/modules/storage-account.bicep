import * as sharpResouce from '../../lib/resource.bicep'
import * as sharpNetwork from '../../lib/network.bicep'
import * as sharpAuth from '../../lib/authorization.bicep'
import * as sharpStorage from '../../lib/storage.bicep'

targetScope = 'resourceGroup'

@minLength(3)
@maxLength(24)
@description('Postfix of the storage account')
param storagePostfix string

param tags object

@description('Id of the LogAnalytics workspace')
param workspaceId string = ''

@description('Roles needed on a storage account')
param roleIds sharpAuth.roleGuid[] = [
  sharpAuth.roles.storageBlobDataContributor
]

@minLength(36)
@maxLength(36)
@description('Entra ID principal to give the roles on the storage account to')
param principalId string

@description('Example blob container')
param blobContainerName string

@description('Private endpoint types needed on a storage account')
param groupIds array = [
  sharpNetwork.groupIds.azureStorageDataLakeStorageGen2DFS
  sharpNetwork.groupIds.azureStorageBlobService
  sharpNetwork.groupIds.azureStorageQueueService
]

@description('Id of the subnet to attach the private endpoints to')
param subnetId string

var sharpPrivateEndpoints = [
  for groupId in groupIds: sharpNetwork.buildPrivateEndpoint(sa.name, sa.id, groupId, subnetId)
]
var sharpRoleAssignments = [
  for roleId in roleIds: sharpAuth.buildRoleAssignmentForServicePrincipal(roleId, principalId, sa.name)
]

var sharpStorageAccount = sharpStorage.buildStorage(storagePostfix, true, true)
var sharpStorageAccountBlobService = sharpStorage.buildStorageBlobService(15, 15, null)
var sharpStorageAccountContainer = sharpStorage.buildStorageContainer(blobContainerName)
var sharpStorageDiagnosticsMetrics = sharpStorage.buildStorageDiagnosticsMetrics(workspaceId)
var sharpStorageBlobDiagnosticsLogs = sharpStorage.buildStorageBlobDiagnosticsLogs(workspaceId, false, false)

resource sa 'Microsoft.Storage/storageAccounts@2023-01-01' = {
  name: sharpStorageAccount.name
  properties: sharpStorageAccount.properties
  sku: sharpStorageAccount.sku
  kind: sharpStorageAccount.kind
  location: sharpResouce.getPrimaryLocation()
  tags: tags

  resource blobServices 'blobServices' = {
    name: sharpStorageAccountBlobService.name
    properties: sharpStorageAccountBlobService.properties

    resource storageBlobContent 'containers' = {
      name: sharpStorageAccountContainer.name
      properties: sharpStorageAccountContainer.properties
    }
  }

  resource fileServices 'fileServices' = {
    name: 'default'
    properties: sharpStorage.buildStorageFilePolicy(5, null)
  }
}

resource diagMetricSa 'Microsoft.Insights/diagnosticSettings@2021-05-01-preview' =
  if (!empty(workspaceId)) {
    name: sharpStorageDiagnosticsMetrics.name
    properties: sharpStorageDiagnosticsMetrics.properties
    scope: sa
  }

resource diagLogBlob 'Microsoft.Insights/diagnosticSettings@2021-05-01-preview' =
  if (!empty(workspaceId)) {
    name: sharpStorageBlobDiagnosticsLogs.name
    properties: sharpStorageBlobDiagnosticsLogs.properties
    scope: sa::blobServices
  }

resource roleAssignmentsForGroup 'Microsoft.Authorization/roleAssignments@2022-04-01' = [
  for sharpRoleAssignment in sharpRoleAssignments: {
    name: sharpRoleAssignment.name
    properties: sharpRoleAssignment.properties
    scope: sa
  }
]

resource privateEndpoints 'Microsoft.Network/privateEndpoints@2023-09-01' = [
  for sharpPrivateEndpoint in sharpPrivateEndpoints: {
    name: sharpPrivateEndpoint.name
    properties: sharpPrivateEndpoint.properties
    location: sharpResouce.getPrimaryLocation()
    tags: tags
  }
]

output id string = sa.id
output name string = sa.name
output blobEndpoint string = sa.properties.primaryEndpoints.blob
output dfsEndpoint string = sa.properties.primaryEndpoints.dfs
