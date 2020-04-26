
filename2 = 'pvalsboxplotde10df12fe50.tif';
titlename = 'DE, CEC2005 F12, 10D, FE = 50';
load -force myresultsde10df1f13.txt


    figure(1); clf; hold on;
    axis("nolabel");
    axis("labely");
    #plot(time,u,'b-');
 #   titlename = ['DE, CEC2005 F',num2str(iscript),', 30D'];
    title(titlename);
%{
    for j= 1:50
        g(1:7,1,j) = 'Uniform';
        g(1:7,2,j) = 'Halton ';
        g(1:7,3,j) = 'Sobol  ';
    end
%}
#g = []
boxplot([best_f_iter1_f1f13(:,1,12) best_f_iter2_f1f13(:,1,12) best_f_iter3_f1f13(:,1,12)],'Labels',{'Uniform','Halton','Sobol'});
#text(0.9,-50000,'Uniform');
#text(1.9,-50000,'Halton');
#text(2.9,-50000,'Sobol');

set(gca (), "xtick", [1 2 3], "xticklabel", {"Uniform", "Halton","Sobol"});
    #xlabel('iterations');
    ylabel('global best value');
    #legend('show');
#    filename2 = [rootname2, num2str(iscript), extension2];
    print ('-dtiff', filename2);


%{
    for j=1:4
        [pval, k, df] = kruskal_wallis_test(best_f_iter1(:,50*j),best_f_iter2(:,50*j),best_f_iter3(:,50*j));
        fprintf(fid,"FE = %d\n",2500*j);
        fprintf(fid,"pval = %e\n",pval);
        if pval < 0.05
            post_hoc2(fid,[best_f_iter1(:,50*j) best_f_iter2(:,50*j) best_f_iter3(:,50*j)]);
        end
    end
%}
%end
#status = fclose(fid);