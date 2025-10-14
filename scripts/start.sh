#!/bin/bash
mkdir -p /data/db
chown -R mongodb:mongodb /data/db || true
mongod --bind_ip 0.0.0.0 --dbpath /data/db --logpath /var/log/mongodb.log --fork >/dev/null 2>&1
touch /var/log/keyla-api.log /var/log/mongodb.log
if [ -d /app/assets ]; then
  cd /app/assets || true
  if compgen -G "api-scala-*/bin" > /dev/null; then
    cd api-scala-*/bin || true
    setsid nohup ./Keyla-api </dev/null >/var/log/keyla-api.log 2>&1 &
    cd ../.. || true
  fi
fi
if [ -t 0 ]; then
  stty sane || true
  stty echo icanon || true
  exec /bin/bash
fi
tail -F /var/log/mongodb.log /var/log/keyla-api.log
