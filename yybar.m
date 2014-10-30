function yybar(p1,p2,p3,p4,p5,p6)
figure
xlims = 250;
inBeamD = 45;
outBeamD = 90;
beamMin = 35;
ymin = beamMin/2;
ylims = outBeamD/2+5;
d1 = 2500;
d5 = 4500;

% Plot y and ybar axes
% plot([0 0],[-ylims, ylims],'k')
% hold on
% plot([-xlims xlims],[0, 0],'k')

% Plot beam diameter limits
plot([0 xlims],[ymin ymin],'--k')
hold on
plot([0 xlims],[-ymin -ymin],'--k')

x1 = p1(1); y1 = p1(2);
x2 = p2(1); y2 = p2(2);
x3 = p3(1); y3 = p3(2);
x4 = p4(1); y4 = p4(2);
x5 = p5(1); y5 = p5(2);
x6 = p6(1); y6 = p6(2);

% Plot minimum mirror lines
plot([x1 x2 x3 x4 x5 x6],[y1 y2 y3 y4 y5 y6],'r','LineWidth',2)
plot([x1 x2 x3 x4 x5 x6],[y1 y2 y3 y4 y5 y6],'*k','LineWidth',1)
% fill([0 0 2500/45*2 x1 x2 5000/90*2 0]',[35 45 45 y1 y2 -90 -90],'r','LineStyle','none','FaceColor','r','FaceAlpha',0.5)
h1 = fill([0 x1 x2]',[0 y1 y2]','r','LineStyle','none','FaceColor','b','FaceAlpha',0.5);
h2 = fill([0 x2 x3]',[0 y2 y3]','r','LineStyle','none','FaceColor',[1 1 0],'FaceAlpha',0.5);
h3 = fill([0 x3 x4]',[0 y3 y4]','r','LineStyle','none','FaceColor',[0 1 0],'FaceAlpha',0.5);
h4 = fill([0 x4 x5]',[0 y4 y5]','r','LineStyle','none','FaceColor',[1 0.6 0],'FaceAlpha',0.5);
h5 = fill([0 x5 x6]',[0 y5 y6]','r','LineStyle','none','FaceColor',[0 1 1],'FaceAlpha',0.5);
hold off
area1 = norm(cross([0 x1 x2],[0 y1 y2]))/2;
area2 = norm(cross([0 x2 x3],[0 y2 y3]))/2;
area3 = norm(cross([0 x3 x4],[0 y3 y4]))/2;
area4 = norm(cross([0 x4 x5],[0 y4 y5]))/2;
area5 = norm(cross([0 x5 x6],[0 y5 y6]))/2;
ylim([-outBeamD/2-5 outBeamD/2+5])
legend([h1 h2 h3 h4 h5],['Area: ' num2str(area1,4)],['Area: ' num2str(area2,4)],...
    ['Area: ' num2str(area3,4)],['Area: ' num2str(area4,4)],...
    ['Area: ' num2str(area5,4)],'Location','NorthWest');
grid on
set(gca,'gridalpha',0.5)
ylabel('Marginal Ray Height ($y$)','interpreter','latex')
xlabel('Chief Ray Height ($\bar{y}$)','interpreter','latex')
