#!/bin/bash
# Simple setup.sh for configuring Jython for use with UACalc
# William DeMeo <williamdemeo@gmail.com>


echo
echo 'This script will install the software and configuration files'
echo 'necessary to use the command line version of UACalc.'
echo
cd $HOME
uacalc_jython_path=$HOME'/UACalc_Jython'
if [ -d $uacalc_jython_path/ ]; then
    echo 'Directory '$uacalc_jython_path' already exists...'
    read -p 'Rename it? [Y/n]' -n 1 -r
    if [[ $REPLY =~ ^[Yy]$ ]]
    then
	echo $(date +'%Y%m%d:%H:%m')
	mv $uacalc_jython_path $uacalc_jython_path'_'$(date +'%Y%m%d:%H:%M')
    else
	echo 'Aborting setup. (Please rename UACalc_Jython and try again.)'
	exit
    fi
fi
sudo apt-get install -y git-core curl
# wget http://uacalc.org/uacalc.jar  
# (for now we're including uacalc.jar in the git repo)
#git clone https://github.com/williamdemeo/UACalc_Jython.git
wget https://github.com/williamdemeo/UACalc_Jython/archive/master.zip
if [ -d ./UACalc_Jython-master/ ]; then
    mv UACalc_Jython-master UACalc_Jython-master-tmp
fi
unzip master.zip
rm -f master.zip
mv UACalc_Jython-master UACalc_Jython
if [ -d ./UACalc_Jython-master-tmp/ ]; then
    mv UACalc_Jython-master-tmp UACalc_Jython-master
fi

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
	echo 'Aborting setup.'
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
	    echo 'Aborting setup. (You need java to use Jython.)'
	    exit
	fi
    fi
fi

if [ ! -d $HOME/bin/ ]; then
    mkdir -v $HOME/bin
fi
uacalc_name='uacalc_jython'
uacalc_fqname=$HOME'/bin/'$uacalc_name
echo 'Adding a link to startup script at '$uacalc_fqname
if [ -h "$uacalc_fqname" ]; then
    echo ""
    echo $uacalc_fqname" already exists."
    read -p 'Rename it? [Y/n]' -n 1 -r
    if [[ $REPLY =~ ^[Yy]$ ]]
    then
	mv $uacalc_fqname $uacalc_fqname$(date +'%Y%m%d:%H:%m')
    else
	echo "Aborting setup. (Please rename "$uacalc_fqname" and try again.)"
	exit
    fi
fi
ln -s $uacalc_jython_path/uacalc_jython $uacalc_fqname

echo
echo '...UACalc_Jython Setup finished!!!'
echo 
echo 'To run the Jython interpreter CL interface to uacalc, enter'
echo
echo '    '$uacalc_name
echo
echo 'a the prompt in a terminal window.'
echo
echo 'Look at the file AlgebraConstructionExample.py for some examples'
echo 'of Jython/UACalc code you can enter at the Jython >>> prompt.'
