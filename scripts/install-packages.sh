#!/bin/bash

packages=(
    htop
    btop
    yazi
    xclip # pbcopy for linux distros
    postgresql-client # self explanatory
)

for package in ${packages[@]}; do
    yay -S --noconfirm ${package}
done

# chmod +x install-package.sh

## sudo apt update && sudo apt install xclip
# alias pbcopy='xclip -selection clipboard'

# export PGSSLROOTCERT="~/.postgresql/root.crt"
# sudo cp local-ca.crt /usr/local/share/ca-certificates


# Create PostgreSQL SSL directory
mkdir -p ~/.postgresql

# Download the current AWS RDS CA certificate
wget https://truststore.pki.rds.amazonaws.com/global/global-bundle.pem -O ~/.postgresql/root.crt

# Set proper permissions
chmod 600 ~/.postgresql/root.crt

# Set environment variable
export PGSSLROOTCERT="$HOME/.postgresql/root.crt"
export PGSSLMODE="verify-ca"


psql -h localhost -p 5432 -U postgres -d publish_product -f /mnt/c/Temp/ps_product_prod_pse_publish_product_db2025-09-09_16-42-16.schema
pg_restore -h localhost -p 5432 -U postgres -W -d publish_product -f /mnt/c/Temp/ps_product_prod_pse_publish_product_db2025-09-09_16-42-16.schema

