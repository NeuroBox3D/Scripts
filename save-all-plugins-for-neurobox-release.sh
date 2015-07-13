### author stephan
## todo: error handling 

RELEASE=$1
RLS_DIR=/Volumes/MacintoshHD2/neurobox/rls/$RELEASE/

if test -e "$RLS_DIR"; then
	echo "Release directory already present: $RLS_DIR"
else
	mkdir -p "$RLS_DIR"
fi

echo "Copying jars to $RLS_DIR now.";
cp /Volumes/MacintoshHD2/neurobox/final-jars/*.jar $RLS_DIR
cp /Volumes/MacintoshHD2/neurobox/final-jars/plugin-updates/*.jar $RLS_DIR

if test -e $RLS_DIR/natives; then
	echo "Natives directory in release directory already present: $RLS_DIR/natives"
else
	mkdir $RLS_DIR/natives/
fi

echo "Copying natives to $RLS_DIR now.";
	cp -r /Volumes/MacintoshHD2/neurobox/vrl-ug-natives/* $RLS_DIR/natives/
