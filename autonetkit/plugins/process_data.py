import textfsm
import pika

def sh_ip_route(nidb, data):
    sample_data = """
    Codes: K - kernel route, C - connected, S - static, R - RIP, O - OSPF,
       I - ISIS, B - BGP, > - selected route, * - FIB route

O   10.0.0.1/32 [110/10] is directly connected, lo, 02:59:26
C>* 10.0.0.1/32 is directly connected, lo
B   10.0.0.2/32 [200/1] via 10.0.0.2 inactive, 02:57:24
O>* 10.0.0.2/32 [110/11] via 10.0.0.10, eth2, 02:57:31
B   10.0.0.3/32 [200/1] via 10.0.0.3 inactive, 02:57:22
O>* 10.0.0.3/32 [110/11] via 10.0.0.17, eth0, 02:58:41
O   10.0.0.8/30 [110/1] is directly connected, eth2, 02:59:26
C>* 10.0.0.8/30 is directly connected, eth2
B   10.0.0.12/30 [200/1] via 10.0.0.2, 02:57:24
O>* 10.0.0.12/30 [110/2] via 10.0.0.10, eth2, 02:57:26
  *                      via 10.0.0.17, eth0, 02:57:26
O   10.0.0.16/30 [110/1] is directly connected, eth0, 02:59:26
C>* 10.0.0.16/30 is directly connected, eth0
C>* 10.1.0.8/30 is directly connected, eth1
C>* 127.0.0.0/8 is directly connected, lo
C>* 172.16.0.0/16 is directly connected, eth3
"""
    template = open("autonetkit/textfsm/quagga/sh_ip_route")
    re_table = textfsm.TextFSM(template)
    routes = re_table.ParseText(data)
    print "\t".join(re_table.header)
    for route in routes:
        print "\t".join(route)
    return

def traceroute(nidb, data):
    template = open("autonetkit/textfsm/linux/traceroute")
    re_table = textfsm.TextFSM(template)
    routes = re_table.ParseText(data)
    #print "\t".join(re_table.header)
    for route in routes:
        #print "\t".join(route)
        route = route[0] # first element of table: todo make this programatic from table.header
        #print reverse_lookup(nidb, route)

    return [reverse_lookup(nidb, route[0])[1] for route in routes]


def reverse_lookup(nidb, address):
    for node in nidb.nodes("is_l3device"):
        if str(node.loopback) == address:
            return ("loopback", node)

        for interface in node.interfaces:
            if str(interface.ip_address) == address:
                return (interface.id, node)
            
    return "IP not found"

def reverse_tap_lookup(nidb, address):
    for node in nidb.nodes("is_l3device"):
        if str(node.tap.ip) == address:
            return node
