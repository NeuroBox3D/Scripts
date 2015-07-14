## author: stephanmg <stephan@syntaktischer-zucker.de>
## brief: prepares git repositories

BASEDIR=/Users/ug/Local/neurobox/release/
PROJECTS=(VRL VRL-UG VRL-UserData VRL-NeuronalTopologyImporter-Plugin)
RELEASE=$1
#DRY_RUN=true

for project in "${PROJECTS[@]}"; do
	if [ "$DRY_RUN" = true ]; then
		echo "cd $BASEDIR/$project; git stash; git checkout $RELEASE"
	else 
	if [ ! -d "$BASEDIR/$project" ]; then
		echo "Check your path-setup for all projects"
		exit
	fi
		cd "$BASEDIR/$project"
		git stash
	  git fetch origin $RELEASE
		git checkout $RELEASE
		git pull && git stash pop
	fi
done
