#!/bin/bash
mkdir -p /data/db
chown -R mongodb:mongodb /data/db || true
mongod --bind_ip 0.0.0.0 --dbpath /data/db --logpath /var/log/mongodb.log --fork >/dev/null 2>&1
(
  if command -v mongosh >/dev/null 2>&1; then
    for i in {1..15}; do
      if mongosh --quiet --eval 'db.runCommand({ ping: 1 })' | grep -q '"ok"\s*:\s*1'; then
        break
      fi
      sleep 1
    done
  else
    sleep 2
  fi
  if [ -d /app/assets ]; then
    cd /app/assets || true
    if compgen -G "api-scala-*/bin" > /dev/null; then
      cd api-scala-*/bin || true
      ./Keyla-api > /dev/null 2>&1 &
      cd ../.. || true
    fi
  fi
) &
exec /bin/bash
