BASEDIR=/Users/ug/Local/neurobox/
#PROJECTS=(VRL VRL-UG VRL-UserData VRL-NeuroBox-Plugin VRL-NeuronalTopologyImporter-Plugin)
PROJECTS=(VRL-NeuroBox-Plugin)

for project in "${PROJECTS[@]}"; do
	if [ "$DRY_RUN" = true ]; then
		echo "cd $basedir/$project; git stash; git checkout $RELEASE"
	else 
		cd "$basedir/$project"
		git stash
		git checkout $RELEASE
	fi
done
