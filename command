# 1) Be sure we’re on the new local name
git checkout AB#356428-fixedalert

# 2) Create the REMOTE branch with the new name (from your current HEAD)
git push origin HEAD:AB#356428-fixedalert

# 3) Point your local branch to track the new remote
git branch -u origin/AB#356428-fixedalert

# 4) Remove the old remote branch name
git push origin --delete feature/fixedalert

# 5) Clean up stale refs
git remote prune origin
