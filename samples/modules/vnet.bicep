import * as sharpResource from '../../lib/resource.bicep'
import * as sharpNetwork from '../../lib/network.bicep'

targetScope = 'resourceGroup'

param tags object

@description('The postfix of the vnet')
param vnetPostFix string

@description('The postfix of the name of the target subnet and nsg')
param subnetPostfix string

@description('CIDR, address space of the subnet')
param subnetAddressPrefix string

@description('CIDR, address space of the vnet')
param vnetAddressPrefix array

var sharpSubnets = [sharpNetwork.buildSubnet(subnetPostfix, subnetAddressPrefix, nsg.id, null)]
var sharpVnet = sharpNetwork.buildVnet(vnetPostFix, vnetAddressPrefix, false, null, sharpSubnets)

var sharpNsgRules = [
  sharpNetwork.buildNsgRuleIpToIp(
    sharpNetwork.nsgRuleDirections.inbound,
    sharpNetwork.nsgRuleAccesses.allow,
    '10.10.10.10',
    '10.10.10.11',
    sharpNetwork.nsgRuleDestinationServices.couchDb
  )
  sharpNetwork.buildNsgRuleServiceTagToServiceTag(
    sharpNetwork.nsgRuleDirections.inbound,
    sharpNetwork.nsgRuleAccesses.allow,
    sharpNetwork.nsgRuleServiceTagsInbound.virtualNetwork,
    sharpNetwork.nsgRuleServiceTagsInbound.azureDataFactory,
    sharpNetwork.nsgRuleDestinationServices.https
  )
  sharpNetwork.buildNsgRuleFirewallServiceTagToServiceTag(
    sharpNetwork.nsgRuleDirections.inbound,
    sharpNetwork.nsgRuleAccesses.deny,
    sharpNetwork.nsgRuleServiceTagsInbound.azureChaosStudio,
    sharpNetwork.nsgRuleServiceTagsInbound.azureAISearch,
    sharpNetwork.nsgRuleDestinationServices.rdp
  )
  sharpNetwork.buildNsgRuleFirewallServiceTagToServiceTag(
    sharpNetwork.nsgRuleDirections.outbound,
    sharpNetwork.nsgRuleAccesses.deny,
    sharpNetwork.nsgRuleServiceTagsOutbound.azureDatabricks,
    sharpNetwork.nsgRuleServiceTagsOutbound.azureAppService,
    sharpNetwork.nsgRuleDestinationServices.ssh
  )
  sharpNetwork.buildNsgRuleFirewallServiceTagToServiceTag(
    sharpNetwork.nsgRuleDirections.outbound,
    sharpNetwork.nsgRuleAccesses.deny,
    sharpNetwork.nsgRuleServiceTagsOutbound.azureAttestation,
    sharpNetwork.nsgRuleServiceTagsOutbound.azureFrontDoorBackend,
    sharpNetwork.nsgRuleDestinationServices.kestrel
  )
  sharpNetwork.buildNsgRuleFirewallServiceTagToServiceTag(
    sharpNetwork.nsgRuleDirections.outbound,
    sharpNetwork.nsgRuleAccesses.deny,
    sharpNetwork.nsgRuleServiceTagsOutbound.azureArcInfrastructure,
    sharpNetwork.nsgRuleServiceTagsOutbound.azureCosmosDB,
    sharpNetwork.nsgRuleDestinationServices.elasticSearch
  )
]

var sharpNsg = sharpNetwork.buildNsg(subnetPostfix, sharpNetwork.createNsgRuleCollectionWithPriority(sharpNsgRules))

resource nsg 'Microsoft.Network/networkSecurityGroups@2023-09-01' = {
  name: sharpNsg.name
  properties: sharpNsg.properties
  location: sharpResource.getPrimaryLocation()
  tags: tags
}

resource vnet 'Microsoft.Network/virtualNetworks@2023-09-01' = {
  name: sharpVnet.name
  properties: sharpVnet.properties
  location: sharpResource.getPrimaryLocation()
  tags: tags
}

output subnetId string = vnet.properties.subnets[0].id
