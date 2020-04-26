function [x] = alea_sphere(D, radius, unif)
%*  ******* Random point in a hypersphere ********
% Put  a random point inside the hypersphere S(0,radius) (center 0, radius 1).
% unif=1 => Uniform distribution
%      0 => non uniform (denser around the centre)

% Developed by: Maurice Clerc (May 2011)
    

% --------- Step 1. Direction
% x=randn(1,D)

for j=1:1:D
    x(j)=alea_normal(0,1); %**
end

l=norm(x);

% --------- Step 2. Random radius
switch unif
  case 0 % Non uniform
  r=alea(0,1);
  case 1 % Uniform
r=alea(0,1)^(1/D);
end

x= r*radius*x/l;
    
end
