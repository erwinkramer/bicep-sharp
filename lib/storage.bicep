import * as _storageType from 'private/types/storage.bicep'
import * as _insightsType from 'private/types/insight.bicep'
import * as _resourceType from 'private/types/resource.bicep'
import * as _storageFunction from 'private/functions/storage.bicep'
import * as _insightsFunction from 'private/functions/insight.bicep'

/* ----------------------------------------

      🤠 Bicep# - Public variables 🤠

------------------------------------------- */

/* ----------------------------------------

      😎 Bicep# - Public types 😎

------------------------------------------- */

@export()
type storageProperties = _storageType.storageProperties

@export()
type storageBlobServicesProperties = _storageType.storageBlobServicesProperties

@export()
type storageFileServicesProperties = _storageType.storageFileServicesProperties

@export()
type storageContainerProperties = _storageType.storageContainerProperties

@export()
type storageContainerName = _storageType.storageContainerName

/* ---------------------------------------- 

      💪 Bicep# - Public functions 💪

------------------------------------------- */

@description('''
Build a storage account.
''')
@export()
func buildStorage(storagePostfix string, enableBlobService bool, enableFileService bool) _resourceType.resourceFormat => {
  name: replace('st${storagePostfix}', '-', '')
  properties: _storageFunction.buildStorageProperties(enableBlobService, enableFileService)
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
}

@description('''
Build storage blob services.
''')
@export()
func buildStorageBlobService(containerDeleteRetentionDays int, blobDeleteRetentionDays int, corsRules array?) _resourceType.resourceFormatWithDefaultName => {
  name: 'default'
  properties: _storageFunction.buildStorageBlobPolicyProperties(
    containerDeleteRetentionDays,
    blobDeleteRetentionDays,
    corsRules
  )
}

@description('''
Build storage file services.
''')
@export()
func buildStorageFilePolicy(shareDeleteRetentionDays int, corsRules array?) storageFileServicesProperties => {
  cors: {
    corsRules: corsRules == null ? [] : corsRules
  }
  shareDeleteRetentionPolicy: {
    enabled: true
    days: shareDeleteRetentionDays
  }
}

@description('''
Build a storage container.
''')
@export()
func buildStorageContainer(containerName string) _resourceType.resourceFormat => {
  name: containerName
  properties: _storageFunction.buildStorageContainerProperties()
}

@description('''
Build storage diagnostics metrics.
''')
@export()
func buildStorageDiagnosticsMetrics(workspaceId string) _resourceType.resourceFormat => {
  name: 'diagMetricTransaction'
  properties: _insightsFunction.buildStorageDiagnosticsMetricsProperties(workspaceId)
}

@description('''
Build storage blob service diagnostics logs.
''')
@export()
func buildStorageBlobDiagnosticsLogs(
  workspaceId string,
  storageWriteCategoryEnabled bool,
  storageDeleteCategoryEnabled bool
) _resourceType.resourceFormat => {
  name: 'diagLogBlob'
  properties: _insightsFunction.buildStorageBlobDiagnosticsLogsProperties(
    workspaceId,
    storageWriteCategoryEnabled,
    storageDeleteCategoryEnabled
  )
}
