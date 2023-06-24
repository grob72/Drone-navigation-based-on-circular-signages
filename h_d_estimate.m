function [h,d] = h_d_estimate(E,f,r)

% h_d_estimate(E,f,r) estimates the altitude 'h' and the distance 'd' on the
% signage plane, of the camera with respect to the center of the circular
% target.
%
% Inputs:
% E is the 3x3 matrix of the ellipse in the image plane of the camera.
% f is the focal length of the camera.
% r is the radius of the circular target.
%
% Outputs:
% h is the height (altitude) of the camera center with respect to the
%   signage plane.
% d is the distance of the camera from the target center in the target
%   plane, i.e. the length of the projection on the signage plane of the
%   vector joining the centers of the camera and of the circle.

%%%%%%%%%%%%%%%%%% Ellipse reduction %%%%%%%%%%%%%%%%%%%%%%
%
% Finds the rotation matrix in the image plane so that the the reference
% axes are alligned to the axes of the ellipse E.

X=linsolve(E(1:2,1:2),-E(1:2,3));
[V,lambda]=eig(E(1:2,1:2));
V=normc(V);
X=V'*X;
x1=X(1,1);y1=X(2,1);z1=f;
Ecanon=det(E)/det(E(1:2,1:2));
alfa=sqrt(-Ecanon/lambda(1,1));beta=sqrt(-Ecanon/lambda(2,2));

%%%%%%%%%%%%%% First Euclidean invariants %%%%%%%%%%%%%%%%%%%%%
% 
% Calculate the Euclidean invarinats

i1=((alfa/(beta*z1))*(y1^2+z1^2)+(beta/(alfa*z1))*(x1^2+z1^2)-(alfa*beta/z1));
i2=x1^2+y1^2+z1^2-alfa^2-beta^2;
i3=-alfa*beta*z1;

%%%%%%%%%%%%% Estimation of the Altitude and distance %%%%%%%%%
%
% See the article for furhter details.

P1=[i3^2 (-2*i1*i2*i3+i1^3*i3)*r^2 (-2*i1^3*i3+i1^2*i2^2)*r^4 i1^3*i3*r^6];
eta=roots(P1);eta2=eta.^2;eta3=eta.^3;eta4=eta.^4;eta5=eta.^5;
mu=((i1^2*i2^2-i1*i2*i3)*r^6*eta2+(i1^2*i2^2-i1^3*i3-2*i1*i2*i3+i3^2)*r^4*eta3+...
    (i1^3*i3-2*i1*i2*i3+i3^2)*r^2*eta4+i3^2*eta5)/((-i1^4*i2+i1^3*i3)*r^8);
nu=eta-2*mu+r^2;
h=sqrt(mu);
d=sqrt(nu);

