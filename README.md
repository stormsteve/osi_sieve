# osi_sieve

Small collection of BASIC prime sieve programs and variants for Ohio
Scientific (OSI) vintage computers.

Inspired by Dave Plummer's Primes drag-race (https://github.com/PlummersSoftwareLLC/Primes/tree/drag-race)

Author: Steve Gale

## License

GPL-3.0-or-later. See [LICENSE](LICENSE).

## Contents

- `prime_sieve_simple.bas` - straightforward prime finder using trial division
- `prime_sieve_dave.bas` - Dave Plummer sieve version
- `prime_sieve_dave_ROM.bas` - Dave Plummer variant adapted for OSI ROM BASIC
- `prime_sieve_ROM.bas` - full-size array sieve for OSI ROM BASIC
- `prime_sieve_disk.bas` - full-size integer-array sieve for OSI Disk BASIC
- `prime_sieve_disk_bit.bas` - bit-packed integer-array sieve for OSI Disk BASIC
- `prime_sieve_segmented_disk_bit.bas` - segmented bit-packed sieve for OSI Disk BASIC, sized to handle runs up to 1,000,000
- `prime_sieve_ROM_bit.bas` - direct-memory bit-packed sieve for OSI ROM BASIC

## Notes

These programs target Ohio Scientific (OSI) vintage computers and OSI BASIC
environments. Files with `ROM` in the name target OSI ROM BASIC, while files
with `disk` in the name target OSI Disk BASIC. The sources use features such as
`PEEK`, `POKE`, `FRE`, and line-numbered source.

Some files are experimental variants of the same prime-sieve idea, with tradeoffs
between simplicity, memory use, and speed.

The `prime_sieve_dave*.bas` files are OSI-oriented adaptations of a Dave
Plummer prime sieve variant. The other files are project-native sieve variants
for OSI ROM BASIC and OSI Disk BASIC.

Empirically, the segmented disk-bit variant appears to scale roughly linearly
over the tested range. One observed data point was about 10 seconds per 1000
numbers on a 4x emulator, which suggests that a full run to 1,000,000 would be
impractically long in that setup.

## Running

Load the desired `.bas` file into an appropriate OSI BASIC environment, then
run it. Most programs prompt for an upper bound `N`, run the sieve, and print
the number of primes found along with a simple self-check for common inputs.

Manual check for `prime_sieve_segmented_disk_bit.bas`: enter `1000000` and
expect `Found 78498 primes` followed by `Test PASSED`.

