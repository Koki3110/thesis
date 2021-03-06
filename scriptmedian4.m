rootname = 'myresultspso';
extension = 'df7.txt';
#filename = 'plotmediandeTripod.tif';
#filenameroot = 'plotmediandef';
#filenameext = '.tif';
#titlename = 'de, Frequency Modulation';
#filename2 = 'plotmeansddeTripod.tif';
#titlename2 = 'DE, Tripod';
#filename3 = 'plotmeansedeTripod.tif';
#filename4 = 'plotmeandeTripod.tif';

for iscript=2:9
    titlename2 = ['PSO, CEC2005 F7, ',num2str(iscript),'D'];
    filename5 = [rootname, num2str(iscript), extension];
    load ('-force', filename5);
    filename = ['plotmedianqpso', num2str(iscript), 'df7.tif'];
    filename6 = ['plotmedianpso', num2str(iscript), '.df7.tif'];
    filename2 = ['plotmeansdpso', num2str(iscript), 'df7.tif'];
    filename3 = ['plotmeansepso', num2str(iscript), 'df7.tif'];
    filename4 = ['plotmeanpso', num2str(iscript), 'df7.tif'];
    
    q1 = quantile(best_f_iter1);
    q2 = quantile(best_f_iter2);
    q3 = quantile(best_f_iter3);
    figure(1); clf; hold on;
    #axis([0 1000]);
    #plot(time,u,'b-');
    #title(titlename2);
    title(titlename2);
#    semilogy(q1(1,:),'k-.','DisplayName',"q11");
    semilogy(0:199,q1(2,:),'k--','DisplayName',"The first quartile of Uniform");
    semilogy(0:199,q1(3,:),'k-','DisplayName',"The median of Uniform");
    semilogy(0:199,q1(4,:),'k-.','DisplayName',"The third quartile of Uniform");
#    semilogy(q1(5,:),'k-.','DisplayName',"p-value");
#    semilogy(q2(1,:),'r-.','DisplayName',"p-value");
    semilogy(0:199,q2(2,:),'r--','DisplayName',"The first quartile of Halton");
    semilogy(0:199,q2(3,:),'r-','DisplayName',"The median of Halton");
    semilogy(0:199,q2(4,:),'r-.','DisplayName',"The third quartile of Halton");
#    semilogy(q2(5,:),'r-.','DisplayName',"p-value");
#    semilogy(q3(1,:),'b-.','DisplayName',"p-value");
    semilogy(0:199,q3(2,:),'b--','DisplayName',"The first quartile of Sobol");
    semilogy(0:199,q3(3,:),'b-','DisplayName',"The median of Sobol");
    semilogy(0:199,q3(4,:),'b-.','DisplayName',"The first quartile of Sobol");
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
    semilogy(0:199,q1(3,:),'k-','DisplayName',"The median of Uniform");
    semilogy(0:199,q2(3,:),'r-','DisplayName',"The median of Halton");
    semilogy(0:199,q3(3,:),'b-','DisplayName',"The median of Sobol");
    xlabel('iterations');
    ylabel('global best error');
    legend('show');
    print ('-dtiff', filename6);


    figure(1); clf; hold on;
    #axis([0 1000]);
    #plot(time,u,'b-');
    title(titlename2);
    ve = 0:199;
    #semilogyerr(ve,mean(best_f_iter1),std(best_f_iter1),'k-','DisplayName',"The mean of Uniform");
    #semilogyerr(ve,mean(best_f_iter2),std(best_f_iter2),'r-','DisplayName',"The mean of Halton");
    #semilogyerr(ve,mean(best_f_iter3),std(best_f_iter3),'b-','DisplayName',"The mean of Sobol");
    semilogy(0:199,mean(best_f_iter1)+std(best_f_iter1),'k--','DisplayName',"(The mean + the SD) of Uniform");
    semilogy(0:199,mean(best_f_iter1),'k-','DisplayName',"The mean of Uniform");
    semilogy(0:199,mean(best_f_iter1)-std(best_f_iter1),'k-.','DisplayName',"(The mean - the SD) of Uniform");
    semilogy(0:199,mean(best_f_iter2)+std(best_f_iter2),'r--','DisplayName',"(The mean + the SD) of Halton");
    semilogy(0:199,mean(best_f_iter2),'r-','DisplayName',"The mean of Halton");
    semilogy(0:199,mean(best_f_iter2)-std(best_f_iter2),'r-.','DisplayName',"(The mean - the SD) of Halton");
    semilogy(0:199,mean(best_f_iter3)+std(best_f_iter3),'b--','DisplayName',"(The mean + the SD) of Sobol");
    semilogy(0:199,mean(best_f_iter3),'b-','DisplayName',"The mean of Sobol");
    semilogy(0:199,mean(best_f_iter3)-std(best_f_iter3),'b-.','DisplayName',"(The mean - the SD) of Sobol");
    xlabel('iterations');
    ylabel('global best error');
    legend('show');
    print ('-dtiff', filename2);

    figure(1); clf; hold on;
    #axis([0 1000]);
    #plot(time,u,'b-');
    title(titlename2);
    ve = 0:199;
    #semilogyerr(ve,mean(best_f_iter1),std(best_f_iter1),'k-','DisplayName',"The mean of Uniform");
    #semilogyerr(ve,mean(best_f_iter2),std(best_f_iter2),'r-','DisplayName',"The mean of Halton");
    #semilogyerr(ve,mean(best_f_iter3),std(best_f_iter3),'b-','DisplayName',"The mean of Sobol");
    semilogy(0:199,mean(best_f_iter1)+std(best_f_iter1)/sqrt(50),'k--','DisplayName',"(The mean + the SE) of Uniform");
    semilogy(0:199,mean(best_f_iter1),'k-','DisplayName',"The mean of Uniform");
    semilogy(0:199,mean(best_f_iter1)-std(best_f_iter1)/sqrt(50),'k-.','DisplayName',"(The mean - the SE) of Uniform");
    semilogy(0:199,mean(best_f_iter2)+std(best_f_iter2)/sqrt(50),'r--','DisplayName',"(The mean + the SE) of Halton");
    semilogy(0:199,mean(best_f_iter2),'r-','DisplayName',"The mean of Halton");
    semilogy(0:199,mean(best_f_iter2)-std(best_f_iter2)/sqrt(50),'r-.','DisplayName',"(The mean - the SE) of Halton");
    semilogy(0:199,mean(best_f_iter3)+std(best_f_iter3)/sqrt(50),'b--','DisplayName',"(The mean + the SE) of Sobol");
    semilogy(0:199,mean(best_f_iter3),'b-','DisplayName',"The mean of Sobol");
    semilogy(0:199,mean(best_f_iter3)-std(best_f_iter3)/sqrt(50),'b-.','DisplayName',"(The mean - the SE) of Sobol");
    xlabel('iterations');
    ylabel('global best error');
    legend('show');
    print ('-dtiff', filename3);

    figure(1); clf; hold on;
    #axis([0 1000]);
    #plot(time,u,'b-');
    title(titlename2);
    ve = 0:199;
    #semilogyerr(ve,mean(best_f_iter1),std(best_f_iter1),'k-','DisplayName',"The mean of Uniform");
    #semilogyerr(ve,mean(best_f_iter2),std(best_f_iter2),'r-','DisplayName',"The mean of Halton");
    #semilogyerr(ve,mean(best_f_iter3),std(best_f_iter3),'b-','DisplayName',"The mean of Sobol");
    semilogy(0:199,mean(best_f_iter1),'k-','DisplayName',"The mean of Uniform");
    semilogy(0:199,mean(best_f_iter2),'r-','DisplayName',"The mean of Halton");
    semilogy(0:199,mean(best_f_iter3),'b-','DisplayName',"The mean of Sobol");
    xlabel('iterations');
    ylabel('global best error');
    legend('show');
    print ('-dtiff', filename4);

end