pkg load stk;
pkg load statistics;

D=3;
fun = 6;
N = 50;
%err = 10^(-2);
name = "pso";
%filename2 = [name,]
%fid = fopen('funcevalresults','a');
%filename5 = ["myresultsgbestpso2_",num2str(D),"df",num2str(fun),"_",num2str(N),"ps.txt"];
%filename5 = ["myresultsde_modified",num2str(D),"df",num2str(fun),"_",num2str(N),"ps.txt"];
%filename5 = ["myresultspso",num2str(D),"df",num2str(fun),"_2",".txt"];
filename5 = ["myresultspso",num2str(D),"df",num2str(fun),".txt"];

fid = fopen(['funcevalresults',filename5],'w');
filename = ["funcevalresultsdata",filename5];
titlename2 = ["PSO",", ","F",num2str(fun),", ",num2str(D),"D, ",num2str(N)," particles"];
filename9 = ["barploteval",name, num2str(D),"df",num2str(fun),"_",num2str(N),"ps.png"];
filename10 = ["barplotfit",name, num2str(D),"df",num2str(fun),"_",num2str(N),"ps.png"];

fprintf("fun = %d\n",fun);
fprintf("D = %d\n",D);
fprintf("No. of particles = %d\n",N);

load ('-force', filename5);

bf1_eval = N*(sum(best_f_iter1' > err) .+ 1);
bf2_eval = N*(sum(best_f_iter2' > err) .+ 1);
bf3_eval = N*(sum(best_f_iter3' > err) .+ 1);

%{
fprintf('GBestPSO2\n');
fprintf('Avg. fitness = %e(%e)\n', mean(bf1_eval),std(bf1_eval));
fprintf('GBestPSO2 - Halton Sequence\n');
fprintf('Avg. fitness = %e(%e)\n', mean(bf2_eval),std(bf2_eval));
fprintf('GBestPSO2 - Sobol Sequence\n');
fprintf('Avg. fitness = %e(%e)\n', mean(bf3_eval),std(bf3_eval));

fprintf(fid,'GBestPSO2\n');
fprintf(fid,'Avg. fitness = %e(%e)\n', mean(bf1_eval),std(bf1_eval));
fprintf(fid,'GBestPSO2 - Halton Sequence\n');
fprintf(fid,'Avg. fitness = %e(%e)\n', mean(bf2_eval),std(bf2_eval));
fprintf(fid,'GBestPSO2 - Sobol Sequence\n');
fprintf(fid,'Avg. fitness = %e(%e)\n\n', mean(bf3_eval),std(bf3_eval));
%}

soruU = new_f(:,1) <= err;
soruH = new_f(:,2) <= err;
soruS = new_f(:,3) <= err;

EVALmeanU = mean(bf1_eval(soruU));
EVALstdU = std(bf1_eval(soruU));
EVALmeanH = mean(bf2_eval(soruH));
EVALstdH = std(bf2_eval(soruH));
EVALmeanS = mean(bf3_eval(soruS));
EVALstdS = std(bf3_eval(soruS));

FITmeanU = mean((new_f(:,1))(not(soruU)));
FITstdU = std((new_f(:,1))(not(soruU)));
FITmeanH = mean((new_f(:,2))(not(soruH)));
FITstdH = std((new_f(:,2))(not(soruH)));
FITmeanS = mean((new_f(:,3))(not(soruS)));
FITstdS = std((new_f(:,3))(not(soruS)));

%{
EVALmeanU = mean(FE(soruU));
EVALstdU = std(FE(soruU));
EVALmeanH = mean(FE1(soruH));
EVALstdH = std(FE1(soruH));
EVALmeanS = mean(FE2(soruS));
EVALstdS = std(FE2(soruS));

FITmeanU = mean((new_f(:,1))(not(soruU)));
FITstdU = std((new_f(:,1))(not(soruU)));
FITmeanH = mean((new_f(:,2))(not(soruH)));
FITstdH = std((new_f(:,2))(not(soruH)));
FITmeanS = mean((new_f(:,3))(not(soruS)));
FITstdS = std((new_f(:,3))(not(soruS)));

EVALmeanU = mean(FE(soruU));
EVALstdU = std(FE(soruU));
EVALmeanH = mean(FE1(soruH));
EVALstdH = std(FE1(soruH));
EVALmeanS = mean(FE2(soruS));
EVALstdS = std(FE2(soruS));

FITmeanU = mean((new_f(:,1))(not(soruU)));
FITstdU = std((new_f(:,1))(not(soruU)));
FITmeanH = mean((new_f(:,2))(not(soruH)));
FITstdH = std((new_f(:,2))(not(soruH)));
FITmeanS = mean((new_f(:,3))(not(soruS)));
FITstdS = std((new_f(:,3))(not(soruS)));
%}

fprintf(fid, "fun = %d\n",fun);
fprintf(fid, "D = %d\n",D);
fprintf(fid, "No. of particles = %d\n",N);
fprintf(fid, 'FE_max = %d\n', FE_max);
fprintf(fid, "No. of runs = %d\n",Nr);

fprintf(fid, 'SPSO 2011\n');
fprintf(fid, 'SUC = %d\n', 100*SR/Nr);
fprintf(fid, 'EVAL = %e(%e)', EVALmeanU, EVALstdU);
fprintf(fid, '\n');
fprintf(fid, 'FIT = %e(%e)', FITmeanU, FITstdU);
fprintf(fid, '\n');

fprintf(fid, 'SPSO 2011 - Halton Sequence\n');
fprintf(fid, 'SUC = %d\n', 100*SR1/Nr);
fprintf(fid, 'EVAL = %e(%e)', EVALmeanH, EVALstdH);
fprintf(fid, '\n');
fprintf(fid, 'FIT = %e(%e)', FITmeanH, FITstdH);
fprintf(fid, '\n');

fprintf(fid, 'SPSO 2011 - Sobol Sequence\n');
fprintf(fid, 'SUC = %d\n', 100*SR2/Nr);
fprintf(fid, 'EVAL = %e(%e)', EVALmeanS, EVALstdS);
fprintf(fid, '\n');
fprintf(fid, 'FIT = %e(%e)', FITmeanS, FITstdS);
fprintf(fid, '\n');

fprintf(fid, 'SPSO 2011\n');
fprintf(fid, 'Avg. fitness = %e(%e) SR = %e Avg. FEs = %e(%e)\n', mean(new_f(:,1)),
std(new_f(:,1)), 100*SR/Nr, mean(FE), std(FE));
fprintf(fid, 'Avg. time = %e(%e)\n', mean(tot_time), std(tot_time));

fprintf(fid, 'SPSO 2011 - Halton Sequence\n');
fprintf(fid, 'Avg. fitness = %e(%e) SR = %e Avg. FEs = %e(%e)\n', mean(new_f(:,2)),
std(new_f(:,2)), 100*SR1/Nr, mean(FE1), std(FE1));
fprintf(fid, 'Avg. time = %e(%e)\n', mean(tot_time1),
std(tot_time1));

fprintf(fid, 'SPSO 2011 - Sobol Sequence\n');
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

fprintf('SPSO 2011\n');
fprintf('SUC = %d\n', 100*SR/Nr);
fprintf('EVAL = %e(%e)', EVALmeanU, EVALstdU);
fprintf('\n');
fprintf('FIT = %e(%e)', FITmeanU, FITstdU);
fprintf('\n');

fprintf('SPSO 2011 - Halton Sequence\n');
fprintf('SUC = %d\n', 100*SR1/Nr);
fprintf('EVAL = %e(%e)', EVALmeanH, EVALstdH);
fprintf('\n');
fprintf('FIT = %e(%e)', FITmeanH, FITstdH);
fprintf('\n');

fprintf('SPSO 2011 - Sobol Sequence\n');
fprintf('SUC = %d\n', 100*SR2/Nr);
fprintf('EVAL = %e(%e)', EVALmeanS, EVALstdS);
fprintf('\n');
fprintf('FIT = %e(%e)', FITmeanS, FITstdS);
fprintf('\n');


fprintf('SPSO 2011\n');
fprintf('Avg. fitness = %e(%e) SR = %e Avg. FEs = %e(%e)\n', mean(new_f(:,1)),
std(new_f(:,1)), 100*SR/Nr, mean(FE), std(FE));
fprintf('Avg. time = %e(%e)\n', mean(tot_time), std(tot_time));

fprintf('SPSO 2011 - Halton Sequence\n');
fprintf('Avg. fitness = %e(%e) SR = %e Avg. FEs = %e(%e)\n', mean(new_f(:,2)),
std(new_f(:,2)), 100*SR1/Nr, mean(FE1), std(FE1));
fprintf('Avg. time = %e(%e)\n', mean(tot_time1),
std(tot_time1));

fprintf('SPSO 2011 - Sobol Sequence\n');
fprintf('Avg. fitness = %e(%e) SR = %e Avg. FEs = %e(%e)\n',
mean(new_f(:,3)),
std(new_f(:,3)), 100*SR2/Nr, mean(FE2), std(FE2));
fprintf('Avg. time = %e(%e)\n', mean(tot_time2),
std(tot_time2));

%filename = ["myresultsgbestpsoNg_",num2str(D),"df",num2str(fun),"_",num2str(N),"ps.txt"];
save(filename);


meanall=[EVALmeanU,EVALmeanH,EVALmeanS];
errbar=[EVALstdU/sqrt(SR),EVALstdH/sqrt(SR1),EVALstdS/sqrt(SR2)];
%errbar=[EVALstdU,EVALstdH,EVALstdS];

figure(1);
clf;
hold on;
%axis([0.5 3.5 5000 6000]);

#c = categorical({'normal','halton','scrambled halton'});

bar(meanall);

er = errorbar(1:3, meanall, errbar, 'o');
#er.Color = [0 0 0];                            % make the errorbars black
#er.LineStyle = 'none';
set(gca (), "xtick", [1 2 3], "xticklabel", {"Pseudo-random", "Halton","Sobol"});
    
ylabel('the mean of function evaluations');
#legend('show');
%title('Sphere function');
title(titlename2);


meanall=[FITmeanU,FITmeanH,FITmeanS];
errbar=[FITstdU/sqrt(SR),FITstdH/sqrt(SR1),FITstdS/sqrt(SR2)];
%errbar=[FITstdU,FITstdH,FITstdS];
print (filename9);

figure(2);
clf;
hold on;
%axis([0.5 3.5 5000 6000]);

#c = categorical({'normal','halton','scrambled halton'});

bar(meanall);

er = errorbar(1:3, meanall, errbar, 'o');
#er.Color = [0 0 0];                            % make the errorbars black
#er.LineStyle = 'none';
set(gca (), "xtick", [1 2 3], "xticklabel", {"Pseudo-random", "Halton","Sobol"});
    
%ylabel('the mean of function evaluations');
ylabel('global best error');
#legend('show');
%title('Sphere function');
%ylabel('the mean of function evaluations');
title(titlename2);
print (filename10);


status = fclose(fid);