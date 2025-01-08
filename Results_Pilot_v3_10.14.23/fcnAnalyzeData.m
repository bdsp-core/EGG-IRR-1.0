function [vc, V] = fcnAnalyzeData(v,T,fileName)


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
        disp(s)
    end
end
T = T2; 


%% get answer options
A = readtable('quiz_answer_options.xlsx');
varNames = A(:,2); 
A = A(:,1); 

%% parse answers for each expert
% create answer matrix: Q x A [rows = questions; cols = answer options]
R = zeros(size(T,1),size(T,2),size(A,1)); % 4 x 32 x 31 
for i = 1:size(T,1)
    for j = 1:size(T,2); % loop over questions
        a = T{i,j}; 
        a = string(a); 
        if ismissing(a)
            a = '';
        end
        for k = 1:size(A,1); % loop over answers 
            q = A{k,1}{1};
            disp(a)
            disp(q)
            disp('************')
            r = findstr(a,q); 
            if ~isempty(r); 
                R(i,j,k) = 1; 
            end
        end
    end
end

%% get concensus / correct answer

% get C: 32 x 29 (32 questions, 29 options each)
c = readtable('C-matrix.csv');
a = c(:,3:end); a = table2array(a); 
a = a'; 
col0 = c(:,2); col0 = table2array(col0); 
col1 = sum(a)'; 
disp([col0 col1])
C = a; 

%% get correct answer for ve-cam-s scores
W = fcnGetW; 
vc = min(sum((W.*C)'),15); 

%% get percent agreement for each category (pa)
s = []; f = []; p = []; n = []; m = []; 
for i = 1:1000
    % bootstrap on questions
    idx = randsample(size(R,2),size(R,2),1);
    [Sem,Fpm, PPVm, NPVm, MCCm,Vem, V, Ve] = fcnGetStats(R(:,idx,:),C(idx,:), vc(idx)); 
    s(i,:) = Sem; 
    f(i,:) = Fpm; 
    p(i,:) = PPVm; 
    n(i,:) = NPVm; 
    m(i,:) = MCCm; 
    
end

Ls = prctile(s,2.5); 
Us = prctile(s,97.5);

Lf = prctile(f,2.5); 
Uf = prctile(f,97.5);

Lp = prctile(p,2.5); 
Up = prctile(p,97.5);

Ln = prctile(n,2.5); 
Un = prctile(n,97.5);

Lm = prctile(m,2.5); 
Um = prctile(m,97.5);

[Sem,Fpm, PPVm, NPVm, MCCm, Vem, V, Ve] = fcnGetStats(R,C,vc); 


%% show bar charts
xLabels = fcnGetLabels; 
disp('*********')
for i = 1:length(Fpm);
    nStr = num2str(round(100*[Sem(i) Fpm(i) PPVm(i) NPVm(i)])); 
    disp([xLabels{i} ': ' nStr])
end

%% write to file
N = sum(C); 
varNames = table2array(varNames);
T2 = table(varNames, N',MCCm', Lm', Um', Sem', Ls', Us', Fpm', Lf',Uf', PPVm', Lp', Up', NPVm',Ln',Un'); 
v = {'var','N+','MCC','MCCL','MCCU','Sens', 'SensL','SensU', 'FPR','FPRL','FPRU','PPV','PPVL','PPVU','NPV','NPVL','NPVU'}; 
T2.Properties.VariableNames = v; 
T2.Properties.RowNames = xLabels; 
writetable(T2,fileName);