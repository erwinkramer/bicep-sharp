import * as _insightsType from '../types/insight.bicep'

@description('''
Build the storage diagnostics metrics properties
''')
@export()
func buildStorageDiagnosticsMetricsProperties(workspaceId string) _insightsType.insightsDiagnosticsSettingsProperties => {
  workspaceId: workspaceId
  metrics: [
    {
      category: 'Transaction'
      enabled: true
    }
  ]
}

@description('''
Build the storage blob service diagnostics logs properties
''')
@export()
func buildStorageBlobDiagnosticsLogsProperties(
  workspaceId string,
  storageWriteCategoryEnabled bool,
  storageDeleteCategoryEnabled bool
) _insightsType.insightsDiagnosticsSettingsProperties => {
  workspaceId: workspaceId
  logs: [
    {
      category: 'StorageRead'
      enabled: true
    }
    {
      category: 'StorageWrite'
      enabled: storageWriteCategoryEnabled
    }
    {
      category: 'StorageDelete'
      enabled: storageDeleteCategoryEnabled
    }
  ]
}
