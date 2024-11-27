import subprocess

from constants import PYLINT_RCFILE, LINT_PATH, BLACK_LINE_LENGTH, FORMAT_PATH

print(PYLINT_RCFILE, LINT_PATH, BLACK_LINE_LENGTH, FORMAT_PATH)
# Lint with Pylint
subprocess.run(
    ["pylint", "--rcfile", PYLINT_RCFILE, LINT_PATH]
    if PYLINT_RCFILE
    else ["pylint", LINT_PATH]
)

# Format with Black
subprocess.run(["black", "--line-length", BLACK_LINE_LENGTH, FORMAT_PATH])
