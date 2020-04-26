function [best_x, best_f, max_FEs, best_f_iter] = SPSO2011(x,f,N,D, FE_max, fun, err, LB, UB, opt_f,normalize)
% Standard PSO 2011
% Translated from the C version by 
% Dr. Mahamed G.H. Omran (omran.m@gust.edu.kw) 7-May-2011

% Modified and improved by: Maurice Clerc 
% 2011-05-23
% 2018-04 (test options)

% x swarm
% f swarm fitness
% N swarm size
% fun -- function specifier
% D -- Problem dimension
% LB -- Lower bound
% UB -- Upper bound
% opt_f -- global optimum for fun

% Compatibility with the original C version
% 
% 1) RNG and numerical instability.
% 
% We (Clerc and Omran) conducted several experiments on some benchmark functions. 
% For several functions the results are very similar to the ones of 
% the C version while for one function (CEC F6) the SR is really different:
% 
% F6 results (C code):
% a) No normalization
% Avg. fitness = 5.69e+01 (2.06e+02)
% SR= 49.20 %
% 
% b) Normalization
% Avg. fitness = 6.44e+01 (1.57e+02)
% SR= 37.2 %
% 
% F6 results (Matlab code)
% a) No normalization
% 
% Avg. fitness = 6.05e+01(1.58e+02) 
% SR = 0%
% 
% b) Normalization
% 
% Avg. fitness = 5.12e+01(1.37e+02) 
% SR = 0%
% 
% We suspect that there is a problem with the Matlab RNG and/or numerical 
% instability (we implemented a simple RNG using C and Matlab and run our 
% programs and still we got different results).
% 
% 2) Normalization
% 
% It is recommended that you use this option (i.e. randomize = 1) when 
% the search space in not a hypercube. 
% If the search space is a hypercube, It is better not normalize 
% (there is a small difference between the position without 
% any normalisation and the de-normalised one.).
% 
% 3) Random permutation
% 
% The random permutation of the numbering of the particles before 
% each step is not included in the Matlab version(usually, it does not 
% make a great difference in the C version).

stagndetect=false; % For tests. Not part of the standard
localsearch=4; % Useful only if stagndetect is true

unif=0; % Rand in hypersphere. 0 => non uniform,
          % 1 => uniform

w = 1/(2*log(2));
c1 = 0.5 + log(2);
c2 = c1;

% x=zeros(N,D);

% velocity
v = zeros(size(x));

if (normalize>0)
    xMin=0;
    xMax=1;
end

for i=1:1:N
    for j=1:1:D
        if (normalize==0)
            xMin=LB(j);
            xMax=UB(j); 
        end
        
        % x(i,j) = alea(xMin,xMax);
        v(i,j) = alea(xMin-x(i,j), xMax-x(i,j));  
    end
end

% f = zeros(1,N);

% calculate fitness
%{
for i = 1:1:N
    if (normalize>0) 
      f(i) = func((x(i,:) .* (UB - LB) + LB), fun,opt_f);  
    else
          f(i) = func(x(i,:),fun,opt_f);
    end 
end
%}

% initialize the personal experience
p_x = x;
p_f = f;

% index of the global best particle
[best_f, g] = min(p_f);

FEs=N; % N initialisations.  

% K neighbors for each particle -- based on Clerc description 
% http://clerc.maurice.free.fr/pso/random_topology.pdf
% P. 2 (Method 2)
K = 3;

p=1-power(1-1/N,K); % Probability to be an informant

stop=0;
  stagNb=0;
  stagn=true;
count=0;

best_f_iter_count = 1;
best_f_iter = zeros(1,FE_max/N);
best_f_iter(best_f_iter_count) = best_f;
  
while stop<1

    % In the C version, random permutation is applied here. This is
    % currently not implemented in this code.

        %if count > 0  % No improvement of the best solution. So randomize topology 
          
          if stagn
            L = eye(N,N); % Each particle informs itself
            count=0;
           % L=zeros(N,N); % Each particle does not inform itself
            %{
              Matlab function eye does not exist in FreeMat
            L=zeros(N,N);
            for s=1:1:N
                L(s,s)=1;
            end
            %}
            
            for s = 1:1:N % Each particle (column) informs at most K other at random   
                for r=1:1:N
                if (r~=s)
                if (alea(0,1)<p)
                    L(s,r) = 1;
                end
                end
        
                end
            end
            
        end % if count>0
  
    FEprev=FEs;
    for i = 1:1:N  % Move the particles 
         
        %  ...find the best informant g
				MIN = Inf;  
        for s=1:1:N
            if (L(s,i) == 1)
               % if p_f(s) < MIN
               if p_f(s) <= MIN
                    MIN = p_f(s);
                    g_best = s;
                end
            end
        end

		% define a point p' on x-p, beyond p
        p_x_p = x(i,:) + c1*(p_x(i,:) - x(i,:));
        
        % ... define a point g' on x-g, beyond g
        p_x_l = x(i,:) + c2*(p_x(g_best,:) - x(i,:));
        
        if (g_best == i) % If the best informant is the particle itself, define the gravity center G as the middle of x-p' 
            G = 0.5*(x(i,:) + p_x_p);
        else % Usual  way to define G
            sw = 1/3;
            G = sw*(x(i,:) + p_x_p + p_x_l);
        end


        rad = norm(G - x(i,:)); % radius = Euclidean norm of x-G  
        
        x_p = alea_sphere(D,rad,unif)+ G; % Generate a random point in the hyper-sphere around G (uniform distribution)       
        v(i,:) = w*v(i,:) + x_p - x(i,:); % Update the velocity = w*v(t) + (G-x(t)) + random_vector 
																					% The result is v(t+1)
        x(i,:) = x(i,:) + v(i,:); % Apply the new velocity to the current position. The result is x(t+1)
 
%Check for constraint violations
for j = 1:1:D
    if (normalize==0)
        xMin=LB(j);
        xMax=UB(j); 
    else
        xMin = 0;
        xMax = 1;
    end      
    
    if x(i,j) > xMax
        x(i,j) = xMax;
        v(i,j) = -0.5*v(i,j); % variant: 0
    end
    
    if x(i,j) < xMin
        x(i,j) = xMin;
        v(i,j) = -0.5*v(i,j); % variant: 0
    end   
end %j
 
    if (normalize>0) 
      f(i) = CEC2005func((x(i,:) .* (UB - LB) + LB), fun,opt_f);
   % f(i) = rosenbrock(x(i,:).* (UB - LB) + LB); 
  
    else
          f(i) = CEC2005func(x(i,:),fun,opt_f); 
    end  

        FEs = FEs + 1;
        if (FEs>=FE_max) % Too many FE
            break; 
        end     
    end % End loop on particles
  
   if stagndetect % Probabilistic stagnation detection
     stagn=stagnation(best_f,min(f),FEprev,FEs);
    
       % Local search if stagnation
   if stagn
     stagNb=stagNb+1;
     if FE_max>FEs
      [x1,f1,FEs]=localSearch(fun, opt_f,x(g,:),LB,UB,FE_max,FEs,localsearch) ;
      x(g,:)=x1;
      p_f(g)=f1;
     end
   end 
  end
    
    % Update personal best   
    for i=1:1:N
        if f(i) <= p_f(i)
            p_x(i,:) = x(i,:);
            p_f(i) = f(i);
        end %if
    end %i
    
  
   [b_f, g] = min(p_f);
   
    % Update global best 
    if b_f < best_f
        best_f = b_f;
        count = 0;  
    else
        count = count + 1; % If no improvement, the topology 
        %         will be initialised for the next iteration
        if ~stagndetect % Can be seen as a rudimentary stagnation detection
          stagn=true;
        end
          
    end
    
       
    %if (min(p_f) < err) || (FEs>=FE_max)
    %if (best_f < err) || (FEs>=FE_max)
    %  stop=1;  
    %end

    best_f_iter_count++;
    best_f_iter(best_f_iter_count) = best_f;

    if (FEs>=FE_max)
      stop=1;  
    end
    
end %t

if normalize > 0
    best_x = p_x(g,:) .* (UB - LB) + LB;
else
    best_x = p_x(g,:);
end

max_FEs = FEs;

if stagn
 % fprintf('\n stagnations %i',stagNb); 
end

end %SPSO2011
