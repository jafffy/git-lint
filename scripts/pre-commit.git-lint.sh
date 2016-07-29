#!/bin/sh

diff_files=$(git diff-index --cached HEAD --name-only --diff-filter=ACMR)

if [[ $diff_files ]]; then
    tr "\n" " " < $diff_files | git lint
else
    echo "There doesn't exist any modified file."

    exit 1;
fi

if [ "$?" != "0" ]; then
  echo "There are some problems with the modified files.";
  echo "Fix them before committing or suggest a change to the rules defined in REPO_HOME/.gitlint.yaml.";
  echo "If it is not possible to fix them all commit with the option --no-verify.";

  exit 1;
fi
