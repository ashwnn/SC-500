# Day 12 - Enterprise network controls

**Time:** 90-120 minutes  
**Mode:** One brief hands-on control plus guided designs for expensive/licensed services  
**SC-500:** VNet Manager, Virtual WAN, VPN, Entra Private Access, Private Link Service, Azure Firewall

## Business request

NCES expects multiple offices and subscriptions. It needs centrally enforced network rules, private access for remote users, an inspection path, and a way to publish internal services to partner VNets without public exposure.

## Part A - Virtual Network Manager

1. Create an Azure Virtual Network Manager scoped to the lab subscription if the portal shows an acceptable estimate.
2. Add the app and AKS VNets to a network group by tag or explicit membership.
3. Create a security admin configuration that denies inbound management ports from the internet across the group.
4. Deploy the configuration and compare security admin rules with NSGs. Record why security admin rules are evaluated before NSGs.

If deployment cost/availability is unsuitable, complete the objects in a decision record and use NSGs for the live test.

## Part B - Azure Firewall cost-burst

1. Check the live hourly estimate before deployment.
2. Deploy the lowest suitable nonproduction Firewall SKU into `AzureFirewallSubnet` with one public IP.
3. Create one network rule, one application rule, threat-intelligence alert/deny setting, diagnostics, and a route from a test subnet.
4. Test one allowed and one denied destination. Inspect Firewall logs.
5. Remove the route, delete Firewall and public IP in the same session, and confirm both are gone.

## Part C - Architecture stations

Create a one-page design for each:

- **VPN Gateway:** point-to-site for administrators, Entra authentication, certificate alternative, gateway subnet, client routes, and cost.
- **Virtual WAN:** secured virtual hub for five offices, branch VPN, routing intent, and why it is excessive for this POC.
- **Microsoft Entra Private Access:** connector group, private application segment, Conditional Access, and its separate Global Secure Access licensing.
- **Private Link Service:** internal Standard Load Balancer frontend, provider service, consumer private endpoint, approval workflow, and NAT source behavior.

Open each portal creation flow through validation but do not leave gateways or load balancers running merely for screenshots.

## Decision summary

NCES selects hub-spoke plus short-lived Firewall for the POC. Production evaluation compares Virtual WAN when office count and managed routing justify it. Entra Private Access is a user-to-private-app access control, not a VNet-to-VNet replacement.

## Evidence

Security admin rule result, Firewall allow/deny logs and deletion proof, plus four architecture records with current portal estimates.

## Sources

- [VNet Manager security admin rules](https://learn.microsoft.com/azure/virtual-network-manager/concept-security-admins)
- [Azure Firewall](https://learn.microsoft.com/azure/firewall/overview)
- [VPN Gateway](https://learn.microsoft.com/azure/vpn-gateway/vpn-gateway-about-vpngateways)
- [Virtual WAN](https://learn.microsoft.com/azure/virtual-wan/virtual-wan-about)
- [Entra Private Access](https://learn.microsoft.com/entra/global-secure-access/concept-private-access)
- [Private Link Service](https://learn.microsoft.com/azure/private-link/private-link-service-overview)

