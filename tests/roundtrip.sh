#!/bin/sh
# Round-trip regression test for the rebuilt PVRGMPEG codec.
#
# 1. Decodes the original 1993 SHORT.MPG and confirms all 10 frames decode
#    cleanly.
# 2. Re-encodes a fresh SHORT.MPG from the original source GIFs, using
#    Graham Logan's documented 1993 command line, and decodes it back.
#
# Requires: the built `mpeg` binary (see ../BUILDING.md), ffmpeg, python3.

set -e

HERE="$(cd "$(dirname "$0")" && pwd)"
REPO="$(cd "$HERE/.." && pwd)"
MPEG_BIN="${MPEG_BIN:-$REPO/source/mpeg}"
WORK="$(mktemp -d)"

if [ ! -x "$MPEG_BIN" ]; then
  echo "Build the mpeg binary first (see BUILDING.md). Expected at: $MPEG_BIN"
  exit 1
fi

echo "== Test 1: decode original 1993 SHORT.MPG =="
cd "$WORK"
cp "$REPO/original-1993-release/SHORT.MPG" .
"$MPEG_BIN" -d -s SHORT.MPG out
FRAMES=$(ls out*.Y 2>/dev/null | wc -l)
if [ "$FRAMES" -ne 10 ]; then
  echo "FAIL: expected 10 decoded frames, got $FRAMES"
  exit 1
fi
echo "PASS: decoded $FRAMES frames from the original 1993 file"

echo
echo "== Test 2: re-encode from source GIFs and round-trip =="
cp "$REPO/original-1993-release"/SHORT*.GIF .

i=0
while [ $i -le 5 ]; do
  ffmpeg -y -loglevel error -i SHORT$i.GIF -vf scale=160:120 -pix_fmt yuv420p -f rawvideo SHORT$i.yuv420p
  python3 - "$i" << 'PYEOF'
import sys
i = sys.argv[1]
w, h = 160, 120
data = open(f"SHORT{i}.yuv420p", "rb").read()
ysize = w * h
csize = (w // 2) * (h // 2)
y = data[:ysize]; u = data[ysize:ysize+csize]; v = data[ysize+csize:ysize+2*csize]
open(f"short{i}.Y", "wb").write(y)
open(f"short{i}.U", "wb").write(u)
open(f"short{i}.V", "wb").write(v)
PYEOF
  i=$((i + 1))
done

# ping-pong loop: 6<-4, 7<-3, 8<-2, 9<-1 (per USEMPEG.TXT)
for pair in 6:4 7:3 8:2 9:1; do
  dst=${pair%%:*}; src=${pair##*:}
  cp short$src.Y short$dst.Y; cp short$src.U short$dst.U; cp short$src.V short$dst.V
done

"$MPEG_BIN" -XING -a 0 -b 9 short -s short_rebuilt.mpg > /dev/null
"$MPEG_BIN" -d -s short_rebuilt.mpg rebuilt_out > /dev/null

FRAMES2=$(ls rebuilt_out*.Y 2>/dev/null | wc -l)
if [ "$FRAMES2" -ne 10 ]; then
  echo "FAIL: expected 10 decoded frames from rebuilt encode, got $FRAMES2"
  exit 1
fi
echo "PASS: re-encoded short_rebuilt.mpg and decoded $FRAMES2 frames"
echo
echo "Compare rebuilt_out*.Y/.U/.V against out*.Y/.U/.V (or render with"
echo "ffmpeg, see BUILDING.md) to visually confirm frames match."
echo
echo "Working files left in: $WORK"
