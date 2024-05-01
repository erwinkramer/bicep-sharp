@export()
type nsgName = resource<'Microsoft.Network/networkSecurityGroups@2023-09-01'>.name

@export()
type nsgProperties = resource<'Microsoft.Network/networkSecurityGroups@2023-09-01'>.properties

@export()
type nsgRuleProperties = nsgProperties.securityRules[*].properties

@export()
type buildNsgRuleServiceTagFirewallnsgRuleProperties = nsgProperties.securityRules[*].properties

@export()
type peName = resource<'Microsoft.Network/privateEndpoints@2023-09-01'>.name

@export()
type peProperties = resource<'Microsoft.Network/privateEndpoints@2023-09-01'>.properties

@export()
type subnet = resource<'Microsoft.Network/virtualNetworks@2023-09-01'>.properties.subnets[*]

@export()
type vnetProperties = resource<'Microsoft.Network/virtualNetworks@2023-09-01'>.properties

@export()
type serviceTagRegional =
  | 'AzureWebPubSub'
  | 'ApiManagement'
  | 'AppService'
  | 'AutonomousDevelopmentPlatform'
  | 'AzureCloud'
  | 'AzureConnectors'
  | 'AzureContainerAppsService'
  | 'AzureContainerRegistry'
  | 'AzureCosmosDB'
  | 'AzureDevOps'
  | 'AzureFrontDoor.Frontend'
  | 'AzureFrontDoor.Backend'
  | 'AzureFrontDoor.FirstParty'
  | 'AzureIoTHub'
  | 'AzureKeyVault'
  | 'AzureWebPubSub'
  | 'BatchNodeManagement'
  | 'DataFactory'
  | 'Dynamics365ForMarketingEmail'
  | 'EventHub'
  | 'HDInsight'
  | 'M365ManagementActivityApi'
  | 'M365ManagementActivityApiWebhook'
  | 'MicrosoftContainerRegistry'
  | 'PowerPlatformInfra'
  | 'PowerPlatformPlex'
  | 'ServiceBus'
  | 'Sql'
  | 'Storage'
  | 'StorageMover'

@export()
type serviceTagFirewallUse =
  | '*'
  | 'WindowsAdminCenter'
  | 'StorageMover'
  | 'Storage'
  | 'Sql'
  | 'ServiceBus'
  | 'MicrosoftContainerRegistry'
  | 'MicrosoftCloudAppSecurity'
  | 'MicrosoftAzureFluidRelay'
  | 'GuestAndHybridManagement'
  | 'EventHub'
  | 'DataFactoryManagement'
  | 'AzureUpdateDelivery'
  | 'AzureStack'
  | 'AzureSpringCloud'
  | 'AzureSiteRecovery'
  | 'AzureSignalR'
  | 'AzureResourceManager'
  | 'AzureMonitor'
  | 'AzureOpenDatasets'
  | 'AzureManagedGrafana'
  | 'AzureKeyVault'
  | 'AzureIoTHub'
  | 'AzureInformationProtection'
  | 'AzureDevSpaces'
  | 'AzureCosmosDB'
  | 'AzureContainerRegistry'
  | 'AzureBackup'
  | 'AzureAttestation'
  | 'AzureArcInfrastructure'
  | 'AzureAdvancedThreatProtection'
  | 'AppConfiguration'
  | 'AppService'
  | 'AppServiceManagement'
  | 'AutonomousDevelopmentPlatform'
  | 'AzureActiveDirectory'
  | 'AzureActiveDirectoryDomainServices'
  | 'AzureBotService'
  | 'AzureCloud'
  | 'AzureConnectors'
  | 'AzureDatabricks'
  | 'AzureDeviceUpdate'
  | 'AzureEventGrid'
  | 'AzureFrontDoor.Frontend'
  | 'AzureFrontDoor.Backend'
  | 'AzureFrontDoor.FirstParty'
  | 'AzureHealthcareAPIs'
  | 'AzureMachineLearning'
  | 'AzureSphere'
  | 'AzureWebPubSub'
  | 'BatchNodeManagement'
  | 'ChaosStudio'
  | 'CognitiveServicesFrontend'
  | 'CognitiveServicesManagement'
  | 'DataFactory'
  | 'Dynamics365ForMarketingEmail'
  | 'Dynamics365BusinessCentral'
  | 'EOPExternalPublishedIPs'
  | 'LogicApps'
  | 'Marketplace'
  | 'MicrosoftDefenderForEndpoint'
  | 'PowerBI'
  | 'PowerPlatformInfra'
  | 'PowerQueryOnline'
  | 'ServiceFabric'
  | 'SqlManagement'
  | 'StorageSyncService'
  | 'WindowsVirtualDesktop'
  | 'VideoIndexer'
  | 'ActionGroup'
  | 'ApiManagement'
  | 'ApplicationInsightsAvailability'
  | 'AzureCognitiveSearch'
  | 'AzureDataExplorerManagement'
  | 'AzureDevOps'
  | 'AzureDigitalTwins'
  | 'AzureLoadTestingInstanceManagement'
  | 'AzureMachineLearningInference'
  | 'AzureSentinel'
  | 'AzureTrafficManager'
  | 'HDInsight'
  | 'LogicAppsManagement'
  | 'M365ManagementActivityApiWebhook'
  | 'PowerPlatformPlex'
  | 'SerialConsole'

@export()
type serviceTagFirewallAndNonFirewallUse =
  | serviceTagFirewallUse
  | 'Scuba'
  | 'GatewayManager'
  | 'AzureContainerAppsService'
  | 'AzureLoadBalancer'
  | 'Internet'
  | 'KustoAnalytics'
  | 'VirtualNetwork'
  | 'AzurePlatformDNS'
  | 'AzurePlatformIMDS'
  | 'AzurePlatformLKM'
  | 'MicrosoftPurviewPolicyDistribution'

@export()
type nsgRuleDirection = 'Inbound' | 'Outbound'

@export()
type nsgRuleAccess = 'Allow' | 'Deny'

@export()
type nsgRuleDestinationService = {
  portRange: string
  protocol: string
}
