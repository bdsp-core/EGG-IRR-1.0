function [T,T0,v,A] = fcnGetData

load data_2022_11_01 T
v = T.Properties.VariableNames; 

T0 = T; 

idx = zeros(1,length(v)); 
for i = 1:length(v); 
    if ~isempty(strfind(v{i},'Feedback'));
        idx(i)=1; 
    end
    if ~isempty(strfind(v{i},'Score'));
        idx(i)=1; 
    end
    if ~isempty(strfind(v{i},'VarName'));
        idx(i)=1; 
    end
end
ind = find(idx)
T(:,ind) = [];
v = T.Properties.VariableNames; 

%% get question indicies
clc
v = T.Properties.VariableNames; 
% pattern: Question_1 [nothing after]
disp('**************')
idx = [];
for i = 3:length(v); 
    if length(v{i})<15; 
        idx = [idx; i];
    end
end
T = T(:,idx); 

%% convert all to cells
T2 = [];
for i = 1:size(T,1); 
    for j = 1:size(T,2); 
        s = T{i,j}; 
        if iscell(s); 
            s = s{1}; 
        end
        T2{i,j} = s; 
%         disp(s)
    end
end
T = T2; 

%% get answer options
A = readtable('quiz_answer_options_new list.xlsx');
A = A(1:end-2,:);

