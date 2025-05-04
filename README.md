# Plex Worker IP Address Lists for MikroTik Firewalls

MikroTik firewall address lists for Plex worker IP address ranges. Refreshed daily at 05:30 UTC. The generated configuration file creates an IPv4 address list named **plex-worker-ips** which can be used in firewall filter/NAT/mangle rules.

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
