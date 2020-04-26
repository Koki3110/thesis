fid = fopen('pvalsdecec30d.txt','w');
fprintf(fid,"pvalsdecec30d\n");
rootname = 'myresultsde30df';
extension = '.txt';
rootname2 = 'pvalsplotde30df';
extension2 = '.tif';
for iscript=1:13
    pvals = zeros(200,1);
    filename = [rootname, num2str(iscript), extension];
    load ('-force', filename);
%    load -force myresultsde30df8_2.txt
    fprintf(fid,"fun = %d\n",iscript);
    for j=1:200
        [pvals(j), k, df] = kruskal_wallis_test(best_f_iter1(:,j),best_f_iter2(:,j),best_f_iter3(:,j));
        fprintf(fid,"FE = %d\n",50*j);
        fprintf(fid,"pval = %e\n",pvals(j));
        if pvals(j) < 0.05
            post_hoc2(fid,[best_f_iter1(:,j) best_f_iter2(:,j) best_f_iter3(:,j)]);
        end
    end

    figure(1); clf; hold on;
    #axis([0 1000]);
    #plot(time,u,'b-');
    titlename = ['DE, CEC2005 F',num2str(iscript),', 30D'];
    title(titlename);
    plot(pvals,'b.','DisplayName',"p-value");
    plot(pvals,'b-');
    xlabel('iterations');
    ylabel('p-value');
    legend('show');
    filename2 = [rootname2, num2str(iscript), extension2];
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
end
status = fclose(fid);