clear all; clc; format compact; 

%% ToDo: 
% review "correct" answers
% review cases where most experts are wrong
% add in Fabio's answers

%% remove columns with "[score]" or [feedback]
load Data % T
v = T.Properties.VariableNames; 

T2 = T([1 2 3 5 6 7 8 9 10],:); fileName = 'experts.xlsx'; % experts
[vc1, V1] = fcnAnalyzeData(v,T2,fileName);

T2 = T([4 11 14 16 17],:); fileName = 'nonExpertNeurologists.xlsx'; % non-expert neurologists
[vc2, V2] = fcnAnalyzeData(v,T2,fileName);

T2 = T([12 13 15],:); fileName = 'nonExperts.xlsx'; % non-experts
[vc3, V3] = fcnAnalyzeData(v,T2,fileName);


%% plot errors
figure(1); clf
subplot(311);
alpha = 0.1;
clc

vc=vc1; V = V1; x = vc+0.25*randn(size(vc)); y = V + 0.25*randn(size(V));
% y=[y(1,:) y(2,:) y(3,:)]; x = [x x x];
alpha = 0.5; 
scatter(x,y,'o','filled','MarkerEdgeColor','none','MarkerFaceAlpha',alpha);
r = corr(x',y','Type','Spearman');
grid on; disp([median(r) min(r) max(r)]); axis equal; axis square

subplot(312); 
vc=vc2; V = V2; x = vc+0.25*randn(size(vc)); y = V + 0.25*randn(size(V));
% y=[y(1,:) y(2,:) y(3,:)]; x = [x x x];
scatter(x,y,'o','filled','MarkerEdgeColor','none','MarkerFaceAlpha',alpha);
r = corr(x',y','Type','Spearman');
grid on; disp([median(r) min(r) max(r)]); axis equal; axis square


subplot(313);
vc=vc3; V = V3; x = vc+0.25*randn(size(vc)); y = V + 0.25*randn(size(V));
% y=[y(1,:) y(2,:) y(3,:)]; x = [x x x];
scatter(x,y,'o','filled','MarkerEdgeColor','none','MarkerFaceAlpha',alpha);
r = corr(x',y','Type','Spearman');
grid on; disp([median(r) min(r) max(r)]); axis equal; axis square

subplot(311); set(gca,'XTickLabel',[]); set(gca,'YTickLabel',[]); 
subplot(312); set(gca,'XTickLabel',[]); set(gca,'YTickLabel',[]); 
subplot(312); set(gca,'XTickLabel',[]); set(gca,'YTickLabel',[]); 
subplot(313); set(gca,'XTickLabel',[]); ylabel('Rater E-CAM-S'); xlabel('Gold E-CAM-S'); 


set(gcf,'color','w')