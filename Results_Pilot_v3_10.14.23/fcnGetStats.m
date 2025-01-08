function [Sem,Fpm, PPVm, NPVm,MCCm,Vem, v, ve] = fcnGetStats(R,C,vc); 


W = fcnGetW; 

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
    v(i,:) = min(sum((W.*m)'),15); 
    ve(i,:) = v(i,:) - vc; 
end

Se =    (tp./(tp+fn));
Fp =    (1-(tn./(tn+fp)));
PPV =   (tp./(tp+fp));
NPV =   (tn./(tn+fn));
MCC = (tp.*tn - fp.*fn)./sqrt((tp+fp).*(tp+fn).*(tn+fp).*(tn+fn));

Sem =    nanmean(tp./(tp+fn));
Fpm =    nanmean(1-(tn./(tn+fp)));
PPVm =   nanmean(tp./(tp+fp));
NPVm =   nanmean(tn./(tn+fn)); 
MCCm =   nanmean(MCC); 

Vem = nanmean(ve); 