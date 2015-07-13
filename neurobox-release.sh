### author stephan
## todo: error handling 

RELEASE=$1
EXE_DIR=/Users/ug/Local/neurobox/
DEPLOYMENT_SITE="http://neurobox.eu/releases/"
E_NO_RLS_GIVEN=1

if test -z "$1"; then
	echo "Exiting. No RELEASE specified!";
	exit $E_NO_RLS_GIVEN
fi

echo "Preparing git repos - branch to be considered in all repositories is: $RELEASE"
# prepare git repos (i. e. checkout $RELEASE branch!)
# sh $EXE_DIR/prepare-git-repos-for-neurobox-release.sh $RELEASE

echo "Building VRL Plugins and UG-API and testing working Plugins and UG-API"
# build plugins on given $RELEASE branch
# sh $EXE_DIR/copy-and-build-vrl-ug-for-neurobox-release.sh
# sh $EXE_DIR/testing-VRL-UG-AP-build-for-neurobox-release.sh 
# sh $EXE_DIR/build-vrl-neti-plugin-for-neurobox.sh 

echo "Copying VRL Plugins and UG natives to $RELEASE dir."
sh $EXE_DIR/save-all-plugins-for-neurobox-release.sh $RELEASE

echo "Deploying NeuroBox release $RELEASE to $DEPLOYMENT_SITE now."
sh $EXE_DIR/deploy-neurobox-release.sh $RELEASE $DEPLOYMENT_SITE
