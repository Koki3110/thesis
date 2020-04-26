
function f=schwefel_213(x, idata, opt_f)%after Fletcher and Powell
global initial_flag
persistent a b A alpha
[ps,D]=size(x);
if initial_flag==0
    initial_flag=1;
    #load schwefel_213_data
    load(['schwefel_213_data',num2str(idata), '.txt']);
    if length(alpha)>=D
        alpha=alpha(1:D);a=a(1:D,1:D);b=b(1:D,1:D);
    else
        alpha=-3+6*rand(1,D);
        a=round(-100+200.*rand(D,D));
        b=round(-100+200.*rand(D,D));
    end
    
    alpha=repmat(alpha,D,1);
    A=sum(a.*sin(alpha)+b.*cos(alpha),2);
    global xSol
xSol=alpha(1,1:D);
end
f = zeros(ps,1);
for i=1:ps
    xx=repmat(x(i,:),D,1);
    B=sum(a.*sin(xx)+b.*cos(xx),2);
    f(i,1)=sum((A-B).^2,1);
end
f = abs(f-opt_f);