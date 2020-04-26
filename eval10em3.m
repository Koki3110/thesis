pkg load stk;
pkg load statistics;

D=10;
fun = 1;
N = 50;

fid = fopen('eval10em3results','a');

fprintf("fun = %d\n",fun);
fprintf("D = %d\n",D);
fprintf("No. of particles = %d\n",N);
filename5 = ["myresultsgbestpso2_",num2str(D),"df",num2str(fun),"_",num2str(N),"ps.txt"];
load ('-force', filename5);

bf1_eval = N*(sum(best_f_iter1' >= 0.001) .+ 1);
bf2_eval = N*(sum(best_f_iter2' >= 0.001) .+ 1);
bf3_eval = N*(sum(best_f_iter3' >= 0.001) .+ 1);

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



status = fclose(fid);