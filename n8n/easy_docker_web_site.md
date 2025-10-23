## Run a web site fast

- DNS resolution:

  - docker exec -it n8n sh -lc 'getent hosts n8n.edcastdev.com || nslookup n8n.edcastdev.com || echo "DNS not resolving"'

- Basic TCP reachability:
  - docker exec -it n8n-n8n-1 sh -lc 'apk add --no-cache curl 2>/dev/null || apt-get update && apt-get install -y curl >/dev/null; curl -vkI https://n8n.edcastdev.com || curl -vI http://n8n.edcastdev.com'

Step 1 — See what package manager you have

```bash
docker exec -it n8n-n8n-1 sh -lc 'which apk || which apt-get || which microdnf || echo "no pkg mgr"'
docker exec -it n8n-n8n-1 sh -lc 'cat /etc/os-release || uname -a'
```

Step 2 — Install a client (only if a package manager exists)

- Alpine (apk):

```bash
docker exec -it n8n-n8n-1 sh -lc 'apk add --no-cache curl ca-certificates && update-ca-certificates'
sudo docker exec -it --user 0 n8n-n8n-1 sh -lc 'apk add --no-cache curl ca-certificates && update-ca-certificates'

docker exec -it n8n sh -lc 'curl -vkI https://n8n.edcastdev.com || curl -vI http://n8n.edcastdev.com'


```

### Inspecting networks

#### for n8n

```bash
docker inspect n8n-n8n-1 --format '{{json .NetworkSettings.Networks}}'
```

Result

```json
{
  "n8n_default": {
    "IPAMConfig": null,
    "Links": null,
    "Aliases": ["n8n-n8n-1", "n8n"],
    "MacAddress": "7a:51:df:79:b2:43",
    "DriverOpts": null,
    "GwPriority": 0,
    "NetworkID": "272179331d5fac646732e8e9f4119342f03b4b8c6aba08ac25d36dc0f6956bf7",
    "EndpointID": "5d3ecf3969c3b927f605ec6f0f394c48ec03db1edf8ba5e68966bf5e413b9af7",
    "Gateway": "172.19.0.1",
    "IPAddress": "172.19.0.2",
    "IPPrefixLen": 16,
    "IPv6Gateway": "",
    "GlobalIPv6Address": "",
    "GlobalIPv6PrefixLen": 0,
    "DNSNames": ["n8n-n8n-1", "n8n", "ebb81efc428e"]
  }
}
```

#### for web site

```bash
docker inspect website --format '{{json .NetworkSettings.Networks}}'
```

Result

```json
{
  "bridge": {
    "IPAMConfig": null,
    "Links": null,
    "Aliases": null,
    "MacAddress": "5e:61:03:9d:c8:e3",
    "DriverOpts": null,
    "GwPriority": 0,
    "NetworkID": "900cf38d7eb5e471bbf8edefa0199e659993eb9a799c0180c6b21687ba26b75f",
    "EndpointID": "9d3bd7a47759ed0aed1ce603e6111288926b2ae966ec44921d4c1794ed8870f6",
    "Gateway": "172.17.0.1",
    "IPAddress": "172.17.0.2",
    "IPPrefixLen": 16,
    "IPv6Gateway": "",
    "GlobalIPv6Address": "",
    "GlobalIPv6PrefixLen": 0,
    "DNSNames": null
  }
}
```
