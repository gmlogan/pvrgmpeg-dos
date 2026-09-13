# History

In June 1993, Graham Logan — then at Dundee Institute of Technology (now
Abertay University) — ported the Portable Video Research Group's (PVRG)
public-domain MPEG-1 codec from Unix to DOS, and released it as
`PVRGMPEG.ZIP` on Usenet and via anonymous FTP.

## Timeline

- **14 June 1993** — `PVRGMPEG.ZIP` uploaded to FTP archives (earliest
  surviving timestamp found: `files.mpoli.fi`, a Finnish FTP/BBS archive).
- **15 June 1993** — Announced on Usenet (likely `comp.compression`) from
  `glogan@taynet.co.uk`, crediting the PVRG group, and thanking Jelle van
  Zeijl for passing on a Xing-compatibility patch originally written by
  Mats Löfqvist.
- The post and archive listing were subsequently folded into Frank
  Gadegast's periodic **"MPEG-FAQ: multimedia compression"**, a
  Usenet FAQ posted to `comp.compression` and `news.answers` and mirrored
  across the early web.
- Graham Logan is also listed by name in the **official PVRG-MPEG
  acknowledgements**, alongside contributors including Frank Gadegast,
  Chad Fogg, Mats Löfqvist, and Jelle van Zeijl.
- `havefun.stanford.edu`, the original FTP host for the PVRG codec source,
  went offline after the PVRG group's charter ended in 1994; the exact
  source tarballs Graham built against (`MPEGv1.2.alpha.tar.Z`,
  `MPEGDOCv1.1.tar.Z`) no longer survive as standalone files anywhere we
  could find. The successor release, `MPEGv1.2.2.tar.Z`, does survive and
  is vendored into `source/` here (see `source/PROVENANCE.md`).
- **2026** — This repository was assembled: the original 1993 release
  recovered from a surviving FTP mirror, verified byte-for-byte against
  the Usenet-FAQ-quoted README/porting notes, and confirmed to still
  build and correctly encode/decode after 30+ years (see
  `tests/roundtrip.sh`).

## Primary sources

- **The MPEG-FAQ entry** naming this release and quoting the original
  README/MAKEMPEG.TXT/USEMPEG.TXT in full:
  [opennet.ru mirror, part 5/9](https://www.opennet.ru/docs/FAQ/multimedua/mpeg-faq/part5.html)
  — short excerpt reproduced in `docs/mpeg-faq-1993.md`.

- **The surviving original archive**, `PVRGMPEG.ZIP` (344 KB, dated
  1993-06-14), on a mirror of the old Finnish `files.mpoli.fi` FTP/BBS
  archive:
  [ftp.zx.net.nz mirror](https://ftp.zx.net.nz/pub/archive/files.mpoli.fi/pub/software/DOS/GRAPHICS/PVRGMPEG.ZIP)
  — contents reproduced verbatim in `original-1993-release/` (with the
  unrelated Metropoli BBS advertisement executable, `STARPRT2.EXE`,
  omitted as not part of the original release).

- **The official PVRG-MPEG README and acknowledgements**, naming Graham
  Logan and Jelle van Zeijl as contributors, preserved by the HP-UX
  Porting & Archive Centre:
  [hpux.connect.org.uk — MPEG-1.2.2 README](http://hpux.connect.org.uk/hppd/hpux/X11/Graphics/MPEG-1.2.2/readme.html)

- **The surviving PVRG-MPEG v1.2.x source**, vendored into `source/`:
  [github.com/maikmerten/mpeg](https://github.com/maikmerten/mpeg)

- **General PVRG-MPEG background**:
  [SAL software listing (KachinaTech mirror)](http://www.sai.msu.su/sal/E/5/PVRG-MPEG.html)
