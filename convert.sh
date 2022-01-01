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

for stick in AnimatedSticker\ \(10\).tgs AnimatedSticker\ \(11\).tgs AnimatedSticker\ \(12\).tgs AnimatedSticker\ \(13\).tgs AnimatedSticker\ \(14\).tgs AnimatedSticker\ \(15\).tgs AnimatedSticker\ \(16\).tgs AnimatedSticker\ \(17\).tgs AnimatedSticker\ \(18\).tgs AnimatedSticker\ \(19\).tgs AnimatedSticker\ \(1\).tgs AnimatedSticker\ \(20\).tgs AnimatedSticker\ \(21\).tgs AnimatedSticker\ \(22\).tgs AnimatedSticker\ \(23\).tgs AnimatedSticker\ \(24\).tgs AnimatedSticker\ \(25\).tgs AnimatedSticker\ \(26\).tgs AnimatedSticker\ \(27\).tgs AnimatedSticker\ \(28\).tgs AnimatedSticker\ \(29\).tgs AnimatedSticker\ \(2\).tgs AnimatedSticker\ \(30\).tgs AnimatedSticker\ \(31\).tgs AnimatedSticker\ \(32\).tgs AnimatedSticker\ \(33\).tgs AnimatedSticker\ \(34\).tgs AnimatedSticker\ \(35\).tgs AnimatedSticker\ \(36\).tgs AnimatedSticker\ \(37\).tgs AnimatedSticker\ \(38\).tgs AnimatedSticker\ \(39\).tgs AnimatedSticker\ \(3\).tgs AnimatedSticker\ \(40\).tgs AnimatedSticker\ \(41\).tgs AnimatedSticker\ \(42\).tgs AnimatedSticker\ \(43\).tgs AnimatedSticker\ \(44\).tgs AnimatedSticker\ \(45\).tgs AnimatedSticker\ \(46\).tgs AnimatedSticker\ \(47\).tgs AnimatedSticker\ \(4\).tgs AnimatedSticker\ \(5\).tgs AnimatedSticker\ \(6\).tgs AnimatedSticker\ \(7\).tgs AnimatedSticker\ \(8\).tgs AnimatedSticker\ \(9\).tgs AnimatedSticker.tgs; do
cat $stick | gzip -d | jq '
    .fr = 60
    | .op *= 2.5
    | .ip *= 2.5
    | .layers[].ip *= 2.5
    | .layers[].op *= 2.5
    | walk( if type == "object" and .t then .t *= 2.5 else . end )
' \
 | tee /dev/stderr | jq -c | gzip > $(basename $stick .tgs)_new.tgs
done
