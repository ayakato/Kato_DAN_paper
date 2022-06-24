function x = fdiffN(x,dt,n,m)
% x = dofdiff(x,dt,degree,dimension)
%
if(nargin < 4)
    m = 1;
end
if(nargin < 3)
    n = 1;
end
for i = 1:n
    x = dofdiff(x,dt,m);
end;

function y = dofdiff(x,dt,m)
k = size(x);
k(m) = 1;
y = zeros(k);
y = cat(m,diff(x,1,m)/dt,y);
