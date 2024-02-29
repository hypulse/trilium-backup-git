#!/bin/sh

/usr/local/bin/python /backup_script.py

cd /backups

# Git configuration
git config --global user.email "${GIT_USER_EMAIL}"
git config --global user.name "${GIT_USER_NAME}"
if [ ! -d ".git" ]; then
    git init
    git remote add origin "${GIT_ORIGIN_WITH_TOKEN}"
fi

git fetch origin master
git checkout master
git merge origin/master

# Remove old backups
ls -d */ | sort -r | tail -n +$((MAX_BACKUPS + 1)) | xargs rm -rf

git add .
git commit -m "Backup ${BACKUP_TIMESTAMP}"
git push -u origin master
