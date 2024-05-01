var buildVariables = {
  buildDefinitionName: 'BUILD_DEFINITIONNAME'
  buildRepositoryName: 'BUILD_REPOSITORY_NAME'
}

var systemVariables = {
  systemteamProject: 'SYSTEM_TEAMPROJECT'
}

@export()
var variables = union(buildVariables, systemVariables)
