% for i in node.interfaces:  
/sbin/ifconfig ${i.id} ${i.ipv4_address} netmask ${i.ipv4_subnet.netmask} broadcast ${i.ipv4_subnet.broadcast} up
% endfor                                                                                                                             
route del default
/sbin/ifconfig lo 127.0.0.1 up
/etc/init.d/ssh start
/etc/init.d/hostname.sh 
/etc/init.d/zebra start
%if node.is_nameServer or node.is_DNSResolver or node.is_rootServer : 
/etc/init.d/bind start
% endif 
%if node.is_webServer : 
/etc/init.d/apache2 start
% endif 

% if node.ssh.use_key:
chown -R root:root /root     
chmod 755 /root
chmod 755 /root/.ssh
chmod 644 /root/.ssh/authorized_keys
% endif     
