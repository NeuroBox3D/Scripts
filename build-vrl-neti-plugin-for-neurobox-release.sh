RELEASE=$1
RLS_DIR="\/Volumes\/MacintoshHD2\/neurobox\/rls\/$RELEASE\/"

cd /Users/ug/Local/neurobox/VRL-NeuronalTopologyImporter-Plugin/
git pull
#sed -i.bak 's/\(vrldir\).*/\1=\/Volumes\/MacintoshHD2\/neurobox\/final-jars\//' VRL-NeuronalTopologyImporter-Plugin/build.properties
sed -i.bak "s/\(vrldir\).*/\1=\/$RLS_DIR\/final-jars\//" VRL-NeuronalTopologyImporter-Plugin/build.properties
cd VRL-NeuronalTopologyImporter-Plugin && ./gradlew build

[[ $? -eq 0 ]] && ./gradlew installVRLPlugin

git stash
