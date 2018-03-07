#!/usr/bin/env bash

if [ -z "$GITHUB_USER" ]; then
  echo "Must export GITHUB_USER to clone repos"
  echo "export GITHUB_USER=vmware to clone upstream repo"
  exit 1
fi

function test_repo() {
  STATUS=$(curl -s -o /dev/null -I -w "%{http_code}" https://github.com/$GITHUB_USER/$1)
  if [ "$STATUS" == "200" ]; then
    return 0
  else
    return 1
  fi
}

echo "Cloning VIC"
if [ test_repo vic ]; then
  git clone git@github.com:${GITHUB_USER}/vic.git ~/go/src/github.com/vmware/vic
else
  echo "Failed to find repo"
  exit 1
fi

cd ~/go/src/github.com/vmware/vic
git remote add upstream git@github.com:vmware/vic.git
git remote update
curl https://cdn.rawgit.com/tommarshall/git-good-commit/v0.6.1/hook.sh > .git/hooks/commit-msg && chmod +x .git/hooks/commit-msg

echo "Cloning vic-product"
if [ test_repo vic-product ]; then
  git clone git@github.com:${GITHUB_USER}/vic-product.git ~/go/src/github.com/vmware/vic-product
else
  echo "Failed to find repo, cloning upstream"
  git clone git@github.com:vmware/vic-product.git ~/go/src/github.com/vmware/vic-product
fi

cd ~/go/src/github.com/vmware/vic-product
git remote add upstream git@github.com:vmware/vic-product.git
git remote update
curl https://cdn.rawgit.com/tommarshall/git-good-commit/v0.6.1/hook.sh > .git/hooks/commit-msg && chmod +x .git/hooks/commit-msg

echo "Cloning govmomi"
git clone git@github.com:vmware/govmomi.git ~/go/src/github.com/vmware/govmomi
cd ~/go/src/github.com/vmware/govmomi
