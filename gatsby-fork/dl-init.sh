#!/bin/bash

# If you prefer to download the source of the specific commit,
# please execute this script upon attaching to the container
# Downloaded source will be unzipped, followed by git init and ready to test your project

# Getting variables from external txt file
. /home/node/workdir/variables.txt
# This is a recommended setting for VSCode users
if [ -d "$VSCDIR" ]; then
    if [ ! -f "$VSCJSON" ]; then
        echo -e "$VSCSET" >"$VSCJSON"
    fi
    code --install-extension donjayamanne.githistory
fi
# Store git-credentials at container home dir upon first time git authorization
git config --global credential.helper store
# Git user info set globally prior to gatsby new installation
git config --global user.name "$GIT_UNAME"
git config --global user.email "$GIT_UMAIL"
# if your repository is not created yet
if [ ! -d "$REPODIR" ]; then
    # Download tarball source from remote repository
    curl "$UPSTREAM_ADDR" -L -o archive.tar.gz
    mkdir "$REPODIR"
    tar xzf archive.tar.gz -C "$REPODIR" --strip-components 1
    rm archive.tar.gz
    # Move to app repository
    cd "$REPODIR" || exit 1
    # If package-lock.json exists then erase
    if [ -e ./package-lock.json ]; then
        rm package-lock.json
    fi
    # yarn install && git init
    yarn install
    git init && git add . && git commit -m "Initial commit from gatsby"
    # If current branch is not main, change its name to main
    if [ "$($SHOW_CRB_CMD)" != "main" ]; then
        git branch -m "$($SHOW_CRB_CMD)" main
    fi
fi
