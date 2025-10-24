--------------
-- Misc 
--------------
-- comment in code

-*
a
multiline
comment
*-

help -- shows help in session
viewHelp -- shows help in browser

help PolynomialRing -- help for a specific function / object 

---------------
-- Polynomials
---------------

-- polynomial ring
R = QQ[x_1 .. x_3]

-- random polynomials of degree 4 in R
f = random(4, R)
g = random(4, R)

gcd(f, g)
lcm(f, g)

I = ideal(f, g)
II = radical I

-- checking equality of ideals uses Groebner bases behing the scenes
II == I

S = QQ[y_1 .. y_10]
m = map(R, S, monomials (sum gens R)^3)
-*
-- same as defining the map as:
m = map(R,S,{x_1^3, x_1^2*x_2, x_1*x_2^2, x_2^3, x_1^2*x_3, x_1*x_2*x_3, x_2^2*x_3, x_1*x_3^2, x_2*x_3^2, x_3^3}) 
*-
m(y_1)
m(y_2)
m(y_1+y_2)

J = ker(m) -- kernel of ring map
gens J -- is a matrix

transpose gens J -- might be easier to read

--------------------
-- Data types
--------------------

i = 0 
class i -- integer (ZZ)
i += 1 -- increment by 1

L = {1,2,3} -- list
L | L -- join lists together
L_0 -- index into a list
L#0 -- can also use '#' for indexing into lists

S = (1,2,3) -- sequence

s = "hello world" -- string
print(s)

H = hashTable {1 => 2, 2 => 5, 4 => 10} -- HashTable
H#1
keys H
values H

M = matrix {{1,2,3},{4,5,6}}
N = transpose matrix {gens R}
M*N

entries (M*N)
oo -- last output
flatten oo -- flatten a lits

-- By default all datatypes are immutable
-- there are Mutable variants of these datatypes 

-------------------
-- Control flow
-------------------

-- statements separated by ';' output the last item
(x := 1; -- create local variable x set to 1
 x += 1; -- increment x by 1
 x) -- return x

(x := 1; x += 1;) -- doesn't return anything 

-- basic functions
f = x -> x^2 
f(3)
f 3 -- don't need brackets for single arguments
f f 2 -- chain functions together

if f f 2 == 16 then print "yes" else print "no"

-- if statements can return values
x = if 1 == 2 then 1 else 2  -- x = 2

fib = n -> (
  if n <= 1 then (
    1
    )
  else (
    fib(n-1) + fib(n-2)
    )
  )

-- for loops with integer ranges
for i from 0 to 10 do print fib i

-- for loops over lists
for i in {1,3,4,7} do print i

-- for loops can return lists
for i from 0 to 10 list (
  x := fib i; -- local variable in the loop
  print(i, x);
  if x % 2 == 0 then (
    -- x % 2 means tabke the remainder on dividing x by 2
    fib i
    ) 
  else (
    continue -- skip entry in the for loop
    )
  )
-- this returns a list of even fib(i)   

-- while loops repeat until the condition is satisfied
i = 0
while i < 10 do (
i += 1;
)

-- these loops can do more, for more help and examples see:
help "for"
help "while"

--------------------
-- Packages
--------------------

-- code in Macaulay2 is usually created and spread as Packages
-- see:
help "packages"
help "packages provided with Macaulay2"

-- Good packages usually have readable documentation with lots of examples
-- use 'help [Package Name]' to access the documentation

installPackage "NumericalAlgebraicGeometry" -- installing creates all the documentation
help NumericalAlgebraicGeometry
-- Note: some packages with *Gold stars* have papers that accompany them
-- These papers should explain some of the theory behind the package and 
-- how the package helps with computing examples etc.



----------------------------
monomialIdealRadical = I -> (
    M := first entries gens I;
    R := ring I;
    ideal for f in M list (
        -- f is a generator of the ideal I (assume to be monomial ideal)
        e := for i in first exponents f list (
            -- i is an exponent of a generator of I
            if i > 0 then 1 else 0
            );
        R_e -- the new monomial without higher exponents
        )
    )

monomialIdealRadical(ideal(R_{0,0,1}, R_{2,1,0},R_{1,2,3}))
mingens oo
