function [Aout,bout] = bigReduce(Ain,bin)

if ~isempty(Ain)
    idx = true(size(bin));
    param = struct('OutputFlag', 0);
    for i = 1:length(bin)
        idx(i) = false;
        
% ------------ Gurobi ------------
        curNum = numel(find(idx));
        model = struct('obj',zeros(curNum,1),...
            'A',sparse([Ain(idx,:)';bin(idx)']),...
            'rhs', [Ain(i,:)';bin(i)],...
            'sense', [char(ones(size(Ain,2),1)*'=');char(ones(1)*'<')],...
            'lb',zeros(curNum,1));
        res = gurobi(model,param);
            
        idx(i) = strcmp(res.status,'INFEASIBLE');

        
% ------------ Own Simplex Phase One solver ----------
%         idx(i) = ~phaseI(bin(idx)',bin(i),Ain(idx,:)',Ain(i,:)');
    end

    Aout = Ain(idx,:);
    bout = bin(idx);
else
    Aout = [];
    bout = [];
end