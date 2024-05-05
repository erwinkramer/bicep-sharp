import * as _resourceType from '../types/resource.bicep'

@description('''
Add iteration identifier element to the properties of each resource, based on the index of a resource in the unIterizedResourceCollection.
If the iteration identifier element already exists, it skip setting the element to that object.
''')
@export()
func makeIteratedResourceCollection(
  unIterizedResourceCollection _resourceType.resourceFormat[],
  iterationIdentifier string,
  startIndexAt int
) _resourceType.resourceFormat[] =>
  map(
    range(0, length(unIterizedResourceCollection)),
    i => {
      name: unIterizedResourceCollection[i].name
      properties: contains(unIterizedResourceCollection[i].properties, iterationIdentifier)
        ? unIterizedResourceCollection[i].properties
        : union(unIterizedResourceCollection[i].properties, { '${iterationIdentifier}': startIndexAt + i })
    }
  )
