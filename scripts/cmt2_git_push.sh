#!/bin/bash
#
# Script
#


#
# Process script args
#
if [ "$1" == "-?" ]; then
    shift

	echo "Usage: cmt2_git-push.sh <gateway_host> <policy_folder> <destination> <git_username> <git_password>"
	echo "     gateway_host: The hostname or ip address of the Layer 7 gateway"
	echo "     policy_folder: The folder to migrate from the Layer 7 gateway"
	echo "     destination: The destination directory to store the output files in the Git repository"
	echo "     git_username: The username to use for Git"
	echo "     git_password: The password to use for Git"
	echo " "
	echo " Example: sh cmt2_git-push.sh explore.layer7.ca CMT ~/cmt-examples/CMT gituser gitpass"
	echo " "
	echo " "

    shift
else
	GWHOST=$1
	FOLDER=$2
	DEST=$3
	GITUSER=$4
	GITPASS=$5
	
	sh cmt2 migrateOut -h ${GWHOST} -u admin -x 7layer -i ${FOLDER} -o output --auto=yes
	cp -r output ${DEST}
	cd ${DEST}
	git add ${DEST} 
	git commit -m "policy files - latest rev" 
	git push https://${GITUSER}:${GITPASS}@github.com/Layer7-presales/cmt-examples
fi

