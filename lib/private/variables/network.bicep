@export()
var groupIds = {
  azureAIservices: 'account'
  azureAISearch: 'searchService'
  azureAppConfiguration: 'configurationStores'
  azureAppServiceMicrosoftWebHostingEnvironments: 'hosting environment'
  azureAppServiceMicrosoftWebSites: 'sites'
  azureAppServiceMicrosoftWebSitesStagingSlot: 'sites-staging'
  azureAutomationWebhook: 'Webhook'
  azureAutomationuserAndSystemHybridWorkers: 'DSCAndHybridWorker'
  azureBackup: 'AzureBackup'
  azureBackupAzureSiteRecovery: 'AzureSiteRecovery'
  azureBatchaccount: 'batchAccount'
  azureBatchnodeMnagement: 'nodeManagement'
  azureCacheForRedis: 'redisCache'
  azureCacheForRedisEnterprise: 'redisEnterprise'
  azureContainerRegistry: 'registry'
  azureCosmosDBSQL: 'SQL'
  azureCosmosDBMongoDB: 'MongoDB'
  azureCosmosDBCassandra: 'Cassandra'
  azureCosmosDBGremlin: 'Gremlin'
  azureCosmosDBTable: 'Table'
  azureCosmosDBForPostgreSQL: 'coordinator'
  azureDataExplorer: 'cluster'
  azureDataFactory: 'dataFactory'
  azureDatabaseForMariaDB: 'mariadbServer'
  azureDatabaseForMySQLSingleServer: 'mysqlServer'
  azureDatabaseForMySQLFlexibleServer: 'mysqlServer'
  azureDatabaseForPostgreSQLSingleserver: 'postgresqlServer'
  azureDatabricksUIAPI: 'databricks_ui_api'
  azureDatabricksBrowserAuthentication: 'browser_authentication'
  azureDeviceProvisioningService: 'iotDps'
  azureDigitalTwins: 'API'
  azureEventGriddomain: 'domain'
  azureEventGridtopic: 'topic'
  azureEventHub: 'namespace'
  azureFileSync: 'File Sync Service'
  azureHDInsight: 'cluster'
  azureIoTCentral: 'IoTApps'
  azureIoTHub: 'iotHub'
  azureKeyVault: 'vault'
  azureKeyVaultHSMHardwareSecurityModule: 'HSM'
  azureKubernetesServiceKubernetesAPI: 'management'
  azureMachineLearningregistry: 'amlregistry'
  azureMachineLearningworkspace: 'amlworkspace'
  azureManagedDisks: 'managed disk'
  azureMediaServiceskeyDelivery: 'keydelivery'
  azureMediaServicesliveEvent: 'liveevent'
  azureMediaServicesstreamingEndpoint: 'streamingendpoint'
  azureMigrate: 'project'
  azureMonitorPrivateLinkScope: 'azuremonitor'
  azureRelay: 'namespace'
  azureServiceBus: 'namespace'
  azureSignalRService: 'signalr'
  azureSignalRServicewebPubSub: 'webpubsub'
  azureSQLDatabaseSQLServer: 'sqlServer'
  azureSQLManagedInstance: 'managedInstance'
  azureStaticWebApps: 'staticSites'
  azureStorageBlobService: 'blob'
  azureStorageBlobServiceSecondary: 'blob_secondary'
  azureStorageTableService: 'table'
  azureStorageTableServiceSecondary: 'table_secondary'
  azureStorageQueueService: 'queue'
  azureStorageQueueServiceSecondary: 'queue_secondary'
  azureStorageFileService: 'file'
  azureStorageFileServiceSecondary: 'file_secondary'
  azureStorageStaticWebsites: 'web'
  azureStorageStaticWebsitesSecondary: 'web_secondary'
  azureStorageDataLakeStorageGen2DFS: 'dfs'
  azureStorageDataLakeStorageGen2DFSSecondary: 'dfs_secondary'
  azureSynapse: 'web'
  azureSynapseAnalyticsSql: 'Sql'
  azureSynapseAnalyticsSqlOnDemand: 'SqlOnDemand'
  azureSynapseAnalyticsDev: 'Dev'
  azureVirtualDesktophostPools: 'connection'
  azureVirtualDesktopworkspacesFeedDownload: 'feed'
  azureVirtualDesktopworkspacesInitialFeedDiscovery: 'global'
  deviceUpdateForIoTHub: 'DeviceUpdate'
  microsoftPurview: 'account'
  microsoftPurviewPortal: 'portal'
  powerBI: 'Power BI'
  resourceManagementPrivateLinks: 'ResourceManagement'
}

@export()
var nsgRuleDirections = {
  inbound: 'Inbound'
  outbound: 'Outbound'
}

@export()
var nsgRuleAccesses = {
  allow: 'Allow'
  deny: 'Deny'
}

var nsgRuleServiceTagsInboundAndOutbound = {
  anyServicetag: '*'
  appServiceEnvironment: 'AppServiceManagement'
  autonomousDevelopmentPlatform: 'AutonomousDevelopmentPlatform'
  microsoftEntraDomainServices: 'AzureActiveDirectoryDomainServices'
  azureBotService: 'AzureBotService'
  azureCloud: 'AzureCloud'
  azureConnectors: 'AzureConnectors'
  azureDatabricks: 'AzureDatabricks'
  azureDeviceUpdateForIoTHub: 'AzureDeviceUpdate'
  azureEventGrid: 'AzureEventGrid'
  azureFrontDoorFrontend: 'AzureFrontDoor.Frontend'
  azureFrontDoorBackend: 'AzureFrontDoor.Backend'
  azureFrontDoorFirstParty: 'AzureFrontDoor.FirstParty'
  azureHealthcareAPIs: 'AzureHealthcareAPIs'
  azureMachineLearning: 'AzureMachineLearning'
  azureSphereSecurityServices: 'AzureSphere'
  azureWebPubSub: 'AzureWebPubSub'
  azureBatchnodeManagement: 'BatchNodeManagement'
  azureChaosStudio: 'ChaosStudio'
  azureAIServicesFrontendPortals: 'CognitiveServicesFrontend'
  azureAIServicesManagement: 'CognitiveServicesManagement'
  azureDataFactory: 'DataFactory'
  dynamics365MarketingEmailService: 'Dynamics365ForMarketingEmail'
  dynamics365BusinessEentralServices: 'Dynamics365BusinessCentral'
  securityAndComplianceCenterPowerShellEOPExternalPublishedIPs: 'EOPExternalPublishedIPs'
  logicApps: 'LogicApps'
  azureCommercialMarketplaceExperiencesServices: 'Marketplace'
  microsoftDefenderForEndpoint: 'MicrosoftDefenderForEndpoint'
  powerBIPlatform: 'PowerBI'
  powerPlatformServices: 'PowerPlatformInfra'
  powerQueryOnline: 'PowerQueryOnline'
  azureServiceFabric: 'ServiceFabric'
  azureSqldeploymentAndManagement: 'SqlManagement'
  storageSyncService: 'StorageSyncService'
  azureVirtualDesktop: 'WindowsVirtualDesktop'
  videoIndexer: 'VideoIndexer'
  azureContainerAppsService: 'AzureContainerAppsService'
  azureLoadBalancer: 'AzureLoadBalancer'
  internet: 'Internet'
  kustoAnalytics: 'KustoAnalytics'
  virtualNetwork: 'VirtualNetwork'
}

@export()
var nsgRuleServiceTagsRegional = loadJsonContent('./generated/serviceTagsRegional.json')

@export()
var nsgRuleServiceTagsInbound = union(
  nsgRuleServiceTagsInboundAndOutbound,
  {
    dataConnectorsForMicrosoftScurityProducts: 'Scuba'
    azureVPNGatewayAndApplicationGateway: 'GatewayManager'
    actionGroup: 'ActionGroup'
    apiManagement: 'ApiManagement'
    applicationInsightsAvailability: 'ApplicationInsightsAvailability'
    azureAISearch: 'AzureCognitiveSearch'
    azureDataExplorerManagement: 'AzureDataExplorerManagement'
    azureDevOps: 'AzureDevOps'
    azureDigitalTwins: 'AzureDigitalTwins'
    azureLoadTestingInstanceManagement: 'AzureLoadTestingInstanceManagement'
    azureMachineLearningInference: 'AzureMachineLearningInference'
    microsoftSentinel: 'AzureSentinel'
    azureTrafficManager: 'AzureTrafficManager'
    azureHDInsight: 'HDInsight'
    logicAppsManagement: 'LogicAppsManagement'
    office365ManagementActivityAPIWebhook: 'M365ManagementActivityApiWebhook'
    powerPlatformextensionExecution: 'PowerPlatformPlex'
    serialConsoleService: 'SerialConsole'
  }
)

@export()
var nsgRuleServiceTagsOutbound = union(
  nsgRuleServiceTagsInboundAndOutbound,
  {
    appConfiguration: 'AppConfiguration'
    azureAppService: 'AppService'
    microsoftEntraID: 'AzureActiveDirectory'
    azureAdvancedThreatProtection: 'AzureAdvancedThreatProtection'
    azureArcInfrastructure: 'AzureArcInfrastructure'
    azureAttestation: 'AzureAttestation'
    azureBackup: 'AzureBackup'
    azureContainerRegistry: 'AzureContainerRegistry'
    azureCosmosDB: 'AzureCosmosDB'
    azureDataLakeStorageGen1: 'AzureDataLake'
    azureDevSpaces: 'AzureDevSpaces'
    azureInformationProtection: 'AzureInformationProtection'
    azureIoTHub: 'AzureIoTHub'
    azureKeyVault: 'AzureKeyVault'
    azureManagedGrafana: 'AzureManagedGrafana'
    azureMonitor: 'AzureMonitor'
    azureOpenDatasets: 'AzureOpenDatasets'
    azureResourceManager: 'AzureResourceManager'
    azureSignalR: 'AzureSignalR'
    azureSiteRecovery: 'AzureSiteRecovery'
    azureSpringApps: 'AzureSpringCloud'
    azureStackBridgeServices: 'AzureStack'
    azureUpdateDelivery: 'AzureUpdateDelivery'
    azureDataFactoryManagement: 'DataFactoryManagement'
    azureEventHubs: 'EventHub'
    azureAutomationAndGuestConfiguration: 'GuestAndHybridManagement'
    office365ManagementActivityAPI: 'M365ManagementActivityApi'
    azureMicrosoftFluidRelayServer: 'MicrosoftAzureFluidRelay'
    microsoftDefenderForCloudApps: 'MicrosoftCloudAppSecurity'
    microsoftContainerRegistry: 'MicrosoftContainerRegistry'
    azureServiceBus: 'ServiceBus'
    azureSql: 'Sql'
    azureStorage: 'Storage'
    storageMover: 'StorageMover'
    windowsAdminCenter: 'WindowsAdminCenter'
    azurePlatformDNS: 'AzurePlatformDNS'
    azurePlatformAzureInstanceMetadataServiceIMDS: 'AzurePlatformIMDS'
    azurePlatformlicensingOrKeyManagementServiceLKM: 'AzurePlatformLKM'
    microsoftPurviewPolicyDistribution: 'MicrosoftPurviewPolicyDistribution'
  }
)

@export()
var nsgRuleDestinationServices = {
  anyService: { portRange: '*', protocol: '*' }
  http: { portRange: '80', protocol: 'TCP' }
  https: { portRange: '443', protocol: 'TCP' }
  ssh: { portRange: '22', protocol: 'TCP' }
  rdp: { portRange: '3389', protocol: 'TCP' }
  msSql: { portRange: '1433', protocol: 'TCP' }
  mySql: { portRange: '3306', protocol: 'TCP' }
  postgreSql: { portRange: '5432', protocol: 'TCP' }
  windowsAdminCenter: { portRange: '6516', protocol: 'TCP' }
  ftp: { portRange: '21', protocol: 'TCP' }
  smtp: { portRange: '25', protocol: 'TCP' }
  dnsTpc: { portRange: '53', protocol: 'TCP' }
  dnsUdp: { portRange: '53', protocol: 'UDP' }
  pop3: { portRange: '110', protocol: 'TCP' }
  imap: { portRange: '143', protocol: 'TCP' }
  ldap: { portRange: '389', protocol: 'TCP' }
  smtps: { portRange: '465', protocol: 'TCP' }
  imaps: { portRange: '993', protocol: 'TCP' }
  pop3s: { portRange: '995', protocol: 'TCP' }
  rabbitMq: { portRange: '5672', protocol: 'TCP' }
  couchDb: { portRange: '5984', protocol: 'TCP' }
  winRm: { portRange: '5986', protocol: 'TCP' }
  redis: { portRange: '6379', protocol: 'TCP' }
  couchDbHttps: { portRange: '6984', protocol: 'TCP' }
  cassandraJmx: { portRange: '7199', protocol: 'TCP' }
  neo4j: { portRange: '7474', protocol: 'TCP' }
  riak: { portRange: '8093', protocol: 'TCP' }
  riakJmx: { portRange: '8985', protocol: 'TCP' }
  cassandra: { portRange: '9042', protocol: 'TCP' }
  cassandraThrift: { portRange: '9160', protocol: 'TCP' }
  elasticSearch: { portRange: '9200-9300', protocol: 'TCP' }
  memcached: { portRange: '11211', protocol: 'TCP' }
  kestrel: { portRange: '22133', protocol: 'TCP' }
  mongoDb: { portRange: '27017', protocol: 'TCP' }
  dynamicPorts: { portRange: '49152-65535', protocol: 'TCP' }
}
