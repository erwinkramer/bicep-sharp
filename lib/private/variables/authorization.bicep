var builtInRoles = loadJsonContent('./generated/rolesBuiltIn.json')

var customRoles = loadJsonContent('./generated/rolesCustom.json')

@export()
var roles = union(builtInRoles, customRoles)
