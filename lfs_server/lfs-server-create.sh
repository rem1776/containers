#!/bin/bash
# starts a container in background to host a git lfs server
echo "Starting lfs server in docker..."

IP="$1"
PORT="$2"
[ "$IP" == "" ] && IP="0.0.0.0"
[ "$PORT" == "" ] && PORT="8080"

echo "$IP:$PORT"

docker run --rm -p 8080:8080 datopian/giftless               \
  -M -T --threads 2 -p 2 --manage-script-name --callable app \
  --env GIFTLESS_CONFIG_STR="`cat server-conf.yaml`"         \
  --http $IP:$PORT > lfs-server.log 2>&1 &
