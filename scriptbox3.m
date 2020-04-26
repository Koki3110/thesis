
filename2 = 'pvalsboxplot10df12_50ps.tif';
titlename = 'CEC2005 F12, 10D, 50 particles, initial global best error';
load -force myresultsde_modified10df12_50ps.txt


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
boxplot([best_f_iter1(:,1) best_f_iter2(:,1) best_f_iter3(:,1)],'Labels',{'Uniform','Halton','Sobol'});
#text(0.9,-50000,'Uniform');
#text(1.9,-50000,'Halton');
#text(2.9,-50000,'Sobol');


set(gca (), "xtick", [1 2 3], "xticklabel", {"Uniform", "Halton","Sobol"});
    #xlabel('iterations');
    ylabel('global best error');
    #legend('show');
#    filename2 = [rootname2, num2str(iscript), extension2];
    print ('-dtiff', filename2);

fid = fopen('f12results.txt','a');
fprintf(fid,"cec10df12_10ps\n");
[pval, k, df] = kruskal_wallis_test(best_f_iter1(:,1),best_f_iter2(:,1),best_f_iter3(:,1));
fprintf(fid,"pval = %e\n",pval);
printf("pval = %e\n",pval);
if pval < 0.05
    post_hoc2(fid,[best_f_iter1(:,1) best_f_iter2(:,1) best_f_iter3(:,1)]);
end

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
status = fclose(fid);