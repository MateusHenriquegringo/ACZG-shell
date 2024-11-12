#!/bin/bash
name="$1"

git status
git checkout -b "feat-$name"
git branch -a
