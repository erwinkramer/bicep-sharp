import * as _authVar from 'private/variables/authorization.bicep'
import * as _authType from 'private/types/authorization.bicep'
import * as _authFunction from 'private/functions/authorization.bicep'
import * as _resourceType from 'private/types/resource.bicep'

/* ----------------------------------------

      🤠 Bicep# - Public variables 🤠

------------------------------------------- */

@description('''
All Azure built-in roles and custom roles. 

Please note, this list is generated during compile-time for Bicep# with a specific tenant.
- Built-in roles as specified at https://learn.microsoft.com/en-us/azure/role-based-access-control/built-in-roles.
''')
@export()
var roles = _authVar.roles

/* ----------------------------------------

      😎 Bicep# - Public types 😎

------------------------------------------- */

@export()
type roleAssignmentProperties = _authType.roleAssignmentProperties

@export()
type roleAssignmentName = _authType.roleAssignmentName

@description('''
Type of the role value
''')
@export()
type roleGuid = _authType.roleGuid

/* ---------------------------------------- 

      💪 Bicep# - Public functions 💪

------------------------------------------- */

@description('''
Build a role assignment for a service principal identity.
''')
@export()
func buildRoleAssignmentForServicePrincipal(roleId string, principalId string, targetResourceName string) _resourceType.resourceFormat => {
  name: guid(resourceGroup().id, targetResourceName, roleId, principalId)
  properties: _authFunction.buildRoleAssignmentProperties(roleId, principalId, 'ServicePrincipal')
}

@description('''
Build a role assignment for a group identity.
''')
@export()
func buildRoleAssignmentForGroup(roleId string, principalId string, targetResourceName string) _resourceType.resourceFormat => {
  name: guid(resourceGroup().id, targetResourceName, roleId, principalId)
  properties: _authFunction.buildRoleAssignmentProperties(roleId, principalId, 'Group')
}
