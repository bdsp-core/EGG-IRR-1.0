function [pa,pe, mcc] = fcnGetMCC(m1,m2,k) 

t1 = m1(:,k); 
t2 = m2(:,k); 
m(1,1) = sum(t1==1 & t2==1); 
m(1,2) = sum(t1==1 & t2==0);
m(2,1) = sum(t1==0 & t2==1); 
m(2,2) = sum(t1==0 & t2==0);

pa = (m(1,1)+m(2,2)) / sum(m(:)); 
p0 = (m(1,1)+m(1,2))*(m(1,1)+m(2,1)) / sum(m(:))^2; 
p1 = (m(2,1)+m(2,2))*(m(1,2)+m(2,2)) / sum(m(:))^2; 
pe = p0+p1; 


tp = m(1,1); 
tn = m(2,2); 
fp = m(1,2); 
fn = m(2,1); 

mcc = (tp*tn - fp*fn)\sqrt((tp+fp)*(tp+fn)*(tn+fp)*(tn+fn)); 

if isnan(mcc); 
    keyboard; 
end