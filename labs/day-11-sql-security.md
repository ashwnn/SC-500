# Day 11 - Azure SQL security, auditing, and encryption

**Time:** 90-120 minutes  
**Mode:** Hands-on; SSMS required for full Always Encrypted test  
**SC-500:** SQL platform security, auditing, Defender for Databases

## Business request

Case records need Entra-only administration, private access, auditable queries, encryption at rest, and protection for a small set of highly sensitive values from database operators.

## Build

1. Create an Azure SQL logical server and a database using the current free serverless offer if displayed for your subscription.
2. Set a Microsoft Entra administrator, then enable Microsoft Entra-only authentication after confirming access.
3. Create contained database users for a group and a managed identity. Grant the minimum database roles/permissions.
4. Load ten synthetic case rows. Do not use real personal data.
5. Verify TLS requirements and TDE status. Explain that TDE protects files, logs, and backups at rest but not values from an authorized query.
6. Configure SQL auditing to Log Analytics. Generate successful and failed queries and find their audit events.
7. Add a SQL private endpoint and `privatelink.database.windows.net` link. Confirm the normal server name resolves privately inside the VNet, then deny public network access.
8. If you have SSMS on Windows, configure Always Encrypted for one synthetic identifier column with a Key Vault column master key. Compare:
   - ciphertext from a client without key access;
   - plaintext from an authorized Always Encrypted client.
9. Review customer-managed TDE using a managed identity and Key Vault key. Implement only if the dependency and rotation workload fit the session; otherwise write the exact role/key/rotation design.
10. Enable Defender for SQL during day 20 or use the existing trial. Review vulnerability assessment and alert settings.

## Failure tests

- SQL password authentication fails after Entra-only enforcement.
- Public connection fails after private-only access.
- A database principal without column-master-key access cannot decrypt the protected column.
- Audit logs show both access and failure evidence.

## Cost and cleanup

Close SSMS/Object Explorer so serverless auto-pause can occur. Keep only a free/auto-pausing database. Delete accidental provisioned databases, private endpoints, or duplicate audit destinations.

## Sources

- [Azure SQL free offer](https://learn.microsoft.com/azure/azure-sql/database/free-offer)
- [Entra-only authentication](https://learn.microsoft.com/azure/azure-sql/database/authentication-azure-ad-only-authentication)
- [SQL auditing](https://learn.microsoft.com/azure/azure-sql/database/auditing-overview)
- [TDE](https://learn.microsoft.com/azure/azure-sql/database/transparent-data-encryption-tde-overview)
- [Always Encrypted](https://learn.microsoft.com/sql/relational-databases/security/encryption/always-encrypted-database-engine)

