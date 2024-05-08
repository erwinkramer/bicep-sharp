import * as _networkType from 'private/types/network.bicep'
import * as _networkVar from 'private/variables/network.bicep'
import * as _networkFunction from 'private/functions/network.bicep'
import * as _resourceType from 'private/types/resource.bicep'
import * as _resourceFunction from 'private/functions/resource.bicep'
import * as _locationType from 'private/types/location.bicep'

/* ----------------------------------------

      🤠 Bicep# - Public variables 🤠

------------------------------------------- */

@description('''
Private endpoint group Ids, also known as sub-resources. 
Please look at https://learn.microsoft.com/en-us/azure/private-link/private-endpoint-overview#private-link-resource for a detailed reference.
''')
@export()
var groupIds = _networkVar.groupIds

@description('''
NSG Rule direction
''')
@export()
var nsgRuleDirections = _networkVar.nsgRuleDirections

@description('''
NSG Rule access
''')
@export()
var nsgRuleAccesses = _networkVar.nsgRuleAccesses

@description('''
NSG Rule Service tags for inbound.
Please look at https://learn.microsoft.com/en-us/azure/virtual-network/service-tags-overview  for a detailed reference.
''')
@export()
var nsgRuleServiceTagsInbound = _networkVar.nsgRuleServiceTagsInbound

@description('''
NSG Rule Service tags for outbound.
Please look at https://learn.microsoft.com/en-us/azure/virtual-network/service-tags-overview for a detailed reference.
''')
@export()
var nsgRuleServiceTagsOutbound = _networkVar.nsgRuleServiceTagsOutbound

@description('''
NSG Rule Service tags that are regional.

Please note, this list is generated during compile-time for Bicep# with a specific location.
Please look at https://learn.microsoft.com/en-us/azure/virtual-network/service-tags-overview for a detailed reference.
''')
@export()
var nsgRuleServiceTagsRegional = _networkVar.nsgRuleServiceTagsRegional

@description('''
NSG Rule Destionation Service. The service specifies the destination protocol and port range for this rule. 
You can choose a predefined service, like RDP or SSH, or provide a custom port range.
''')
@export()
var nsgRuleDestinationServices = _networkVar.nsgRuleDestinationServices

@description('''
Private Endpoint connection names from own and other tenants with either manual or auto-approval. Name pattern is:
- `[private endpoint name]` for a private endpoint resource in own tenant.
- `[resourceName]_[private endpoint name]` for other (managed) private endpoint connections.
''')
@export()
var privateEndpointConnectionNames = _networkVar.privateEndpointConnectionNames

/* ----------------------------------------

      😎 Bicep# - Public types 😎

------------------------------------------- */

@export()
type nsgName = _networkType.nsgName

@export()
type nsgProperties = _networkType.nsgProperties

@export()
type nsgRulePropertiesOptionalPriority = _networkType.nsgRulePropertiesOptionalPriority

@export()
type buildNsgRuleServiceTagFirewallnsgRuleProperties = _networkType.buildNsgRuleServiceTagFirewallnsgRuleProperties

@export()
type peName = _networkType.peName

@export()
type peProperties = _networkType.peProperties

type subnet = _networkType.subnet

@export()
type vnetProperties = _networkType.vnetProperties

@description('''
NSG Rule Service tags that support regional scope.
''')
@export()
type serviceTagRegional = _networkType.serviceTagRegional

@description('''
NSG Rule Service tags that support firewall use.
''')
@export()
type serviceTagFirewallUse = _networkType.serviceTagFirewallUse

@description('''
NSG Rule Service tags that not support firewall use.
''')
@export()
type serviceTagFirewallAndNonFirewallUse = _networkType.serviceTagFirewallAndNonFirewallUse

@description('''
NSG Rule direction.
''')
@export()
type nsgRuleDirection = _networkType.nsgRuleDirection

@description('''
NSG Rule access.
''')
@export()
type nsgRuleAccess = _networkType.nsgRuleAccess

@export()
type nsgRuleDestinationService = _networkType.nsgRuleDestinationService

/* ---------------------------------------- 

      💪 Bicep# - Public functions 💪

------------------------------------------- */

@description('''
Build a vnet.
''')
@export()
func buildVnet(
  vnetPostfix string,
  addressPrefixes array,
  enableDdosProtection bool,
  virtualNetworkPeerings array?,
  subnets array
) _resourceType.resourceFormat => {
  name: 'vnet-${vnetPostfix}'
  properties: _networkFunction.buildVnetProperties(
    addressPrefixes,
    enableDdosProtection,
    virtualNetworkPeerings,
    subnets
  )
}

@description('''
Build a subnet.
''')
@export()
func buildSubnet(
  subnetPostfix string,
  subnetAddressPrefix string,
  networkSecurityGroupId string,
  serviceEndpoints array?
) _resourceType.resourceFormat => {
  name: 'snet-${subnetPostfix}'
  properties: _networkFunction.buildSubnetProperties(subnetAddressPrefix, networkSecurityGroupId, serviceEndpoints)
}

@description('''
Build a private endpoint.
''')
@export()
func buildPrivateEndpoint(targetResourceName string, targetResourceId string, groupId string, subnetId string) _resourceType.resourceFormat => {
  name: 'pe-${targetResourceName}-${groupId}'
  properties: _networkFunction.buildPrivateEndpointProperties(targetResourceName, targetResourceId, groupId, subnetId)
}

@description('''
Build a private endpoint connection approval.
''')
@export()
func buildBuildPrivateEndpointConnectionApproval(connectionName string, additionalInfo string) _resourceType.resourceFormat => {
  name: connectionName
  properties: _networkFunction.buildBuildPrivateEndpointConnectionApprovalProperties(connectionName, additionalInfo)
}

@description('''
Build an NSG.
''')
@export()
func buildNsg(subnetPostfix string, securityRules nsgProperties.securityRules) _resourceType.resourceFormat => {
  name: 'nsg-${subnetPostfix}'
  properties: _networkFunction.buildNsgProperties(securityRules)
}

@description('''
Build an NSG rule from IP to IP.
''')
@export()
func buildNsgRuleIpToIp(
  direction nsgRuleDirection,
  access nsgRuleAccess,
  sourceAddressPrefix string,
  destinationAddressPrefix string,
  destinationService nsgRuleDestinationService
) _resourceType.resourceFormat => {
  name: _networkFunction.buildNsgRuleName(access, sourceAddressPrefix, destinationAddressPrefix, direction)
  properties: _networkFunction.buildNsgRuleProperties(
    direction,
    access,
    sourceAddressPrefix,
    destinationAddressPrefix,
    destinationService
  )
}

@description('''
Build an NSG rule with service tags that are supported on Azure Firewall.
''')
@export()
func buildNsgRuleFirewallServiceTagToServiceTag(
  direction nsgRuleDirection,
  access nsgRuleAccess,
  sourceServiceTag serviceTagFirewallUse,
  destinationServiceTag serviceTagFirewallUse,
  destinationService nsgRuleDestinationService
) _resourceType.resourceFormat => {
  name: _networkFunction.buildNsgRuleName(access, sourceServiceTag, destinationServiceTag, direction)
  properties: _networkFunction.buildNsgRuleProperties(
    direction,
    access,
    sourceServiceTag,
    destinationServiceTag,
    destinationService
  )
}

@description('''
Build an NSG rule with service tags.
''')
@export()
func buildNsgRuleServiceTagToServiceTag(
  direction nsgRuleDirection,
  access nsgRuleAccess,
  sourceServiceTag serviceTagFirewallAndNonFirewallUse,
  destinationServiceTag serviceTagFirewallAndNonFirewallUse,
  destinationService nsgRuleDestinationService
) _resourceType.resourceFormat => {
  name: _networkFunction.buildNsgRuleName(access, sourceServiceTag, destinationServiceTag, direction)
  properties: _networkFunction.buildNsgRuleProperties(
    direction,
    access,
    sourceServiceTag,
    destinationServiceTag,
    destinationService
  )
}

@description('''
Create an NSG rule collection and add the 'priority' element based on the order of the nsgRuleResourceCollectionUnPrioritized. Starts at 100.
''')
@export()
func createNsgRuleCollectionWithPriority(
  nsgRuleResourceCollectionUnPrioritized _networkType.nsgProperties.securityRules
) _networkType.nsgProperties.securityRules =>
  _resourceFunction.makeIteratedResourceCollection(nsgRuleResourceCollectionUnPrioritized, 'priority', 100)
