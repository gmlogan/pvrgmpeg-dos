# Building PVRGMPEG

There are two ways to build this: a period-accurate DOS build (matching the
original 1993 toolchain exactly), and a modern native build (for testing and
day-to-day use). Both build from the same source in `source/`, after applying
`patches/dos-binary-mode.patch`.

## 1. Apply the patch

```
cd pvrgmpeg-dos
patch -p1 < patches/dos-binary-mode.patch
```

This changes the seven `fopen()` calls in `source/mem.c`, `source/stream.c`
and `source/mpeg.c` from text mode (`"r"`, `"w"`, `"w+"`) to binary mode
(`"rb"`, `"wb"`, `"wb+"`). DOS/DJGPP compilers default to text mode, which
silently corrupts binary YUV/MPEG data on read and write; Unix compilers
default to binary mode already, so this patch is a no-op there but essential
for DOS.

## 2. Period-accurate DOS build (DJGPP)

This reproduces Graham Logan's original June 1993 build as closely as
possible.

**Tools required:**
- [DOSBox](https://www.dosbox.com/) (to run a DOS environment)
- [DJGPP](https://www.delorie.com/djgpp/) — GNU C for DOS (GCC 2.2.2 was the
  original; any early DJGPP release will produce an equivalent binary)
- `go32.exe`, DJGPP's DOS extender loader, included with DJGPP

**Steps (from the original `MAKEMPEG.TXT`):**

```
REM Compile each of the 12 source files to an object file
gcc -O -c chendct.c
gcc -O -c codec.c
gcc -O -c huffman.c
gcc -O -c io.c
gcc -O -c lexer.c
gcc -O -c marker.c
gcc -O -c me.c
gcc -O -c mem.c
gcc -O -c mpeg.c
gcc -O -c stat.c
gcc -O -c stream.c
gcc -O -c transform.c

REM Link
gcc lexer.o mpeg.o huffman.o transform.o codec.o io.o marker.o me.o mem.o stat.o stream.o chendct.o -lgcc -lm -o pvrgmpeg

REM Bundle the DOS extender to produce a standalone .EXE
copy /b go32.exe+pvrgmpeg pvrgmpeg.exe
```

Two filenames exceed DOS 8.3 limits and need local renaming before this step:
`transform.c` → `transfor.c`, `prototype.h` → `prototyp.h` (or build under
DJGPP's long-filename-tolerant environment, which sidesteps this).

## 3. Modern native build (Linux/macOS, gcc)

Confirmed working with GCC 13 on Linux. Two flags are needed to work around
behaviour changes in modern GCC (implicit `-fno-common` since GCC 10, and
stricter C99 `inline` semantics vs. the old GNU89 default the code assumes):

```
cd source
patch -p2 < ../patches/dos-binary-mode.patch   # optional on Unix, harmless
make MFLAGS="-O -fcommon -fgnu89-inline"
```

This produces a native `mpeg` binary implementing the same encoder/decoder,
usable for testing, verification, or as a modern CLI tool.

**Gotcha:** `lexer.c` is a large, partly hand-augmented file, not a plain
`flex`/`lex` output — GNU Make's built-in implicit rule will try to
regenerate it from `lexer.l` with `lex` if it looks out of date, and a plain
`flex` regeneration will produce a `lexer.c` missing several hand-written
functions (`Execute`, `Memory`, `parser`, `initparser`), causing link errors.
If you hit undefined-reference errors for those symbols, restore `lexer.c`
from this repo and `touch lexer.c` (to post-date `lexer.l`) before building.

## 4. Usage (from the original USEMPEG.TXT)

To encode a 10-frame "short" demo movie in Xing-compatible format from GIF
source frames:

```
# 1. Convert GIFs to 160x120 raw planar YUV 4:2:0 (.Y/.U/.V per frame)
#    Originally: Image Alchemy or giftoppm + ppm2cyuv
#    (see tests/roundtrip.sh for a modern ffmpeg-based equivalent)

# 2. Build a "ping-pong" 10-frame sequence for smooth looping:
#    frames 0,1,2,3,4,5 -> 0,1,2,3,4,5,4,3,2,1

# 3. Encode
pvrgmpeg -XING -a 0 -b 9 short -s short.mpg

# 4. Decode (sanity check / playback prep)
pvrgmpeg -d -s short.mpg out
```
