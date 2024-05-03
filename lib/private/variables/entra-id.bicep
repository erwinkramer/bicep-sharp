var builtInEnterpriseApps = loadJsonContent('./generated/entraIdAppsBuiltIn.json')

var customEnterpriseApps = loadJsonContent('./generated/entraIdAppsCustom.json')

@export()
var entraIdApps = union(builtInEnterpriseApps, customEnterpriseApps)

@export()
var entraIdPrincipals = {
  servicePrincipal: 'ServicePrincipal'
  group: 'Group'
}
