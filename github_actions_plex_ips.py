from datetime import datetime, UTC
import requests

today = datetime.now(UTC).strftime("%c") + " UTC"

plexIpsURL = "https://s3-eu-west-1.amazonaws.com/plex-sidekiq-servers-list/sidekiqIPs.txt"

def generateRsc():
    fileData = requests.get(plexIpsURL).content

    writer = open("plex-worker-ips.rsc", "w")
    writer.write("# Generated on " + today)

    writer.write("\n/ip firewall address-list")

    for line in fileData.splitlines():
        ip = str(line.decode("utf-8"))
        writer.write("\nadd list=plex-worker-ips address=" + ip)
    
    writer.close()

def main():
    generateRsc()

if __name__ == "__main__":
    main()
