load -force myresultsde10df1f13.txt
fid = fopen('pvalsdecec10d_2.txt','w');
fprintf(fid,"pvalsdecec10d_2\n");
rootname = 'pvalsplotde10df';
extension = '.tif';

for i=1:13
    fprintf(fid,"fun = %d\n",i);
    pvals = zeros(200,1);
    for j=1:200
        [pvals(j), k, df] = kruskal_wallis_test(best_f_iter1_f1f13(:,j,i),best_f_iter2_f1f13(:,j,i),best_f_iter3_f1f13(:,j,i));
        fprintf(fid,"FE = %d\n",50*j);
        fprintf(fid,"pval = %e\n",pvals(j));
        if pvals(j) < 0.05
            post_hoc2(fid,[best_f_iter1_f1f13(:,j,i) best_f_iter2_f1f13(:,j,i) best_f_iter3_f1f13(:,j,i)]);
        end
    end
    figure(1); clf; hold on;
    #axis([0 1000]);
    #plot(time,u,'b-');
    titlename = ['DE, CEC2005 F',num2str(i),', 10D'];
    title(titlename);
    plot(pvals,'b.','DisplayName',"p-value");
    plot(pvals,'b-');
    xlabel('iterations');
    ylabel('p-value');
    legend('show');
    filename = [rootname, num2str(i), extension];
    print ('-dtiff', filename);
%{
    for j=1:4
        [pval, k, df] = kruskal_wallis_test(best_f_iter1_f1f13(:,50*j,i),best_f_iter2_f1f13(:,50*j,i),best_f_iter3_f1f13(:,50*j,i));
        fprintf(fid,"FE = %d\n",2500*j);
        fprintf(fid,"pval = %e\n",pval);
        if pval < 0.05
            post_hoc2(fid,[best_f_iter1_f1f13(:,50*j,i) best_f_iter2_f1f13(:,50*j,i) best_f_iter3_f1f13(:,50*j,i)]);
        end
    end
%}
end
status = fclose(fid);