# go into project folder
cd /Users/ug/Local/neurobox/VRL-UserData

# get the latest code
git checkout master 
git pull

sed -i.bak 's/\(vrl\.dir\).*/\1=\/Volumes\/MacintoshHD2\/neurobox\/final-jars\//' build.properties

cp /Volumes/MacintoshHD2/neurobox/final-jars/VRL-UG.jar jars/
cp /Volumes/MacintoshHD2/neurobox/final-jars/VRL-UG-API.jar jars/
cp ~/Local/neurobox/VRL/VRL/dist/VRL.jar jars/

# clean the java project
/usr/local/bin/ant clean

# build the java project
/usr/local/bin/ant compile 

# create a jar file of the java project
/usr/local/bin/ant jar

# git stash (don't stash as we need to set project dependencies in Netbeans again or in the appropriate .xml Netbeans project files!)

cp dist/VRL-UserData.jar /Volumes/MacintoshHD2/neurobox/final-jars/
