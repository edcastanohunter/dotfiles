
## n8n




## Installing On-prem 

### Pre requisites
- Domain Name 
- Cloudflare Account 
    - Cloudflare Tunnels: tunnel from n8n domain to server


### Cloudflare
- Go to ZeroTrust
    - Network
        - Create a tunnel
            - Cloudflared Option



```bash
# Add cloudflare gpg key
sudo mkdir -p --mode=0755 /usr/share/keyrings
curl -fsSL https://pkg.cloudflare.com/cloudflare-main.gpg | sudo tee /usr/share/keyrings/cloudflare-main.gpg >/dev/null

# Add this repo to your apt repositories
echo 'deb [signed-by=/usr/share/keyrings/cloudflare-main.gpg] https://pkg.cloudflare.com/cloudflared any main' | sudo tee /etc/apt/sources.list.d/cloudflared.list

# install cloudflared
sudo apt-get update && sudo apt-get install cloudflared

## you can install a service to automatically run your tunnel whenever your machine starts:
sudo cloudflared service install eyJhIjoiOTdiNWFmYmJkNGM2MjBlYWI4Nzg0MTA1MzdmMDU3ZGEiLCJ0IjoiZjMwMWRmZDctZjhiNS00OWIwLWJiYTAtZTMwYTU0NDU4NDRjIiwicyI6Ik16QmxPVFE1WXpjdFltTXhZeTAwTlRBMExXRTNNalV0TUdJME4yRXlNRFkzT1dKaiJ9

## Or Run manual  - run the tunnel manually
cloudflared tunnel run --token eyJhIjoiOTdiNWFmYmJkNGM2MjBlYWI4Nzg0MTA1MzdmMDU3ZGEiLCJ0IjoiZjMwMWRmZDctZjhiNS00OWIwLWJiYTAtZTMwYTU0NDU4NDRjIiwicyI6Ik16QmxPVFE1WXpjdFltTXhZeTAwTlRBMExXRTNNalV0TUdJME4yRXlNRFkzT1dKaiJ9

```

### Test 
A section shoul show something as
```bash

Connector ID
1acc68db-13eb-411b-9aad-9be20087eb2d

Status
Connected

Version
2025.10.0
```



sudo docker volume create n8n_data


### Set domain in cloudflare

```
```

## Updating N8N

```bash
### Updating N8n
If you run n8n using a Docker Compose file, follow these steps to update n8n:


# Navigate to the directory containing your docker compose file
cd </path/to/your/compose/file/directory>

# Pull latest version
docker compose pull

# Stop and remove older version
docker compose down

# Start the container
docker compose up -d

```


/etc/nginx/sites-available/n8n.edcastdev.com

ln -s <target> <link_name>
ln -s /etc/nginx/sites-available/n8n.edcastdev.com n8n.edcastdev.com



📄 Official n8n Docs: https://docs.n8n.io
☁️ Sign up for Cloudflare (It’s FREE): https://dash.cloudflare.com
🧰 Docker Install: https://docs.docker.com/engine/instal...
🔐n8n Security Setup: https://docs.n8n.io/security