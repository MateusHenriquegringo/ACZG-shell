#!/bin/bash
name="$1"
featureBranch="feat-$name"

git checkout master
git merge "$featureBranch"
git branch -d "$featureBranch"

git push origin --delete "$featureBranch"

git branch -a
