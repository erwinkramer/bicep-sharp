import * as sharpTag from '../lib/tag.bicep'
import * as sharpEntraId from '../lib/entra-id.bicep'
import * as sharpDevOpsServices from '../lib/devops-services.bicep'

using 'main.bicep'

param tagsDevOpsServices = sharpTag.createDevOpsServicesCollection(
  'Bicep# Expert Team',
  readEnvironmentVariable(sharpDevOpsServices.variables.systemteamProject, 'unknown'),
  readEnvironmentVariable(sharpDevOpsServices.variables.buildDefinitionName, 'unknown'),
  readEnvironmentVariable(sharpDevOpsServices.variables.buildRepositoryName, 'unknown')
)

param tagsServiceNow = sharpTag.createServiceNowCollection(
  '54a4d0e39700e9142239b1ece053af29',
  'sharpServiceNowInstance'
)

param tagsEnterprise = sharpTag.createEnterpriseCollection(
  'j.plumber@contoso.nl',
  'basement.redteam@contoso.nl',
  '2599999',
  sharpTag.criticalities.low,
  sharpTag.productionStatuses.notInProduction,
  '0000007',
  '1234567'
)

param projectShortName = 'hello'
param functionalName = 'sharp'
param environment = sharpTag.envs.development
param revision = '001'

param principalId = sharpEntraId.entraIdApps.microsoftGraph
param subnetAddressPrefix = '10.240.32.64/29'
param vnetAddressPrefix = ['10.0.0.0/8']
