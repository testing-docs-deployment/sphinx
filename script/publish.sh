#!/bin/bash
set -e

# Get the deploy key by using Travis's stored variables to decrypt deploy_key.enc
ENCRYPTED_KEY_VAR="encrypted_${ENCRYPTION_LABEL}_key"
ENCRYPTED_IV_VAR="encrypted_${ENCRYPTION_LABEL}_iv"
ENCRYPTED_KEY=${!ENCRYPTED_KEY_VAR}
ENCRYPTED_IV=${!ENCRYPTED_IV_VAR}
openssl aes-256-cbc -K $ENCRYPTED_KEY -iv $ENCRYPTED_IV -in deploy_key.enc -out deploy_key -d
chmod 600 deploy_key
eval `ssh-agent -s`
ssh-add deploy_key


# Push build to repository
BUILDDIR="build"
GIT_PUB_LOCAL_DIR="docs_repo"
ssh-add -l
git clone $GIT_PUB_REPO $GIT_PUB_LOCAL_DIR
cp -r ${BUILDDIR}/html docs_repo/${GIT_PUB_DIR}
cd $GIT_PUB_LOCAL_DIR
git config user.name "Travis Docs CI"
git config user.email "$COMMIT_AUTHOR_EMAIL"
git add .
git commit -m "Updating docs."
git push $GIT_PUB_REPO $GIT_PUB_BRANCH
