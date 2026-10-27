# Manual testing

Use these expected counts when manually testing or comparing variants:

| `N` | Expected primes |
| --- | --- |
| 2 | 1 |
| 10 | 4 |
| 100 | 25 |
| 1,000 | 168 |
| 10,000 | 1,229 |
| 100,000 | 9,592 |
| 1,000,000 | 78,498 |

Programs with built-in self-checks verify only selected inputs. An unchecked
input reports `No built-in check`; compare its result with the table or another
trusted prime-counting implementation.

## Reference implementations

Run `prime_sieve_simple.bas`, `prime_sieve_dave.bas`, and
`prime_sieve_dave_ROM.bas` with their source default `N=1000`. Each should
report 168 primes. These programs are retained as reference implementations;
the boundary checks below focus on the optimized variants.

## Basic boundaries

For each of `prime_sieve_ROM.bas`, `prime_sieve_disk.bas`,
`prime_sieve_ROM_bit.bas`, and `prime_sieve_disk_bit.bas`, run with `N=2` and
expect one prime without an array bounds error. Also check `N=3` and `N=8`,
expecting 2 and 4 primes respectively, then run with `N=10` to exercise
composite marking and expect 4 primes.

For `prime_sieve_segmented_disk_bit.bas`, enter `1000000` and expect
`Found 78498 primes` followed by `Test PASSED`.

## ROM bit-packed boundaries

For `prime_sieve_ROM_bit.bas`, check `N=32767`, `32768`, and `32769`; each
should find 3512 primes. Then check `N=40000` (4203 primes) and `N=100000`
(9592 primes), with enough RAM for the bitmap. These runs should finish
without an illegal-quantity error in marking or counting. Compare the counts
directly; only `100000` has a built-in self-check among these inputs.

To check bitmap allocation near the memory limit in OSI ROM BASIC, set
`MEMORY SIZE` to `8146` and run `prime_sieve_ROM_bit.bas` with `N=98608`.
Expect `Found 9467 primes` and `Test PASSED`; `N=98609` should be rejected
with the reported maximum of `98608`.

For the square-root boundary, run `prime_sieve_ROM_bit.bas` with `N=26568`,
`26569`, and `26570`. Each input should report 2915 primes. `26569` is
`163^2`; this case checks that a slightly low floating-point `SQR` result does
not make the sieve stop before using 163 to mark its square. Compare the
counts directly because only common inputs have built-in self-checks.

If `BREAK` stops `prime_sieve_ROM_bit.bas`, its direct-memory bitmap may still
be reserved. At the BASIC prompt, before entering `RUN`, restore the saved
high-water mark with:

```basic
POKE 134,FNH(HW):POKE 133,FNL(HW)
```

The program's variables and helper functions remain available after `BREAK`.
If they have been cleared or the command cannot be entered, reset the computer
before running the program again.

## Segmented allocation and clearing

To check segment clearing without a long run, temporarily replace line 590 in
`prime_sieve_segmented_disk_bit.bas` with `590 M=100`, then run with `N=1000`.
Expect `Found 168 primes` followed by `Test PASSED`. This forces multiple
segments with multiple array entries to be cleared. Restore the original line
590 after the check.

To check segment allocation near the memory limit, use the original line 590
and enable the diagnostic `PRINT` at line 610. Run with `N=100000` and set the
BASIC memory limit low enough that the printed `M` is less than 100000, while
still allowing the program and base sieve to load. Expect `Found 9592 primes`
and `Test PASSED`, without an out-of-memory error during allocation or
processing. Disable the diagnostic `PRINT` after the check.
