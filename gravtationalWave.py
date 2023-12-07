from vpython import*
import numpy as np
from math import sin, cos, pi



def create_spheres(Cords, points, Radius, z0):
    return [sphere(radius=Radius, color=color.orange, pos=vector(Cords[point[0]], Cords[point[1]], Cords[z0])) for point in points]
#______________________________________________________
# h_{+} Polarization
def Model_Plus(t, t_max, dt, C, x0, y0, k, Param):
    #____________________________________________________
    # test mass [particles] that
    #will be affected by gravitational wave
    #____________________________________________________
    # motion of the test mass as the wave pass by
    test_masses = create_spheres(Param[0], Param[1], Param[2], Param[3])
    xyLine = test_masses[:4] 
    xyQuad = test_masses[4:]
    while (t < t_max):
        rate(t_max)
        wave = 0.5 * sin(k * t)
        for i in range(4):
            if i < 2:
                xyLine[i].pos.x = 1 - x0 * wave if i == 0 else -(1 - x0 * wave)
            else:
                xyLine[i].pos.y = 1 + wave if i == 2 else -(1 + wave)
        for i in range(4):
            xyQuad[i].pos.x = C - y0 * wave if (i == 0 or i == 3) else -(C - y0 * wave)
            xyQuad[i].pos.y = C + y0 * wave if (i == 0 or i == 1) else -(C + y0 * wave) 
        t+=dt

#_________________________________________________________
        # h_{x} Polarization
def Model_Cross(t, t_max, dt, C, x0, y0, k, Param):
    #____________________________________________________
    # test mass [particles] that
    #will be affected by gravitational wave
    test_masses = create_spheres(Param[0], Param[1], Param[2], Param[3])
    #____________________________________________________
    # motion of the test mass as the wave pass by
    xyLine = test_masses[:4] 
    xyQuad = test_masses[4:]
    while (t < t_max):
        rate(t_max)
        wave = 0.5 * sin(0.25 * pi * k * t)
        for i in range(4):
            if i < 2:
                xyLine[i].pos.x = x0 * wave if i == 0 else -x0 * wave
                xyQuad[i].pos.x =-(C-x0 * wave) if i == 0 else C + x0 * wave
                xyLine[i].pos.y = 1 if i == 0 else -1
                xyQuad[i].pos.y = C-y0 * wave if i == 0 else C + y0 * wave
            else:
                xyLine[i].pos.x = -1 if i == 2 else 1
                xyQuad[i].pos.x =-(C + x0 * wave) if i == 2 else C - x0 * wave
                xyLine[i].pos.y =-y0 * wave if i == 2 else y0 * wave
                xyQuad[i].pos.y =-(C + y0 * wave) if i == 2 else -(C - y0 * wave)   
        t+=dt
#_____________________________________________________________
        # function calls for the Polarizations


def main():
    #____________________________________________________
    # constants
    t = 0
    y0 = 1.0
    x0 = 1.0
    k  = 2.0
    dt = 0.01
    t_max = 100
    Radius = 0.1; 
    z0 = 2; # Radius and the Z co-ordinates
    A = 1/np.sqrt(2)

    Cords = [1 ,  -1 , 0, 1/np.sqrt(2), -1/np.sqrt(2)]
    points = [(0, 2), (1, 2), (2, 0), (2, 1), (3, 3), (3, 4), (4, 4), (4, 3)]

    choice = input("Enter your Polarization choice [h_{+} or h_{x}] as + or x: \n")
    if (choice=="+"):
        print(Model_Plus(t, t_max, dt, A, x0, y0 ,k, (Cords, points, Radius, z0)))
    else:
        print(Model_Cross(t, t_max, dt, A, x0, y0, k, (Cords, points, Radius, z0)))
if __name__=='__main__':
    main()