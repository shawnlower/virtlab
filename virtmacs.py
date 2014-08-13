#!/usr/bin/python

import libvirt

conn = libvirt.open('qemu:///system')

# List all running domains
domains=[ d for d in conn.listAllDomains() 
            if d.state()[0] == libvirt.VIR_DOMAIN_RUNNING ]
for dom in domains:
    print "%s " % dom.name()
