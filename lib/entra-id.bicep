import * as _entraIdVar from 'private/variables/entra-id.bicep'
import * as _entraIdType from 'private/types/entra-id.bicep'

/* ----------------------------------------

      🤠 Bicep# - Public variables 🤠

------------------------------------------- */

@description('''
Value of a principal to grant a role to. An individual value matches the `principal` type.
''')
@export()
var principals = _entraIdVar.entraIdPrincipals

@export()
var entraIdApps = _entraIdVar.entraIdApps

/* ----------------------------------------

      😎 Bicep# - Public types 😎

------------------------------------------- */

@description('''
Type of principal to grant a role to.
''')
@export()
type principal = _entraIdType.principal

/* ---------------------------------------- 

      💪 Bicep# - Public functions 💪

------------------------------------------- */
