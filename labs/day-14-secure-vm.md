# Day 14 - Trusted Launch VM, encryption, Bastion, and JIT

**Time:** 90-120 minutes  
**Mode:** Cost-burst  
**SC-500:** disk encryption, Bastion, JIT, secure boot, vTPM, integrity monitoring

## Business request

A legacy document converter must temporarily run on a VM. NCES wants measured boot, encrypted storage, no persistent public management port, and time-limited analyst access.

## Build

1. Deploy one small supported Gen2 VM in `rg-sc500-vm-cc` with **Trusted Launch**, Secure Boot, vTPM, and boot integrity monitoring.
2. Do not attach a public IP. Use a managed OS disk with platform-managed encryption.
3. Review encryption options:
   - storage service encryption with platform-managed or customer-managed key;
   - encryption at host;
   - Azure Disk Encryption where supported/appropriate.
4. Create a decision record choosing the default for NCES. Do not stack encryption features without a requirement and compatibility check.
5. Enable Defender for Servers P2 if its plan trial is available.
6. Configure JIT for the management port with a narrow source and short duration. Request access and observe the temporary NSG rule, then verify expiry/removal.
7. Use Bastion Developer if available and suitable. Otherwise review the paid SKU estimate, deploy only if the burst budget allows, connect once, then delete it.
8. Review boot diagnostics and integrity recommendations.

## Verification

- VM security type shows Trusted Launch.
- Secure Boot and vTPM are enabled.
- No VM public IP exists.
- Management is unreachable before JIT, reachable during the approved window through the intended path, and closed afterward.

## Cost and cleanup

Stop/deallocate at session end. Delete paid Bastion resources and unused public IPs. Keep the VM until day 15 only.

## Sources

- [Trusted Launch](https://learn.microsoft.com/azure/virtual-machines/trusted-launch)
- [Disk encryption overview](https://learn.microsoft.com/azure/virtual-machines/disk-encryption-overview)
- [Azure Bastion](https://learn.microsoft.com/azure/bastion/bastion-overview)
- [JIT VM access](https://learn.microsoft.com/azure/defender-for-cloud/just-in-time-access-overview)

