@export()
type collection = {
  @minLength(1)
  @maxLength(256)
  *: string //* may be used to make all values require a constraint. Additional properties may still be defined when using *.
}

@export()
type collectionEnterprise = {
  contact: contact
  costcenter: costcenter
  criticality: criticality
  productionstatus: productionStatus
  projectactivity: projectActivity
  projectcode: projectCode
  securitycontact: securityContact
}

@export()
type collectionServiceNow = {
  cmdbLink: cmdbLink
  cmdbId: cmdbId
}

@export()
type collectionDevOpsServices = {
  ado_team: adoTeam
  ado_project: adoProject
  ado_pipeline: adoPipeline
  application: application
}

@export()
@maxLength(256)
type cmdbLink = string

@export()
@minLength(32)
@maxLength(32)
type cmdbId = string

@export()
@description('Valid contact')
@maxLength(256)
type contact = string

@export()
@minLength(7)
@maxLength(7)
type costcenter = string

@export()
type criticality = 'L' | 'M' | 'H'

@export()
type env = 'dev' | 'tst' | 'acc' | 'prd'

@export()
type productionStatus = 'true' | 'false'

@export()
@minLength(7)
@maxLength(7)
type projectActivity = string

@export()
@minLength(7)
@maxLength(7)
type projectCode = string

@export()
@maxLength(256)
type securityContact = string

@export()
@maxLength(256)
type adoTeam = string?

@export()
@maxLength(256)
type adoProject = string?

@export()
@maxLength(256)
type adoPipeline = string?

@export()
@maxLength(256)
type application = string?
