# OSI Prime Sieve

Prime-counting programs written for Ohio Scientific (OSI) computers and their
ROM and Disk BASIC environments. This project explores how the Sieve of
Eratosthenes can be adapted to vintage systems with tight memory limits and
BASIC-specific constraints.

The implementations range from a small trial-division baseline to odd-only,
bit-packed, direct-memory, and segmented sieves. The segmented Disk BASIC
version is documented for runs up to 1,000,000.

Author: Steve Gale

## Quick start

Load a `.bas` file into a compatible OSI BASIC environment and enter `RUN`.
Most optimized versions prompt for an upper bound `N`. For example, the
segmented Disk BASIC program accepts `1000000` and should report 78,498 primes.
The simple and Dave reference programs use `N=1000` in their source; edit that
value before running them with a different bound.

```text
Find primes up to what number? 1000000
Found 78498 primes
Test PASSED
```

Choose a program for the BASIC environment named in the variant guide below.
These sources use OSI-specific features such as `PEEK`, `POKE`, `FRE`, and
line-numbered BASIC; they are not intended to run unchanged in modern BASIC
interpreters.

## Implementations

| Program | Target | Technique | Purpose |
| --- | --- | --- | --- |
| `prime_sieve_simple.bas` | Generic OSI BASIC | Trial division | Small, readable baseline |
| `prime_sieve_dave.bas` | OSI Disk BASIC | Full sieve over integers | Reference adaptation |
| `prime_sieve_dave_ROM.bas` | OSI ROM BASIC | Full sieve over integers | ROM reference adaptation |
| `prime_sieve_ROM.bas` | OSI ROM BASIC | Odd-only array sieve | Straightforward optimized variant |
| `prime_sieve_ROM_bit.bas` | OSI ROM BASIC | Direct-memory bit-packed odd sieve | Reduce memory use without an array |
| `prime_sieve_disk.bas` | OSI Disk BASIC | Odd-only integer-array sieve | Straightforward optimized variant |
| `prime_sieve_disk_bit.bas` | OSI Disk BASIC | Bit-packed odd-only integer array | Reduce memory use |
| `prime_sieve_segmented_disk_bit.bas` | OSI Disk BASIC | Segmented bit-packed odd sieve | Process larger bounds with a limited working segment |

The `prime_sieve_dave*.bas` files are OSI-oriented adaptations of Dave
Plummer's [Primes drag-race](https://github.com/PlummersSoftwareLLC/Primes/tree/drag-race)
reference. The remaining variants are project implementations for OSI BASIC.

## Design progression

`prime_sieve_simple.bas` provides a small trial-division baseline, while the
Dave adaptations provide full-array sieve references. The project variants
then reduce the sieve's memory use in stages: they skip even numbers, pack
composite flags into bits, and, for Disk BASIC, process the range in segments.

The Disk BASIC bit-packed variants store 15 flags per integer. OSI BASIC's
bitwise `OR` mishandles the 16th, sign bit, so leaving that bit unused avoids
the bug. The ROM bit-packed variant instead stores eight flags per byte in
directly reserved memory using `PEEK` and `POKE`. Its memory recovery procedure
is documented in the [testing guide](TESTING.md).

The segmented variant reuses a bounded working array while processing
successive ranges. It supports bounds up to 1,000,000, though runs at that
scale can take a long time on an emulator.

Runtime output differs between programs. Timing is printed only by variants
that can read a usable clock from the target system.

## Validation and performance

The source includes self-checks for selected common inputs. Detailed expected
counts, boundary cases, and memory-limit procedures are in
[TESTING.md](TESTING.md).

One observed run of the segmented Disk BASIC program took about 10 seconds for
`N=1000` on a 4× emulator. This is a single observation, not a controlled
benchmark or a comparison between variants; emulator and machine details can
change the result substantially.

## License

GPL-3.0-or-later. See [LICENSE](LICENSE).
