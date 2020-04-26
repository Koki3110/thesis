global  initial_flag

%fun = input("Select a function:");
%D = input("Choose the dimension of the function:");

%numoffuns = 6;

D=10;
%Dar = [4 4 2 3 6 15];


N = 50; %No. of particles
FE_max = 50; %Max. no. of function evaluations

Nr = 50; % No. of runs

%best_f_iter1_meansf1f13 = zeros(13,FE_max/N);
%best_f_iter2_meansf1f13 = zeros(13,FE_max/N);
%best_f_iter3_meansf1f13 = zeros(13,FE_max/N);

rootname = 'schwefel_213_data';
extension = '.txt';

%{
for i = 1:10
    a = randi([-100,100], 100);
    b = randi([-100,100], 100);
    alpha = unifrnd(-pi, pi, 1, 100);
    filename = [rootname, num2str(i), extension];
    save(filename, "a", "b", "alpha");
end
%}

for idata = 9:10

%D = Dar(fun-47);


[LB UB opt_f err] = CEC2005get_fun_info(12,D);

x = zeros(N,D);
qx = zeros(N,D);
qx1 = zeros(N,D);
FE = zeros(1,Nr);
new_f = zeros(Nr,3);
FE1 = zeros(1,Nr);
tot_time = zeros(1,Nr);
tot_time1 = zeros(1,Nr);
FE2 = zeros(1,Nr);
tot_time2 = zeros(1,Nr);

best_f_iter1 = zeros(Nr,FE_max/N);
best_f_iter2 = zeros(Nr,FE_max/N);
best_f_iter3 = zeros(Nr,FE_max/N);

xs=zeros(N,D,Nr);
qxs=zeros(N,D,Nr);
qx1s=zeros(N,D,Nr);
ys=zeros(Nr,D,3);

SR = 0;
SR1 = 0;
SR2 = 0;
SR_a = zeros(Nr,3);

tot_time = 0;
tot_time1 = 0;
tot_time2 = 0;

% p = haltonset(D,'Skip',1e3);
% qr = net(p,N*Nr);
qr = stk_sampling_halton_rr2(N*Nr+1000, D)(1001:N*Nr+1000,1:D);
qr_ind = 1;

% p1 = sobolset(D,'Skip',1e3);
% qr1 = net(p1,N*Nr);
qr1 = stk_sampling_sobol(N*Nr+1000, D)(1001:N*Nr+1000,1:D);
qr1_ind = 1;

for r=1:1:Nr

    initial_flag = 0;
        for i=1:1:N
            for j=1:1:D
                x(i,j) = LB(j) + rand*(UB(j) - LB(j));
                xs(i,j,r) = x(i,j);
            end
        end
    f = zeros(1,N);
    %calculate fitness
    for j = 1:1:N
        initial_flag = 0;
        f(j) = schwefel_213(x(j,:), idata, opt_f);
    end
    new_f(r,1) = min(f);

    for i=1:1:N
        for j=1:1:D
            qx(i,j) = double(LB(j) + qr(qr_ind,j)*(UB(j) - LB(j)));
            qxs(i,j,r) = qx(i,j);
        end
        qr_ind = qr_ind + 1;
    end
 
    qf = zeros(1,N);

    %calculate fitness
    for j = 1:1:N
        initial_flag = 0;
        qf(j) = schwefel_213(qx(j,:), idata, opt_f);
    end
    new_f(r,2) = min(qf);

    for i=1:1:N
        for j=1:1:D
            qx1(i,j) = double(LB(j) + qr1(qr1_ind,j)*(UB(j) - LB(j)));
            qx1s(i,j,r) = qx1(i,j);
        end
        qr1_ind = qr1_ind + 1;
    end

    qf1 = zeros(1,N);

    %calculate fitness
    for j = 1:1:N
        initial_flag = 0;
        qf1(j) = schwefel_213(qx1(j,:), idata, opt_f);
    end
    new_f(r,3) = min(qf1);

end %r

#fprintf("fun = %d\n",fun);
fprintf("D = %d\n",D);
fprintf("No. of particles = %d\n",N);
fprintf('FE_max = %d\n', FE_max);
fprintf("No. of runs = %d\n",Nr);

fprintf('PSO\n');
fprintf('Avg. fitness = %e(%e) SR = %e Avg. FEs = %e(%e)\n', mean(new_f(:,1)),
std(new_f(:,1)), 100*SR/Nr, mean(FE), std(FE));
#fprintf('Avg. time = %e(%e)\n', mean(tot_time), std(tot_time));
fprintf('PSO - Halton Sequence\n');

fprintf('Avg. fitness = %e(%e) SR = %e Avg. FEs = %e(%e)\n', mean(new_f(:,2)),
std(new_f(:,2)), 100*SR1/Nr, mean(FE1), std(FE1));
#fprintf('Avg. time = %e(%e)\n', mean(tot_time1),
#std(tot_time1));

fprintf('PSO - Sobol Sequence\n');
fprintf('Avg. fitness = %e(%e) SR = %e Avg. FEs = %e(%e)\n',
mean(new_f(:,3)),
std(new_f(:,3)), 100*SR2/Nr, mean(FE2), std(FE2));
#fprintf('Avg. time = %e(%e)\n', mean(tot_time2),
#std(tot_time2));

% fprintf('Avg. Err.');
% [p, table, stats] = friedman(new_f);
% c = multcompare(stats,'ctype','dunn-sidak');
[pval, k, df] = kruskal_wallis_test(new_f(:,1),new_f(:,2),new_f(:,3));

pval

alpha = 0.05;
crntrank = 1;
prevbestval = -1;
tienum = 1;
B=0;
new_f_rank = zeros(Nr,3);


while(crntrank<=3*Nr)
    bestval = -1;
    for i=1:(3*Nr)
        if (new_f(i) > prevbestval) && (new_f(i) < bestval || bestval == -1)
            bestval = new_f(i);
            tienum = 1;
        elseif new_f(i) == bestval
            tienum++;
        end
    end
    B+=(tienum^3-tienum)/(12*(3*Nr-1));
    for i=1:(3*Nr)
        if(new_f(i)==bestval)
            new_f_rank(i)=crntrank+(tienum-1)/2;
        end
    end
    crntrank+=tienum;
    prevbestval = bestval;
endwhile

for i=1:3
    T(i) = sum(new_f_rank(:,i));
end

ypersigma = zeros(2,3);

for i=1:2
    for j=(i+1):3
        y=T(i)/Nr - T(j)/Nr;
        sigma = ((3*Nr*(3*Nr+1)/12-B)*(1/Nr*2))^0.5;
        ypersigma(i,j) = y/sigma;
        fprintf("Sample%d, Sample%d\n", i, j);
        fprintf("y/sigma is %e\n", y/sigma);
        if y/sigma < -norminv(1-alpha/(2*3))
            fprintf("Sample%d is better than Sample%d\n", i, j);
        elseif y/sigma > norminv(1-alpha/(2*3))
            fprintf("Sample%d is better than Sample%d\n", j, i);
        else
            fprintf("No significant difference\n\n");
        end
    end
end

pvalpost=ones(2,3)-2*abs(normcdf(ypersigma)-0.5);

%{
best_f_iter1_mean = mean(best_f_iter1);
best_f_iter2_mean = mean(best_f_iter2);
best_f_iter3_mean = mean(best_f_iter3);
%}

%best_f_iter1_meansf1f13(fun,:) = mean(best_f_iter1);
%best_f_iter2_meansf1f13(fun,:) = mean(best_f_iter2);
%best_f_iter3_meansf1f13(fun,:) = mean(best_f_iter3);

save(['myresultscec',num2str(D),'df12_fe50_',num2str(idata), '.txt']);

titlename = ['CEC2005 F12, ',num2str(D), 'D, FE = 50, data',num2str(idata)];
filename2 = ['pvalsboxplotcec', num2str(D) ,'df12fe50data',num2str(idata),'.tif'];
figure(1); clf; hold on;
axis("nolabel");
axis("labely");
title(titlename);
boxplot([new_f(:,1) new_f(:,2) new_f(:,3)]);

set(gca (), "xtick", [1 2 3], "xticklabel", {"Uniform", "Halton","Sobol"});
    #xlabel('iterations');
    ylabel('global best error');
    #legend('show');
#    filename2 = [rootname2, num2str(iscript), extension2];
    print ('-dtiff', filename2);


end

%save myresults.txt best_f_iter1_meansf1f13 best_f_iter2_meansf1f13 best_f_iter3_meansf1f13

