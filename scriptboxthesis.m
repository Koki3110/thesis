pkg load stk;
pkg load statistics;

D = 6;
fun = 7;
N = 50;
maxiter = 10000/N;
%name = "de_modified";
name = "pso";

filename10 = ["boxplotpresen",name, num2str(D),"df",num2str(fun),"_",num2str(N),"ps.png"];
%filename5 = ["myresults",name,num2str(D),"df",num2str(fun),"_",num2str(N),"ps.txt"];
%filename5 = ["myresults",name,num2str(D),"df",num2str(fun),"_2",".txt"];
filename5 = ["myresults",name,num2str(D),"df",num2str(fun),".txt"];
load ('-force', filename5);
%titlename2 = ["The global-best PSO (w = 1.0, c_1 = c_2 = 0.5), Sphere function",", ",num2str(D),"D, ",num2str(N)," particles"];
%titlename2 = ["DE",", ","F",num2str(fun),", ",num2str(D),"D, ",num2str(N)," particles"];
titlename2 = ["PSO",", ","F",num2str(fun),", ",num2str(D),"D, ",num2str(N)," particles"];

    figure(1); clf; hold on;
    axis("nolabel");
    axis("labely");
    %axis([0 4 0 100000]);
    title(titlename2);
    boxplot([best_f_iter1(:,maxiter) best_f_iter2(:,maxiter) best_f_iter3(:,maxiter)]);
    set(gca (), "xtick", [1 2 3], "xticklabel", {"Pseudo-random", "HaltonRR2","Sobol"});
    %set(gca, 'YScale', 'log');
    ylabel('global best error');
    print (filename10);

quantile(best_f_iter1(:,maxiter))
quantile(best_f_iter2(:,maxiter))
quantile(best_f_iter3(:,maxiter))
pval
