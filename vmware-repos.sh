#!/usr/bin/env bash

set -x

function test_repo() {
  URL="https://github.com/$GITHUB_USER/$1"
  STATUS=$(curl -s -o /dev/null -I -w "%{http_code}" $URL)
  if [ "$STATUS" == "200" ]; then
    echo "0"
  else
    echo "1"
  fi
}

if [ -z "$GITHUB_USER" ]; then
  echo "Must export GITHUB_USER to clone repos"
  echo "export GITHUB_USER=vmware to clone upstream repo"
  exit 1
fi

echo "Defaulting to forks for $GITHUB_USER"

EXISTS=$(test_repo vic)
if [ $EXISTS ]; then
  echo "Cloning VIC"
  git clone git@github.com:${GITHUB_USER}/vic.git ~/go/src/github.com/vmware/vic
else
  echo "Failed to find repo"
  exit 1
fi

cd ~/go/src/github.com/vmware/vic
git remote add upstream git@github.com:vmware/vic.git
git remote update
curl https://cdn.rawgit.com/tommarshall/git-good-commit/v0.6.1/hook.sh > .git/hooks/commit-msg && chmod +x .git/hooks/commit-msg

EXISTS=$(test_repo vic-product)
if [ $EXISTS ]; then
  echo "Cloning vic-product"
  git clone git@github.com:${GITHUB_USER}/vic-product.git ~/go/src/github.com/vmware/vic-product
else
  echo "Failed to find vic-product fork for $GITHUB_USER, cloning upstream"
  git clone git@github.com:vmware/vic-product.git ~/go/src/github.com/vmware/vic-product
fi

cd ~/go/src/github.com/vmware/vic-product
git remote add upstream git@github.com:vmware/vic-product.git
git remote update
curl https://cdn.rawgit.com/tommarshall/git-good-commit/v0.6.1/hook.sh > .git/hooks/commit-msg && chmod +x .git/hooks/commit-msg

echo "Cloning govmomi"
git clone git@github.com:vmware/govmomi.git ~/go/src/github.com/vmware/govmomi
cd ~/go/src/github.com/vmware/govmomi
