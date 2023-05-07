#!/bin/bash

set -euxo pipefail

SCRIPT_DIR=$(dirname "$(readlink -f "$0")")

# Export the stickers
# Note that original frame rate, e.g. 24 vs 60 - ratio is 2.5
# Update ratio in the code below to fit whatever you need
# Run the script, upload to the @stickers bot
# If the bot complains about a too long animation or there's flickering,
# try lowering the ratio slightly - it won't be noticeable in the animation
# but in my experience it seems to fix the above two issues

for stick in /tmp/AnimatedSticker.tgs; do
    cat $stick | gzip -d | jq '
        . as $root
        | (60 / .fr) as $f
        | $root 
        | .fr *= 2
        | .op *= ($f | tonumber)
        | .ip *= ($f | tonumber)
        | .layers[].ip *= ($f | tonumber)
        | .layers[].op *= ($f | tonumber)
        | walk( if type == "object" and .t then .t *= ($f | tonumber) else . end )
    ' \
     | tee /dev/stderr | jq -c | gzip > ~/Fast.tgs
done
