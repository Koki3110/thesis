load -force myresultsde_modified10df9_10ps.txt;
filename = 'plotmedianqde_modified10df9_10ps.tif';
filename6 = 'plotmediande_modified10df9_10ps.tif';
#titlename = 'pso, Frequency Modulation';
filename2 = 'plotmeansdde_modified10df9_10ps.tif';
titlename2 = 'DE, CEC2005 F9, 10 particles';
filename3 = 'plotmeansede_modified10df9_10ps.tif';
filename4 = 'plotmeande_modified10df9_10ps.tif';
maxiter = 9999;

    q1 = quantile(best_f_iter1);
    q2 = quantile(best_f_iter2);
    q3 = quantile(best_f_iter3);
    figure(1); clf; hold on;
    #axis([0 1000]);
    #plot(time,u,'b-');
    title(titlename2);
#    semilogy(q1(1,:),'k-.','DisplayName',"q11");
    semilogy(0:maxiter,q1(2,:),'k--','DisplayName',"The first quartile of Uniform");
    semilogy(0:maxiter,q1(3,:),'k-','DisplayName',"The median of Uniform");
    semilogy(0:maxiter,q1(4,:),'k-.','DisplayName',"The third quartile of Uniform");
#    semilogy(q1(5,:),'k-.','DisplayName',"p-value");
#    semilogy(q2(1,:),'r-.','DisplayName',"p-value");
    semilogy(0:maxiter,q2(2,:),'r--','DisplayName',"The first quartile of Halton");
    semilogy(0:maxiter,q2(3,:),'r-','DisplayName',"The median of Halton");
    semilogy(0:maxiter,q2(4,:),'r-.','DisplayName',"The third quartile of Halton");
#    semilogy(q2(5,:),'r-.','DisplayName',"p-value");
#    semilogy(q3(1,:),'b-.','DisplayName',"p-value");
    semilogy(0:maxiter,q3(2,:),'b--','DisplayName',"The first quartile of Sobol");
    semilogy(0:maxiter,q3(3,:),'b-','DisplayName',"The median of Sobol");
    semilogy(0:maxiter,q3(4,:),'b-.','DisplayName',"The first quartile of Sobol");
#    semilogy(q3(5,:),'b-.','DisplayName',"p-value");
    xlabel('iterations');
    ylabel('global best error');
    legend('show');
    print ('-dtiff', filename);

    figure(1); clf; hold on;
    #axis([0 1000]);
    #plot(time,u,'b-');
    #title(titlename2);
    title(titlename2);
    semilogy(0:maxiter,q1(3,:),'k-','DisplayName',"The median of Uniform");
    semilogy(0:maxiter,q2(3,:),'r-','DisplayName',"The median of Halton");
    semilogy(0:maxiter,q3(3,:),'b-','DisplayName',"The median of Sobol");
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
    semilogy(0:maxiter,mean(best_f_iter1)+std(best_f_iter1),'k--','DisplayName',"(The mean + the SD) of Uniform");
    semilogy(0:maxiter,mean(best_f_iter1),'k-','DisplayName',"The mean of Uniform");
    semilogy(0:maxiter,mean(best_f_iter1)-std(best_f_iter1),'k-.','DisplayName',"(The mean - the SD) of Uniform");
    semilogy(0:maxiter,mean(best_f_iter2)+std(best_f_iter2),'r--','DisplayName',"(The mean + the SD) of Halton");
    semilogy(0:maxiter,mean(best_f_iter2),'r-','DisplayName',"The mean of Halton");
    semilogy(0:maxiter,mean(best_f_iter2)-std(best_f_iter2),'r-.','DisplayName',"(The mean - the SD) of Halton");
    semilogy(0:maxiter,mean(best_f_iter3)+std(best_f_iter3),'b--','DisplayName',"(The mean + the SD) of Sobol");
    semilogy(0:maxiter,mean(best_f_iter3),'b-','DisplayName',"The mean of Sobol");
    semilogy(0:maxiter,mean(best_f_iter3)-std(best_f_iter3),'b-.','DisplayName',"(The mean - the SD) of Sobol");
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
    semilogy(0:maxiter,mean(best_f_iter1)+std(best_f_iter1)/sqrt(50),'k--','DisplayName',"(The mean + the SE) of Uniform");
    semilogy(0:maxiter,mean(best_f_iter1),'k-','DisplayName',"The mean of Uniform");
    semilogy(0:maxiter,mean(best_f_iter1)-std(best_f_iter1)/sqrt(50),'k-.','DisplayName',"(The mean - the SE) of Uniform");
    semilogy(0:maxiter,mean(best_f_iter2)+std(best_f_iter2)/sqrt(50),'r--','DisplayName',"(The mean + the SE) of Halton");
    semilogy(0:maxiter,mean(best_f_iter2),'r-','DisplayName',"The mean of Halton");
    semilogy(0:maxiter,mean(best_f_iter2)-std(best_f_iter2)/sqrt(50),'r-.','DisplayName',"(The mean - the SE) of Halton");
    semilogy(0:maxiter,mean(best_f_iter3)+std(best_f_iter3)/sqrt(50),'b--','DisplayName',"(The mean + the SE) of Sobol");
    semilogy(0:maxiter,mean(best_f_iter3),'b-','DisplayName',"The mean of Sobol");
    semilogy(0:maxiter,mean(best_f_iter3)-std(best_f_iter3)/sqrt(50),'b-.','DisplayName',"(The mean - the SE) of Sobol");
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
    semilogy(0:maxiter,mean(best_f_iter1),'k-','DisplayName',"The mean of Uniform");
    semilogy(0:maxiter,mean(best_f_iter2),'r-','DisplayName',"The mean of Halton");
    semilogy(0:maxiter,mean(best_f_iter3),'b-','DisplayName',"The mean of Sobol");
    xlabel('iterations');
    ylabel('global best error');
    legend('show');
    print ('-dtiff', filename4);
