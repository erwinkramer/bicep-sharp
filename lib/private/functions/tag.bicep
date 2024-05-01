import * as _tagType from '../types/tag.bicep'

@export()
func buildCmdblink(ci _tagType.cmdbId, serviceNowInstanceName string) _tagType.cmdbLink =>
  'https://${serviceNowInstanceName}.com/now/nav/ui/classic/params/target/cmdb_ci_appl.do%3Fsys_id%3D${ci}'
