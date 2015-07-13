#!/bin/bash

RELEASE=$1
RLS_DIR=/Volumes/MacintoshHD2/neurobox/rls/$RELEASE/

#place of the native compiled ug library
UG_LIB_FOLDER_OSX=$RLS_DIR/vrl-ug-natives/osx/
UG_LIB_FOLDER_LINUX=$RLS_DIR/vrl-ug-natives/linux/
UG_LIB_FOLDER_WINDOWS=$RLS_DIR/vrl-ug-natives/windows/

#ug library name
ZIP_NAME=natives.zip

#Operating-System (OS) specific library ending
#ATTENTION: all endings need to start with a dot "."
# mac = .dylib
# windows = .dll
# linux = .a  (static)  .so (shared/dynamic) WE USE dynamic LIBS 
#UG_LIB_ENDING=.so  

#place of the vrl-ug java project (must be replaced by Local/neurobox VRL UG!)
VRL_UG_JAVA_PROJECT_FOLDER=/Users/ug/Local/neurobox/VRL-UG/VRL-UG/
#VRL_UG_JAVA_PROJECT_FOLDER=/Users/ug/Apps/VRL-UG/VRL-UG/

#common part of package were natives zips need to be placed
VRL_UG_PACKAGE_NATIVES=eu/mihosoft/vrl/plugin/content/natives/

#complete path to common part of package were natives zips need to be placed
COMMON_PART_NATIVES=${VRL_UG_JAVA_PROJECT_FOLDER}src/${VRL_UG_PACKAGE_NATIVES}

#on which OS do we operate
# on windows 64bit use   /windows/x64/
# on windows 32bit use   /windows/x86/
# on windows 64bit use   /linux/x64/
# on windows 32bit use   /linux/x86/
# on mac           use   /osx/


###
### SCRIPT COMMANDS
###

##
## zipping part
##

# OSX
#
# gehe in das verzeichnis in dem die nativ kompilierte version von ug liegt
echo " gehe in ${UG_LIB_FOLDER_OSX} "
cd ${UG_LIB_FOLDER_OSX}

# loesche bereits vorhandenes zip um sicher zustellen
# das kein update des zip gemacht wird sondern ein neues erstellt wird
echo "loesche zip ${ZIP_NAME}"
rm  ${ZIP_NAME}

#zippe die datei libug.dylib in die datei natives.zip
echo " zip -r ${ZIP_NAME} *.dylib "
zip -r ${ZIP_NAME} *.dylib



# LINUX /x64
#
# gehe in das verzeichnis in dem die nativ kompilierte version von ug liegt
echo " gehe in ${UG_LIB_FOLDER_LINUX}x64/ "
cd ${UG_LIB_FOLDER_LINUX}x64/

# loesche bereits vorhandenes zip um sicher zustellen
# das kein update des zip gemacht wird sondern ein neues erstellt wird
echo "loesche zip ${ZIP_NAME}"
rm  ${ZIP_NAME}

#zippe die datei libug.so in die datei natives.zip
echo " zip -r ${ZIP_NAME} *.so "
zip -r ${ZIP_NAME} *.so

# LINUX /x86
#
# gehe in das verzeichnis in dem die nativ kompilierte version von ug liegt
echo " gehe in ${UG_LIB_FOLDER_LINUX}x86/ "
cd ${UG_LIB_FOLDER_LINUX}x86/

# loesche bereits vorhandenes zip um sicher zustellen
# das kein update des zip gemacht wird sondern ein neues erstellt wird
echo "loesche zip ${ZIP_NAME}"
rm  ${ZIP_NAME}

#zippe die datei libug.so in die datei natives.zip
echo " zip -r ${ZIP_NAME} *.so "
zip -r ${ZIP_NAME} *.so



# WINDOWS /x64
#
# gehe in das verzeichnis in dem die nativ kompilierte version von ug liegt
#cd /Users/christianpoliwoda/Apps/ug4-git/trunk/lib
echo " gehe in ${UG_LIB_FOLDER_WINDOWS}x64/ "
cd ${UG_LIB_FOLDER_WINDOWS}x64/

# loesche bereits vorhandenes zip um sicher zustellen
# das kein update des zip gemacht wird sondern ein neues erstellt wird
echo "loesche zip ${ZIP_NAME}"
rm  ${ZIP_NAME}

#zippe die datei libug.dll in die datei natives.zip
echo " zip -r ${ZIP_NAME} *.dll "
zip -r ${ZIP_NAME} *.dll

# WINDOWS /x86
#
# gehe in das verzeichnis in dem die nativ kompilierte version von ug liegt
#cd /Users/christianpoliwoda/Apps/ug4-git/trunk/lib
echo " gehe in ${UG_LIB_FOLDER_WINDOWS}x86/ "
cd ${UG_LIB_FOLDER_WINDOWS}x86/

# loesche bereits vorhandenes zip um sicher zustellen
# das kein update des zip gemacht wird sondern ein neues erstellt wird
echo "loesche zip ${ZIP_NAME}"
rm  ${ZIP_NAME}

#zippe die datei libug.dll in die datei natives.zip
echo " zip -r ${ZIP_NAME} *.dll "
zip -r ${ZIP_NAME} *.dll




##
## coping natives part into java project
##

# create OS specific sub folder for native content 
echo "erzeuge ordnerstruktur"
mkdir -p ${COMMON_PART_NATIVES}osx/
mkdir -p ${COMMON_PART_NATIVES}linux/x86
mkdir -p ${COMMON_PART_NATIVES}linux/x64
mkdir -p ${COMMON_PART_NATIVES}windows/x86
mkdir -p ${COMMON_PART_NATIVES}windows/x64
echo ""
echo ""



# copy zip file into project folder
echo "zip-datei wird ins java-projekt kopiert"
cp ${UG_LIB_FOLDER_OSX}${ZIP_NAME} ${COMMON_PART_NATIVES}osx/${ZIP_NAME} 
cp ${UG_LIB_FOLDER_LINUX}x86/${ZIP_NAME} ${COMMON_PART_NATIVES}linux/x86/${ZIP_NAME} 
cp ${UG_LIB_FOLDER_LINUX}x64/${ZIP_NAME} ${COMMON_PART_NATIVES}linux/x64/${ZIP_NAME} 
cp ${UG_LIB_FOLDER_WINDOWS}x86/${ZIP_NAME} ${COMMON_PART_NATIVES}windows/x86/${ZIP_NAME} 
cp ${UG_LIB_FOLDER_WINDOWS}x64/${ZIP_NAME} ${COMMON_PART_NATIVES}windows/x64/${ZIP_NAME} 



##
## part for compiling the java project
##


# gehe ins netbeans projekt
#cd /Users/christianpoliwoda/Apps/VRL-UG4/VRL-UG/
cd ${VRL_UG_JAVA_PROJECT_FOLDER}

#call clean
/usr/local/bin/ant clean

#building jar-file is a 2 step process 
# "build" in netbeans is in ant "ant compile jar"
#call compile
/usr/local/bin/ant compile

#call jar
/usr/local/bin/ant jar

# kopiere die vrl-ug nach 
cp /Users/ug/Apps/VRL-UG/VRL-UG/dist/VRL-UG.jar $RLS_DIR/final-jars/

#
# make a sound if ready with all compilings

# go into project folder
cd /Users/ug/Local/neurobox/VRL-UserData
sed -i.bak 's/\(vrl\.dir\).*/\1=\/Volumes\/MacintoshHD2\/neurobox\/final-jars\//' build.properties

cp $RLS_DIR/VRL-UG.jar jars/
cp $RLS_DIR/VRL-UG-API.jar jars/
cp ~/Local/neurobox/VRL/VRL/dist/VRL.jar jars
#cp /Volumes/MacintoshHD2/neurobox/final-jars/VRL-UG.jar jars/
#cp /Volumes/MacintoshHD2/neurobox/final-jars/VRL-UG-API.jar jars/
#cp ~/Local/neurobox/VRL/VRL/dist/VRL.jar jars/

# clean the java project
/usr/local/bin/ant clean

# build the java project
/usr/local/bin/ant compile 

# create a jar file of the java project
/usr/local/bin/ant jar

git stash

cp dist/VRL-UserData.jar $RLS_DIR/final-jars/
