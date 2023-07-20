#!/bin/bash

# If you prefer a regular gatsby new method,
# please execute this script upon attaching to the container
# Cloning the original repo into your local machine with only the latest commit

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
# If not installed gatsby-cli globally yet
if [ ! -e /home/node/.yarn/bin/gatsby ]; then
    yarn global add gatsby-cli
fi
# set default package manager to yarn
/home/node/.yarn/bin/gatsby options set package-manager yarn
# if your repository is not created yet
if [ ! -d "$REPODIR" ]; then
    # gatsby new
    /home/node/.yarn/bin/gatsby new "$REPODIR" "$UPSTREAM_ADDR"
    # Move to app repository
    cd "$REPODIR" || exit 1
    # If current branch is not main, change its name to main
    if [ "$($SHOW_CRB_CMD)" != "main" ]; then
        git branch -m "$($SHOW_CRB_CMD)" main
    fi
fi
