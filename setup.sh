#!/bin/bash

rm -Rf .git
rm *.txt

git init

echo "foo" > A.txt
git add .
git commit -am "Added A.txt"

git checkout -b feature/1
echo "1" >> A.txt
git add .
git commit -am "Commit 1"

git checkout -b feature/2
echo "2" >> B.txt
git add .
git commit -am "Commit 2"

git checkout -b feature/3
echo "3" >> C.txt
git add .
git commit -am "Commit 3"

git checkout feature/1
sed -i 's/1/1a/g' A.txt
git add .
git commit -m "PR feedback."

git checkout feature/3
git rebase feature/1 --update-refs

sed -i 's/1a/1a-foo/g' A.txt
sed -i 's/2/2-foo/g' B.txt
sed -i 's/3/3-foo/g' C.txt

git autofixup -vv master
git rebase --interactive --autosquash master --update-refs