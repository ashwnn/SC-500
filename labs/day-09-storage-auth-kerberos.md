# Day 9 - Storage authorization, SAS, and Entra Kerberos

**Time:** 90-120 minutes  
**Mode:** Blob hands-on; Azure Files cloud-only Kerberos preview/region-dependent  
**SC-500:** Storage security, firewall, access policies and authorization

## Business request

Pathfinder applications must use Entra tokens, while a limited file-share pilot needs user authentication without account keys. Any delegated access must expire automatically.

## Blob authorization

1. Create a container with anonymous access disabled.
2. Give `platform.operator` **Storage Blob Data Contributor** at container scope. Give `dev.pathfinder` **Reader** only on the storage account management plane.
3. Prove the operator can upload with Entra authorization and the developer cannot read blob contents.
4. Generate a short-lived **user delegation SAS** for one blob. Set HTTPS-only, minimum permissions, and minutes rather than days.
5. Test before and after expiry.
6. Configure a SAS expiration policy and review diagnostic logs.
7. Disable Shared Key authorization after confirming no lab dependency requires it. Prove an account-key request fails while Entra access still works.
8. Compare account SAS, service SAS, user-delegation SAS, and stored access policy in a decision record.

## Azure Files Entra Kerberos lane

Current documentation supports hybrid and cloud-only identities, with regional and service-tier limitations. Canada Central cloud-only support may require premium/SSD Azure Files.

If prerequisites and cost permit:

1. Create a short-lived premium FileStorage account and SMB share.
2. Enable Microsoft Entra Kerberos as the only identity source.
3. Grant admin consent to the generated application and enable documented cloud-group support.
4. Assign share-level RBAC to a cloud-only group.
5. From an updated Entra-joined Windows client, mount the share and inspect `klist` for the CIFS ticket.
6. Ensure any broad MFA Conditional Access policy excludes only the storage application required for silent Kerberos, document the exception, and monitor it.

If unavailable, walk the portal prerequisites, capture the unsupported region/SKU/quota result, and complete the identity/CA design. Label it simulated.

## Cost and cleanup

Delete the premium FileStorage account immediately. Keep the GPv2 account. Cloud-only Kerberos is not a reason to deploy Entra Domain Services for this 30-day lab.

## Sources

- [Authorize Storage data](https://learn.microsoft.com/azure/storage/common/authorize-data-access)
- [Prevent Shared Key](https://learn.microsoft.com/azure/storage/common/shared-key-authorization-prevent)
- [SAS overview](https://learn.microsoft.com/azure/storage/common/storage-sas-overview)
- [Entra Kerberos for Azure Files](https://learn.microsoft.com/azure/storage/files/storage-files-identity-auth-hybrid-identities-enable)

