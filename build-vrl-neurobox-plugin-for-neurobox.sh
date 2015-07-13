cd /Users/ug/Local/neurobox/VRL-NeuroBox-Plugin/
git checkout master
git pull
sed -i.bak 's/\(vrldir\).*/\1=\/Volumes\/MacintoshHD2\/neurobox\/final-jars\//' build.properties
./gradlew build

[[ $? -eq 0 ]] && ./gradlew installVRLPlugin

git stash
