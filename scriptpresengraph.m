pkg load stk;
pkg load statistics;

D=10;
fun =26;
N=50;
%filename = ["myresultsgbestpsoNg_2_",num2str(D),"df",num2str(fun),"_",num2str(N),"ps.txt"];
filename = ["myresultsgbestpsoNg_",num2str(D),"df",num2str(fun),"_",num2str(N),"ps.txt"];
%filename5 = ["myresults",name,num2str(D),"df",num2str(fun),".txt"];
load ('-force', filename);

%meanall(3) = mean(gbsc3);
%meanstd(3) = std(gbsc3)/sqrt(iter)
%errbar(3) = 2 * meanstd(3)

meanall=[EVALmeanU,EVALmeanH,EVALmeanS];
errbar=[EVALstdU/sqrt(SR),EVALstdH/sqrt(SR1),EVALstdS/sqrt(SR2)];
%errbar=[EVALstdU,EVALstdH,EVALstdS];

figure(1);
clf;
hold on;
axis([0.5 3.5 5000 6000]);
%axis([0.5 3.5 0 6000]);

#c = categorical({'normal','halton','scrambled halton'});

%bar(meanall);

er = errorbar(1:3, meanall, errbar, 'o');
#er.Color = [0 0 0];                            % make the errorbars black
#er.LineStyle = 'none';
set(gca (), "xtick", [1 2 3], "xticklabel", {"Pseudo-random", "Halton","Sobol"});
    
ylabel('the mean of function evaluations');
#legend('show');
title('Sphere function');
