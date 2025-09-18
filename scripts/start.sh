#!/bin/bash
cd /app/assets
cd api-scala-*/bin
./Keyla-api > /dev/null 2>&1 &
cd ../..
exec /bin/bash
