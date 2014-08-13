#!/bin/bash

repos="RHEL-6-Server-OS-Foreman.repo rhel-x86_64-server-6-rhscl-1.repo rhel-6.5.repo"
(cd /var/www/repos; scp $repos root@$IP:/etc/yum.repos.d/)
