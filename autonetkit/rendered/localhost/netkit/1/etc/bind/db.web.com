;
; BIND data file for local loopback interface
;
$TTL	None
@	IN	SOA	web.com. root.localhost. (
			      2		; Serial
			 604800		; Refresh
			  86400		; Retry
			2419200		; Expire
			 604800 )	; Negative Cache TTL
;
@		IN	NS	None.web.com.
None	None	IN	A	10.0.0.18

None	None	IN	A	10.0.0.21
None	None	IN	A	10.0.0.20
None	None	IN	A	10.0.0.2
None	None	IN	A	10.0.0.17
None	None	IN	A	10.0.0.4
