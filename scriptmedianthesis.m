pkg load stk;
pkg load statistics;

D = 10;
fun = 30;
N = 20;
maxiter = 1000/N;
%name = "de_modified";
name = "gbestpsoNg_2_";
%name = "gbestpso2_";
%name2 = "Tripod";

filename5 = ["myresults",name,num2str(D),"df",num2str(fun),"_",num2str(N),"ps.txt"];
%filename5 = ["myresults",name,num2str(D),"df",num2str(fun),".txt"];
%filename5 = ["myresults",name,name2,".txt"];
%filename2 = ["summarythesis_",name,name2,".txt"];
%filename5 = ["myresults",name,num2str(D),"df",num2str(fun),"_2",".txt"];
%filename2 = ["summarythesis_",name,num2str(D),"df",num2str(fun),"_",num2str(N),"ps_2.txt"];
%filename5 = ["myresults",name,num2str(D),"df",num2str(fun),".txt"];
load ('-force', filename5);

filename2 = ["summarythesis_",name,num2str(D),"df",num2str(fun),"_",num2str(N),"ps.txt"];
%fid = fopen(filename2,'a');

q1 = quantile(best_f_iter1(:,maxiter));
q2 = quantile(best_f_iter2(:,maxiter));
q3 = quantile(best_f_iter3(:,maxiter));

name
%name2
D
fun
N
maxiter

meanU = mean(best_f_iter1(:,maxiter));
stdU = std(best_f_iter1(:,maxiter));
meanH = mean(best_f_iter2(:,maxiter));
stdH = std(best_f_iter2(:,maxiter));
meanS = mean(best_f_iter3(:,maxiter));
stdS = std(best_f_iter3(:,maxiter));

printf ("meanU = %e\n",meanU);
printf ("stdU  = %e\n",stdU);
printf ("meanH = %e\n",meanH);
printf ("stdH  = %e\n",stdH);
printf ("meanS = %e\n",meanS);
printf ("stdS  = %e\n",stdS);

%{
fprintf("q1\n");
%q1(1)
q1(2)
q1(3)
q1(4)
%q1(5)
fprintf("q2\n");
%q2(1)
q2(2)
q2(3)
q2(4)
%q2(5)
fprintf("q3\n");
%q3(1)
q3(2)
q3(3)
q3(4)
%q3(5)
%}

fprintf("q1\n");
%q1(1)
printf ("%e\n",q1(1));
printf ("%e\n",q1(2));
printf ("%e\n",q1(3));
printf ("%e\n",q1(4));
printf ("%e\n",q1(5));
%q1(5)
fprintf("q2\n");
%q2(1)
printf ("%e\n",q2(1));
printf ("%e\n",q2(2));
printf ("%e\n",q2(3));
printf ("%e\n",q2(4));
printf ("%e\n",q2(5));
%q2(5)
fprintf("q3\n");
%q3(1)
printf ("%e\n",q3(1));
printf ("%e\n",q3(2));
printf ("%e\n",q3(3));
printf ("%e\n",q3(4));
printf ("%e\n",q3(5));
%q3(5)

SRa = 2*SR
SRa1 = 2*SR1
SRa2 = 2*SR2
%pval
printf ("pval  = %.5f\n",pval);
pvalpost
ypersigma

%save(filename2,"q1","q2","q3","meanU","stdU","meanH","stdH","meanS","stdS","SRa","SRa1","SRa2","pval","pvalpost","ypersigma","D","fun","N","maxiter","name","name2");
save(filename2,"q1","q2","q3","meanU","stdU","meanH","stdH","meanS","stdS","SRa","SRa1","SRa2","pval","pvalpost","ypersigma","D","fun","N","maxiter","name");

%q1(2,maxiter);
%{
FITmeanU = mean((new_f(:,1))(not(soruU)));
FITstdU = std((new_f(:,1))(not(soruU)));
FITmeanH = mean((new_f(:,2))(not(soruH)));
FITstdH = std((new_f(:,2))(not(soruH)));
FITmeanS = mean((new_f(:,3))(not(soruS)));
FITstdS = std((new_f(:,3))(not(soruS)));

fprintf(fid, "fun = %d\n",fun);
fprintf(fid, "D = %d\n",D);
fprintf(fid, "No. of particles = %d\n",N);
%fprintf(fid, 'FE_max = %d\n', FE_max);
%fprintf(fid, "No. of runs = %d\n",Nr);

fprintf(fid, "Uniform\n");
fprintf(fid, "Uniform\n");


fprintf(fid, 'GBestpsoN_2\n');
fprintf(fid, 'SUC = %d\n', 100*SR/Nr);
fprintf(fid, 'EVAL = %e(%e)', EVALmeanU, EVALstdU);
fprintf(fid, '\n');
fprintf(fid, 'FIT = %e(%e)', FITmeanU, FITstdU);
fprintf(fid, '\n');

fprintf(fid, 'GBestpsoN_2 - Halton Sequence\n');
fprintf(fid, 'SUC = %d\n', 100*SR1/Nr);
fprintf(fid, 'EVAL = %e(%e)', EVALmeanH, EVALstdH);
fprintf(fid, '\n');
fprintf(fid, 'FIT = %e(%e)', FITmeanH, FITstdH);
fprintf(fid, '\n');

fprintf(fid, 'GBestpsoN_2 - Sobol Sequence\n');
fprintf(fid, 'SUC = %d\n', 100*SR2/Nr);
fprintf(fid, 'EVAL = %e(%e)', EVALmeanS, EVALstdS);
fprintf(fid, '\n');
fprintf(fid, 'FIT = %e(%e)', FITmeanS, FITstdS);
fprintf(fid, '\n');

fprintf(fid, 'GBestpsoN_2\n');
fprintf(fid, 'Avg. fitness = %e(%e) SR = %e Avg. FEs = %e(%e)\n', mean(new_f(:,1)),
std(new_f(:,1)), 100*SR/Nr, mean(FE), std(FE));
fprintf(fid, 'Avg. time = %e(%e)\n', mean(tot_time), std(tot_time));

fprintf(fid, 'GBestPSON_2 - Halton Sequence\n');
fprintf(fid, 'Avg. fitness = %e(%e) SR = %e Avg. FEs = %e(%e)\n', mean(new_f(:,2)),
std(new_f(:,2)), 100*SR1/Nr, mean(FE1), std(FE1));
fprintf(fid, 'Avg. time = %e(%e)\n', mean(tot_time1),
std(tot_time1));

fprintf(fid, 'GBestPSON_2 - Sobol Sequence\n');
fprintf(fid, 'Avg. fitness = %e(%e) SR = %e Avg. FEs = %e(%e)\n',
mean(new_f(:,3)),
std(new_f(:,3)), 100*SR2/Nr, mean(FE2), std(FE2));
fprintf(fid, 'Avg. time = %e(%e)\n', mean(tot_time2),
std(tot_time2));





fprintf("fun = %d\n",fun);
fprintf("D = %d\n",D);
fprintf("No. of particles = %d\n",N);
fprintf('FE_max = %d\n', FE_max);
fprintf("No. of runs = %d\n",Nr);

fprintf('GBestpsoN_2\n');
fprintf('SUC = %d\n', 100*SR/Nr);
fprintf('EVAL = %e(%e)', EVALmeanU, EVALstdU);
fprintf('\n');
fprintf('FIT = %e(%e)', FITmeanU, FITstdU);
fprintf('\n');

fprintf('GBestpsoN_2 - Halton Sequence\n');
fprintf('SUC = %d\n', 100*SR1/Nr);
fprintf('EVAL = %e(%e)', EVALmeanH, EVALstdH);
fprintf('\n');
fprintf('FIT = %e(%e)', FITmeanH, FITstdH);
fprintf('\n');

fprintf('GBestpsoN_2 - Sobol Sequence\n');
fprintf('SUC = %d\n', 100*SR2/Nr);
fprintf('EVAL = %e(%e)', EVALmeanS, EVALstdS);
fprintf('\n');
fprintf('FIT = %e(%e)', FITmeanS, FITstdS);
fprintf('\n');


fprintf('GBestpsoN_2\n');
fprintf('Avg. fitness = %e(%e) SR = %e Avg. FEs = %e(%e)\n', mean(new_f(:,1)),
std(new_f(:,1)), 100*SR/Nr, mean(FE), std(FE));
fprintf('Avg. time = %e(%e)\n', mean(tot_time), std(tot_time));

fprintf('GBestpsoN_2 - Halton Sequence\n');
fprintf('Avg. fitness = %e(%e) SR = %e Avg. FEs = %e(%e)\n', mean(new_f(:,2)),
std(new_f(:,2)), 100*SR1/Nr, mean(FE1), std(FE1));
fprintf('Avg. time = %e(%e)\n', mean(tot_time1),
std(tot_time1));

fprintf('GBestpsoN_2 - Sobol Sequence\n');
fprintf('Avg. fitness = %e(%e) SR = %e Avg. FEs = %e(%e)\n',
mean(new_f(:,3)),
std(new_f(:,3)), 100*SR2/Nr, mean(FE2), std(FE2));
fprintf('Avg. time = %e(%e)\n', mean(tot_time2),
std(tot_time2));
%}


%fclose(fid);
