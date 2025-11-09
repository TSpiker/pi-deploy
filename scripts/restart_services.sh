#!/bin/bash
# Example service restart script
SERVICES=(ssh apache2)

for svc in "${SERVICES[@]}"; do
  echo "🔄 Restarting $svc..."
  sudo systemctl restart "$svc" || echo "⚠️  $svc not found"
done
