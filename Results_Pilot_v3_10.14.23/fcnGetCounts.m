function [Sem,Fpm, PPVm, NPVm] = fcnGetStats(R,C); 


N = size(R,1); 
ct = 1; 
tp = []; tn = []; fp = []; fn = []; 
for i = 1:N
    % should have 31 [tp,fp,fn,fn]
    m = squeeze(R(i,:,:)); % dim: questions x answer options
    tp(i,:) = sum(C==1 & m==1,1)./sum(C==1,1);
    tn(i,:) = sum(C==0 & m==0,1)./sum(C==0,1);
    fp(i,:) = sum(C==0 & m==1,1)./sum(C==0,1);
    fn(i,:) = sum(C==1 & m==0,1)./sum(C==1,1);
end

Se =    (tp./(tp+fn));
Fp =    (1-(tn./(tn+fp)));
PPV =   (tp./(tp+fp));
NPV =   (tn./(tn+fn)); 

TP =    nanmean(tp);
FP =    nanmean(fp);
TN =   nanmean(tp./(tp+fp));
FN =   nanmean(tn./(tn+fn)); 