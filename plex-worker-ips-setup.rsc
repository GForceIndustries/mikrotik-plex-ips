/system script
add dont-require-permissions=yes name=plex-worker-ips owner=admin policy=ftp,read,write,test source=":log info \"Download Plex Worker IP list\";\r\
    \n/tool fetch url=\"https://raw.githubusercontent.com/GForceIndustries/mikrotik-plex-ips/refs/heads/main/plex-worker-ips.rsc\" mode=https dst-path=plex-worker-ips.rsc;\r\
    \n\r\
    \n:log info \"Remove current Plex worker IPs\";\r\
    \n/ip firewall address-list remove [find where list=\"plex-worker-ips\"];\r\
    \n:log info \"Import newest Plex worker IPs\";\r\
    \n/import file-name=plex-worker-ips.rsc;"
/system scheduler
add interval=1d name=plex-worker-ips on-event=plex-worker-ips policy=ftp,read,write,test start-date=2025-04-23 start-time=06:45:00
