## author: stephanmg <stephan@syntaktischer-zucker.de>
## brief builds NeuroBox 

RELEASE=$1
RLS_DIR="\/Volumes\/MacintoshHD2\/neurobox\/rls\/$RELEASE\/"

cd /Users/ug/Local/neurobox/release/VRL-NeuroBox-Plugin/

git pull
sed -i.bak "s/\(vrldir\).*/\1=\/$RLS_DIR\/final-jars\//" build.properties
./gradlew build

[[ $? -eq 0 ]] && ./gradlew installVRLPlugin

#git stash

