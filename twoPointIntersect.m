function [xi, yi] = twoPointIntersect(xa,ya,xb,yb)
% This function computes the intersection between two lines given two
% points on each line.
% xa, ya, xb, yb are two each element vectors. [xa(1), ya(1)] correspond to a
% point on line 'a', etc.


[ma, ba] = twoPointLine(xa,ya);
[mb, bb] = twoPointLine(xb,yb);

xi = (bb-ba)./(ma-mb);
yi = ma.*xi+ba;

