import * as _tagType from 'private/types/tag.bicep'
import * as _tagVar from 'private/variables/tag.bicep'
import * as _tagFunction from 'private/functions/tag.bicep'

/* ----------------------------------------

      🤠 Bicep# - Public variables 🤠

------------------------------------------- */

@description('''
Criticality. An individual value matches the `criticality` type.
''')
@export()
var criticalities = _tagVar.criticalities

@description('''
Environment. An individual value matches the `env` type.
''')
@export()
var envs = _tagVar.envs

@export()
@description('''
Production status, in production or not'. An individual value matches the `productionstatus` type.
''')
var productionStatuses = _tagVar.productionStatuses

/* ----------------------------------------

      😎 Bicep# - Public types 😎

------------------------------------------- */

@description('''
Tag collection.
''')
@export()
type collection = _tagType.collection

@description('''
Tag collection for common enterprise values. Use `createEnterpriseCollection()` in order to initialize an object.
''')
@export()
type collectionEnterprise = _tagType.collectionEnterprise

@description('''
Tag collection for common DevOps Services values. Use `createDevOpsServicesCollection()` in order to initialize an object.
''')
@export()
type collectionDevOpsServices = _tagType.collectionDevOpsServices

@description('''
Tag collection for common ServiceNow values. Use `createServiceNowCollection()` in order to initialize an object.
''')
@export()
type collectionServiceNow = _tagType.collectionServiceNow

@export()
@description('''
Hyperlink to a valid ServiceNow CI.
''')
type cmdbLink = _tagType.cmdbLink

@export()
@description('''
Link of a valid ServiceNow CI id.
''')
type cmdbId = _tagType.cmdbId

@export()
@description('Valid contact.')
type contact = _tagType.contact

@export()
@description('Valid costcenter, all digits.')
type costcenter = _tagType.costcenter

@export()
@description('Criticality. Low, Medium or High.')
type criticality = _tagType.criticality

@export()
@description('Environment')
type env = _tagType.env

@export()
@description('Production status, in production or not.')
type productionStatus = _tagType.productionStatus

@export()
@description('Valid project activity code, all digits.')
type projectActivity = _tagType.projectActivity

@export()
@description('Valid project code, all digits.')
type projectCode = _tagType.projectCode

@export()
@description('Valid security contact.')
type securityContact = _tagType.securityContact

@export()
@description('Azure DevOps team name.')
type adoTeam = _tagType.adoTeam

@export()
@description('''
Azure DevOps project name. Please use `readEnvironmentVariable(_devOpsServices.variables.systemteamProject, 'unknown')` in a bicepparam file to fill this value.
''')
type adoProject = _tagType.adoProject

@export()
@description('''
Azure DevOps pipeline. Please use `readEnvironmentVariable(_devOpsServices.variables.buildDefinitionName, 'unknown')` in a bicepparam file to fill this value.
''')
type adoPipeline = _tagType.adoPipeline

@export()
@description('''
Azure DevOps repository name or ServiceNow CMDB business application name. 
In case of the Azure DevOps repository name, please use `readEnvironmentVariable(_devOpsServices.variables.buildRepositoryName, 'unknown')` in a bicepparam file to fill this value. 
''')
type application = _tagType.application

/* ---------------------------------------- 

      💪 Bicep# - Public functions 💪

------------------------------------------- */

@description('''
Creates a tag collection with common properties for enterprises.
''')
@export()
func createEnterpriseCollection(
  contact contact,
  securityContact securityContact,
  costcenter costcenter,
  criticality criticality,
  productionStatus productionStatus,
  projectActivity projectActivity,
  projectCode projectCode
) collectionEnterprise => {
  contact: contact
  securitycontact: securityContact
  costcenter: costcenter
  criticality: criticality
  productionstatus: productionStatus
  projectactivity: projectActivity
  projectcode: projectCode
}

@description('''
Creates a tag collection with common properties for DevOps Services.
''')
@export()
func createDevOpsServicesCollection(
  adoTeam adoTeam,
  adoProject adoProject,
  adoPipeline adoPipeline,
  application application
) collectionDevOpsServices => {
  ado_team: adoTeam
  ado_project: adoProject
  ado_pipeline: adoPipeline
  application: application
}

@description('''
Creates a tag collection with common properties for ServiceNow.
Note: For the cmdblink tag, it will use the cmdbId function parameter and convert it to the correct cmdblink.
''')
@export()
func createServiceNowCollection(cmdbId cmdbId, serviceNowInstanceName string) collectionServiceNow => {
  cmdbLink: _tagFunction.buildCmdblink(cmdbId, serviceNowInstanceName)
  cmdbId: cmdbId
}
