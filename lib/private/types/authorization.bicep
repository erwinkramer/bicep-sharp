@export()
type roleAssignmentProperties = resource<'Microsoft.Authorization/roleAssignments@2022-04-01'>.properties

@export()
type roleAssignmentName = resource<'Microsoft.Authorization/roleAssignments@2022-04-01'>.name

@minLength(36)
@maxLength(36)
@export()
type roleGuid = string
