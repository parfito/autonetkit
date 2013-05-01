;
; BIND data file for local loopback interface
;
$TTL	${node.TTL}
@	IN	SOA	${node.domain}. root.localhost. (
			      2		; Serial
			 604800		; Refresh
			  86400		; Retry
			2419200		; Expire
			 604800 )	; Negative Cache TTL
;
@		IN	NS	${node.name}.${node.domain}.
${node.name}	${node.TTL}	IN	A	${node.interfaces[0].ipv4_address}

% if node.is_nameServer:
% for domain in node.domains:
	% for (hostname, hostAddress, ttl) in domain.clients :
${hostname}	${ttl}	IN	A	${hostAddress}
	% endfor
% endfor
%endif