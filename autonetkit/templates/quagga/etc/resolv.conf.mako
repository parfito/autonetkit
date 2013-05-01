%if node.is_client:
nameserver ${node.DNSResolverIpv4}
domain ${node.Domain}
%endif
