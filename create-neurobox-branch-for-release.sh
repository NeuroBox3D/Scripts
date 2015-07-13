#!/bin/bash
## author: stephan
##   what: 1. creates a new neurobox release branch, e. g. v0.1 from the current ug trunk and
##         2. checkout the given git tags for the RELEASE, e. g. v0.1 from all plugins

REVISION=trunk
RELEASE=$1

if [ -z $1 ]; then
	echo "Exiting. No RELEASE specified!"
	exit 1;
fi

REPOSITORY=svn://fuji.gcsc.uni-frankfurt.de/ug4
DRY_RUN=true

if [ "$DRY_RUN" = true ]; then
	echo "Dry run..."
else
	svn info $REPOSITORY/branches/neurobox/$RELEASE

	if [ $? -ne 0 ]; then
		echo "Branch already exists!"
	else
		svn copy \
		$REPOSITORY/$REVISION \
		$REPOSITORY/branches/neurobox/$RELEASE \
		-m "Creating NeuroBox $RELEASE branch"
		fi
fi
