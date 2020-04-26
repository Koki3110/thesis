clear all;
pkg load stk;
pkg load statistics;

D=2;
N=50;

%{
    b=[2 3 5 7 11 13 17 19 23 29 31 37 41 43 47 53 59 61 67 71 73 79 83 89 97];

for n=1:N
  for i=1:k

    y=0;
    f=1.0/b(i);
    fact=1.0/b(i);
    ntemp=n;
    while (ntemp>0)
        t = mod(ntemp, b(i));
        y += t * fact;
        ntemp = (ntemp - t)/b(i);
        fact *= f;
    end
    Y(i,n)=y;
  end
end
%}

%qr = halton(N,D)(1:N,1:D);
qr = stk_sampling_sobol(N,D)(1:N,1:D);
for i=1:N
    for j = 1:D
        qr(i,j) = (randn * 0.05 + qr(i,j));
    end
end

figure(1);
clf;
hold on;
axis([0 1 0 1]);

%plot(qr(:,1),qr(:,2),'bo','DisplayName',"Halton sequence");
%plot(qr(:,1),qr(:,2),'bo','DisplayName',"Sobol sequence");
plot(qr(:,1),qr(:,2),'bo','DisplayName',"Sobol sequence with Gaussian noises");
xlabel('dim 1');
ylabel('dim 2');
legend('show');
#title('Initial value 0.8');
%filename10 = ["halton50.png"];
