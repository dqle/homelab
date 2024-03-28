## HomeLab - Overview

Hardware:
- Minisforum UM790 Pro
- Crucial 96GB (2x48GB) DDR5 SODIMM RAM
- Kingston NV2 1TB M.2 NVMe SSD

Software:
- Proxmox - 3 Nodes K3S Cluster (https://www.rancher.com/products/k3s)
```
K3S-MASTER     - 4 cores 16GB RAM
K3S-WORKER-01  - 4 cores 36GB RAM
K3S-WORKER-02  - 4 cores 36GB RAM
```

## Cluster Software

| Name  | Directory | Description |
| ----- | --------- | ----------- |
| MetalLB| `./metallb` | load-balancer implementation for k3s cluster |
| Nginx Ingress Controller | `nginx-ingress` | ingress controller for k3s cluster |
| Palworld Dedicated Server  | `./palworld`  | Hosting [Palworld](https://store.steampowered.com/app/1623730/Palworld/) Dedicated Server  |