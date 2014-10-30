function [slope, yint] = twoPointLine(X,Y)
y1 = Y(1);
y2 = Y(2);
x1 = X(1);
x2 = X(2);
slope = (y1-y2)./(x1-x2);
yint = (x1.*y2-x2.*y1)./(x1-x2);