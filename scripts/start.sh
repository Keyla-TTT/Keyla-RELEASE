#!/bin/bash
mkdir -p /data/db
chown -R mongodb:mongodb /data/db || true
mongod --bind_ip 0.0.0.0 --dbpath /data/db --logpath /var/log/mongodb.log --fork >/dev/null 2>&1
if [ -t 0 ]; then
  exec /bin/bash
fi
if [ -d /app/assets ]; then
  cd /app/assets || true
  if compgen -G "api-scala-*/bin" > /dev/null; then
    cd api-scala-*/bin || true
    ./Keyla-api </dev/null >/dev/null 2>&1 &
    cd ../.. || true
  fi
fi
tail -f /var/log/mongodb.log
