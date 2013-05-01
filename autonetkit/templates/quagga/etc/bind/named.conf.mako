// This is the primary configuration file for the BIND DNS server named.
//
// Please read /usr/share/doc/bind9/README.Debian.gz for information on the 
// structure of BIND configuration files in Debian, *BEFORE* you customize 
// this configuration file.
//
// If you are just adding zones, please do that in /etc/bind/named.conf.local

include "/etc/bind/named.conf.options";

// prime the server with knowledge of the root servers
zone "." {
	% if node.is_rootServer :
	type master;
	%else:
	type hint;
	%endif
	file "/etc/bind/db.root";
};

// be authoritative for the localhost forward and reverse zones, and for
// broadcast zones as per RFC 1912

zone "localhost" {
	type master;
	file "/etc/bind/db.local";
};

zone "127.in-addr.arpa" {
	type master;
	file "/etc/bind/db.127";
};

zone "0.in-addr.arpa" {
	type master;
	file "/etc/bind/db.0";
};

zone "255.in-addr.arpa" {
	type master;
	file "/etc/bind/db.255";
};

%if node.is_nameServer :
% for domain in node.domains :
zone "${domain.name}" {
	type ${node.level};
	file "/etc/bind/db.${domain.name}";
	% if node.level == "slave":
	masters {${node.primaryNameServerIP}};
	% endif
};
% endfor
%endif
##% import autonetkit.console_script as cs
##% loadBalancingType = cs.parse_options().loadBalType
##rrset-order { order ${loadBalancingType}; };

include "/etc/bind/named.conf.local";
