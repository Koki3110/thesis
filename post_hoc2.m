function ypersigma=post_hoc2(fid,new_f)

Nr = 50;

alpha = 0.05;
crntrank = 1;
prevbestval = -1;
tienum = 1;
B=0;
new_f_rank = zeros(Nr,3);


while(crntrank<=3*Nr)
    bestval = -1;
    for i=1:(3*Nr)
        if (new_f(i) > prevbestval) && (new_f(i) < bestval || bestval == -1)
            bestval = new_f(i);
            tienum = 1;
        elseif new_f(i) == bestval
            tienum++;
        end
    end
    B+=(tienum^3-tienum)/(12*(3*Nr-1));
    for i=1:(3*Nr)
        if(new_f(i)==bestval)
            new_f_rank(i)=crntrank+(tienum-1)/2;
        end
    end
    crntrank+=tienum;
    prevbestval = bestval;
endwhile

for i=1:3
    T(i) = sum(new_f_rank(:,i));
end

ypersigma = zeros(2,3);

for i=1:2
    for j=(i+1):3
        y=T(i)/Nr - T(j)/Nr;
        sigma = ((3*Nr*(3*Nr+1)/12-B)*(1/Nr*2))^0.5;
        ypersigma(i,j) = y/sigma;
        fprintf(fid,"Sample%d, Sample%d\n", i, j);
        fprintf(fid,"y/sigma is %e\n", y/sigma);
        if y/sigma < -norminv(1-alpha/(2*3))
            fprintf(fid,"Sample%d is better than Sample%d\n\n", i, j);
        elseif y/sigma > norminv(1-alpha/(2*3))
            fprintf(fid,"Sample%d is better than Sample%d\n\n", j, i);
        else
            fprintf(fid,"No significant difference\n\n");
        end
    end
end
