# Plex Worker IP Address Lists for MikroTik Firewalls

MikroTik firewall address lists for Plex worker IP address ranges. Refreshed daily at 05:30 UTC. The generated configuration file creates an IPv4 address list named **plex-worker-ips** which can be used in firewall filter/NAT/mangle rules.

Developed and tested on RouterOS 7.18.2

## Usage

Create a script to download **plex-worker-ips.rsc**, remove any existing entries in the **plex-worker-ips** address list, and import the new address list. Then, create a schedule to run the script at an appropriate time for your environment. You can either configure these manually, or download and import **plex-worker-ips-setup.rsc** to create them automatically. Read on for a sample script and schedule if you want to configure these manually. If you create the script and schedule manually, they require **ftp**, **read**, **write** and **test** permissions.

### Sample Script

```
:log info "Download Plex Worker IP list";
/tool fetch url="https://raw.githubusercontent.com/GForceIndustries/mikrotik-plex-ips/refs/heads/main/plex-worker-ips.rsc" mode=https dst-path=plex-worker-ips.rsc;

:log info "Remove current Plex worker IPs";
/ip firewall address-list remove [find where list="plex-worker-ips"];
:log info "Import newest Plex worker IPs";
/import file-name=plex-worker-ips.rsc;
```

### Sample Schedule

```
/system scheduler
add interval=1d name=plex-worker-ips on-event=plex-worker-ips policy=ftp,read,write,test start-date=2025-04-23 start-time=06:45:00
```

## Licence & Warranty

You are free to use the provided MikroTik configuration files to aid in maintaining your firewall configuration. You are free also to clone the repository and adapt the code that generates the daily files to suit your needs.

Configuration files are provided without warranty. While they are offered in good faith, no assurance is offered that they are appropriate for your environment and no liability will is accepted for any outcomes of their use. You are responsible for examining the configuration provided and ascertaining that it is suitable for your use case.

While the daily configuration files are generated using information provided by Plex Inc., they are 100% unofficial and are not endorsed or maintained by Plex Inc.
