UACalc_Jython
=============

Authors
-------
William DeMeo and Ralph Freese

Synopsis
--------
Install and setup the command line version of the Universal Algebra Calculator (UACalc).

Details
-------
The Universal Algebra Calculator is a powerful software system for general algebra.  
It comes with a useful and intuitive graphical user interface and can be easily run from 
any computer with a Java runtime environment.  The UACalc is open source software written 
in Java and is available at http://uacalc.org

For certain tasks, working with UACalc from a command line using Python syntax is more 
convenient than using the gui interface.  The files in this repository are useful for
setting up a computer to run the Jython interpreter with the dependencies required to make use
of UACalc Java classes from the Jython command line.

Installation
------------
The setup.sh script in this repository will automatically set up everything on Ubuntu Linux.  
If you are not using Ubuntu, you can read the comments in the setup.sh file, and do the analogous 
steps for your platform.  (We are in the process of generalizing the setup.sh script so that it 
works on other flavors of Linux, and eventually on Macs too.)

On Ubuntu Linux, there is no need to download this repository.  Simply issue the following 
commands in a terminal window (at the shell prompt):

1.  wget https://raw.github.com/UACalc/UACalc_Jython/master/setup.sh

2.  chmod a+x setup.sh

3.  ./setup.sh


Running
-------
Once you have successfully run setup.sh (or followed the analogous steps for your platform),
you can run the Jython interpreter with UACalc dependencies by typing `uacalc` at the prompt 
in a terminal window.

After a few seconds, you should see the Jython >>> prompt and you should be able to import 
UACalc classes.  To test this, first try something like this:

    >>> from org.uacalc import alg
    >>>

If this produces an error, something is wrong.  

If you get the >>> prompt, then it's probably working, in which case you can look in the file 

    UACalc_Jython/Jython/AlgebraConstructionExample.py 

for some examples of things you can try at the Jython >>> prompt.


Feedback/Help
-------------
Please send us feedback, or ask for help, especially if the installation script 
in this repo does not work on your system.
