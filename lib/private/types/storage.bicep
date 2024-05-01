@export()
type storageProperties = resource<'Microsoft.Storage/storageAccounts@2023-01-01'>.properties

@export()
type storageBlobServicesProperties = resource<'Microsoft.Storage/storageAccounts/blobServices@2023-01-01'>.properties

@export()
type storageFileServicesProperties = resource<'Microsoft.Storage/storageAccounts/fileServices@2023-01-01'>.properties

@export()
type storageContainerProperties = resource<'Microsoft.Storage/storageAccounts/blobServices/containers@2023-01-01'>.properties

@export()
type storageContainerName = resource<'Microsoft.Storage/storageAccounts/blobServices/containers@2023-01-01'>.name
