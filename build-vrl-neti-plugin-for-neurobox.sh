## author: stephanmg <stephan@syntaktischer-zucker.de>
## brief: builds NETI

cd /Users/ug/Local/neurobox/VRL-NeuronalTopologyImporter-Plugin/
git checkout master
git pull
sed -i.bak 's/\(vrldir\).*/\1=\/Volumes\/MacintoshHD2\/neurobox\/final-jars\//' VRL-NeuronalTopologyImporter-Plugin/build.properties
cd VRL-NeuronalTopologyImporter-Plugin && ./gradlew build

[[ $? -eq 0 ]] && ./gradlew installVRLPlugin

git stash
