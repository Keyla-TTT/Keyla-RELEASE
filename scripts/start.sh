#!/bin/bash
set -euo pipefail

# Ensure data dir exists and proper permissions
mkdir -p /data/db
chown -R mongodb:mongodb /data/db || true

# Start MongoDB in background
mongod --bind_ip 0.0.0.0 --dbpath /data/db --logpath /var/log/mongodb.log --fork

# Wait for MongoDB to be ready
for i in {1..30}; do
  if mongosh --quiet --eval 'db.runCommand({ ping: 1 })' | grep -q '"ok"\s*:\s*1'; then
    break
  fi
  sleep 1
done

cd /app/assets
cd api-scala-*/bin
./Keyla-api > /dev/null 2>&1 &
cd ../..

# Keep container running
tail -f /var/log/mongodb.log
