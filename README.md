# Bicep# #

[![CC BY-NC-SA 4.0][cc-by-nc-sa-shield]][cc-by-nc-sa]
![GitHub commit activity](https://img.shields.io/github/commit-activity/m/erwinkramer/bicep-sharp)

Bicep# (pronounced Bicep sharp) is a functional framework to be used with Azure Bicep. It aims to simplify Bicep even further by providing variables, types and functions for better modularity.

## Demo ##

See Bicep# [/lib/network](/lib/network.bicep) in action!

![Demo](/demo.gif)

## Status ##

This project is currently in preview and only has the most basic functionality.

## Compile ##

Bicep# tailors to your policies, environment resources and to the latest changes on Azure:

- Roles are compiled for your tenant, to get the tenant-specific custom roles and the latest Built-In roles.
- Enterprise Apps are compiled for your tenant, to get the tenant-specific custom Enterprise Apps and the latest Microsoft Apps.
- Service tags are compiled for your region, to get the relevant and latest regional service tags.
- Global settings are compiled for your policies, for instance if resources are allowed to be publicly accessible.

Compiled files are outputted to [/lib/private/variables/generated/](/lib/private/variables/generated/).

To compile, make sure to install [PowerShell Az](https://www.powershellgallery.com/packages/Az) (11.5.0 or higher), then run with:

- param `location`, a location (a valid Azure region), for instance `westeurope`;
- param `allowPublicResources`, either `0` or `1`. Sets the public network access property on resources.

```bash
Connect-AzAccount
./scripts/Build-Lib.ps1 -location westeurope -allowPublicResources 0
```

## Samples ##

Try out [the samples](/samples/) by running the following commands:

```bash
az login
az deployment sub create --location westeurope --template-file samples/main.bicep --parameters samples/main.dev.bicepparam 
```

Or just build the sample locally:

```bash
az bicep build --file samples/main.bicep
```

## Functional oriented vs. module oriented approach ##

Module oriented libraries like [Azure Verified Modules](https://azure.github.io/Azure-Verified-Modules/) aim to modularize each resource. With Bicep#, the approach is to:

1. **Provide a way to mix and match better than modules.** Bicep# provides centralized types, functions and variables you can use over and over again, without being isolated into a single module, where some [types](https://github.com/Azure/bicep-registry-modules/blob/24e4a79e840088f266002631efdc0383ea9e98a0/avm/res/storage/storage-account/main.bicep#L652) and [patterns](https://github.com/Azure/bicep-registry-modules/blob/24e4a79e840088f266002631efdc0383ea9e98a0/avm/res/storage/storage-account/main.bicep#L449) are actually not that reusable at all. For instance, in Bicep#, you make an NSG rule without having to look up what the service tags are, or what the destination service structure looks like, or without restricting in what module your NSG rule ends up in. You decide, and Bicep# gets you the additional information and structure you missed out on.

2. **Prevent overuse of modules.** Many use cases for Bicep modules are obsolete with the introduction of user-defined concepts in Bicep. Technically, modules are just separate deployment templates (and server side sub-deployments in Azure). There used to be no other way to centralize logic than to use templates and reference them. With Bicep#, there shouldn't be much reason to keep modularizing everything with the concept of Bicep modules. That doesn't mean modules don't have a use case anymore, but it sure isn't as much of a big deal anymore.

3. **Respect the simplicity of Bicep, and only provide functionality that extends your workflow instead of overhauling it.** Giving in on enterprise-scale libraries most likely means overhauling a large part of your infrastructure. When keeping things small and functional oriented, you can effectively refactor either big or small parts of your infrastructure, where it matters to you the most.

## Technical design ##

### Public facing ###

The root of [/lib/](/lib/) contains public variables, types and functions to be used by the end-user, smartly grouped together, to;

- reduce the amount of imports for the end-user;
- reduce the total size of templates after import;
- keep the public facing files readable.

### Breakdown of lib files ###

Lib files should only have a use case within two scopes at most, and ideally just one scope, except for the `resource` and `tag` lib.

| Public lib | Groups together... | Makes sense to use in files with scope... |
| -- | -- | -- |
| resource | Generic usages on resources, resource groups and modules | resourceGroup and subscription  |
| tag  | Tagging | bicepparam and subscription  |
| authorization | [Azure Role Based Access Control](https://learn.microsoft.com/en-us/azure/role-based-access-control/overview) | resourceGroup  |
| network | [Azure Networking](https://azure.microsoft.com/en-us/products/category/networking) | resourceGroup |
| storage | Azure Storage | resourceGroup |
| devOpsServices | DevOps Services | bicepparam |
| entraId | Entra ID | bicepparam  |

### Breakdown of artifacts in lib files ###

Public functions are either;

- helper functions, prefixed by `get`, `calculate`, `create` etc..., or;
- resource builder functions, prefixed by `build` and appended with the resource to build, for instance `buildVnet`. These functions will always return a complete resource with at least `name` and `properties`, as specified by the types `resourceFormat` and `resourceFormatWithDefaultName` in [/lib/private/types/resource.bicep](/lib/private/types/resource.bicep).
  - Building the `properties` of a resource will always be done in a private function file at [/lib/private/functions/](/lib/private/functions/).
  - Building the `name` of a resource will only be done in a private function file at [/lib/private/functions/](/lib/private/functions/) if the name is being built in more than one public function or if it's more than a one-liner.

Public variables are;

- never fully written down, but always specified and referenced from a private facing file at [/lib/private/variables/](/lib/private/variables/).

Public types are;

- never fully written down, but always specified and referenced from a private facing file at [/lib/private/types/](/lib/private/types/).

### Private facing ###

[/lib/private/](/lib/private/) contains private variables, types and functions, grouped by resource type, to be used by public facing Bicep# files.

[/scripts/New-FrameworkGlobals.ps1](/scripts/New-FrameworkGlobals.ps1) outputs separate text files in [/lib/private/variables/generated/](/lib/private/variables/generated/) for each global value, to preserve efficient loading with `loadTextContent()`. Because we cannot use variables inside functions, these files can directly be used inside any private function.

## License ##

This work is licensed under a
[Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License][cc-by-nc-sa].

[![CC BY-NC-SA 4.0][cc-by-nc-sa-image]][cc-by-nc-sa]

[cc-by-nc-sa]: http://creativecommons.org/licenses/by-nc-sa/4.0/
[cc-by-nc-sa-image]: https://licensebuttons.net/l/by-nc-sa/4.0/88x31.png
[cc-by-nc-sa-shield]: https://img.shields.io/badge/License-CC%20BY--NC--SA%204.0-lightgrey.svg
