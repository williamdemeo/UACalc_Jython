#!/bin/bash
# Simple setup.sh for configuring Jython for use with UACalc
# William DeMeo <williamdemeo@gmail.com>
# Date: 2013.08.26

cd $HOME
if [ -d ./UACalc]; then
    echo 'ERROR: Directory UACalc already exists...'
    echo 'ERROR:    ...please rename it and run setup.sh again.'
    exit
fi
sudo apt-get install -y git-core curl
# wget http://uacalc.org/uacalc.jar  
# (for now we're including uacalc.jar in the git repo)
git clone https://github.com/williamdemeo/UACalc_Jython.git

if type -p java; then
    echo 'found java executable in PATH'
    _java=java
elif [[ -n "$JAVA_HOME" ]] && [[ -x "$JAVA_HOME/bin/java" ]];  then
    echo 'found java executable in JAVA_HOME'
    _java="$JAVA_HOME/bin/java"
else
    read -p 'No java found. Install it? [Y/n]' -n 1 -r
    echo    # (optional) move to a new line
    if [[ $REPLY =~ ^[Yy]$ ]]
    then
	sudo apt-get install openjdk-7-jdk
    else
	echo 'ERROR: You need java to run jython.'
	exit
    fi
fi

if [[ "$_java" ]]; then
    version=$("$_java" -version 2>&1 | awk -F '"' '/version/ {print $2}')
    echo version "$version"
    if [[ "$version" > "1.5" ]]; then
        echo 'java version is more than 1.5... ok'
    else         
        read -p 'java version is less than 1.5... install new version? [Y/n]' -n 1 -r
	echo    # (optional) move to a new line
	if [[ $REPLY =~ ^[Yy]$ ]]
	then
	    sudo apt-get install openjdk-7-jdk
	else
	    echo 'ERROR: You need java to run jython.'
	    exit
	fi
    fi
fi
cd ~/UACalc/Jython
echo
echo '...UACalc_Jython Setup finished!!!'
echo 
echo 'Now, from within the ~/UACalc/Jython directory,'
echo 'Start Jython with the following command:'
echo
echo '         java -jar jython.jar -i uacalc.py'
echo
echo 'Then look at the file AlgebraConstructionExample.py for some examples'
echo 'of jython/uacalc code you can enter at the jython command line.'
