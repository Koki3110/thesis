load -force myresultsde10df1f13.txt
rootname = 'plotmediande10df';
extension = '.tif';

for i=1:13

%{
    figure(1); clf; hold on;
    #axis([0 1000]);
    #plot(time,u,'b-');
    titlename = ['DE, CEC2005 F',num2str(i),', 10D'];
    title(titlename);
    plot(q1(1,:),'b.','DisplayName',"q11");
    plot(q1(2,:),'b.','DisplayName',"p-value");
    plot(q1(3,:),'b.','DisplayName',"p-value");
    plot(q1(4,:),'b.','DisplayName',"p-value");
    plot(q1(5,:),'b.','DisplayName',"p-value");
    plot(q2(1,:),'b.','DisplayName',"p-value");
    plot(q2(2,:),'b.','DisplayName',"p-value");
    plot(q2(3,:),'b.','DisplayName',"p-value");
    plot(q2(4,:),'b.','DisplayName',"p-value");
    plot(q2(5,:),'b.','DisplayName',"p-value");
    plot(q3(1,:),'b.','DisplayName',"p-value");
    plot(q3(2,:),'b.','DisplayName',"p-value");
    plot(q3(3,:),'b.','DisplayName',"p-value");
    plot(q3(4,:),'b.','DisplayName',"p-value");
    plot(q3(5,:),'b.','DisplayName',"p-value");
    xlabel('iterations');
    ylabel('global best value');
    legend('show');
    filename = [rootname, num2str(i), extension];
    print ('-dtiff', filename);
%}

    titlename2 = ['DE, CEC2005 F',num2str(i),', 10D'];
    filename = ['plotmedianqde10df', num2str(i), '.tif'];
    filename6 = ['plotmediande10df', num2str(i), '.tif'];
    filename2 = ['plotmeansdde10df', num2str(i), '.tif'];
    filename3 = ['plotmeansede10df', num2str(i), '.tif'];
    filename4 = ['plotmeande10df', num2str(i), '.tif'];

    q1 = quantile(best_f_iter1_f1f13(:,:,i));
    q2 = quantile(best_f_iter2_f1f13(:,:,i));
    q3 = quantile(best_f_iter3_f1f13(:,:,i));

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
    #semilogyerr(ve,mean(best_f_iter2_f1f13(:,:,i)),std(best_f_iter2_f1f13(:,:,i)),'r-','DisplayName',"The mean of Halton");
    #semilogyerr(ve,mean(best_f_iter3_f1f13(:,:,i)),std(best_f_iter3_f1f13(:,:,i)),'b-','DisplayName',"The mean of Sobol");
    semilogy(0:199,mean(best_f_iter1_f1f13(:,:,i))+std(best_f_iter1_f1f13(:,:,i)),'k--','DisplayName',"(The mean + the SD) of Uniform");
    semilogy(0:199,mean(best_f_iter1_f1f13(:,:,i)),'k-','DisplayName',"The mean of Uniform");
    semilogy(0:199,mean(best_f_iter1_f1f13(:,:,i))-std(best_f_iter1_f1f13(:,:,i)),'k-.','DisplayName',"(The mean - the SD) of Uniform");
    semilogy(0:199,mean(best_f_iter2_f1f13(:,:,i))+std(best_f_iter2_f1f13(:,:,i)),'r--','DisplayName',"(The mean + the SD) of Halton");
    semilogy(0:199,mean(best_f_iter2_f1f13(:,:,i)),'r-','DisplayName',"The mean of Halton");
    semilogy(0:199,mean(best_f_iter2_f1f13(:,:,i))-std(best_f_iter2_f1f13(:,:,i)),'r-.','DisplayName',"(The mean - the SD) of Halton");
    semilogy(0:199,mean(best_f_iter3_f1f13(:,:,i))+std(best_f_iter3_f1f13(:,:,i)),'b--','DisplayName',"(The mean + the SD) of Sobol");
    semilogy(0:199,mean(best_f_iter3_f1f13(:,:,i)),'b-','DisplayName',"The mean of Sobol");
    semilogy(0:199,mean(best_f_iter3_f1f13(:,:,i))-std(best_f_iter3_f1f13(:,:,i)),'b-.','DisplayName',"(The mean - the SD) of Sobol");
    xlabel('iterations');
    ylabel('global best error');
    legend('show');
    print ('-dtiff', filename2);

    figure(1); clf; hold on;
    #axis([0 1000]);
    #plot(time,u,'b-');
    title(titlename2);
    ve = 0:199;
    #semilogyerr(ve,mean(best_f_iter1_f1f13(:,:,i)),std(best_f_iter1_f1f13(:,:,i)),'k-','DisplayName',"The mean of Uniform");
    #semilogyerr(ve,mean(best_f_iter2_f1f13(:,:,i)),std(best_f_iter2_f1f13(:,:,i)),'r-','DisplayName',"The mean of Halton");
    #semilogyerr(ve,mean(best_f_iter3_f1f13(:,:,i)),std(best_f_iter3_f1f13(:,:,i)),'b-','DisplayName',"The mean of Sobol");
    semilogy(0:199,mean(best_f_iter1_f1f13(:,:,i))+std(best_f_iter1_f1f13(:,:,i))/sqrt(50),'k--','DisplayName',"(The mean + the SE) of Uniform");
    semilogy(0:199,mean(best_f_iter1_f1f13(:,:,i)),'k-','DisplayName',"The mean of Uniform");
    semilogy(0:199,mean(best_f_iter1_f1f13(:,:,i))-std(best_f_iter1_f1f13(:,:,i))/sqrt(50),'k-.','DisplayName',"(The mean - the SE) of Uniform");
    semilogy(0:199,mean(best_f_iter2_f1f13(:,:,i))+std(best_f_iter2_f1f13(:,:,i))/sqrt(50),'r--','DisplayName',"(The mean + the SE) of Halton");
    semilogy(0:199,mean(best_f_iter2_f1f13(:,:,i)),'r-','DisplayName',"The mean of Halton");
    semilogy(0:199,mean(best_f_iter2_f1f13(:,:,i))-std(best_f_iter2_f1f13(:,:,i))/sqrt(50),'r-.','DisplayName',"(The mean - the SE) of Halton");
    semilogy(0:199,mean(best_f_iter3_f1f13(:,:,i))+std(best_f_iter3_f1f13(:,:,i))/sqrt(50),'b--','DisplayName',"(The mean + the SE) of Sobol");
    semilogy(0:199,mean(best_f_iter3_f1f13(:,:,i)),'b-','DisplayName',"The mean of Sobol");
    semilogy(0:199,mean(best_f_iter3_f1f13(:,:,i))-std(best_f_iter3_f1f13(:,:,i))/sqrt(50),'b-.','DisplayName',"(The mean - the SE) of Sobol");
    xlabel('iterations');
    ylabel('global best error');
    legend('show');
    print ('-dtiff', filename3);

    figure(1); clf; hold on;
    #axis([0 1000]);
    #plot(time,u,'b-');
    title(titlename2);
    ve = 0:199;
    #semilogyerr(ve,mean(best_f_iter1_f1f13(:,:,i)),std(best_f_iter1_f1f13(:,:,i)),'k-','DisplayName',"The mean of Uniform");
    #semilogyerr(ve,mean(best_f_iter2_f1f13(:,:,i)),std(best_f_iter2_f1f13(:,:,i)),'r-','DisplayName',"The mean of Halton");
    #semilogyerr(ve,mean(best_f_iter3_f1f13(:,:,i)),std(best_f_iter3_f1f13(:,:,i)),'b-','DisplayName',"The mean of Sobol");
    semilogy(0:199,mean(best_f_iter1_f1f13(:,:,i)),'k-','DisplayName',"The mean of Uniform");
    semilogy(0:199,mean(best_f_iter2_f1f13(:,:,i)),'r-','DisplayName',"The mean of Halton");
    semilogy(0:199,mean(best_f_iter3_f1f13(:,:,i)),'b-','DisplayName',"The mean of Sobol");
    xlabel('iterations');
    ylabel('global best error');
    legend('show');
    print ('-dtiff', filename4);


end