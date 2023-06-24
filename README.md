# Drone-navigation-based-on-circular-signages

The matlab function h_d_estimate(E,f,r) estimates the altitude 'h' and the distance 'd' on the signage plane, of the camera with respect to the center of the circular target.

 Inputs:
 E is the 3x3 matrix of the ellipse in the image plane of the camera.
 f is the focal length of the camera.
 r is the radius of the circular target.

 Outputs:
 h is the height (altitude) of the camera center with respect to the    signage plane.
 d is the distance of the camera from the target center in the target plane, i.e. the length of the projection on the signage plane of the vector joining the centers of the camera and of the circle.
