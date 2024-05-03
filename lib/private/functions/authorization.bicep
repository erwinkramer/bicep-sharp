import * as _authType from '../types/authorization.bicep'
import * as _entraIdType from '../types/entra-id.bicep'

@description('''
Get the complete role resource id based of a role id
''')
@export()
func getRoleResourceId(roleId string) string =>
  subscriptionResourceId('Microsoft.Authorization/roleDefinitions', roleId)

@description('''
Build role assignment properties
''')
@export()
func buildRoleAssignmentProperties(roleId string, principalId string, principalType _entraIdType.principal) _authType.roleAssignmentProperties => {
  roleDefinitionId: getRoleResourceId(roleId)
  principalId: principalId
  principalType: principalType
}
