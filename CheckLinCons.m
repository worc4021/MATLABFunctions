function bool = CheckLinCons(x,LHS,RHS)
% bool = CheckLinCons(x,LHS,RHS) checks whether LHS*x<=RHS holds.
tol = 1e-9;

bool = isempty(find(LHS*x-RHS>tol,1));