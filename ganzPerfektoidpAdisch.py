#!/usr/bin/env python3
from typing import List, Tuple

def p_adic_digits(n: int, p: int, k: int) -> List[int]:
    """
    Compute the first k digits of the p-adic expansion of an integer n.
    Returns digits a_0,...,a_{k-1} such that
        n ≡ Σ a_i p^i (mod p^k),  0 ≤ a_i < p.
    Works for negative integers as well.
    """
    if p < 2:
        raise ValueError("p must be ≥ 2 (usually prime).")
    digits = []
    m = n
    for _ in range(k):
        ai = m % p
        digits.append(ai)
        m = (m - ai) // p
    return digits


def p_adic_to_int(digits: List[int], p: int) -> int:
    """
    Reconstruct the integer modulo p^k from p-adic digits.
    (Finite truncation = approximation of the p-adic number.)
    """
    value = 0
    power = 1
    for a in digits:
        if not (0 <= a < p):
            raise ValueError("digit outside [0,p).")
        value += a * power
        power *= p
    return value


def p_adic_repr(n: int, p: int, k: int) -> str:
    """
    Pretty string like  (a0 + a1 p + a2 p^2 + ...)_p
    """
    ds = p_adic_digits(n, p, k)
    terms = [f"{a}" if i == 0 else f"{a}·{p}^{i}"
             for i, a in enumerate(ds)]
    return " + ".join(terms) + f"  (mod {p}^{k})"


# ---- Examples / Demo ----
if __name__ == "__main__":
    p = 5
    n = -17
    k = 8  # number of p-adic digits (truncation depth)

    digits = p_adic_digits(n, p, k)
    approx = p_adic_to_int(digits, p)

    print(f"{n} in {p}-adic (first {k} digits): {digits}")
    print("pretty:", p_adic_repr(n, p, k))
    print(f"reconstruction mod {p}^{k} =", approx)
