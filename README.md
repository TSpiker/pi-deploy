# Pi-Deploy

Automated Raspberry Pi deployment and configuration toolkit.

## Usage
### Initial setup (first boot via cloud-init)
```bash
#cloud-config
runcmd:
  - git clone https://github.com/TSpiker/pi-deploy.git /opt/pi-deploy
  - bash /opt/pi-deploy/setup_pi.sh
```

### Manual operation
```bash
cd /opt/pi-deploy
make setup     # run full setup
make update    # pull repo updates
make pull      # pull + refresh Python deps
make clean     # remove logs
```
