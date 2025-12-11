"""
Day 11: Reactor

https://adventofcode.com/2025/day/11
"""

import pathlib

import duckdb

from advent_of_code.meta import read_input

HERE = pathlib.Path(__file__).parent


def _read(file: str) -> str:
    """
    Read the file.
    """
    return (HERE / file).read_text("utf-8")


def solution(use_sample: bool) -> list:
    """
    Solve the day 11 problem!
    """
    file_1 = HERE / ("sample-1.data" if use_sample else "input.data")
    file_2 = HERE / ("sample-2.data" if use_sample else "input.data")
    read_input(file_1)
    read_input(file_2)

    part_1 = _read("part-1.sql").replace("{{ file }}", str(file_1.absolute()))
    part_2 = _read("part-2.sql").replace("{{ file }}", str(file_2.absolute()))

    return [
        duckdb.sql(part_1).fetchone()[0],
        duckdb.sql(part_2).fetchone()[0],
    ]
