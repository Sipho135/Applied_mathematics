from vpython import*
import numpy as np
from math import sin, cos


#____________________________________________________
# constants
y0 = 1.0
x0 = 1.0
Polarization = "+"
k  = 2.0
M = 1.0  # mass of the test particles in the xy plane
Radius = 0.1; z0 = 2; # Radius and the Z co-ordinates
Cords = [1 ,  -1 , 0, 1/np.sqrt(2), -1/np.sqrt(2)]
points = [(0, 2), (1, 2), (2, 0), (2, 1), (3, 3), (3, 4), (4, 4), (4, 3)]

def create_spheres():
    return [sphere(radius=Radius, color=color.orange, pos=vector(Cords[point[0]], Cords[point[1]], Cords[z0])) for point in points]
#______________________________________________________
# h_{+} Polarization
def Model_Plus():
    #____________________________________________________
    # test mass [particles] that
    #will be affected by gravitational wave
    #____________________________________________________
    # motion of the test mass as the wave pass by
    test_masses = create_spheres()
    xyLine = test_masses[:4] 
    xyQuad = test_masses[4:]
    dt = 0.01
    t = 0
    while (t < 100):
        rate(100)
        dx = 1-(1/2)*x0*sin(k*t)
        dy = 1+(1/2)*y0*sin(k*t)
        dx1 = 1/np.sqrt(2)-(1/2)*x0*sin(k*t)
        dy1 = 1/np.sqrt(2)+(1/2)*y0*sin(k*t)
        xyLine[0].pos.x = dx
        xyLine[2].pos.y = dy
        xyLine[3].pos.y =-dy                                                           
        xyQuad[0].pos.x = dx1
        xyQuad[0].pos.y =dy1
        xyQuad[1].pos.x = -dx1
        xyQuad[1].pos.y = dy1
        xyLine[1].pos.x =-dx
        xyQuad[2].pos.x =-dx1
        xyQuad[2].pos.y =-dy1
        xyQuad[3].pos.x = dx1
        xyQuad[3].pos.y = -dy1

        t+=dt

#_________________________________________________________
        # h_{x} Polarization
def Model_Cross():
    #____________________________________________________
    # test mass [particles] that
    #will be affected by gravitational wave
    test_masses = create_spheres()
    #____________________________________________________
    # motion of the test mass as the wave pass by
    xyLine = test_masses[:4] 
    xyQuad = test_masses[4:]
    dt = 0.01
    t = 0
    while (t < 100):
        rate(100)
        dx =(1/2)*x0*sin((1/4)*np.pi*k*t);
        dy =(1/2)*y0*sin((1/4)*np.pi*k*t)                                 # the wave is passing to xy-plane and the z-direction
        dx1 = 1/np.sqrt(2)-(1/2)*x0*sin((1/4)*np.pi*k*t);
        dy1 = 1/np.sqrt(2)-(1/2)*y0*sin((1/4)*np.pi*k*t)   
        dx2 = 1/np.sqrt(2)+(1/2)*x0*sin((1/4)*np.pi*k*t);
        dy2 = 1/np.sqrt(2)+(1/2)*y0*sin((1/4)*np.pi*k*t)
        xyLine[0].pos.x = dx; xyLine[0].pos.y = 1
        xyQuad[0].pos.x = -dx1;
        xyQuad[0].pos.y =dy1
        xyQuad[1].pos.x = dx2;
        xyQuad[1].pos.y = dy2
        xyLine[1].pos.x = -dx;
        xyLine[1].pos.y = -1
        xyQuad[2].pos.x =-dx2;
        xyQuad[2].pos.y =-dy2
        xyQuad[3].pos.x = dx1;
        xyQuad[3].pos.y = -dy1
        xyLine[2].pos.y = -dy;
        xyLine[2].pos.x = -1
        xyLine[3].pos.y = dy; xyLine[3].pos.x =1
        t+=dt
#_____________________________________________________________
        # function calls for the Polarizations
choice = input("Enter your Polarization choice [h_{+} or h_{x}] as + or x: \n")
if (choice==Polarization):
    print(Model_Plus())
else:
    print(Model_Cross())
