#!/bin/bash
# Simple setup.sh for configuring Jython for use with UACalc
# William DeMeo <williamdemeo@gmail.com>

echo
echo 'This script will install the software and configuration files'
echo 'necessary to use the command line version of UACalc.'
echo
echo 'Here is a summary of what this script does:'
echo
echo '    1.  Setup UACalc home directory.'
echo "    2.  Install Git and clone the UACalc_Jython GitHub repository."
echo "    3.  Setup Java (openjdk-7-jdk), unless a suitable JRE is already present."
echo "    4.  Create symbolic link to uacalc command."
echo
read -p 'Abort this setup script? [Y/n]' -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]] 
then
    echo
    echo 'Setup aborted.'
    echo
    exit
fi
echo
echo
echo "Step 1.  Setting up UACalc home directory."
echo

cd $HOME
#
# If ~/UACalc doesn't already exist, create it.
#
uacalc_path=$HOME'/UACalc'
mkdir -p $uacalc_path

#
# If ~/UACalc/Algebras already exists, ask if it should be renamed. 
# If not, then .ua algebra files from the UACalc_Jython repository might overwrite 
# existing files in the UACalc/Algebras directory, if the latter are older.
#
uacalc_algebras_path=$uacalc_path'/Algebras'
if [ -d $uacalc_algebras_path/ ]; then
    echo '         Directory '$uacalc_algebras_path' already exists...'
    read -p '         Rename it? [Y/n]' -n 1 -r
    if [[ $REPLY =~ ^[Yy]$ ]]
    then
	mv $uacalc_algebras_path $uacalc_algebras_path'_'$(date +'%Y%m%d:%H:%M')
	# Create new empty Algebras directory:
	mkdir $uacalc_algebras_path 
    else
	echo
	echo "         You have chosen to NOT rename the existing directory,"
	echo
	echo "             "$uacalc_algebras_path
	echo
	echo "         If you proceed, then .ua algebra files in that directory may be overwritten"
	echo "         if they are older than files with the same name in the UACalc_Jython repository."
	echo
	read -p '         Abort setup? [Y/n]' -n 1 -r
	echo
	if [[ $REPLY =~ ^[Yy]$ ]]
	then
	    echo
	    echo "         Aborting setup. "
	    echo "         Please backup your "$uacalc_algebras_path" and try again."
	    echo
	    exit
	fi
    fi
else
    mkdir $uacalc_algebras_path 
fi


#
# If the directory ~/UACalc/UACalc_Jython already exists,
# ask if it should be renamed (otherwise setup will be aborted).
#
uacalc_jython_path=$uacalc_path'/UACalc_Jython'
if [ -d $uacalc_jython_path/ ]; then
    echo '         Directory '$uacalc_jython_path' already exists...'
    read -p '         Rename it? [Y/n]' -n 1 -r
    if [[ $REPLY =~ ^[Yy]$ ]]
    then
	echo $(date +'%Y%m%d:%H:%m')
	mv $uacalc_jython_path $uacalc_jython_path'_'$(date +'%Y%m%d:%H:%M')
    else
	echo
	echo '         Aborting setup. '
	echo '         Please rename '$uacalc_jython_path' and try again.'
	echo
	exit
    fi
fi

echo 
echo "Step 2.  Installing Git and cloning UACalc_Jython GitHub repository."
echo
sudo apt-get install -y git-core

# Change into $HOME/UACalc before cloning the git repo.
cd $uacalc_path
git clone https://github.com/UACalc/UACalc_Jython.git

# Copy .ua algebra files from UACalc_Jython/Algebras to ~/UACalc/Algebras directory.
# If they already exist, rename with ~ extension.
uacalc_jython_algebras_path=$uacalc_jython_path'/Algebras'
echo
echo "         Copying .ua algebra files"
echo
echo "            FROM  "$uacalc_jython_algebras_path
echo
echo "            TO    "$uacalc_algebras_path
echo 
echo "         Any matching .ua files will be renamed with .ua~ extension."
echo
cp -b $uacalc_jython_algebras_path/*.ua $uacalc_algebras_path/

echo
echo "Step 3.  Setting up Java."
echo
if type -p java; then
    echo '         Found Java executable in PATH.'
    _java=java
elif [[ -n "$JAVA_HOME" ]] && [[ -x "$JAVA_HOME/bin/java" ]];  then
    echo '         Found Java executable in JAVA_HOME.'
    _java="$JAVA_HOME/bin/java"
else
    echo
    read -p '         No Java found. Install it? [Y/n]' -n 1 -r
    echo    # (optional) move to a new line
    if [[ $REPLY =~ ^[Yy]$ ]]
    then
	sudo apt-get install openjdk-7-jdk
    else
	echo 
	echo '         Aborting setup.'
	echo
	exit
    fi
fi

#
# Check Java version is recent enough.
#
if [[ "$_java" ]]; then
    version=$("$_java" -version 2>&1 | awk -F '"' '/version/ {print $2}')
    echo version "$version"
    if [[ "$version" > "1.5" ]]; then
        echo '         java version is more than 1.5... ok'
    else         
        read -p '         java version is less than 1.5... install new version? [Y/n]' -n 1 -r
	echo    # (optional) move to a new line
	if [[ $REPLY =~ ^[Yy]$ ]]
	then
	    sudo apt-get install openjdk-7-jdk
	else
	    echo '         '
	    echo '         Aborting setup. (You need a recent version of Java to use Jython.)'
	    echo 
	    exit
	fi
    fi
fi

echo
echo "Step 4.  Create symbolic link to uacalc command."
echo
if [ ! -d $HOME/bin/ ]; then
    mkdir -v $HOME/bin
fi
uacalc_name='uacalc'
uacalc_fqname=$HOME'/bin/'$uacalc_name
echo '         Adding a link to startup script at '$uacalc_fqname
if [ -h "$uacalc_fqname" ]; then
    echo ""
    echo "         "$uacalc_fqname" already exists."
    read -p '         Rename it? [Y/n]' -n 1 -r
    if [[ $REPLY =~ ^[Yy]$ ]]
    then
	mv $uacalc_fqname $uacalc_fqname'_'$(date +'%Y%m%d:%H:%m')
    else
	echo 
	echo "         Aborting setup. (Please rename "$uacalc_fqname" and try again.)"
	echo
	exit
    fi
fi
ln -s $uacalc_jython_path/uacalc_jython $uacalc_fqname
echo
echo
echo '   ...UACalc_Jython Setup finished!!!'
echo
echo '   To run the Jython interpreter CL interface to uacalc, enter'
echo
echo '       '$uacalc_name
echo
echo '   a the prompt in a terminal window.'
echo
echo '   If you get command not found, enter the fully qualified'
echo '   name of the startup script:'
echo 
echo '       '$uacalc_fqname
echo
echo '   Look at the file AlgebraConstructionExample.py for some examples'
echo '   of Jython/UACalc code you can enter at the Jython >>> prompt.'
echo
