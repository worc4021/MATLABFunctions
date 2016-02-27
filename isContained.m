function retVal = isContained(A1,b1,A2,b2)
% isContained(A1,b1,A2,b2)
% Checks whether A1*x<=b1 is contained in A2*x<=b2.
% 
% if and(~isempty(A1),~isempty(A2))
%     V = vertexEnumeration(A1,b1);
%     retVal = 1;
%     for i = 1:size(V,1)
%         retVal = and(retVal,CheckLinCons(V(i,:)',A2,b2));
%     end
% else
%     retVal = 0;
% end

if and(~isempty(A1),~isempty(A2))
    
    m = length(b2);

    Aeq = sparse(kron(eye(m),A1'));
    beq = reshape(A2',numel(A2),1);
    Aineq = sparse(kron(eye(m),b1'));
    bineq = b2;

    model = struct('obj',ones(size(Aeq,2),1),...
                    'A',[Aeq;Aineq],...
                    'rhs',[beq;bineq],...
                    'sense',[char(ones(size(beq))*'=');char(ones(size(bineq))*'<')],...
                    'lb',zeros(size(Aeq,2),1));
	param = struct('LogToConsole',0,'OutputFlag',0);
    
    res = gurobi(model,param);

    retVal = or(strcmp(res.status,'OPTIMAL'),strcmp(res.status,'SUBOPTIMAL'));
    
    
    
else
    retVal = 0;
end