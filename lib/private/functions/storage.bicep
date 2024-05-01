import * as _storageType from '../types/storage.bicep'

@description('''
Build storage properties
''')
@export()
func buildStorageProperties(enableBlobService bool, enableFileService bool) _storageType.storageProperties => {
  accessTier: 'Hot'
  allowBlobPublicAccess: false
  allowedCopyScope: 'PrivateLink'
  allowCrossTenantReplication: false
  allowSharedKeyAccess: false
  azureFilesIdentityBasedAuthentication: {
    directoryServiceOptions: 'None'
  }
  defaultToOAuthAuthentication: true
  encryption: {
    requireInfrastructureEncryption: true
    services: {
      blob: {
        enabled: enableBlobService
        keyType: 'Account'
      }
      file: {
        enabled: enableFileService
        keyType: 'Account'
      }
    }
    keySource: 'Microsoft.Storage'
  }
  isNfsV3Enabled: false
  isSftpEnabled: false
  isHnsEnabled: true
  largeFileSharesState: 'Disabled'
  minimumTlsVersion: loadTextContent('../variables/generated/tls.txt')
  networkAcls: {
    bypass: 'AzureServices'
    defaultAction: 'Deny'
    ipRules: []
    resourceAccessRules: []
    virtualNetworkRules: []
  }
  publicNetworkAccess: loadTextContent('../variables/generated/publicNetworkAccess.txt')
  supportsHttpsTrafficOnly: true
}

@description('''
Build storage blob services properties
''')
@export()
func buildStorageBlobPolicyProperties(containerDeleteRetentionDays int, blobDeleteRetentionDays int, corsRules array?) _storageType.storageBlobServicesProperties => {
  containerDeleteRetentionPolicy: {
    enabled: true
    days: containerDeleteRetentionDays
  }
  cors: {
    corsRules: corsRules == null ? [] : corsRules
  }
  deleteRetentionPolicy: {
    allowPermanentDelete: true
    enabled: true
    days: blobDeleteRetentionDays
  }
}

@description('''
Build storage file services properties
''')
@export()
func buildStorageFilePolicyProperties(shareDeleteRetentionDays int, corsRules array?) _storageType.storageFileServicesProperties => {
  cors: {
    corsRules: corsRules == null ? [] : corsRules
  }
  shareDeleteRetentionPolicy: {
    enabled: true
    days: shareDeleteRetentionDays
  }
}

@description('''
Build storage container properties
''')
@export()
func buildStorageContainerProperties() _storageType.storageContainerProperties => {
  publicAccess: 'None'
}
