<span align="center">

[![Python](https://img.shields.io/badge/Python-3.13+-blue.svg)](https://www.python.org/downloads/)
[![pre-commit.ci status](https://results.pre-commit.ci/badge/github/billwallis/advent-of-code-sql/main.svg)](https://results.pre-commit.ci/latest/github/billwallis/advent-of-code-sql/main)
[![GitHub last commit](https://img.shields.io/github/last-commit/billwallis/advent-of-code-sql)](https://shields.io/badges/git-hub-last-commit)

</span>

---

# Advent of Code - SQL

SQL solutions to the Advent of Code problem sets, available at:

- [https://adventofcode.com/](https://adventofcode.com/)

## Similar projects

Several other folks have been solving the Advent of Code problems with SQL, check them out too!

- https://github.com/DBatUTuebingen/Advent_of_Code
- https://github.com/LennartH/advent-of-code
- https://github.com/neumannt/aoc24
- https://github.com/anthonywritescode/aoc2025
- https://clickhouse.com/blog/clickhouse-advent-of-code-2025


## Contributing

Install the dependencies:

```shell
pip install --editable . --group dev --group test
pre-commit install --install-hooks

# Use the CLI
aoc --help
```

Create an `.env` file with the session cookie you get from Advent of Code:

```
AOC_SESSION_COOKIE="session=..."
```

You can find the session cookie in your browser's developer tools after logging in to Advent of Code.
