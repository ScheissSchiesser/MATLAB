function yybarOPAL2
xlims = 250;
inBeamD = 45;
outBeamD = 90;
beamMin = 35;
ymin = beamMin/2;
ylims = outBeamD/2+5;
d1 = 2530;
d5 = 4250;

x1 = 0; y1 = inBeamD/2;
x2 = d1/(inBeamD/2)*2; y2 = y1;
[x3,y3] = twoPointIntersect([x1 x2],[0 y2],[0 150],[ymin ymin]);
x6 = 0; y6 = -outBeamD/2;
x5 = d5/(outBeamD/2)*2; y5 = y6;
[x4,y4] = twoPointIntersect([x6 x5],[0 y5],[0 150],[-ymin -ymin]);
x3 = 220;
x4 = 102;

f1 = yybarF(x1,x2,x3,y1,y2,y3)/y2;
f2 = yybarF(x2,x3,x4,y2,y3,y4)/y3;
f3 = yybarF(x3,x4,x5,y3,y4,y5)/y4;
f4 = yybarF(x4,x5,x6,y4,y5,y6)/y5;
disp(['M1 F/# = ' num2str(f1,3)])
disp(['M2 F/# = ' num2str(f2,3)])
disp(['M3 F/# = ' num2str(f3,3)])
disp(['M4 F/# = ' num2str(f4,3)])

yybar([x1 y1],[x2 y2],[x3,y3],[x4,y4],[x5,y5],[x6,y6])

function f = yybarF(x1,x2,x3,y1,y2,y3)
[~, yint] = twoPointLine([x1 x2],[y1 y2]);
oline = [x1 x2; y1 y2]-yint;
[xi,yi] = twoPointIntersect(oline(1,:),oline(2,:),[x2 x3],[y2,y3]);
area = norm(cross([xi, x2, 0],[yi, y2, 0]))/2;
f = area;
