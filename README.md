# Applied_mathematics 
project involving the simulation of gravitational waves flowing through space. These codes were written in two languages: Python and Matlab. These models are based on Einstein's general relativity theory, and we basically explain what happens when two bodies of mass in space merge, how the space around them bends and ripples are sent out into space, and how this project models the movement of those ripples. Gravitational effect animation code consists of three methods. The main function does not take any parameters and does not explicitly return anything, but it does initialise metrices and meshgrid to store values in. Then there are two aid functions: the Binary System, which accepts five inputs and generates animation frames for a Binary system, and the Deformation of Spacetime, which generates animation for the Deformation of Spacetime.

gravitationalWave.py mimics what would happen if test particles were placed far enough away from the gravity source that the masses of the gravitational source had no influence. Then, if you arrange unit mass test masses on a circle of radius 2, with the gravitational wave flowing in the z-direction, you obtain two types of polarisation: cross polarisation and plus polarisation.

The code has four functions: one that generates spheres for test particles, one that mimics cross polarisation, one that simulates plus polarisation, and one that serves as the primary method.

## How the codes work
For the Matlab code, not special parameters needed, execute Gravitational_effect_animation.m, it will call the other two functions (binarySystemGIF and deformationGIF).

For the python code, execute the whole code, it will ask the user for an input, the you choose which type of polarization of the gravitational wave you want to observe, that choice is made by either typing + or x as an input.