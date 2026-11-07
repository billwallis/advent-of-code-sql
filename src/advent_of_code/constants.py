"""
Constants for Advent of Code.
"""

import pathlib

PROJECT_ROOT = pathlib.Path(__file__).parent.parent.parent
assert PROJECT_ROOT.name == "advent-of-code-sql", (
    "The project root is not 'advent-of-code-sql'"
)

SOLUTIONS_ROOT = PROJECT_ROOT / "src/advent_of_code/solutions"
