# osi_sieve

Small collection of BASIC prime sieve programs and variants for Ohio
Scientific (OSI) vintage computers.

Inspired by Dave Plummer's Primes drag-race (https://github.com/PlummersSoftwareLLC/Primes/tree/drag-race)

Author: Steve Gale

## License

GPL-3.0-or-later. See [LICENSE](LICENSE).

## Contents

- `prime_sieve_simple.bas` - straightforward prime finder using trial division
- `prime_sieve_dave.bas` - Dave Plummer sieve reference version
- `prime_sieve_dave_ROM.bas` - Dave Plummer reference variant adapted for OSI
  ROM BASIC
- `prime_sieve_ROM.bas` - full-size array sieve for OSI ROM BASIC
- `prime_sieve_disk.bas` - full-size integer-array sieve for OSI Disk BASIC
- `prime_sieve_disk_bit.bas` - bit-packed integer-array sieve for OSI Disk BASIC
- `prime_sieve_segmented_disk_bit.bas` - segmented bit-packed sieve for OSI
  Disk BASIC, sized to handle runs up to 1,000,000
- `prime_sieve_ROM_bit.bas` - direct-memory bit-packed sieve for OSI ROM BASIC

## Variant Guide

| Program | Target | Technique | Role | Notes |
| --- | --- | --- | --- | --- |
| `prime_sieve_simple.bas` | Generic OSI BASIC | Trial division | Baseline | Small and easy to read, but slow |
| `prime_sieve_dave.bas` | OSI Disk BASIC | Full sieve over all integers | Reference | Dave Plummer adaptation kept as a comparison point |
| `prime_sieve_dave_ROM.bas` | OSI ROM BASIC | Full sieve over all integers | Reference | ROM BASIC version of the Dave reference approach |
| `prime_sieve_ROM.bas` | OSI ROM BASIC | Full-size odd-only array sieve | Native optimized | Simpler optimized ROM version |
| `prime_sieve_ROM_bit.bas` | OSI ROM BASIC | Direct-memory bit-packed odd sieve | Native optimized | Trades simplicity for lower memory use |
| `prime_sieve_disk.bas` | OSI Disk BASIC | Full-size odd-only integer-array sieve | Native optimized | Uses Disk BASIC integer arrays |
| `prime_sieve_disk_bit.bas` | OSI Disk BASIC | Bit-packed odd-only integer-array sieve | Native optimized | Better memory efficiency than `prime_sieve_disk.bas` |
| `prime_sieve_segmented_disk_bit.bas` | OSI Disk BASIC | Segmented bit-packed odd sieve | Native optimized | Largest tested range, up to 1,000,000 |

## Notes

These programs target Ohio Scientific (OSI) vintage computers and OSI BASIC
environments. Files with `ROM` in the name target OSI ROM BASIC, while files
with `disk` in the name target OSI Disk BASIC. The sources use features such as
`PEEK`, `POKE`, `FRE`, and line-numbered source.

Some files are experimental variants of the same prime-sieve idea, with
tradeoffs between simplicity, memory use, and speed.

The `prime_sieve_dave*.bas` files are OSI-oriented adaptations of a Dave
Plummer prime sieve variant and are kept as reference implementations. The
other files are project-native sieve variants for OSI ROM BASIC and OSI Disk
BASIC.

Output format is not identical across all variants. In particular, runtime
reporting depends on whether the target configuration exposes a usable real-time
clock through `PEEK`, so timing is only printed by the programs that can rely
on that support.

Empirically, the segmented disk-bit variant appears to scale roughly linearly
over the tested range. One observed data point was about 10 seconds per 1000
numbers on a 4x emulator, which suggests that a full run to 1,000,000 would be
impractically long in that setup.

## Running

Load the desired `.bas` file into an appropriate OSI BASIC environment, then
run it. Most programs prompt for an upper bound `N`, run the sieve, and print
the number of primes found along with a simple self-check for common inputs.
The reference-oriented `prime_sieve_simple.bas`, `prime_sieve_dave.bas`, and
`prime_sieve_dave_ROM.bas` are set up with `N=1000` in the source.

## Manual Checks

Use these expected counts when manually testing or comparing variants:

| N | Expected primes |
| --- | --- |
| 2 | 1 |
| 10 | 4 |
| 100 | 25 |
| 1000 | 168 |
| 10000 | 1229 |
| 100000 | 9592 |
| 1000000 | 78498 |

Programs with built-in self-checks already verify some or all of these values.
For `prime_sieve_segmented_disk_bit.bas`, enter `1000000` and expect
`Found 78498 primes` followed by `Test PASSED`.

For each of `prime_sieve_ROM.bas`, `prime_sieve_disk.bas`,
`prime_sieve_ROM_bit.bas`, and `prime_sieve_disk_bit.bas`, run with `N=2`
and expect `Found 1 primes` without an array bounds error. Also check `N=3`
and `N=8`, expecting 2 and 4 primes respectively, then run with `N=10`
to exercise composite marking and expect 4 primes.

For `prime_sieve_ROM_bit.bas`, check `N=32767`, `32768`, and `32769`;
each should find 3512 primes. Then check `N=40000` (4203 primes) and
`N=100000` (9592 primes), with enough RAM for the bitmap. These runs
should finish without an illegal-quantity error in marking or counting.
Compare the counts directly: only `100000` has a built-in self-check
among these inputs.

To check bitmap allocation near the memory limit in OSI ROM BASIC, set
`MEMORY SIZE` to `8146` and run `prime_sieve_ROM_bit.bas` with `N=98608`.
Expect `Found 9467 primes` and `Test PASSED`; `N=98609` should be rejected
with the reported maximum of `98608`.

For the square-root boundary, run `prime_sieve_ROM_bit.bas` with `N=26568`,
`26569`, and `26570`. Each input should report 2915 primes. Compare the
counts directly because only common inputs have built-in self-checks.

If BREAK stops `prime_sieve_ROM_bit.bas`, its direct-memory bitmap may still
be reserved. At the BASIC prompt, before entering `RUN`, restore the saved
high-water mark with:

```basic
POKE 134,FNH(HW):POKE 133,FNL(HW)
```

The program's variables and helper functions remain available after BREAK.
If they have been cleared or the command cannot be entered, reset the
computer before running the program again.

To check segment clearing without a long run, temporarily replace line 590
in `prime_sieve_segmented_disk_bit.bas` with `590 M=100`, then run with
`N=1000`. Expect `Found 168 primes` followed by `Test PASSED`. This forces
multiple segments with multiple array entries to be cleared. Restore the
original line 590 after the check.

To check segment allocation near the memory limit, use the original line
590 and enable the diagnostic PRINT at line 610. Run with `N=100000` and
set the BASIC memory limit low enough that the printed `M` is less than
100000, while still allowing the program and base sieve to load. Expect
`Found 9592 primes` and `Test PASSED`, without an out-of-memory error during
allocation or processing. Disable the diagnostic PRINT after the check.
