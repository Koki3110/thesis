load -force myresultsde_modified10df6_40ps.txt;
SR=0;
for i=1:50
if best_f_iter1(i,2000) <= 0.01
        SR=SR+1;
end
end

SR1=0;
for i=1:50
if best_f_iter2(i,2000) <= 0.01
        SR1=SR1+1;
end
end

SR2=0;
for i=1:50
if best_f_iter3(i,2000) <= 0.01
        SR2=SR2+1;
end
end
SR
SR1
SR2
