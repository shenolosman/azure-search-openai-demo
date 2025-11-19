// Key Vault module for Bicep
param environmentName string
param location string
param principalId string
param publicNetworkAccess string = 'Enabled'
param tags object = {}

resource keyVault 'Microsoft.KeyVault/vaults@2023-07-01' = {
  name: '${environmentName}-kv'
  location: location
  properties: {
    tenantId: tenant().tenantId
    sku: {
      family: 'A'
      name: 'standard'
    }
    accessPolicies: [
      {
        tenantId: tenant().tenantId
        objectId: principalId // The user or app deploying
        permissions: {
          secrets: [ 'get', 'list', 'set', 'delete', 'recover', 'backup', 'restore' ]
          keys: [ 'get', 'list', 'create', 'delete', 'recover', 'backup', 'restore' ]
        }
      }
    ]
    enabledForDeployment: true
    enabledForTemplateDeployment: true
    enabledForDiskEncryption: true
    publicNetworkAccess: publicNetworkAccess
  }
  tags: tags
}
