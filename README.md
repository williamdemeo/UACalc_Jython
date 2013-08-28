UACalc_Jython
=============

Authors
-------
William DeMeo and Ralph Freese

Synopsis
--------
Files needed for running UACalc from the command line.

Details
-------
The Universal Algebra Calculator (UACalc) is a powerful software
system for general algebra.  It comes with a very useful and 
intuitive graphical user interface and can be easily run from 
any computer with a Java runtime environment.  It is available
at http://uacalc.org

For certain tasks, working with UACalc from a command line using Python 
syntax is more convenient than using the gui interface.
This repository contains files that help configure a computer for
running the Jython interpreter, and for setting up dependencies so 
that you can work with UACalc classes from the Jython command line.

Installation
------------
For now, the installation is easy on Debian based Linux systems (like Ubuntu).  
We are in the process of generalizing the simple installation script so that it 
works on other flavors of Linux, and eventually on Macs as well.

On Ubuntu Linux (or any linux with apt-get package manager installed),
issue the following commands in a terminal window (at the shell prompt):

1.  wget https://raw.github.com/williamdemeo/UACalc_Jython/master/uacalc_setup.sh

2.  chmod a+x uacalc_setup.sh

3.  ./uacalc_setup.sh


Running
-------
Once you have installed Jython and the UACalc dependencies, you can run the 
Jython interpreter by entering the following in a terminal window:

    uacalc_jython

You should see the Jython >>> prompt and you should be able to import UACalc
classes.  To test this, first try something like this:

    >>> from org.uacalc import alg
    >>>

If this produces an error, something is wrong.  

If you get the >>> prompt, then it's probably working, in which case you can
look in the file 

    UACalc_Jython/Jython/AlgebraConstructionExample.py 

for some examples of things you can try at the Jython >>> prompt.


Feedback/Help
-------------
Please send us feedback, or ask for help, especially if the installation script 
in this repo does not work on your system.

