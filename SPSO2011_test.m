function SPSO2011_test (fun, D, N,FE_max, Nr)
global initial_flag


%disp_fun;
%fun = input('Select a function:');
%D = input('Choose the dimension of the function:');

%N = 12; %No. of particles
%FE_max = 98; %Max. no. of function evaluations

%Nr = 100; % No. of runs
normalize = 0; % 0 => no normalisation, else 1

[LB UB opt_f err] = get_fun_info(fun,D);

FE = zeros(1,Nr);
new_f = zeros(1,Nr);
tot_time = zeros(1,Nr);

FE1 = zeros(1,Nr);
new_f1 = zeros(1,Nr);
tot_time = zeros(1,Nr);

rng(123456789); % For reproducible results
% % Warm up the RNG
for t=1:1:10000
    zz=alea(0,1); %rand;
end

SR = 0; % Success rate

for r=1:Nr
    initial_flag = 0;
 tic; %Reset the timer
[x(r,:) f(r) FE(r)] = SPSO2011(N,D, FE_max, fun, err, LB, UB, opt_f,normalize);
        
        if f(r) <= err
            SR = SR + 1;
        end
        
       % fprintf('Run = %d error = %e\n', r, f(r));

tot_time(r) = toc;
end %r


fprintf('SPSO 2011\n');
fprintf('Avg. fitness = %1.2e(%1.2e) Avg. FEs = %1.2e(%1.2e) SR = %f\n',...
  mean(f), std(f), mean(FE), std(FE), SR/Nr);
fprintf('Avg. time = %1.2e(%1.2e)\n', mean(tot_time), std(tot_time));
[fmin,Ind]=min(f);
fprintf('\n Acceptable error %f',err);
fprintf('\n Best value %f',fmin);
%fprintf('\n Position \n'); disp(x(Ind,:))
end

