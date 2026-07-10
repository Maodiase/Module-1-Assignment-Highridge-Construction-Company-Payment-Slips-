# Module-1-Assignment-Highridge-Construction-Company-Payment-Slips-

Overview

This project implements a Worker Payment Slip Generator in both Python and R. The program dynamically creates a list of 400+ workers (with randomly generated names, salaries, and genders) and prints a formatted payment slip for each worker, including their assigned Employee Level determined by conditional logic.

Files Included

payment_slip_generator.py — Main Python implementation
payment_slip_generator.R — R equivalent implementation
README.md — This documentation file

Requirements Fulfilled

1. Dynamic Worker List (400+ Workers)
Workers are generated programmatically inside generate_workers(count=400). Each worker is a dictionary (Python) or data-frame row (R) containing: id, name, gender, and salary. Random names are drawn from realistic name pools; salaries are drawn uniformly from $5,000 – $35,000. A fixed random seed ensures reproducible results.

2. For Loop – Payment Slip Generation
A for loop iterates over every worker in the list and calls generate_payment_slip() (Python) / print_payment_slip() (R) to produce and print a formatted slip showing the worker's ID, name, gender, salary, and assigned employee level.

3. Conditional Statements – Employee Level Logic
Two independent if conditions are evaluated for every worker:

Condition 1 — Level A1:

If salary > $10,000 and salary < $20,000 → assign "A1"
Condition 2 — Level A5-F:
If salary > $7,500 and salary < $30,000 and gender == "Female" → assign "A5-F"
When both conditions are satisfied (a female worker earning $10,001–$19,999), A5-F takes precedence because the female-specific rule is evaluated second and overrides A1. Workers matching neither condition are assigned "Standard".

4. Exception Handling
Exception handling is implemented at two levels:

Inner (per-worker): catches KeyError (missing fields) and any unexpected Exception — logs a warning and skips the problematic worker, allowing the remaining 399+ slips to process normally.
Outer (global): catches ValueError (empty worker list) and any top-level Exception — prints a [CRITICAL] message and exits gracefully.
R uses tryCatch() at both levels for identical behaviour.

How to Run

Python

Requires Python 3.7+ (no external libraries — standard library only)
Run: python payment_slip_generator.py
R

Requires R 4.0+ (base R only — no packages needed)
Run: Rscript payment_slip_generator.R
Or open in RStudio and press Source
Sample Output
Each payment slip looks like this:

EMP0001 | John Mitchell | Male | $13,250.88 → A1
EMP0004 | Mary Brown | Female | $16,842.33 → A5-F
EMP0003 | Scott Ramirez | Male | $5,953.48 → Standard

A SUMMARY is printed at the end showing counts per level.

Design Decisions
A5-F overrides A1 when both conditions are satisfied — the female-specific rule is more specialised and evaluated last.
Random seed is fixed (42) for reproducible, testable results.
Functions are kept small and single-purpose (generation, logic, formatting, main).
Both versions (Python + R) produce identical logic and equivalent output.
