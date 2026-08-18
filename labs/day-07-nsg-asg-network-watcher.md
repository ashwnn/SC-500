# Day 7 - NSGs, ASGs, and Network Watcher

**Time:** 90-120 minutes  
**Mode:** Hands-on  
**SC-500:** NSGs, ASGs, effective rules, Network Watcher diagnostics

## Business request

NCES needs application-role rules rather than IP-address spreadsheets and must be able to prove why traffic is allowed or denied.

## Build

1. Create `asg-web` and `asg-api` in the app VNet.
2. Create `nsg-app` and attach it to `snet-app`.
3. Add explicit rules with space between priorities:
   - allow HTTPS from `asg-web` to `asg-api` on a chosen test port;
   - allow Azure Load Balancer probes only where required;
   - deny other lateral application traffic before the default VNet allow.
4. Deploy two tiny test NIC/VM workloads only if the cost forecast permits. Assign their NICs to the ASGs.
5. Create an intentional overly broad inbound rule, use Defender/your review to identify it, then remove it.
6. Use Network Watcher:
   - IP flow verify;
   - effective security rules;
   - connection troubleshoot;
   - next hop.
7. Compare subnet-level and NIC-level NSGs. Record the combined effect rather than assuming one overrides the other.

## Tests

- Web to API test port succeeds.
- Web to an unapproved API port fails.
- Internet to API fails.
- Network Watcher identifies the actual rule and next hop.

If you avoid VMs, use temporary NICs where the diagnostic supports them and complete a documented packet-path analysis. Do not claim connectivity tests you did not run.

## Cost and cleanup

Delete or deallocate test VMs, disks, public IPs, and NICs at the end. Keep NSGs/ASGs. Network Watcher packet capture storage is not required.

## Sources

- [NSG overview](https://learn.microsoft.com/azure/virtual-network/network-security-groups-overview)
- [Application security groups](https://learn.microsoft.com/azure/virtual-network/application-security-groups)
- [IP flow verify](https://learn.microsoft.com/azure/network-watcher/network-watcher-ip-flow-verify-overview)
- [Effective security rules](https://learn.microsoft.com/azure/network-watcher/effective-security-rules-overview)

