function [C, vc, V, Vem, MCCm, Lm, Um, Sem, Ls, Us, Fpm, Lf,Uf, PPVm, Lp, Up, NPVm,Ln,Un] = fcnGetStats(T,A);


%% parse answers for each expert
% create answer matrix: Q x A [rows = questions; cols = answer options]
R = zeros(size(T,1),size(T,2),size(A,1)); % 4 x 32 x 31 
for i = 1:size(T,1)
    for j = 1:size(T,2); % loop over questions
        a = T{i,j}; 
        for k = 1:size(A,1); % loop over answers 
            q = A{k,1}{1};
            r = findstr(a,q); 
            if ~isempty(r); 
                R(i,j,k) = 1; 
            end
        end
    end
end

%% get concensus / correct answer
C = [];
for i = 1:size(R,2); 
    for j = 1:size(R,3); 
        t = R(:,i,j); 
        disp(t); 
        C(i,j) = mode(t); 
    end
end

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
