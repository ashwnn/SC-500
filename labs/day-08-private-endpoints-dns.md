# Day 8 - Private endpoints and Private DNS

**Time:** 90-120 minutes  
**Mode:** Hands-on  
**SC-500:** private endpoints, Private DNS, Storage firewall, Private Link concepts

## Business request

Storage must keep its normal service hostname for applications but resolve to a private address inside approved networks. Public access is disabled only after private resolution is proven.

## Build

1. Create a unique Standard GPv2 LRS storage account in `rg-sc500-data-cc` with secure transfer, TLS 1.2 or later, and public blob access disabled.
2. Create a private endpoint for Blob in `snet-private-endpoints`.
3. Create/link `privatelink.blob.core.windows.net` to the app VNet.
4. From a workload inside the VNet, resolve `<account>.blob.core.windows.net` and prove it returns the endpoint's private IP.
5. Test Entra-authorized blob access inside the VNet.
6. Disable Storage public network access, then prove a public client such as ordinary Cloud Shell cannot reach the data endpoint.
7. Inspect the private endpoint connection state and NIC.
8. Repeat the design, not necessarily the deployment, for:
   - `privatelink.vaultcore.azure.net`;
   - `privatelink.database.windows.net`;
   - the current Foundry private-link zones documented for the selected resource type.
9. Create a decision record comparing service endpoint, private endpoint, and Private Link Service.

## Common failure exercise

Temporarily unlink the Private DNS zone or use a wrong DNS record. Observe resolution to the public endpoint and failed access after public-network denial. Restore the link and retest.

## Key lesson

A private endpoint does not automatically disable the public endpoint. DNS configuration is part of the security boundary, and split-horizon/on-premises forwarding must be designed deliberately.

## Cost and cleanup

Private endpoints have a recurring hourly/data-processing meter. Keep the Blob endpoint only if needed for days 9-11 and the budget remains safe; otherwise delete it after evidence and recreate later.

## Sources

- [Private endpoint DNS](https://learn.microsoft.com/azure/private-link/private-endpoint-dns)
- [Storage private endpoints](https://learn.microsoft.com/azure/storage/common/storage-private-endpoints)
- [Storage network security](https://learn.microsoft.com/azure/storage/common/storage-network-security)

