function [best_x, best_f, max_FEs, best_f_iter] = DE(x,f,N,D, FE_max, fun, err, LB, UB, opt_f,normalize)
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


% index of the global best particle
% [best_f, g] = min(p_f);

FEs=N; % N initialisations.  
stop = 0;

t1 = 0.1;
t2 = 0.1;
Fu = 0.9;
Fl = 0.1;

Finit = Fl * ones(N,1) + rand(N,1)*Fu;
CRinit = rand(N,1);
x2 = [x Finit CRinit];
value = f;

best_f = min(value);
best_f_iter_count = 1;
best_f_iter = zeros(1,FE_max/N);
best_f_iter(best_f_iter_count) = best_f;


while stop<1
    % new F and CR
    for i=1:N
        if rand(1) < t1
            x2(i,D+1) = Fl + rand(1) * Fu;
        end
        if rand(1) < t2
            x2(i,D+2) = rand(1);
        end
    end

    % Mutation
    for i=1:N
        rs=randperm(N-1);
        for j=1:3
            if rs(j) >= i
                rs(j)++;
            end
        end
        #v(i,:) = x2(rs(1),:) + x2(i,D+1) * (x2(rs(2),:)-x2(rs(3),:));
        v(i,:) = x2(rs(1),1:D) + x2(i,D+1) * (x2(rs(2),1:D)-x2(rs(3),1:D));
        for j=1:D
            if v(i,j) > UB(j)
                v(i,j) = UB(j);
            elseif v(i,j) < LB(j)
                v(i,j) = LB(j);
            end
        end
    end

    % Crossover
    for i=1:N
        #rn = ceil(rand(1)*(D+2));
        rn = ceil(rand(1)*(D));
        #for j = 1:D+2
        for j = 1:D
            if rand(1) <= x2(i,D+2) || j == rn
                u(i,j) = v(i,j);
            else
                u(i,j) = x2(i,j);
            end
        end
    end

    % Selection
    for i=1:N
        newvalue = CEC2005func(u(i,1:D),fun,opt_f);
        FEs++;
        if( newvalue < value(i))
            #x2(i,:) = u(i,:);
            x2(i,1:D) = u(i,:);
            value(i) = newvalue;
        end
    end

    best_f = min(value);
    best_f_iter_count++;
    best_f_iter(best_f_iter_count) = best_f;

    if (FEs>=FE_max)
        stop=1;  
    end
    
end %t


[best_f,ind] = min(value);
best_x = x2(ind,1:D);
max_FEs = FEs;

end %DE
