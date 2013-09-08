'''Command line utilities for a command line session of Jython-UACalc.

Created on Jun 23, 2013
@see: AlgebraConstructionExample.py
@author: ralph at math.hawaii.edu, williamdemeo at gmail
'''

import sys
from os.path import expanduser
home = expanduser("~")
jars = home+"/UACalc/UACalc_Jython/Jython/Jars"
sys.path.append(jars+"/uacalc.jar")
sys.path.append(jars+"/LatDraw.jar")

import rlcompleter
import readline
readline.parse_and_bind("tab: complete")

from OperationFactory import Operation
from org.uacalc.alg import BasicAlgebra
from org.uacalc.io import AlgebraIO
from org.uacalc.alg import Malcev
from org.uacalc.alg.conlat import BasicPartition

print "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%"
print "Welcome to the command line version of UACalc!"
print "  to exit type quit()"
print "  (more help coming)"
print "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%"

