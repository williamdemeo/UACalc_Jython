'''Examples demonstrating the construction of UACalc algebras in Jython.

Assuming you have Jython installed, this script can be run from the command line:
  
     jython AlgebraConstructionExample.py
     
Created on Jun 18, 2013
@see: OperationFactory.py
@author: williamdemeo at gmail
'''

from OperationFactory import Operation
from org.uacalc.alg import BasicAlgebra
from org.uacalc.io import AlgebraIO

'''Example 1: Constructing an algebra with operations defined using a Python function.'''
print "---- Example 1 ----"
# define a function
def plus_mod5(args):
    result = 0
    for x in args:
        result = result + x
    return result % 5
     
# use the function above to construct UACalc operations
op0 = Operation(plus_mod5, "binaryPlusMod5", 2, 5)
op1 = Operation(plus_mod5, "ternaryPlusMod5", 3, 5)

print "Quick sanity check of the operations:"
print "   binaryPlusMod5:  4 + 10 mod 5 = ", op0.intValueAt([4,10])
print "   ternaryPlusMod5:  4 + 10 + 1 mod 5 = ", op1.intValueAt([4,10,1])

# make a list of the operations we want in the algebra
ops = op0, op1

# construct the algebra
alg = BasicAlgebra("MyAlgebra", 5, ops)

print "Quick check that we constructed an algebra:"
print "   alg.getName() = ", alg.getName()        
print "   alg.universe() = ", alg.universe()

import os.path
if os.path.exists("../Algebras"):

    # write the algebra to a UACalc file
    AlgebraIO.writeAlgebraFile(alg, "../Algebras/Example1_ConstructAlgebra.ua")
    print "UACalc algebra file created: ../Algebras/Example1_ConstructAlgebra.ua"




'''Example 2: Constructing an algebra with unary operations defined "by hand" as vectors.'''
print "\n---- Example 2 ----"

# The algebra will have universe {0, 1, ..., 7}, and the following unary operations: 
f0 = 7,6,6,7,3,2,2,3
f1 = 0,1,1,0,4,5,5,4
f2 = 0,2,3,1,0,2,3,1

# Use the functions above to construct UACalc operations:
op0 = Operation(f0, "f0", 1, 8)
op1 = Operation(f1, "f1", 1, 8)
op2 = Operation(f2, "f2", 1, 8)

# Make a list of the operations we want in the algebra:
ops = op0, op1, op2

# The above is nice and easy, but the following is more general
# and useful if you want to define many operations:
# Suppose all the operations are stored as a list of lists, as in:
fns = f0, f1, f2
# Build the list of operations by looping through fns:
ops = []
for i in range(len(fns)):
    ops.append(Operation(fns[i], "f"+str(i), 1, 8))

    
# Next we check that the operations are as expected:
print "The unary operations are:"
for i in range(len(ops)):
    print "   " + ops[i].symbol().name() + ":", 
    for j in range(8):
        print ops[i].intValueAt([j]),
    print " "


# Finally, construct the algebra:
alg = BasicAlgebra("MyUnaryAlgebra", 8, ops)

print "\nQuick check that we constructed an algebra:"
print "   alg.getName() = ", alg.getName()        
print "   alg.universe() = ", alg.universe()

if os.path.exists("../Algebras"):

    # Optionally, write the algebra to a UACalc file that can be loaded into the gui.
    AlgebraIO.writeAlgebraFile(alg, "../Algebras/Example2_MutliunaryAlgebra.ua")
    print "UACalc algebra file created: ../Algebras/Example2_MutliunaryAlgebra.ua"
