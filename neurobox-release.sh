## author: stephanmg <stephan@syntaktischer-zucker.de>
## brief: master script for NeuroBox releases

# vars
RELEASE=$1
EXE_DIR=/Users/ug/Local/neurobox/
DEPLOYMENT_SITE="sgrein@quadruped.gcsc.uni-frankfurt.de:/home/gitrepos/NeuroBox-Releases/"

# error codes
E_NO_RLS_GIVEN=1
E_COPY_AND_BUILD_VRL_UG_FAILED=2
E_TESTING_VRL_UG_API_FAILED=3
E_BUILD_NETI_PLUGIN_FAILED=4
E_BUILD_NEUROBOX_PLUGIN_FAILED=5

if test -z "$1"; then
	echo "Exiting. No RELEASE specified!";
	exit $E_NO_RLS_GIVEN
fi

# prepare git repos (i. e. checkout $RELEASE branch - for the very first neurobox release we have name inconsistence - correct only in this case)
echo "Preparing git repos - branch to be considered in all repositories is: $RELEASE"
if [ "$RELEASE" == "neurobox-v0.1-ff" ]; then
	sh $EXE_DIR/prepare-git-repos-for-neurobox-release.sh $(sed 's/\(.*\)\(.*\)\.\(.*\)-\(ff\)$/\1\2\3\4/' <<< "$RELEASE")
else
	sh $EXE_DIR/prepare-git-repos-for-neurobox-release.sh $RELEASE
fi

echo "Building VRL Plugins and UG-API and testing working Plugins and UG-API"
# build plugins on given $RELEASE branch
sh $EXE_DIR/copy-and-build-vrl-ug-for-neurobox-release.sh $RELEASE
if [ $? ne 0 ]; then
	exit $E_COPY_AND_BUILD_VRL_UG_FAILED
fi

sh $EXE_DIR/testing-VRL-UG-API-build-for-neurobox-release.sh $RELEASE
if [ $? ne 0 ]; then
	exit $E_TESTING_VRL_UG_API_FAILED
fi

sh $EXE_DIR/build-vrl-neti-plugin-for-neurobox-release.sh $RELEASE
if [ $? ne 0 ]; then
	exit $E_BUILD_VRL_NETI_PLUGIN_FAILED
fi

sh $EXE_DIR/build-vrl-neurobox-plugin-for-neurobox-release.sh $RELEASE
if [ $? ne 0 ]; then
	exit $E_BUILD_VRL_NEUROBOX_PLUGIN_FAILED
fi

# deploy
echo "Deploying NeuroBox release $RELEASE to $DEPLOYMENT_SITE now."
sh $EXE_DIR/deploy-neurobox-release.sh $RELEASE $DEPLOYMENT_SITE
