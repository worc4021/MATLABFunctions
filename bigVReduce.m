function Vout = bigVReduce(Vin)


if ~isempty(Vin)
    idx = true(size(Vin,1),1);
    param = struct('OutputFlag', 0);
    V = sparse(Vin);
    for i = 1:length(idx)
        idx(i) = false;
        curNum = numel(find(idx));
        model = struct('obj',zeros(curNum,1),...
            'A',[V(idx,:)';sparse(ones(1,curNum))],...
            'rhs', [Vin(i,:)';1],...
            'sense', '=',...
            'lb',zeros(curNum,1));
        res = gurobi(model,param);
        idx(i) = strcmp(res.status,'INFEASIBLE');
    end
    
    Vout = Vin(idx,:);
else
    Vout = [];
end
           