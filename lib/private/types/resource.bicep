@export()
type resourceGroupName = resource<'Microsoft.Resources/resourceGroups@2023-07-01'>.name

type default = 'default'

@export()
type resourceFormat = {
  name: string
  properties: object
  kind: string?
  sku: object?
}

@export()
type resourceFormatWithDefaultName = {
  name: 'default'
  properties: object
}
