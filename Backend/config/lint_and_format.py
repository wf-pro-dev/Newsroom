"""
Script for linting and formatting the codebase using Pylint and Black.
"""

import subprocess
from constants import PYLINT_RCFILE, LINT_PATH, BLACK_LINE_LENGTH, FORMAT_PATH


def run_subprocess(command):
    """Run a subprocess command and handle exceptions."""
    try:
        subprocess.run(command, check=True)
    except subprocess.CalledProcessError as e:
        print(f"An error occurred while running command: {command}")
        print(e)


# Lint with Pylint
pylint_command = (
    ["pylint", "--rcfile", PYLINT_RCFILE, LINT_PATH]
    if PYLINT_RCFILE
    else ["pylint", LINT_PATH]
)
run_subprocess(pylint_command)

# Format with Black
black_command = ["black", "--line-length", BLACK_LINE_LENGTH, FORMAT_PATH]
run_subprocess(black_command)
