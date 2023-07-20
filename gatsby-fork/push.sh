#!/bin/bash

# After testing your project, please execute this script
# to push it into your own remote repository

# Getting variables from external txt file
. /home/node/workdir/variables.txt

# Add remote and push to your own remote repo
git remote add origin "$MYREPO_ADDR"
git push -u origin main
