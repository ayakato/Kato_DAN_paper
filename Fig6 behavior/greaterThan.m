function r = greaterThan(x,y)
% return a double array containing 1 where x > y, or 0 otherwise, but keeps
% the NaN entries (usually, NaN > x returns 0 for any x, so that, e.g.,
% [1,2,NaN] > 1 = [0,1,0] and not [0,1,NaN] as the present function
% returns.
%
r = double(x > y) + 0./(~isnan(x));

