# Oracle Free Tier Adguard Unbound WireGuard Solution 
This solution  is a combination of Adguard, wireguard, and unbound , read https://fnazz.medium.com/safe-internet-with-adguard-unbound-and-wireguard-ee912808c7a8 

This repo provides full terraform code for automated deployment. Just update template.tfvars to your tenancy and you are good to proceed.

## Installation

Basic Usage:

```bash
$ git clone https://github.com/fnazz/oracle-tf-adguard-unbound-wireguard.git
$ cd oracle-freetier-tf-adguard-unbound-wireguard

```

## Usage

- Generate api keys and ocids, refer to https://docs.oracle.com/en-us/iaas/Content/API/Concepts/apisigningkey.htm
- update template.tfvars to the values derived from above.
- ensure to choose the correct region and image id as they are specific to the region you plan to deploy.

```bash
$ source template.tfvars
$ terraform init
$ # Fill in .tfvars file
$ terraform plan
$ terraform apply
```
### Following resources are created
- Compartment - "adguard"
- buckets ADGUARD_BUCKET and ADGUARD_ARCHIVE_BUCKET
- policies and dynamic groups to allow stream of log files from compute to ADGUARD_BUCKET based on auth_principal
-  Networking resources, VCN/Subnet/etc
- ubuntu OS
- Install all the all required packages and bring up docker services.

#### docker-compose successful output:
```bash
null_resource.adguard_configure (remote-exec): [cont-init.d] 10-adduser: exited 0.
null_resource.adguard_configure (remote-exec): [cont-init.d] 30-config: executing...
null_resource.adguard_configure (remote-exec): Uname info: Linux b02baef25a3b 5.4.0-1037-oracle #40-Ubuntu SMP Thu Jan 14 09:19:02 UTC 2021 x86_64 x86_64 x86_64 GNU/Linux
null_resource.adguard_configure (remote-exec): **** It seems the wireguard module is already active. Skipping kernel header install and module compilation. ****
null_resource.adguard_configure (remote-exec): **** Server mode is selected ****
null_resource.adguard_configure (remote-exec): **** SERVERURL var is either not set or is set to "auto", setting external IP to auto detected value of 158.101.102.166 ****
null_resource.adguard_configure (remote-exec): **** External server port is set to 51820. Make sure that port is properly forwarded to port 51820 inside this container ****
null_resource.adguard_configure (remote-exec): **** Internal subnet is set to 10.6.0.0 ****
null_resource.adguard_configure (remote-exec): **** AllowedIPs for peers 0.0.0.0/0, ::/0 ****
null_resource.adguard_configure (remote-exec): **** Peer DNS servers will be set to 10.2.0.100 ****
null_resource.adguard_configure (remote-exec): **** No wg0.conf found (maybe an initial install), generating 1 server and 1 peer/client confs ****
null_resource.adguard_configure (remote-exec): grep: /config/peer*/*.conf: No such file or directory
null_resource.adguard_configure (remote-exec): PEER 1 QR code:
null_resource.adguard_configure (remote-exec): █████████████████████████████████████████████████████████████████
null_resource.adguard_configure (remote-exec): █████████████████████████████████████████████████████████████████
null_resource.adguard_configure (remote-exec): ████ ▄▄▄▄▄ █▄▄    ▄██▀▀ ▀▀▄▄  █▄▀▀▄█▀ ▀▀▄▄█ █▄ ███▄ ██ ▄▄▄▄▄ ████
null_resource.adguard_configure (remote-exec): ████ █   █ █ ▄█▀▄██▄▄█ ██▀▄ ▀ ▀ █ ▀ ▄▀█  ▀█ █▀ ▀▄█▄ ██ █   █ ████
null_resource.adguard_configure (remote-exec): ████ █▄▄▄█ █▄█ ▄▄█ ▀▀ █ ▀█▀ █▀ ▄▄▄  ▀▄█▄██ ▀▄█▀ █▄▀▄██ █▄▄▄█ ████
null_resource.adguard_configure (remote-exec): ████▄▄▄▄▄▄▄█▄▀▄█▄▀ █▄▀▄▀▄▀ ▀▄█ █▄█ █ █▄▀ ▀ ▀▄█▄▀ █▄▀▄█▄▄▄▄▄▄▄████
null_resource.adguard_configure (remote-exec): ████▄ ▄ █▀▄▀▄█▄ █▄▀ █ █ ▄▄▄  ▄  ▄   ▀ █▄▄██▀█▀▄▄█   ▀▄█▀▄▄▄█▄████
null_resource.adguard_configure (remote-exec): ████▄ ▀▄█▄▄▄█ ▀ █ ▀█▀ ██▀▄▄█▀▄▄▀▀█▄█ █▀▄██▄ █▄█ ▄█▄▀▀▄██▄▀▄▄ ████
null_resource.adguard_configure (remote-exec): ████▄ ▀▀▄▀▄ ▀█ ▄█▄ ▀██▄█▀█▄▀ ▀████▀▄█ ▄ ▄█ ██ █▄█ ▄▀▄ ▀█▀▀ ▄█████
null_resource.adguard_configure (remote-exec): ████▄▀▀███▄▄██▀▀▀▄█▀█▀█ ▀▄▄█▀███ ▀▀▀ █▀█▄ ▄▄▀▀  █▀  ██▄▀▄▄▀▀█████
null_resource.adguard_configure (remote-exec): ████ ▀▄  █▄▄▄ ▄█ ▀ ▀  ▀▄█▄▀ ▄▀▀▄▄▀█▀ ▄▀▄█▄▄ ██▄▄▄ ▀ █▄▄█▀█▄▄ ████
null_resource.adguard_configure (remote-exec): ████ █▄▄▀▄▄█▄  ▀ ▀▀██▀▀▀ ▀█▄██▀▄█ ▀█▀▄ ▄▄█▄▄▀▄▀ ▄ █▀▄  █ ███▀████
null_resource.adguard_configure (remote-exec): ████▄▄   ▄▄█▀ ▄▄  ██  ▀██ ▄▀██▄ ▄▀ ▀███▄█ █▀▄█▀▀█▄█▀  ▄▄ ▀▄ █████
null_resource.adguard_configure (remote-exec): ████▄▄ ▄▀█▄▀ ██ ▄█▀▀▄▄█ ▄▄▀  ▀ █▄ █▄ ▄▀▄▄███▀▀▄  ██▄███▀▄▀▄▄▄████
null_resource.adguard_configure (remote-exec): █████▀ ▀▄ ▄▀█▀▀    ▄▄  ▀ ▀██▄█▄ ▀█▄▄▄  █ ▄ █▀█▀█  ███▀  █▀▀█▀████
null_resource.adguard_configure (remote-exec): ████▀▀▄▀ ▄▄▄  ▀ ██ █▄▄▄▀██▄█▀  ▄▄▄ ▄▀▀▀█▀▀   █▀▄▀ ▄▀ ▄▄▄  ▀▀█████
null_resource.adguard_configure (remote-exec): ████▀▀ █ █▄█ ▀▀▀█ ▀  █▄█▄▀▀▀██ █▄█ ▄▄ ▀█▀▀█ ▀▄█ ▄ ▀  █▄█ ▄▄▄ ████
null_resource.adguard_configure (remote-exec): ████▄▄ ▄ ▄▄▄  █▄▄▀▀▀████▀▄▀ ▄█ ▄▄▄  ██▄▄▀ ▄  ▄▀▄▀ ▄  ▄▄▄ █▄▄▀████
null_resource.adguard_configure (remote-exec): █████▄▀ ▀▀▄████ ▀▄▀██▀█ ▄█  ▀▄█▀███▄█▀▄▄█ ▄▄▄▄▀█████▄ ▄▄█ ▄ █████
null_resource.adguard_configure (remote-exec): ████▄██ ▄▀▄▄ ▄██▄  ▀█  ▄██▀█▀▀  █▄█▀▀▄ ▄█▄ ▀▄▄█   ▀  ▀  ▀ █▄ ████
null_resource.adguard_configure (remote-exec): ████ ██ █▄▄▄ ▀ █▄▄▀██▄▄▀█   ▄▄█▄ ██▄▀ █▀ ▄  █▄█▄█ █ █▄█▄▀▀█ █████
null_resource.adguard_configure (remote-exec): ████▄█▄▄▀█▄▄▄▄▄▀█ █ ▄ ▄  ▄▄▄▀▄▄ █████▀▄█▀█▄█▄  ▄▀ ▀ ▀ ▀▄ ▄ ██████
null_resource.adguard_configure (remote-exec): █████▄█▀▀▀▄▄▀██ █ ▄  █▀█▄▀█▀▄▀▄▀▀███ ▄ ▄▀▀█▄█  ▄█▀ ▄ █▄▀▀ ▀█▄████
null_resource.adguard_configure (remote-exec): █████▄██ █▄ ▄█▀▀     █▄█▄█ ▀▀█▀▀▀ ▄▀█ █▀▄█▀▀▀▄▀▀█ █▄ ▄██▄██▀ ████
null_resource.adguard_configure (remote-exec): ████ ▀   █▄▄▀█▄▄▄█ ██▀▀▄█ █▀▀██▄▄▀█▄▀██ ▀▄██▄▄▀███▄█▄██ █  ▀▄████
null_resource.adguard_configure (remote-exec): ████ ▀ ▀▀▄▄█ ▀██▄▀▀ ▀ ██▄▄▀▀█  ▀▄███ ▀   ▀██▄▄ ▄▄█  ▀▄▄▀▀▀█  ████
null_resource.adguard_configure (remote-exec): ██████████▄█▀  ▀█▄  █  ▀▀███▄  ▄▄▄ ▀▀██▄ ▀▀████▄▀▀██ ▄▄▄ ▀ █▄████
null_resource.adguard_configure (remote-exec): ████ ▄▄▄▄▄ ██▄ █▀█ ▄▄█▀█  ▄▄▀▀ █▄█  ▀ █ ▄▄ ▄▀▀▀ ▀▄▄▄ █▄█  ▀▀█████
null_resource.adguard_configure (remote-exec): ████ █   █ █▀█▄▄█▄▄▀██▀ ▄█▀ ▀█▄ ▄▄▄▄▄ ▀▄▀█▄█▀ ▄ ▄ ▀▄  ▄▄▄▄▄▀▄████
null_resource.adguard_configure (remote-exec): ████ █▄▄▄█ █ ▀ ▄ ▀█  ██▄▀▀▄█▀ █▄█ ▀███▄▄█▄▀ ▀█▄▄▀▄█▀ █▀██▀▄█▀████
null_resource.adguard_configure (remote-exec): ████▄▄▄▄▄▄▄█▄▄▄▄█▄███▄█▄██▄█████▄█▄█▄██▄▄█▄▄▄▄▄▄██▄███▄▄▄▄▄██████
null_resource.adguard_configure (remote-exec): █████████████████████████████████████████████████████████████████
null_resource.adguard_configure (remote-exec): █████████████████████████████████████████████████████████████████
null_resource.adguard_configure (remote-exec): [cont-init.d] 30-config: exited 0.
null_resource.adguard_configure (remote-exec): [cont-init.d] 90-custom-folders: executing...
null_resource.adguard_configure (remote-exec): [cont-init.d] 90-custom-folders: exited 0.
null_resource.adguard_configure (remote-exec): [cont-init.d] 99-custom-scripts: executing...
null_resource.adguard_configure (remote-exec): [custom-init] no custom files found exiting...
null_resource.adguard_configure (remote-exec): [cont-init.d] 99-custom-scripts: exited 0.
null_resource.adguard_configure (remote-exec): [cont-init.d] done.
null_resource.adguard_configure (remote-exec): [services.d] starting services
null_resource.adguard_configure (remote-exec): [services.d] done.
null_resource.adguard_configure (remote-exec): [#] ip link add wg0 type wireguard
null_resource.adguard_configure (remote-exec): [#] wg setconf wg0 /dev/fd/63
...

Apply complete! Resources: 1 added, 0 changed, 1 destroyed.

Outputs:

adguard_archive_bucket_id = "n/<ns>/b/ADGUARD_ARCHIVE_BUCKET"
adguard_bucket_id = "n/<ns>/b/ADGUARD_BUCKET"
adguard_compartment_ocid = "ocid1.compartment.oc1..xxxxxx"
compartment_name = "adguard"
connect_with_ssh = "ssh -o ProxyCommand='ssh -W %h:%p -p 443 ocid1.instanceconsoleconnection.oc1.iad.xxx@instance-console.us-ashburn-1.oci.oraclecloud.com' ocid1.instance.oc1.iad.xxx"
connect_with_vnc = "ssh -o ProxyCommand='ssh -W %h:%p -p 443 ocid1.instanceconsoleconnection.oc1.iad.xxxx@instance-console.us-ashburn-1.oci.oraclecloud.com' -N -L localhost:5900:ocid1.instance.oc1.iad.xxx:5900 ocid1.instance.oc1.iad.xxxxx"
dynamicPolicies = tolist([
  "Allow dynamic-group adguard_dyn_group to read instances in compartment adguard",
  "Allow dynamic-group adguard_dyn_group to inspect instances in compartment adguard",
  "Allow dynamic-group adguard_dyn_group to manage objects in compartment adguard",
])
instance_id = [
  "ocid1.instance.oc1.iad.xxxx",
]
private_ip = [
  "10.1.0.xx",
]
public_ip = [
  "x.x.x.x",
]
```

## Recommended configuration / Split tunnel:

Modify your wireguard client configuring `AllowedIps` to `10.2.0.0/24` to only tunnel the web panel and DNS traffic.

## Access Adguard Interface

While connected to WireGuard, navigate to http://10.2.0.100:3000

Perform the first time setup , once successful setup, login will looks like: 
![Adguard Admin Interface](https://i.imgur.com/LG1sQBi.png)

## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

Please make sure to update tests as appropriate.
