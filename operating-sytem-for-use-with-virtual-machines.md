---
title: Operating System for Virtual Machines
layout: recommendation
expires: 2018-01-31 (6 months from now)
---

GDS runs a large fleet of Virtual Machines(VMs) across the programmes and these need a Operating System. This is not a recommendation on what OS to use in a container.



## User needs

- the ability for people to move teams without learning a new OS or distribution
- the ability to know that we are using a secure and maintained OS?

## Principles

- we auto update for security issues
- we keep up to date with the latest releases
- we value stability in our OS.

## Recommendation

If you need to run a VM you should use the latest Ubuntu Long Term Support (LTS) version which has had some security hardening applied. for example: disable root ssh access, disable ssh access via password. 
If you need newer kernels/features running normal Ubuntu is fine but make sure you do release update regularly to make sure it is receiving security updates.

We intend to provide an Amazon Machine Image (AMI) in due course for use by GDS programmes.
