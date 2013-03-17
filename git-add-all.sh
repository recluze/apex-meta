git status --porcelain | sed 's/^[D]^[D].\(.*\)/\1/' | xargs git add
