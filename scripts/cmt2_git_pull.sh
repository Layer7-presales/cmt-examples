#!/bin/bash
#
# Script
#


#
# Process script args
#
if [ "$1" == "-?" ]; then
    shift

	echo "Usage: cmt2_git-pull.sh <gateway_host> <policy_folder> <import_dir> <git_url>"
	echo "     gateway_host: The hostname or ip address of the Layer 7 gateway"
	echo "     policy_folder: The folder to migrate to the Layer 7 gateway"
	echo "     import_dir: The directory location for the previously exported migration package"
	echo "     git_url: The url to the repository in GitHub"
	echo " "
	echo " Example: sh cmt2_git-push.sh explore.layer7.ca CMT ~/cmt-examples/CMT https://github.com/Layer7-presales/cmt-examples"
	echo " "
	echo " "

    shift
else
	GWHOST=$1
	FOLDER=$2
	SRC=$3
	GITURL=$4

    cd ${SRC}
	git fetch ${GITURL} 
	git pull 	
	
	cd -
	sh cmt2 migrateIn -h ${GWHOST} -u admin -x 7layer -i ${SRC}/output -f ${FOLDER} --auto=yes

fi