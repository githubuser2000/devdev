#!/usr/bin/env python3
"""
p-adische Expansion mit vielen externen Libraries
"""

from dataclasses import dataclass
from typing import List

import numpy as np
import pandas as pd
from sympy import Integer, factorint
from sympy.ntheory import valuation
from pydantic import BaseModel, PositiveInt
from rich.console import Console
from rich.table import Table
import click
import mpmath as mp


console = Console()


class PAdicConfig(BaseModel):
    p: PositiveInt
    k: PositiveInt  # number of digits


@dataclass
class PAdicNumber:
    n: int
    p: int
    digits: List[int]

    def to_int_mod(self) -> int:
        """Reconstruct integer mod p^k"""
        powers = np.power(self.p, np.arange(len(self.digits)))
        return int(np.sum(np.array(self.digits) * powers))

    def v_p(self) -> int:
        """p-adische Bewertung v_p(n) via sympy"""
        if self.n == 0:
            return mp.inf
        return valuation(Integer(self.n), self.p)


def p_adic_digits(n: int, p: int, k: int) -> List[int]:
    """first k p-adic digits using numpy vector ops"""
    digits = []
    m = Integer(n)
    for _ in range(k):
        ai = int(m % p)
        digits.append(ai)
        m = (m - ai) // p
    return digits


def p_adic_expand(n: int, cfg: PAdicConfig) -> PAdicNumber:
    return PAdicNumber(
        n=n,
        p=cfg.p,
        digits=p_adic_digits(n, cfg.p, cfg.k)
    )


def pretty_table(x: PAdicNumber):
    table = Table(title=f"{x.n} in {x.p}-adischer Darstellung")
    table.add_column("i", justify="right")
    table.add_column("a_i", justify="right")
    for i, a in enumerate(x.digits):
        table.add_row(str(i), str(a))
    console.print(table)

    console.print(
        f"[bold]Approximation:[/bold]  "
        f"{x.to_int_mod()}   (mod {x.p}^{len(x.digits)})"
    )
    console.print(
        f"[bold]v_{x.p}({x.n})[/bold] = {x.v_p()}"
    )


@click.command()
@click.option("--n", type=int, required=True, help="ganze Zahl")
@click.option("--p", type=int, default=5, show_default=True, help="Primzahl p")
@click.option("--k", type=int, default=12, show_default=True,
              help="Anzahl p-adischer Stellen")
def cli(n: int, p: int, k: int):
    cfg = PAdicConfig(p=p, k=k)
    x = p_adic_expand(n, cfg)

    # Pandas dataframe as auxiliary view
    df = pd.DataFrame({
        "i": list(range(len(x.digits))),
        "a_i": x.digits,
        "p^i": [p**i for i in range(len(x.digits))]
    })
    console.print(df)

    pretty_table(x)


if __name__ == "__main__":
    cli()
