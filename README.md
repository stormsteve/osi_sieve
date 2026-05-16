# osi_sieve

Small collection of BASIC prime sieve programs and variants for Ohio
Scientific (OSI) vintage computers.

## License

GPL-3.0-or-later. See [LICENSE](LICENSE).

## Contents

- `prime_sieve_simple.bas` - straightforward prime finder using trial division
- `prime_sieve_dave.bas` - Dave Plummer sieve version
- `prime_sieve_dave_ROM.bas` - Dave Plummer variant adapted for OSI ROM BASIC
- `prime_sieve_ROM.bas` - full-size array sieve for OSI ROM BASIC
- `prime_sieve_disk.bas` - full-size integer-array sieve for OSI Disk BASIC
- `prime_sieve_disk_bit.bas` - bit-packed integer-array sieve for OSI Disk BASIC
- `prime_sieve_ROM_bit.bas` - direct-memory bit-packed sieve for OSI ROM BASIC

## Notes

These programs target Ohio Scientific (OSI) vintage computers and OSI BASIC
environments. Files with `ROM` in the name target OSI ROM BASIC, while files
with `disk` in the name target OSI Disk BASIC. The sources use features such as
`PEEK`, `POKE`, `FRE`, and line-numbered source.

Some files are experimental variants of the same prime-sieve idea, with tradeoffs
between simplicity, memory use, and speed.

## Repository Hygiene

Editor backup files and local Codex metadata are ignored through `.gitignore` so
the repository stays clean when shared on GitHub.
