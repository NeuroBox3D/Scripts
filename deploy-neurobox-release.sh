## author: stephanmg <stephan@syntaktischer-zucker.de>
## brief: deploys release
RELEASE=$1
DEPLOYMENT_SITE=$2
BASE_DIR=/Volumes/MacintoshHD2/neurobox/rls/

cd $BASE_DIR/;

tar cfvj "$RELEASE.tar.bz2" $RELEASE/
md5 "$RELEASE.tar.bz2" > "$RELEASE.tar.bz2.md5"

if [ $? -ne 0 ]; then
	echo "Error during tar-ing. NOT deploying!."
else
	scp "$RELEASE.tar.bz2" $DEPLOYMENT_SITE
	scp "$RELEASE.tar.bz2.md5" $DEPLOYMENT_SITE
fi
