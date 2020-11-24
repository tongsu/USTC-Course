function [root] = NewtonRootWithDbg(f, x0, eps, itermax, realroot)
%NEWTONROOT Use Newton method to get the root of functions
global debugflg
if debugflg == 2
    fprintf('Init,\tx0 %.12e, f(x0) %.12e\n', x0, f(x0));
end
itertimes = 0;
% use matlab diff to get derivative, if fderive is given NaN
% if fderive == NaN
% get the derive of f(x) the function handle, 
% a simple diff is not enough
syms x
fderive = eval(['@(x)' char(diff(f(x)))]);
% end
% fderive = diff(f);

% test order
p = 1.3;
epss = abs(realroot - x0);
while abs(f(x0)) >= eps && itertimes < itermax

    x0 = x0 - f(x0) / fderive(x0);
    epsold = epss;
    epss = abs(realroot - x0);
    fprintf('Order: %.6e\n', epss / (epsold^p));
    itertimes = itertimes + 1;
    if debugflg == 2
        fprintf('Iter %3d,\tx0 %.12e, f(x0) %.12e\n', itertimes, x0, f(x0));
    end
end
if itertimes < itermax
    root = x0;
else
    root = NaN;
end
end

