function yybarOPAL
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

yybar([x1 y1],[x2 y2],[x3,y3],[x4,y4],[x5,y5],[x6,y6])