fid = fopen('pvalspso1d9df13.txt','w');
fprintf(fid,"pvalspso1d9df13\n");
rootname = 'myresultspso';
extension = 'df13.txt';
rootname2 = 'pvalsplotpso';
extension2 = 'df13.tif';
for iscript=1:9
    maxiter = 200;
    pvals = zeros(maxiter,1);
    filename = [rootname, num2str(iscript), extension];
    load ('-force', filename);
%    load -force myresultsde30df8_2.txt
    #fprintf(fid,"fun = %d\n",iscript);
    fprintf(fid,"D = %d\n",iscript);
    for j=1:maxiter
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
    titlename = ['PSO, CEC2005 F13, ',num2str(iscript),'D'];
    title(titlename);
    plot(pvals,'b.','DisplayName',"p-value");
    #plot(pvals,'b-');
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