function jac = Jacobi(x,fun,h)
% J = Jacobi(x,fun,stepSize) returns Jacobian J of fun evaluated at
% stepSize by finite difference method. For scalar functions J is the
% transposed gradient.



inc = eye(numel(x))*h;

fx = fun(x);

if and(size(fx,2)~=1,size(fx,1)>1)
    transp = 1;
    helpjac = kron(ones(1,numel(x)),fx');
else
    transp = 0;
    helpjac = kron(ones(1,numel(x)),fx);
end

helpjac2 = zeros(size(helpjac));

for i = 1:numel(x)
    dx = reshape(inc(:,i),size(x,1),size(x,2));
    if transp
        helpjac2(:,i) = fun(x+dx)';
    else
        helpjac2(:,i) = fun(x+dx);
    end
end

jac = (helpjac2 - helpjac)/h;