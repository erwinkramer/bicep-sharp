import * as _networkType from '../types/network.bicep'

@description('''
Build vnet properties
''')
@export()
func buildVnetProperties(addressPrefixes array, enableDdosProtection bool, virtualNetworkPeerings array?, subnets array) _networkType.vnetProperties => {
  addressSpace: {
    addressPrefixes: addressPrefixes
  }
  enableDdosProtection: enableDdosProtection
  virtualNetworkPeerings: virtualNetworkPeerings
  subnets: subnets
}

@description('''
Build subnet properties
''')
@export()
func buildSubnetProperties(subnetAddressPrefix string, networkSecurityGroupId string, serviceEndpoints array?) _networkType.subnet.properties => {
  addressPrefix: subnetAddressPrefix
  networkSecurityGroup: {
    id: networkSecurityGroupId
  }
  privateEndpointNetworkPolicies: 'NetworkSecurityGroupEnabled'
  privateLinkServiceNetworkPolicies: 'Enabled'
  serviceEndpoints: serviceEndpoints == null ? [] : serviceEndpoints
}

@description('''
Build private endpoint properties
''')
@export()
func buildPrivateEndpointProperties(resourceName string, resourceId string, groupId string, subnetId string) _networkType.peProperties => {
  privateLinkServiceConnections: [
    {
      name: 'pe-${resourceName}-${groupId}'
      properties: {
        privateLinkServiceId: resourceId
        groupIds: [
          groupId
        ]
      }
    }
  ]
  subnet: {
    id: subnetId
  }
}

@description('''
Build NSG properties
''')
@export()
func buildNsgProperties(securityRules _networkType.nsgProperties.securityRules) _networkType.nsgProperties => {
  securityRules: securityRules
}

@description('''
Build NSG rule name
''')
@export()
func buildNsgRuleName(
  access _networkType.nsgRuleAccess,
  source string,
  destination string,
  direction _networkType.nsgRuleDirection
) string => '${access}${source}to${destination}${direction}'

@description('''
Build NSG rule properties
''')
@export()
func buildNsgRuleProperties(
  direction _networkType.nsgRuleDirection,
  access _networkType.nsgRuleAccess,
  sourceAddressPrefix string,
  destinationAddressPrefix string,
  destinationService _networkType.nsgRuleDestinationService
) _networkType.nsgRulePropertiesOptionalPriority => {
  description: '${access} ${direction} traffic from ${sourceAddressPrefix} to ${destinationAddressPrefix} for port ${destinationService.portRange} on protocol ${destinationService.protocol}.'
  protocol: destinationService.protocol
  sourcePortRange: '*'
  destinationPortRange: destinationService.portRange
  sourceAddressPrefix: sourceAddressPrefix
  destinationAddressPrefix: destinationAddressPrefix
  access: access
  direction: direction
}
