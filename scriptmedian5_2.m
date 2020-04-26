pkg load stk;
pkg load statistics;

D = 100;
fun = 12;
N = 20;
maxiter = 499;

filename5 = ["myresultsde_modified",num2str(D),"df",num2str(fun),"_",num2str(N),"ps.txt"];
load ('-force', filename5);
filename = ["plotmedianqde_modified", num2str(D),"df",num2str(fun),"_",num2str(N),"ps.tif"];
filename6 = ["plotmediande_modified", num2str(D),"df",num2str(fun),"_",num2str(N),"ps.tif"];
#titlename = 'pso, Frequency Modulation';
filename2 = ["plotmeansdde_modified", num2str(D),"df",num2str(fun),"_",num2str(N),"ps.tif"];
titlename2 = ["DE, CEC2005 F",num2str(fun),", ",num2str(N)," particles"];
filename3 = ["plotmeansede_modified", num2str(D),"df",num2str(fun),"_",num2str(N),"ps.tif"];
filename4 = ["plotmeande_modified", num2str(D),"df",num2str(fun),"_",num2str(N),"ps.tif"];
filename7 = ["plotlogmeansdde_modified", num2str(D),"df",num2str(fun),"_",num2str(N),"ps.tif"];
filename8 = ["plotlogmeansede_modified", num2str(D),"df",num2str(fun),"_",num2str(N),"ps.tif"];
filename9 = ["plotlogmeande_modified", num2str(D),"df",num2str(fun),"_",num2str(N),"ps.tif"];


    q1 = quantile(best_f_iter1);
    q2 = quantile(best_f_iter2);
    q3 = quantile(best_f_iter3);
    figure(1); clf; hold on;
    #axis([0 1000]);
    #plot(time,u,'b-');
    title(titlename2);
#    semilogy(q1(1,1:maxiter+1),'k-.','DisplayName',"q11");
    semilogy(0:maxiter,q1(2,1:maxiter+1),'k--','DisplayName',"The first quartile of Uniform");
    semilogy(0:maxiter,q1(3,1:maxiter+1),'k-','DisplayName',"The median of Uniform");
    semilogy(0:maxiter,q1(4,1:maxiter+1),'k-.','DisplayName',"The third quartile of Uniform");
#    semilogy(q1(5,1:maxiter+1),'k-.','DisplayName',"p-value");
#    semilogy(q2(1,1:maxiter+1),'r-.','DisplayName',"p-value");
    semilogy(0:maxiter,q2(2,1:maxiter+1),'r--','DisplayName',"The first quartile of Halton");
    semilogy(0:maxiter,q2(3,1:maxiter+1),'r-','DisplayName',"The median of Halton");
    semilogy(0:maxiter,q2(4,1:maxiter+1),'r-.','DisplayName',"The third quartile of Halton");
#    semilogy(q2(5,1:maxiter+1),'r-.','DisplayName',"p-value");
#    semilogy(q3(1,1:maxiter+1),'b-.','DisplayName',"p-value");
    semilogy(0:maxiter,q3(2,1:maxiter+1),'b--','DisplayName',"The first quartile of Sobol");
    semilogy(0:maxiter,q3(3,1:maxiter+1),'b-','DisplayName',"The median of Sobol");
    semilogy(0:maxiter,q3(4,1:maxiter+1),'b-.','DisplayName',"The first quartile of Sobol");
#    semilogy(q3(5,1:maxiter+1),'b-.','DisplayName',"p-value");
    xlabel('iterations');
    ylabel('global best error');
    legend('show');
    print ('-dtiff', filename);

    figure(1); clf; hold on;
    #axis([0 1000]);
    #plot(time,u,'b-');
    #title(titlename2);
    title(titlename2);
    semilogy(0:maxiter,q1(3,1:maxiter+1),'k-','DisplayName',"The median of Uniform");
    semilogy(0:maxiter,q2(3,1:maxiter+1),'r-','DisplayName',"The median of Halton");
    semilogy(0:maxiter,q3(3,1:maxiter+1),'b-','DisplayName',"The median of Sobol");
    xlabel('iterations');
    ylabel('global best error');
    legend('show');
    print ('-dtiff', filename6);


    figure(1); clf; hold on;
    #axis([0 1000]);
    #plot(time,u,'b-');
    title(titlename2);
    ve = 0:maxiter;
    #semilogyerr(ve,mean(best_f_iter1),std(best_f_iter1),'k-','DisplayName',"The mean of Uniform");
    #semilogyerr(ve,mean(best_f_iter2),std(best_f_iter2),'r-','DisplayName',"The mean of Halton");
    #semilogyerr(ve,mean(best_f_iter3),std(best_f_iter3),'b-','DisplayName',"The mean of Sobol");
    semilogy(0:maxiter,mean(best_f_iter1)(1:maxiter+1)+std(best_f_iter1)(1:maxiter+1),'k--','DisplayName',"(The mean + the SD) of Uniform");
    semilogy(0:maxiter,mean(best_f_iter1)(1:maxiter+1),'k-','DisplayName',"The mean of Uniform");
    semilogy(0:maxiter,mean(best_f_iter1)(1:maxiter+1)-std(best_f_iter1)(1:maxiter+1),'k-.','DisplayName',"(The mean - the SD) of Uniform");
    semilogy(0:maxiter,mean(best_f_iter2)(1:maxiter+1)+std(best_f_iter2)(1:maxiter+1),'r--','DisplayName',"(The mean + the SD) of Halton");
    semilogy(0:maxiter,mean(best_f_iter2)(1:maxiter+1),'r-','DisplayName',"The mean of Halton");
    semilogy(0:maxiter,mean(best_f_iter2)(1:maxiter+1)-std(best_f_iter2)(1:maxiter+1),'r-.','DisplayName',"(The mean - the SD) of Halton");
    semilogy(0:maxiter,mean(best_f_iter3)(1:maxiter+1)+std(best_f_iter3)(1:maxiter+1),'b--','DisplayName',"(The mean + the SD) of Sobol");
    semilogy(0:maxiter,mean(best_f_iter3)(1:maxiter+1),'b-','DisplayName',"The mean of Sobol");
    semilogy(0:maxiter,mean(best_f_iter3)(1:maxiter+1)-std(best_f_iter3)(1:maxiter+1),'b-.','DisplayName',"(The mean - the SD) of Sobol");
    xlabel('iterations');
    ylabel('global best error');
    legend('show');
    print ('-dtiff', filename2);

    figure(1); clf; hold on;
    #axis([0 1000]);
    #plot(time,u,'b-');
    title(titlename2);
    ve = 0:maxiter;
    #semilogyerr(ve,mean(best_f_iter1),std(best_f_iter1),'k-','DisplayName',"The mean of Uniform");
    #semilogyerr(ve,mean(best_f_iter2),std(best_f_iter2),'r-','DisplayName',"The mean of Halton");
    #semilogyerr(ve,mean(best_f_iter3),std(best_f_iter3),'b-','DisplayName',"The mean of Sobol");
    semilogy(0:maxiter,mean(best_f_iter1)(1:maxiter+1)+std(best_f_iter1)(1:maxiter+1)/sqrt(50),'k--','DisplayName',"(The mean + the SE) of Uniform");
    semilogy(0:maxiter,mean(best_f_iter1)(1:maxiter+1),'k-','DisplayName',"The mean of Uniform");
    semilogy(0:maxiter,mean(best_f_iter1)(1:maxiter+1)-std(best_f_iter1)(1:maxiter+1)/sqrt(50),'k-.','DisplayName',"(The mean - the SE) of Uniform");
    semilogy(0:maxiter,mean(best_f_iter2)(1:maxiter+1)+std(best_f_iter2)(1:maxiter+1)/sqrt(50),'r--','DisplayName',"(The mean + the SE) of Halton");
    semilogy(0:maxiter,mean(best_f_iter2)(1:maxiter+1),'r-','DisplayName',"The mean of Halton");
    semilogy(0:maxiter,mean(best_f_iter2)(1:maxiter+1)-std(best_f_iter2)(1:maxiter+1)/sqrt(50),'r-.','DisplayName',"(The mean - the SE) of Halton");
    semilogy(0:maxiter,mean(best_f_iter3)(1:maxiter+1)+std(best_f_iter3)(1:maxiter+1)/sqrt(50),'b--','DisplayName',"(The mean + the SE) of Sobol");
    semilogy(0:maxiter,mean(best_f_iter3)(1:maxiter+1),'b-','DisplayName',"The mean of Sobol");
    semilogy(0:maxiter,mean(best_f_iter3)(1:maxiter+1)-std(best_f_iter3)(1:maxiter+1)/sqrt(50),'b-.','DisplayName',"(The mean - the SE) of Sobol");
    xlabel('iterations');
    ylabel('global best error');
    legend('show');
    print ('-dtiff', filename3);

    figure(1); clf; hold on;
    #axis([0 1000]);
    #plot(time,u,'b-');
    title(titlename2);
    ve = 0:maxiter;
    #semilogyerr(ve,mean(best_f_iter1),std(best_f_iter1),'k-','DisplayName',"The mean of Uniform");
    #semilogyerr(ve,mean(best_f_iter2),std(best_f_iter2),'r-','DisplayName',"The mean of Halton");
    #semilogyerr(ve,mean(best_f_iter3),std(best_f_iter3),'b-','DisplayName',"The mean of Sobol");
    semilogy(0:maxiter,mean(best_f_iter1)(1:maxiter+1),'k-','DisplayName',"The mean of Uniform");
    semilogy(0:maxiter,mean(best_f_iter2)(1:maxiter+1),'r-','DisplayName',"The mean of Halton");
    semilogy(0:maxiter,mean(best_f_iter3)(1:maxiter+1),'b-','DisplayName',"The mean of Sobol");
    xlabel('iterations');
    ylabel('global best error');
    legend('show');
    print ('-dtiff', filename4);

bfi1log = log(best_f_iter1);
bfi2log = log(best_f_iter2);
bfi3log = log(best_f_iter3);

    figure(1); clf; hold on;
    #axis([0 1000]);
    #plot(time,u,'b-');
    title(titlename2);
    ve = 0:maxiter;
    #semilogyerr(ve,mean(best_f_iter1),std(best_f_iter1),'k-','DisplayName',"The mean of Uniform");
    #semilogyerr(ve,mean(best_f_iter2),std(best_f_iter2),'r-','DisplayName',"The mean of Halton");
    #semilogyerr(ve,mean(best_f_iter3),std(best_f_iter3),'b-','DisplayName',"The mean of Sobol");
    plot(0:maxiter,mean(bfi1log)(1:maxiter+1)+std(bfi1log)(1:maxiter+1),'k--','DisplayName',"(The mean + the SD) of logarithm of Uniform");
    plot(0:maxiter,mean(bfi1log)(1:maxiter+1),'k-','DisplayName',"The mean of logarithm of Uniform");
    plot(0:maxiter,mean(bfi1log)(1:maxiter+1)-std(bfi1log)(1:maxiter+1),'k-.','DisplayName',"(The mean - the SD) of logarithm of Uniform");
    plot(0:maxiter,mean(bfi2log)(1:maxiter+1)+std(bfi2log)(1:maxiter+1),'r--','DisplayName',"(The mean + the SD) of logarithm of Halton");
    plot(0:maxiter,mean(bfi2log)(1:maxiter+1),'r-','DisplayName',"The mean of logarithm of Halton");
    plot(0:maxiter,mean(bfi2log)(1:maxiter+1)-std(bfi2log)(1:maxiter+1),'r-.','DisplayName',"(The mean - the SD) of logarithm of Halton");
    plot(0:maxiter,mean(bfi3log)(1:maxiter+1)+std(bfi3log)(1:maxiter+1),'b--','DisplayName',"(The mean + the SD) of logarithm of Sobol");
    plot(0:maxiter,mean(bfi3log)(1:maxiter+1),'b-','DisplayName',"The mean of logarithm of Sobol");
    plot(0:maxiter,mean(bfi3log)(1:maxiter+1)-std(bfi3log)(1:maxiter+1),'b-.','DisplayName',"(The mean - the SD) of logarithm of Sobol");
    xlabel('iterations');
    ylabel('the logarithm of global best error');
    legend('show');
    print ('-dtiff', filename7);

    figure(1); clf; hold on;
    #axis([0 1000]);
    #plot(time,u,'b-');
    title(titlename2);
    ve = 0:maxiter;
    #semilogyerr(ve,mean(best_f_iter1),std(best_f_iter1),'k-','DisplayName',"The mean of Uniform");
    #semilogyerr(ve,mean(best_f_iter2),std(best_f_iter2),'r-','DisplayName',"The mean of Halton");
    #semilogyerr(ve,mean(best_f_iter3),std(best_f_iter3),'b-','DisplayName',"The mean of Sobol");

    plot(0:maxiter,mean(bfi1log)(1:maxiter+1)+std(bfi1log)(1:maxiter+1)/sqrt(50),'k--','DisplayName',"(The mean + the SE) of logarithm of Uniform");
    plot(0:maxiter,mean(bfi1log)(1:maxiter+1),'k-','DisplayName',"The mean of logarithm of Uniform");
    plot(0:maxiter,mean(bfi1log)(1:maxiter+1)-std(bfi1log)(1:maxiter+1)/sqrt(50),'k-.','DisplayName',"(The mean - the SE) of logarithm of Uniform");
    plot(0:maxiter,mean(bfi2log)(1:maxiter+1)+std(bfi2log)(1:maxiter+1)/sqrt(50),'r--','DisplayName',"(The mean + the SE) of logarithm of Halton");
    plot(0:maxiter,mean(bfi2log)(1:maxiter+1),'r-','DisplayName',"The mean of logarithm of Halton");
    plot(0:maxiter,mean(bfi2log)(1:maxiter+1)-std(bfi2log)(1:maxiter+1)/sqrt(50),'r-.','DisplayName',"(The mean - the SE) of logarithm of Halton");
    plot(0:maxiter,mean(bfi3log)(1:maxiter+1)+std(bfi3log)(1:maxiter+1)/sqrt(50),'b--','DisplayName',"(The mean + the SE) of logarithm of Sobol");
    plot(0:maxiter,mean(bfi3log)(1:maxiter+1),'b-','DisplayName',"The mean of logarithm of Sobol");
    plot(0:maxiter,mean(bfi3log)(1:maxiter+1)-std(bfi3log)(1:maxiter+1)/sqrt(50),'b-.','DisplayName',"(The mean - the SE) of logarithm of Sobol");

    xlabel('iterations');
    ylabel('the logarithm of global best error');
    legend('show');
    print ('-dtiff', filename8);

    figure(1); clf; hold on;
    #axis([0 1000]);
    #plot(time,u,'b-');
    title(titlename2);
    ve = 0:maxiter;
    #semilogyerr(ve,mean(best_f_iter1),std(best_f_iter1),'k-','DisplayName',"The mean of Uniform");
    #semilogyerr(ve,mean(best_f_iter2),std(best_f_iter2),'r-','DisplayName',"The mean of Halton");
    #semilogyerr(ve,mean(best_f_iter3),std(best_f_iter3),'b-','DisplayName',"The mean of Sobol");
    plot(0:maxiter,mean(bfi1log)(1:maxiter+1),'k-','DisplayName',"The mean of logarithm of Uniform");
    plot(0:maxiter,mean(bfi2log)(1:maxiter+1),'r-','DisplayName',"The mean of logarithm of Halton");
    plot(0:maxiter,mean(bfi3log)(1:maxiter+1),'b-','DisplayName',"The mean of logarithm of Sobol");
    xlabel('iterations');
    ylabel('the logarithm of global best error');
    legend('show');
    print ('-dtiff', filename9);
