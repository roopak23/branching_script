#!/bin/bash
git checkout master &> /dev/null
git branch --merged origin/master | grep -v 'master$' | grep 'tpm*'| xargs git branch -d
MERGED_ON_REMOTE=`git branch -r --merged origin/master | sed 's/ *origin\///' | grep -v 'master$'`
if [ "$MERGED_ON_REMOTE" ]; then
	echo "The following remote branches are fully merged and will be removed:"
	echo $MERGED_ON_REMOTE

	read -p "Continue (y/N)? "
	if [ "$REPLY" == "y" ]; then
		git branch -r --merged origin/master | sed 's/ *origin\///' \
			| grep -v 'master$' | grep 'tpm*'| xargs -I% git push origin :% 2>&1 \
			
		echo "Remote Branches Deleted"
	fi
fi


