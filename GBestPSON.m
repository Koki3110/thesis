function [best_x, best_f, max_FEs, best_f_iter] = GBestPSON(x,f,N,D, FE_max, fun, err, LB, UB, opt_f,normalize)

%w = 1.0;
%c1 = 0.5;
%c2 = 0.5;
w = 1/(2*log(2));
c1 = (w+1)^2 /2;
c2 = c1;
% velocity
vs = zeros(size(x));

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
        vs(i,j) = 0;  
    end
end

% initialize the personal experience
pbs = x;
pbscs = f;

%FEs=N; % N initialisations.  

FEs=0;

[gbsc,gbindex]=min(pbscs);
gb=pbs(gbindex,:);

best_f_iter_count = 0;
best_f_iter = zeros(1,FE_max/N);
#best_f_iter(best_f_iter_count) = gbsc;

stop = 0;

while stop<1
  for i=1:N
    score = CEC2005func(x(i,:),fun,opt_f);
    FEs = FEs + 1;
    %score = criterion(x(:,i));
    if score < pbscs(i)
      pbscs(i) = score;
      pbs(i,:) = x(i,:);
    end
    if score < gbsc
      gbsc = score;
      gb = x(i,:);
    end
  end

  best_f_iter_count++;
  best_f_iter(best_f_iter_count) = gbsc;

  vs = w * vs + c1 * rand(N,D) .* (pbs -x) + c2 * rand(N,D) .* (( ones(N,1) * gb  ) - x);
  x = x + vs;

  if (gbsc < 0.001)
    for counter = best_f_iter_count:FE_max/N
      best_f_iter(counter) = gbsc;
    end
    break;
  end

  if (FEs>=FE_max)
    stop=1;  
  end
    
end %t

best_x = gb;
best_f = gbsc;
max_FEs = FEs;


end