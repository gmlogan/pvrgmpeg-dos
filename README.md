# PVRGMPEG (DOS) — 1993 port, recovered and rebuilt

A DOS port of Stanford's public-domain **PVRG-MPEG** codec, originally
written and released by Graham Logan in June 1993. This repository
recovers the original 1993 release from a surviving FTP mirror, documents
its history, and provides a verified, working build process — both a
period-accurate DOS build and a modern native build — 30+ years later.

## Contents

- [`original-1993-release/`](original-1993-release/) — the exact 1993
  `PVRGMPEG.ZIP` contents: `PVRGMPEG.EXE`, `PPM2CYUV.EXE`, `CYUV2PPM.EXE`,
  the original `README.1ST` / `MAKEMPEG.TXT` / `USEMPEG.TXT`, and the demo
  clip (`SHORT.MPG` + source GIFs).
- [`source/`](source/) — the surviving PVRG-MPEG v1.2.x codec source,
  vendored in (public domain — see [NOTICE](NOTICE)).
- [`patches/dos-binary-mode.patch`](patches/dos-binary-mode.patch) — the
  three-file patch documented in the original `MAKEMPEG.TXT`, recreated
  and verified to apply cleanly.
- [`BUILDING.md`](BUILDING.md) — how to build it, both the period-accurate
  DJGPP/DOS way and a modern native way.
- [`tests/roundtrip.sh`](tests/roundtrip.sh) — automated test: decodes the
  original 1993 `SHORT.MPG`, and re-encodes/decodes from the original
  source GIFs. Both confirmed passing against a fresh 2026 build.
- [`HISTORY.md`](HISTORY.md) — the full story, with links to every
  primary source: the Usenet FAQ entry, the surviving FTP mirror, the
  official PVRG acknowledgements, and the surviving codec source.
- [`docs/mpeg-faq-1993.md`](docs/mpeg-faq-1993.md) — short excerpt of the
  1993 Usenet FAQ entry that documents this release, with a link to the
  full archived FAQ.

## Quick start

```sh
git clone <this repo>
cd pvrgmpeg-dos
patch -p1 < patches/dos-binary-mode.patch
cd source
make MFLAGS="-O -fcommon -fgnu89-inline"
cd ..
MPEG_BIN=source/mpeg sh tests/roundtrip.sh
```

See [BUILDING.md](BUILDING.md) for the full period-accurate DOS/DJGPP
build path.

## License

Graham Logan's own work here (the 1993 port, patch, build scripts, tests,
docs) is dedicated to the public domain — see [LICENSE](LICENSE). The
vendored PVRG-MPEG codec source carries its own public-domain terms with
one attribution condition — see [NOTICE](NOTICE).
