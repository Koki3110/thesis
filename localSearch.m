function [x1,f1,FEs]=localSearch(fun,opt_f,x,LB,UB,FEmax,FEs,evalOption)
[N,D]=size(x);

switch evalOption
  case 3
   MaxFunEvals=min(FEmax-FEs,40*N);
  case 4
    MaxFunEvals=min(FEmax-FEs,3*N*D);
  otherwise
  MaxFunEvals=min(FEmax-FEs,4*N*D);
 
end

    TolFun=1.e-6; TolX=1.e-6;
      ff = @(u)func(u,fun,opt_f);
% fmincon.  (Matlab Optimization toolbox)
      %  http://fr.mathworks.com/help/optim/ug/constrained-nonlinear-optimization-algorithms.html
      
      options = optimoptions(@fmincon,'MaxFunEvals',MaxFunEvals,...
        'Display','off','TolX',TolX, 'TolFun',TolFun);
      %,'Algorithm', 'interior-point', ...
      [x1,f1,~,output] = fmincon(ff,x,[],[],[],[],LB,UB,[],options);
         
      FEs=FEs+ output.funcCount;
end