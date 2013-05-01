$TTL	604800
% if node.is_rootServer:
@	IN	SOA	${node.name}.	root.localhost. (
               2     ; Serial
          604800     ; Refresh
           86400     ; Retry
         2419200     ; Expire
          604800 )   ; Negative Cache TTL
;
%endif

% if node.is_nameServer:

.                       3600000  	IN  NS    ${node.RNS_name}.
${node.RNS_name}.       3600000     IN	A     ${node.RNS_ipv4}

%endif

% if  node.is_rootServer :
% for domain in node.domains:
${domain.name}		IN	NS	${domain.nameServerName}.${domain.name}.
${domain.nameServerName}.${domain.name}.	IN	A	${domain.nameServerIPv4_address}

%endfor
% endif
