virtlab
=======

Fast, stupid-simple VM deployment script
== Overview

Simple and *FAST* method for building a test environment.

Uses qcow2 images and backing files


Inputs:
    - Backing file: e.g. rhel-6.5, rhel-7
    - Number of instances

== Steps
    qemu-img create -o backing_file=$BACKING_FILE $OUTPUT_FILE $SIZE

== Example

Creating a single VM

`

$ time sudo ./vlab.sh create
Formatting '/var/lib/libvirt/images/foreman_el6-i1.qcow2', fmt=qcow2 size=10737418240 backing_file='/home/images/rhel6.qcow2' encryption=off cluster_size=65536 lazy_refcounts=off 
Pool default refreshed

[   0.0] Examining the guest ...
[   7.0] Setting a random seed
[   7.0] Running: fgrep -q "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEA6NF8iallvQVp22WDkTkyrtvp9eWW6A8YVr+kz4TjGYe7gHzIw+niNltGEFHzD8+v1I2YJ6oXevct1YeS0o9HZyN1Q9qgCgzUFtdOKLv6IedplqoPkcmF0aYet2PkEDo3MlTBckFXPITAMzF8dJSIFo9D8HfdOV0IAdx4O7PtixWKn5y2hMNG0zQPyUecp4pzC6kivAIhyfHilFR61RGL+GPXQ2MWZWFYbAGjyiYJnAmCP3NOTd0jMZEnDkbUvxhMmBYSdETk1rRgm+R4LOzFUGaHqHDLKLX+FIPKcF96hrucXzcWyLbIbEgE98OHlnVYCzRdK8jlqm8tehUc9c9WhQ== vagrant insecure public key" /root/authorized_keys && echo "Key already exists." || echo "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEA6NF8iallvQVp22WDkTkyrtvp9eWW6A8YVr+kz4TjGYe7gHzIw+niNltGEFHzD8+v1I2YJ6oXevct1YeS0o9HZyN1Q9qgCgzUFtdOKLv6IedplqoPkcmF0aYet2PkEDo3MlTBckFXPITAMzF8dJSIFo9D8HfdOV0IAdx4O7PtixWKn5y2hMNG0zQPyUecp4pzC6kivAIhyfHilFR61RGL+GPXQ2MWZWFYbAGjyiYJnAmCP3NOTd0jMZEnDkbUvxhMmBYSdETk1rRgm+R4LOzFUGaHqHDLKLX+FIPKcF96hrucXzcWyLbIbEgE98OHlnVYCzRdK8jlqm8tehUc9c9WhQ== vagrant insecure public key" >> /root/authorized_keys
[   7.0] Setting the hostname: foreman_el6-i1
[   7.0] Setting passwords
[   8.0] Finishing off

Starting install...
Creating domain...                                                                                                                                 |    0 B  00:00:00     
Domain creation completed. You can restart your domain by running:
  virsh --connect qemu:///system start foreman_el6-i1

  real  0m10.857s
  user  0m1.987s
  sys   0m0.375s
`


And cleaning up:

`
[sstar@sstar01-lt repo]$ time sudo ./vlab.sh delete
  Domain foreman_el6-i1 destroyed

  Domain foreman_el6-i1 has been undefined
  Volume 'vda'(/var/lib/libvirt/images/foreman_el6-i1.qcow2) removed.


  real  0m0.432s
  user  0m0.165s
  sys   0m0.053s

`

Changing the script to create 4 VMs

`
$ time sudo ./vlab.sh create
Formatting '/var/lib/libvirt/images/foreman_el6-i1.qcow2', fmt=qcow2 size=10737418240 backing_file='/home/images/rhel6.qcow2' encryption=off cluster_size=65536 lazy_refcounts=off 
Pool default refreshed

[   0.0] Examining the guest ...
[   6.0] Setting a random seed
[   6.0] Running: fgrep -q "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEA6NF8iallvQVp22WDkTkyrtvp9eWW6A8YVr+kz4TjGYe7gHzIw+niNltGEFHzD8+v1I2YJ6oXevct1YeS0o9HZyN1Q9qgCgzUFtdOKLv6IedplqoPkcmF0aYet2PkEDo3MlTBckFXPITAMzF8dJSIFo9D8HfdOV0IAdx4O7PtixWKn5y2hMNG0zQPyUecp4pzC6kivAIhyfHilFR61RGL+GPXQ2MWZWFYbAGjyiYJnAmCP3NOTd0jMZEnDkbUvxhMmBYSdETk1rRgm+R4LOzFUGaHqHDLKLX+FIPKcF96hrucXzcWyLbIbEgE98OHlnVYCzRdK8jlqm8tehUc9c9WhQ== vagrant insecure public key" /root/authorized_keys && echo "Key already exists." || echo "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEA6NF8iallvQVp22WDkTkyrtvp9eWW6A8YVr+kz4TjGYe7gHzIw+niNltGEFHzD8+v1I2YJ6oXevct1YeS0o9HZyN1Q9qgCgzUFtdOKLv6IedplqoPkcmF0aYet2PkEDo3MlTBckFXPITAMzF8dJSIFo9D8HfdOV0IAdx4O7PtixWKn5y2hMNG0zQPyUecp4pzC6kivAIhyfHilFR61RGL+GPXQ2MWZWFYbAGjyiYJnAmCP3NOTd0jMZEnDkbUvxhMmBYSdETk1rRgm+R4LOzFUGaHqHDLKLX+FIPKcF96hrucXzcWyLbIbEgE98OHlnVYCzRdK8jlqm8tehUc9c9WhQ== vagrant insecure public key" >> /root/authorized_keys
[   6.0] Setting the hostname: foreman_el6-i1
[   6.0] Setting passwords
[   7.0] Finishing off

Starting install...
Creating domain...                                                                                                                                |    0 B  00:00:00     
Domain creation completed. You can restart your domain by running:
  virsh --connect qemu:///system start foreman_el6-i1
  Formatting '/var/lib/libvirt/images/foreman_el6-i2.qcow2', fmt=qcow2 size=10737418240 backing_file='/home/images/rhel6.qcow2' encryption=off cluster_size=65536 lazy_refcounts=off 
  Pool default refreshed

  [   0.0] Examining the guest ...
  [   5.0] Setting a random seed
  [   5.0] Running: fgrep -q "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEA6NF8iallvQVp22WDkTkyrtvp9eWW6A8YVr+kz4TjGYe7gHzIw+niNltGEFHzD8+v1I2YJ6oXevct1YeS0o9HZyN1Q9qgCgzUFtdOKLv6IedplqoPkcmF0aYet2PkEDo3MlTBckFXPITAMzF8dJSIFo9D8HfdOV0IAdx4O7PtixWKn5y2hMNG0zQPyUecp4pzC6kivAIhyfHilFR61RGL+GPXQ2MWZWFYbAGjyiYJnAmCP3NOTd0jMZEnDkbUvxhMmBYSdETk1rRgm+R4LOzFUGaHqHDLKLX+FIPKcF96hrucXzcWyLbIbEgE98OHlnVYCzRdK8jlqm8tehUc9c9WhQ== vagrant insecure public key" /root/authorized_keys && echo "Key already exists." || echo "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEA6NF8iallvQVp22WDkTkyrtvp9eWW6A8YVr+kz4TjGYe7gHzIw+niNltGEFHzD8+v1I2YJ6oXevct1YeS0o9HZyN1Q9qgCgzUFtdOKLv6IedplqoPkcmF0aYet2PkEDo3MlTBckFXPITAMzF8dJSIFo9D8HfdOV0IAdx4O7PtixWKn5y2hMNG0zQPyUecp4pzC6kivAIhyfHilFR61RGL+GPXQ2MWZWFYbAGjyiYJnAmCP3NOTd0jMZEnDkbUvxhMmBYSdETk1rRgm+R4LOzFUGaHqHDLKLX+FIPKcF96hrucXzcWyLbIbEgE98OHlnVYCzRdK8jlqm8tehUc9c9WhQ== vagrant insecure public key" >> /root/authorized_keys
  [   5.0] Setting the hostname: foreman_el6-i2
  [   5.0] Setting passwords
  [   5.0] Finishing off

  Starting install...
  Creating domain...                                                                                                                                |    0 B  00:00:00     
  Domain creation completed. You can restart your domain by running:
    virsh --connect qemu:///system start foreman_el6-i2
    Formatting '/var/lib/libvirt/images/foreman_el6-i3.qcow2', fmt=qcow2 size=10737418240 backing_file='/home/images/rhel6.qcow2' encryption=off cluster_size=65536 lazy_refcounts=off 
    Pool default refreshed

    [   0.0] Examining the guest ...
    [   5.0] Setting a random seed
    [   5.0] Running: fgrep -q "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEA6NF8iallvQVp22WDkTkyrtvp9eWW6A8YVr+kz4TjGYe7gHzIw+niNltGEFHzD8+v1I2YJ6oXevct1YeS0o9HZyN1Q9qgCgzUFtdOKLv6IedplqoPkcmF0aYet2PkEDo3MlTBckFXPITAMzF8dJSIFo9D8HfdOV0IAdx4O7PtixWKn5y2hMNG0zQPyUecp4pzC6kivAIhyfHilFR61RGL+GPXQ2MWZWFYbAGjyiYJnAmCP3NOTd0jMZEnDkbUvxhMmBYSdETk1rRgm+R4LOzFUGaHqHDLKLX+FIPKcF96hrucXzcWyLbIbEgE98OHlnVYCzRdK8jlqm8tehUc9c9WhQ== vagrant insecure public key" /root/authorized_keys && echo "Key already exists." || echo "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEA6NF8iallvQVp22WDkTkyrtvp9eWW6A8YVr+kz4TjGYe7gHzIw+niNltGEFHzD8+v1I2YJ6oXevct1YeS0o9HZyN1Q9qgCgzUFtdOKLv6IedplqoPkcmF0aYet2PkEDo3MlTBckFXPITAMzF8dJSIFo9D8HfdOV0IAdx4O7PtixWKn5y2hMNG0zQPyUecp4pzC6kivAIhyfHilFR61RGL+GPXQ2MWZWFYbAGjyiYJnAmCP3NOTd0jMZEnDkbUvxhMmBYSdETk1rRgm+R4LOzFUGaHqHDLKLX+FIPKcF96hrucXzcWyLbIbEgE98OHlnVYCzRdK8jlqm8tehUc9c9WhQ== vagrant insecure public key" >> /root/authorized_keys
    [   5.0] Setting the hostname: foreman_el6-i3
    [   5.0] Setting passwords
    [   5.0] Finishing off

    Starting install...
    Creating domain...                                                                                                                                |    0 B  00:00:00     
    Domain creation completed. You can restart your domain by running:
      virsh --connect qemu:///system start foreman_el6-i3
      Formatting '/var/lib/libvirt/images/foreman_el6-i4.qcow2', fmt=qcow2 size=10737418240 backing_file='/home/images/rhel6.qcow2' encryption=off cluster_size=65536 lazy_refcounts=off 
      Pool default refreshed

      [   0.0] Examining the guest ...
      [   5.0] Setting a random seed
      [   5.0] Running: fgrep -q "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEA6NF8iallvQVp22WDkTkyrtvp9eWW6A8YVr+kz4TjGYe7gHzIw+niNltGEFHzD8+v1I2YJ6oXevct1YeS0o9HZyN1Q9qgCgzUFtdOKLv6IedplqoPkcmF0aYet2PkEDo3MlTBckFXPITAMzF8dJSIFo9D8HfdOV0IAdx4O7PtixWKn5y2hMNG0zQPyUecp4pzC6kivAIhyfHilFR61RGL+GPXQ2MWZWFYbAGjyiYJnAmCP3NOTd0jMZEnDkbUvxhMmBYSdETk1rRgm+R4LOzFUGaHqHDLKLX+FIPKcF96hrucXzcWyLbIbEgE98OHlnVYCzRdK8jlqm8tehUc9c9WhQ== vagrant insecure public key" /root/authorized_keys && echo "Key already exists." || echo "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEA6NF8iallvQVp22WDkTkyrtvp9eWW6A8YVr+kz4TjGYe7gHzIw+niNltGEFHzD8+v1I2YJ6oXevct1YeS0o9HZyN1Q9qgCgzUFtdOKLv6IedplqoPkcmF0aYet2PkEDo3MlTBckFXPITAMzF8dJSIFo9D8HfdOV0IAdx4O7PtixWKn5y2hMNG0zQPyUecp4pzC6kivAIhyfHilFR61RGL+GPXQ2MWZWFYbAGjyiYJnAmCP3NOTd0jMZEnDkbUvxhMmBYSdETk1rRgm+R4LOzFUGaHqHDLKLX+FIPKcF96hrucXzcWyLbIbEgE98OHlnVYCzRdK8jlqm8tehUc9c9WhQ== vagrant insecure public key" >> /root/authorized_keys
      [   5.0] Setting the hostname: foreman_el6-i4
      [   5.0] Setting passwords
      [   6.0] Finishing off

      Starting install...
      Creating domain...                                                                                                                                |    0 B  00:00:00     
      Domain creation completed. You can restart your domain by running:
        virsh --connect qemu:///system start foreman_el6-i4

        real    0m32.503s
        user    0m4.601s
        sys 0m0.835s

`
