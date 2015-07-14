## author: stephanmg <stephan@syntaktischer-zucker.de>
## brief: tests VRL UG API
RELEASE=$1
RLS_DIR=/Volumes/MacintoshHD2/neurobox/rls/$RELEASE/

# OPTIONAL clean the working folder of the user
cd /Users/ug/.vrl/0.4.2/default/plugins
rm -rf VRL-UG*

# copy the new VRL-UG.jar from the working folder of the user
#cp /Volumes/MacintoshHD2/neurobox/final-jars/VRL-UG.jar /Users/ug/Apps/ugInit-consolApp/.application/property-folder/plugin-updates/VRL-UG.jar
#cp /Users/ug/.vrl/0.4.2/default/plugin-updates/VRL-UG.jar /Users/ug/Apps/ugInit-consolApp/.application/property-folder/plugin-updates/VRL-UG.jar

#  clean the working folder for the console application
#  where we want to check if building the API works
cd /Users/ug/Apps/ugInit-consolApp/.application/property-folder/plugins
rm -rf VRL-UG*

cp $RLS_DIR/final-jars/plugin-updates/VRL-UG.jar /Users/ug/Apps/ugInit-consolApp/.application/property-folder/plugin-updates/
cp $RLS_DIR/final-jars/plugin-updates/VRL-UG.jar /Users/ug/.vrl/0.4.2/default/plugins/
#cp /Volumes/MacintoshHD2/neurobox/final-jars/VRL-UG.jar /Users/ug/Apps/ugInit-consolApp/.application/property-folder/plugin-updates/
#cp /Volumes/MacintoshHD2/neurobox/final-jars/VRL-UG.jar /Users/ug/.vrl/0.4.2/default/plugins/

#  start the vrl-studio which triggers the installation of the new vrl-ug
#  and the build of the vrl-ug-api
cd /Users/ug/Apps/ugInit-consolApp
#  first run for install vrl-ug and build -api
sh run.sh
#  second run for install vrl-ug-api and run the console app vrl-project
sh run.sh

#  die fertige VRL-UG-API ist unter 
#  /Users/ug/Apps/ugInit-consolApp/.application/property-folder/plugins/

# kopiere die api nach plugin-updates
scp /Users/ug/Apps/ugInit-consolApp/.application/property-folder/plugins/VRL-UG-API.jar $RLS_DIR/final-jars/plugin-updates/VRL-UG-API.jar 
#scp /Users/ug/.vrl/0.4.2/default/plugin-updates/VRL-UG.jar /Volumes/MacintoshHD2/neurobox/final-jars/VRL-UG.jar
