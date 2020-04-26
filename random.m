clear all;
k=2;
N=50;

b=[2 3 5 7 11 13 17 19 23 29 31 37 41 43 47 53 59 61 67 71 73 79 83 89 97];

for n=1:N
  for i=1:k
    Y(i,n)=rand(1);
  end
end


figure(1);
clf;
hold on;
axis([0 1 0 1]);

plot(Y(1,:),Y(2,:),'bo','DisplayName',"Uniform random number");
xlabel('dim 1');
ylabel('dim 2');
legend('show');