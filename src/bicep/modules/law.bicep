

@description('location of the log analytics workspace')
param lawLocation string = resourceGroup().location
@description('name of the log analytics workspace')
param lawName string
@description('log analytics tags')
param lawTags object

var tags = union(lawTags,{
  Component : 'Monitoring'
})

// log analitics workspace
resource law 'Microsoft.OperationalInsights/workspaces@2022-10-01' = {
  name: lawName
  location: lawLocation
  tags: tags
  properties: any({
    retentionInDays: 30
    features: {
      searchVersion: 1
    }
    sku: {
      name: 'PerGB2018'
    }
  })
}

// outputs
output outputLawClientId string = law.properties.customerId
output outputLawWorkspaceName string= lawName
