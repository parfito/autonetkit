%if node.is_client:
nameserver ${node.DNSResolverIpv4}
	%if node.domain is not None:
domain ${node.domain}
	%endif
%endif
