;
; BIND data file for local loopback interface
;
$TTL	8000
@	IN	SOA	web.com. root.localhost. (
			      2		; Serial
			 604800		; Refresh
			  86400		; Retry
			2419200		; Expire
			 604800 )	; Negative Cache TTL
;
@		IN	NS	server3ns2.web.com.
server3ns2	8000	IN	A	10.0.0.18

