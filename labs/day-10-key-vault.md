# Day 10 - Key Vault lifecycle, network, and workload identity

**Time:** 90-120 minutes  
**Mode:** Hands-on  
**SC-500:** Key Vault deployment/settings/access/firewall, keys/secrets/certificates/rotation, managed identities

## Business request

Pathfinder needs secret and cryptographic lifecycle management without letting developers or resource administrators read all values. The application must authenticate without embedded credentials.

## Build

1. Create a Standard Key Vault with Azure RBAC authorization, soft delete, purge protection, and a unique name.
2. Assign separate test roles at vault scope:
   - Key Vault Secrets Officer;
   - Key Vault Crypto Officer;
   - Key Vault Certificates Officer;
   - Key Vault Reader to a user who must see metadata but not values.
3. Create:
   - a versioned synthetic secret with an expiry;
   - an RSA key with permitted operations and a rotation policy;
   - a self-signed test certificate with a lifetime action.
4. Rotate the key and secret manually. Disable an old version, prove access failure, then recover it.
5. Enable diagnostic `AuditEvent` logs to the security Log Analytics workspace when it exists, or stage the setting for day 28.
6. Add a system- or user-assigned managed identity to a low-cost workload. Grant only `Key Vault Secrets User` for the vault or narrower supported scope.
7. Retrieve the synthetic secret using the identity. Do not display it in evidence.
8. Configure the Key Vault firewall/private endpoint, link `privatelink.vaultcore.azure.net`, verify private resolution, then disable public access after success.
9. Enable Defender for Key Vault during day 20, not automatically today, unless its plan trial is already running.

## Failure tests

- Azure Contributor without a Key Vault data role cannot read a secret.
- Key Vault Reader sees metadata but not the secret value.
- The workload identity reads only the authorized secret action.
- Public access fails after private-only configuration.

## Design decision

Standard is selected because this POC does not require HSM-backed keys. Premium would be justified for HSM-specific regulatory or cryptographic requirements, not merely because it sounds more secure.

## Cost and cleanup

Keep the vault through day 30. Remove temporary role assignments. Purge protection means deleted vault names are not immediately reusable, so avoid casual delete/recreate loops.

## Sources

- [Key Vault security](https://learn.microsoft.com/azure/key-vault/general/security-features)
- [Key Vault RBAC](https://learn.microsoft.com/azure/key-vault/general/rbac-guide)
- [Key rotation](https://learn.microsoft.com/azure/key-vault/keys/how-to-configure-key-rotation)
- [Key Vault private link](https://learn.microsoft.com/azure/key-vault/general/private-link-service)

