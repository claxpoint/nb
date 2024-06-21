#!/bin/sh

# Get user input for primary and secondary DNS (emphasize both)
echo "** Enter the IP addresses for your primary and secondary DNS servers (optional for secondary):"
read -p "Primary DNS server IP: " PRIMARY_DNS
read -p "Secondary DNS server IP (optional, press Enter to skip): " SECONDARY_DNS

# Clear existing entries in /etc/resolv.conf (important)
sudo sh -c 'echo "" > /etc/resolv.conf'  # Alternative: `sudo truncate -s 0 /etc/resolv.conf`

# Add the primary DNS server
echo "nameserver $PRIMARY_DNS" | sudo tee -a /etc/resolv.conf

# Add the secondary DNS server (if provided)
if [ -n "$SECONDARY_DNS" ]; then
  echo "nameserver $SECONDARY_DNS" | sudo tee -a /etc/resolv.conf
fi

# Print confirmation message in green (temporary)
echo "\e[32mDNS settings changed to: $PRIMARY_DNS\e[0m"

if [ -n "$SECONDARY_DNS" ]; then
  echo "\e[32mand $SECONDARY_DNS\e[0m"
fi
