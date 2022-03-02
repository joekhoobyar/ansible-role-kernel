## Protect TODO

emerge --noreplace

## Cleanup TODO

Find versions that are:
 - not the three latest kernels
 - not the current kernel
 - not the default boot kernel

emerge --unmerge
/boot
/usr/src/linux
/lib/modules

## Required kernel modules

 *   CONFIG_CPUSETS:	 is not set when it should be.
 *   CONFIG_VETH:	 is not set when it should be.
 *   CONFIG_IP_NF_FILTER:	 is not set when it should be.
 *   CONFIG_IP_NF_TARGET_MASQUERADE:	 is not set when it should be.
 *   CONFIG_NETFILTER_XT_MATCH_ADDRTYPE:	 is not set when it should be.
 *   CONFIG_NETFILTER_XT_MATCH_CONNTRACK:	 is not set when it should be.
 *   CONFIG_NETFILTER_XT_MATCH_IPVS:	 is not set when it should be.
 *   CONFIG_IP_NF_NAT:	 is not set when it should be.
 *   CONFIG_NF_NAT:	 is not set when it should be.
 *   CONFIG_NF_NAT_NEEDED:	 is not set when it should be.
 *   CONFIG_CGROUP_PERF: is optional for container statistics gathering
 *   CONFIG_CGROUP_HUGETLB:	 is not set when it should be.
 *   CONFIG_NET_CLS_CGROUP:	 is not set when it should be.
 *   CONFIG_IP_VS:	 is not set when it should be.
 *   CONFIG_IP_VS_PROTO_TCP:	 is not set when it should be.
 *   CONFIG_IP_VS_PROTO_UDP:	 is not set when it should be.
 *   CONFIG_IP_VS_NFCT:	 is not set when it should be.
 *   CONFIG_IP_VS_RR:	 is not set when it should be.
 *   CONFIG_IPVLAN:	 is not set when it should be.
 *   CONFIG_DUMMY:	 is not set when it should be.
 *   CONFIG_CGROUP_NET_PRIO:	 is not set when it should be.
 *   CONFIG_NF_NAT_IPV4:	 is not set when it should be.
 *   CONFIG_CFQ_GROUP_IOSCHED:	 is not set when it should be.
