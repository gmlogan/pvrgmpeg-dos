# Source provenance

The files in this directory are vendored from:

- **Repository:** https://github.com/maikmerten/mpeg
- **Commit:** `7d0dd9808501174dc32a8eae31a10b41e2e4f182`
- **Commit date:** 2014-02-01
- **Upstream description:** "A public domain MPEG-1 Part 2 en- and decoder
  developed by the Portable Video Research Group at Stanford, patched to
  build on modern systems."

This is the closest available surviving source to what Graham Logan
originally built from in June 1993 (`MPEGv1.2.alpha.tar.Z` /
`MPEGDOCv1.1.tar.Z` from `havefun.stanford.edu`, now offline). The exact
alpha/1.1 release tags no longer survive as standalone archives anywhere we
could find; this is the v1.2/1.2.2-lineage successor, and has been verified
(see ../tests/roundtrip.sh) to correctly decode the original 1993
`SHORT.MPG` byte-for-byte-equivalent output and to re-encode the original
source GIFs into a stream that decodes to visually identical frames.

See ../NOTICE for the licensing/attribution terms that apply to this code.
