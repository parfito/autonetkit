'''
Created on 25 avr. 2013

@author: Parfait
'''

def is_DNSResolver(string):
    """Either from this graph or the physical graph"""
    for dv_subtype in string.split('_'):
        if dv_subtype == "DNSR" :
            return True;
    for dv_subtype in string.split('_'):
        if dv_subtype == "DNSR" :
            return True;
    return False              

def is_client(string):
    """Either from this graph or the physical graph"""
    for dv_subtype in string.split('_'):
        if dv_subtype == "CL" :
            return True;
    for dv_subtype in string.split('_'):
        if dv_subtype == "CL" :
            return True;
    return False                

if __name__ == '__main__':
    from mako.template import Template

    mytemplate = Template(filename='hostname.mako')
    print mytemplate.render()
