
c = [
    28   146  70 ;
    144     47   141;
    0   183    241;
    255  207  0;
    234     39  144;
    49   51  144]./255;
y = 1:10;
markersize  = 7;
markersize2 = 10;



for ind =1:4
clstndx = ind;
figure();
hold on
names = [{'Exc'},{'Del'},{'Off'},{'Inh'}];
title(names{ind},'FontSize',15)
errorbar(maxfr5(clstndx,:),maxfr5(clstndx+4,:),'o','LineWidth',1,'CapSize',0,'MarkerSize',markersize,'MarkerFaceColor',c(1,:) ,'color',c(1,:))
% errorbar(maxfr1_75(clstndx,:),maxfr1_75(clstndx+4,:),'*','LineWidth',1,'CapSize',0,'MarkerSize',markersize2,'MarkerFaceColor',c(2,:),'color',c(2,:))
errorbar(maxfr1_25(clstndx,:),maxfr1_25(clstndx+4,:),'x','LineWidth',1,'CapSize',0,'MarkerSize',markersize2,'MarkerFaceColor',c(2,:),'color',c(2,:))
% errorbar(maxfr1(clstndx,:),maxfr1(clstndx+4,:),'^','LineWidth',1,'CapSize',0,'MarkerSize',markersize,'MarkerFaceColor',c(4,:),'color',c(4,:))
% errorbar(maxfr0_75(clstndx,:),maxfr0_75(clstndx+4,:),'s','LineWidth',1,'CapSize',0,'MarkerSize',markersize,'MarkerFaceColor',c(5,:),'color',c(5,:))
errorbar(maxfr0_5(clstndx,:),maxfr0_5(clstndx+4,:),'d','LineWidth',1,'CapSize',0,'MarkerSize',markersize,'MarkerFaceColor',c(5,:),'color',c(5,:))

data0_5 = frall0_5{clstndx};
data0_75 = frall0_75{clstndx};
data1 = frall1{clstndx};
data1_25 = frall1_25{clstndx};
data1_75 = frall1_75{clstndx};
data5 = frall5{clstndx};

% data = [mean(data0_5(:,10)-data0_5(:,1)) mean(data0_75(:,10)-data0_75(:,1)) mean(data1(:,10)-data1(:,1)) mean(data1_25(:,10)-data1_25(:,1)) mean(data1_75(:,10)-data1_75(:,1)) mean(data5(:,10)-data5(:,1)) ];
% datastd = [std(data0_5(:,10)-data0_5(:,1))/sqrt(size(data0_5,1)) std(data0_75(:,10)-data0_75(:,1))/sqrt(size(data0_75,1)) std(data1(:,10)-data1(:,1))/sqrt(size(data1,1)) std(data1_25(:,10)-data1_25(:,1))/sqrt(size(data1_25,1)) std(data1_75(:,10)-data1_75(:,1))/sqrt(size(data1_75,1)) std(data5(:,10)-data5(:,1))/sqrt(size(data5,1)) ];
% errorbar(data,datastd,'Color',c2(3,:))
% plot([1:6],zeros(6),'LineStyle','--','color',[ 211 211 211]./255,'linewidth',2);


hold on
plot([1:10],maxfr5(clstndx,:),'Linewidth',2,'color',c(1,:));
% plot([1:10],maxfr1_75(clstndx,:),'Linewidth',2,'color',c(2,:));
plot([1:10],maxfr1_25(clstndx,:),'Linewidth',2,'color',c(2,:));
% plot([1:10],maxfr1(clstndx,:),'Linewidth',2,'color',c(4,:));
% plot([1:10],maxfr0_75(clstndx,:),'Linewidth',2,'color',c(5,:));
plot([1:10],maxfr0_5(clstndx,:),'Linewidth',2,'color',c(5,:));

% 
% violin(maxfr5(clstndx,:),'bw',maxfr5(clstndx+4,:)/2,'mc',[],'medc',[],'facecolor',c(1,:),'edgecolor','none','facealpha',0.3);
% violin(maxfr1_75(clstndx,:),'bw',maxfr1_75(clstndx+4,:)/2,'mc',[],'medc',[],'facecolor',c(2,:),'edgecolor','none','facealpha',0.3);
% violin(maxfr1_25(clstndx,:),'bw',maxfr1_25(clstndx+4,:)/2,'mc',[],'medc',[],'facecolor',c(3,:),'edgecolor','none','facealpha',0.3);
% violin(maxfr1(clstndx,:),'bw',maxfr1(clstndx+4,:)/2,'mc',[],'medc',[],'facecolor',c(4,:),'edgecolor','none','facealpha',0.3);
% violin(maxfr0_75(clstndx,:),'bw',maxfr0_75(clstndx+4,:)/2,'mc',[],'medc',[],'facecolor',c(5,:),'edgecolor','none','facealpha',0.3);
% violin(maxfr0_5(clstndx,:),'bw',maxfr0_5(clstndx+4,:)/2,'mc',[],'medc',[],'facecolor',c(6,:),'edgecolor','none','facealpha',0.3);

% violin(maxfr5(clstndx,:),'bw',maxfr5(clstndx+4,:)/2,'mc',[],'medc',[],'facecolor',[1 1 1],'edgecolor',c(1,:));
% violin(maxfr1_75(clstndx,:),'bw',maxfr1_75(clstndx+4,:)/2,'mc',[],'medc',[],'facecolor',[1 1 1],'edgecolor',c(2,:));
% violin(maxfr1_25(clstndx,:),'bw',maxfr1_25(clstndx+4,:)/2,'mc',[],'medc',[],'facecolor',[1 1 1],'edgecolor',c(3,:));
% violin(maxfr1(clstndx,:),'bw',maxfr1(clstndx+4,:)/2,'mc',[],'medc',[],'facecolor',[1 1 1],'edgecolor',c(4,:));
% violin(maxfr0_75(clstndx,:),'bw',maxfr0_75(clstndx+4,:)/2,'mc',[],'medc',[],'facecolor',[1 1 1],'edgecolor',c(5,:));
% violin(maxfr0_5(clstndx,:),'bw',maxfr0_5(clstndx+4,:)/2,'mc',[],'medc',[],'facecolor',[1 1 1],'edgecolor',c(6,:));


if any(maxfr5(clstndx+8,1:10) < 0.05 & maxfr5(clstndx+8,1:10) > 0)
    plot(y(maxfr5(clstndx+8,1:10) < 0.05 & maxfr5(clstndx+8,1:10) > 0), 1.35,'*','color',c(1,:),'MarkerSize',8);
end
% if any(maxfr1_75(clstndx+8,1:10) < 0.05 & maxfr1_75(clstndx+8,1:10) > 0)
%     plot(y(maxfr1_75(clstndx+8,1:10) < 0.05 & maxfr1_75(clstndx+8,1:10) > 0),1.3,'*','color',c(2,:),'MarkerSize',8);
% end
if any(maxfr1_25(clstndx+8,1:10) < 0.05 & maxfr1_25(clstndx+8,1:10) > 0)
    plot(y(maxfr1_25(clstndx+8,1:10) < 0.05 & maxfr1_25(clstndx+8,1:10) > 0), 1.25,'*','color',c(2,:),'MarkerSize',8);
end
% if any(maxfr1(clstndx+8,1:10) < 0.05 & maxfr1(clstndx+8,1:10) > 0)
%     plot(y(maxfr1(clstndx+8,1:10) < 0.05 & maxfr1(clstndx+8,1:10) > 0), 1.2,'*','color',c(4,:),'MarkerSize',8);
% end
% if any(maxfr0_75(clstndx+8,1:10) < 0.05 & maxfr0_75(clstndx+8,1:10) > 0)
%     plot(y(maxfr0_75(clstndx+8,1:10) < 0.05 & maxfr0_75(clstndx+8,1:10) > 0), 1.2,'*','color',c(5,:),'MarkerSize',8);
% end
if any(maxfr0_5(clstndx+8,1:10) < 0.05 & maxfr0_5(clstndx+8,1:10) > 0)
    plot(y(maxfr0_5(clstndx+8,1:10) < 0.05 & maxfr0_5(clstndx+8,1:10) > 0), 1.15,'*','color',c(5,:),'MarkerSize',8);
end
% lga = legend({'5s','1.75s','1.25s','1s','0.75s','0.5s','Baseline'},'FontSize',15,'Location','northwest');
xlabel('Inter Pulse Interval (s)','FontSize',15)
ylabel('Normalized response change from first to last pulse','FontSize',15)
xticks([1:10])
ylim([-1 1.5])
xlim([0.5 10.5])
a=gca;
a.YGrid = 'off';
a.GridAlpha = .3;
savefigpdf(sprintf('%s_IPI_stats',names{ind}))
end
%%
c = [
    28   146  70 ;
    144     47   141;
    0   183    241;
    255  207  0;
    234     39  144;
    49   51  144]./255;
y = 1:10;
markersize  = 10;
markersize2 = 15;



for ind =1:4
clstndx = ind;
figure();
hold on
names = [{'Exc'},{'Del'},{'Off'},{'Inh'}];
title(names{ind},'FontSize',15)
errorbar(maxfr5(clstndx,:),maxfr5(clstndx+4,:),'o','LineWidth',1,'CapSize',0,'MarkerSize',markersize,'MarkerFaceColor',c(1,:) ,'color',c(1,:))
errorbar(maxfr1_75(clstndx,:),maxfr1_75(clstndx+4,:),'*','LineWidth',1,'CapSize',0,'MarkerSize',markersize2,'MarkerFaceColor',c(2,:),'color',c(2,:))
errorbar(maxfr1_25(clstndx,:),maxfr1_25(clstndx+4,:),'x','LineWidth',1,'CapSize',0,'MarkerSize',markersize2,'MarkerFaceColor',c(3,:),'color',c(3,:))
errorbar(maxfr1(clstndx,:),maxfr1(clstndx+4,:),'^','LineWidth',1,'CapSize',0,'MarkerSize',markersize,'MarkerFaceColor',c(4,:),'color',c(4,:))
errorbar(maxfr0_75(clstndx,:),maxfr0_75(clstndx+4,:),'s','LineWidth',1,'CapSize',0,'MarkerSize',markersize,'MarkerFaceColor',c(5,:),'color',c(5,:))
errorbar(maxfr0_5(clstndx,:),maxfr0_5(clstndx+4,:),'d','LineWidth',1,'CapSize',0,'MarkerSize',markersize,'MarkerFaceColor',c(6,:),'color',c(6,:))

data0_5 = frall0_5{clstndx};
data0_75 = frall0_75{clstndx};
data1 = frall1{clstndx};
data1_25 = frall1_25{clstndx};
data1_75 = frall1_75{clstndx};
data5 = frall5{clstndx};

% data = [mean(data0_5(:,10)-data0_5(:,1)) mean(data0_75(:,10)-data0_75(:,1)) mean(data1(:,10)-data1(:,1)) mean(data1_25(:,10)-data1_25(:,1)) mean(data1_75(:,10)-data1_75(:,1)) mean(data5(:,10)-data5(:,1)) ];
% datastd = [std(data0_5(:,10)-data0_5(:,1))/sqrt(size(data0_5,1)) std(data0_75(:,10)-data0_75(:,1))/sqrt(size(data0_75,1)) std(data1(:,10)-data1(:,1))/sqrt(size(data1,1)) std(data1_25(:,10)-data1_25(:,1))/sqrt(size(data1_25,1)) std(data1_75(:,10)-data1_75(:,1))/sqrt(size(data1_75,1)) std(data5(:,10)-data5(:,1))/sqrt(size(data5,1)) ];
% errorbar(data,datastd,'Color',c2(3,:))
% plot([1:6],zeros(6),'LineStyle','--','color',[ 211 211 211]./255,'linewidth',2);


hold on
plot([1:10],maxfr5(clstndx,:),'Linewidth',1,'color',c(1,:));
plot([1:10],maxfr1_75(clstndx,:),'Linewidth',1,'color',c(2,:));
plot([1:10],maxfr1_25(clstndx,:),'Linewidth',1,'color',c(3,:));
plot([1:10],maxfr1(clstndx,:),'Linewidth',1,'color',c(4,:));
plot([1:10],maxfr0_75(clstndx,:),'Linewidth',1,'color',c(5,:));
plot([1:10],maxfr0_5(clstndx,:),'Linewidth',1,'color',c(6,:));

% 
% violin(maxfr5(clstndx,:),'bw',maxfr5(clstndx+4,:)/2,'mc',[],'medc',[],'facecolor',c(1,:),'edgecolor','none','facealpha',0.3);
% violin(maxfr1_75(clstndx,:),'bw',maxfr1_75(clstndx+4,:)/2,'mc',[],'medc',[],'facecolor',c(2,:),'edgecolor','none','facealpha',0.3);
% violin(maxfr1_25(clstndx,:),'bw',maxfr1_25(clstndx+4,:)/2,'mc',[],'medc',[],'facecolor',c(3,:),'edgecolor','none','facealpha',0.3);
% violin(maxfr1(clstndx,:),'bw',maxfr1(clstndx+4,:)/2,'mc',[],'medc',[],'facecolor',c(4,:),'edgecolor','none','facealpha',0.3);
% violin(maxfr0_75(clstndx,:),'bw',maxfr0_75(clstndx+4,:)/2,'mc',[],'medc',[],'facecolor',c(5,:),'edgecolor','none','facealpha',0.3);
% violin(maxfr0_5(clstndx,:),'bw',maxfr0_5(clstndx+4,:)/2,'mc',[],'medc',[],'facecolor',c(6,:),'edgecolor','none','facealpha',0.3);

% violin(maxfr5(clstndx,:),'bw',maxfr5(clstndx+4,:)/2,'mc',[],'medc',[],'facecolor',[1 1 1],'edgecolor',c(1,:));
% violin(maxfr1_75(clstndx,:),'bw',maxfr1_75(clstndx+4,:)/2,'mc',[],'medc',[],'facecolor',[1 1 1],'edgecolor',c(2,:));
% violin(maxfr1_25(clstndx,:),'bw',maxfr1_25(clstndx+4,:)/2,'mc',[],'medc',[],'facecolor',[1 1 1],'edgecolor',c(3,:));
% violin(maxfr1(clstndx,:),'bw',maxfr1(clstndx+4,:)/2,'mc',[],'medc',[],'facecolor',[1 1 1],'edgecolor',c(4,:));
% violin(maxfr0_75(clstndx,:),'bw',maxfr0_75(clstndx+4,:)/2,'mc',[],'medc',[],'facecolor',[1 1 1],'edgecolor',c(5,:));
% violin(maxfr0_5(clstndx,:),'bw',maxfr0_5(clstndx+4,:)/2,'mc',[],'medc',[],'facecolor',[1 1 1],'edgecolor',c(6,:));


if any(maxfr5(clstndx+8,1:10) < 0.05 & maxfr5(clstndx+8,1:10) > 0)
    plot(y(maxfr5(clstndx+8,1:10) < 0.05 & maxfr5(clstndx+8,1:10) > 0), 1.35,'*','color',c(1,:),'MarkerSize',8);
end
% if any(maxfr1_75(clstndx+8,1:10) < 0.05 & maxfr1_75(clstndx+8,1:10) > 0)
%     plot(y(maxfr1_75(clstndx+8,1:10) < 0.05 & maxfr1_75(clstndx+8,1:10) > 0),1.3,'*','color',c(2,:),'MarkerSize',8);
% end
if any(maxfr1_25(clstndx+8,1:10) < 0.05 & maxfr1_25(clstndx+8,1:10) > 0)
    plot(y(maxfr1_25(clstndx+8,1:10) < 0.05 & maxfr1_25(clstndx+8,1:10) > 0), 1.25,'*','color',c(2,:),'MarkerSize',8);
end
% if any(maxfr1(clstndx+8,1:10) < 0.05 & maxfr1(clstndx+8,1:10) > 0)
%     plot(y(maxfr1(clstndx+8,1:10) < 0.05 & maxfr1(clstndx+8,1:10) > 0), 1.2,'*','color',c(4,:),'MarkerSize',8);
% end
% if any(maxfr0_75(clstndx+8,1:10) < 0.05 & maxfr0_75(clstndx+8,1:10) > 0)
%     plot(y(maxfr0_75(clstndx+8,1:10) < 0.05 & maxfr0_75(clstndx+8,1:10) > 0), 1.2,'*','color',c(5,:),'MarkerSize',8);
% end
if any(maxfr0_5(clstndx+8,1:10) < 0.05 & maxfr0_5(clstndx+8,1:10) > 0)
    plot(y(maxfr0_5(clstndx+8,1:10) < 0.05 & maxfr0_5(clstndx+8,1:10) > 0), 1.15,'*','color',c(5,:),'MarkerSize',8);
end
% lga = legend({'5s','1.75s','1.25s','1s','0.75s','0.5s','Baseline'},'FontSize',15,'Location','northwest');
xlabel('Inter Pulse Interval (s)','FontSize',15)
ylabel('Normalized response change from first to last pulse','FontSize',15)
xticks([1:10])
ylim([-1 1.5])
xlim([0.5 10.5])
a=gca;
a.YGrid = 'off';
a.GridAlpha = .3;
savefigpdf(sprintf('%s_IPI_stats',names{ind}))
end




%%
clstndx = 3;
figure();
hold on
title('Offset Excitatory','FontSize',15)
% errorbar(maxfr5(clstndx,:),maxfr5(clstndx+4,:),'o','LineWidth',1,'CapSize',0,'MarkerSize',markersize,'MarkerFaceColor',c(1,:) ,'color',c(1,:))
% errorbar(maxfr1_75(clstndx,:),maxfr1_75(clstndx+4,:),'*','LineWidth',1,'CapSize',0,'MarkerSize',markersize2,'MarkerFaceColor',c(2,:),'color',c(2,:))
% errorbar(maxfr1_25(clstndx,:),maxfr1_25(clstndx+4,:),'x','LineWidth',1,'CapSize',0,'MarkerSize',markersize2,'MarkerFaceColor',c(3,:),'color',c(3,:))
% errorbar(maxfr1(clstndx,:),maxfr1(clstndx+4,:),'^','LineWidth',1,'CapSize',0,'MarkerSize',markersize,'MarkerFaceColor',c(4,:),'color',c(4,:))
% errorbar(maxfr0_75(clstndx,:),maxfr0_75(clstndx+4,:),'s','LineWidth',1,'CapSize',0,'MarkerSize',markersize,'MarkerFaceColor',c(5,:),'color',c(5,:))
% errorbar(maxfr0_5(clstndx,:),maxfr0_5(clstndx+4,:),'d','LineWidth',1,'CapSize',0,'MarkerSize',markersize,'MarkerFaceColor',c(6,:),'color',c(6,:))

data0_5 = frall0_5{clstndx};
data0_75 = frall0_75{clstndx};
data1 = frall1{clstndx};
data1_25 = frall1_25{clstndx};
data1_75 = frall1_75{clstndx};
data5 = frall5{clstndx};

data = [mean(data0_5(:,10)-data0_5(:,1)) mean(data0_75(:,10)-data0_75(:,1)) mean(data1(:,10)-data1(:,1)) mean(data1_25(:,10)-data1_25(:,1)) mean(data1_75(:,10)-data1_75(:,1)) mean(data5(:,10)-data5(:,1)) ];
datastd = [std(data0_5(:,10)-data0_5(:,1))/sqrt(size(data0_5,1)) std(data0_75(:,10)-data0_75(:,1))/sqrt(size(data0_75,1)) std(data1(:,10)-data1(:,1))/sqrt(size(data1,1)) std(data1_25(:,10)-data1_25(:,1))/sqrt(size(data1_25,1)) std(data1_75(:,10)-data1_75(:,1))/sqrt(size(data1_75,1)) std(data5(:,10)-data5(:,1))/sqrt(size(data5,1)) ];
errorbar(data,datastd,'Color',c2(4,:))


plot([0.5:10.5],zeros(11),'LineStyle','--','color',[ 211 211 211]./255,'linewidth',2);


% hold on
% plot([1:10],maxfr5(clstndx,:),'Linewidth',2,'color',c(1,:));
% plot([1:10],maxfr1_75(clstndx,:),'Linewidth',2,'color',c(2,:));
% plot([1:10],maxfr1_25(clstndx,:),'Linewidth',2,'color',c(3,:));
% plot([1:10],maxfr1(clstndx,:),'Linewidth',2,'color',c(4,:));
% plot([1:10],maxfr0_75(clstndx,:),'Linewidth',2,'color',c(5,:));
% plot([1:10],maxfr0_5(clstndx,:),'Linewidth',2,'color',c(6,:));

% violin(maxfr5(clstndx,:),'bw',maxfr5(clstndx+4,:)/2,'mc',[],'medc',[],'facecolor',c(1,:),'edgecolor','none','facealpha',0.3);
% violin(maxfr1_75(clstndx,:),'bw',maxfr1_75(clstndx+4,:)/2,'mc',[],'medc',[],'facecolor',c(2,:),'edgecolor','none','facealpha',0.3);
% violin(maxfr1_25(clstndx,:),'bw',maxfr1_25(clstndx+4,:)/2,'mc',[],'medc',[],'facecolor',c(3,:),'edgecolor','none','facealpha',0.3);
% violin(maxfr1(clstndx,:),'bw',maxfr1(clstndx+4,:)/2,'mc',[],'medc',[],'facecolor',c(4,:),'edgecolor','none','facealpha',0.3);
% violin(maxfr0_75(clstndx,:),'bw',maxfr0_75(clstndx+4,:)/2,'mc',[],'medc',[],'facecolor',c(5,:),'edgecolor','none','facealpha',0.3);
% violin(maxfr0_5(clstndx,:),'bw',maxfr0_5(clstndx+4,:)/2,'mc',[],'medc',[],'facecolor',c(6,:),'edgecolor','none','facealpha',0.3);

% violin(maxfr5(clstndx,:),'bw',maxfr5(clstndx+4,:)/2,'mc',[],'medc',[],'facecolor','none','edgecolor',c(1,:));
% violin(maxfr1_75(clstndx,:),'bw',maxfr1_75(clstndx+4,:)/2,'mc',[],'medc',[],'facecolor','none','edgecolor',c(2,:));
% violin(maxfr1_25(clstndx,:),'bw',maxfr1_25(clstndx+4,:)/2,'mc',[],'medc',[],'facecolor','none','edgecolor',c(3,:));
% violin(maxfr1(clstndx,:),'bw',maxfr1(clstndx+4,:)/2,'mc',[],'medc',[],'facecolor','none','edgecolor',c(4,:));
% violin(maxfr0_75(clstndx,:),'bw',maxfr0_75(clstndx+4,:)/2,'mc',[],'medc',[],'facecolor','none','edgecolor',c(5,:));
% violin(maxfr0_5(clstndx,:),'bw',maxfr0_5(clstndx+4,:)/2,'mc',[],'medc',[],'facecolor','none','edgecolor',c(6,:));


% if any(maxfr5(clstndx+8,1:10) < 0.05 & maxfr5(clstndx+8,1:10) > 0)
%     plot(y(maxfr5(clstndx+8,1:10) < 0.05 & maxfr5(clstndx+8,1:10) > 0), 0.4,'*','color',c(1,:),'MarkerSize',8)
% end
% if any(maxfr1_75(clstndx+8,1:10) < 0.05 & maxfr1_75(clstndx+8,1:10) > 0)
%     plot(y(maxfr1_75(clstndx+8,1:10) < 0.05 & maxfr1_75(clstndx+8,1:10) > 0),0.35,'*','color',c(2,:),'MarkerSize',8)
% end
% if any(maxfr1_25(clstndx+8,1:10) < 0.05 & maxfr1_25(clstndx+8,1:10) > 0)
%     plot(y(maxfr1_25(clstndx+8,1:10) < 0.05 & maxfr1_25(clstndx+8,1:10) > 0), 0.3,'*','color',c(3,:),'MarkerSize',8)
% end
% if any(maxfr1(clstndx+8,1:10) < 0.05 & maxfr1(clstndx+8,1:10) > 0)
%     plot(y(maxfr1(clstndx+8,1:10) < 0.05 & maxfr1(clstndx+8,1:10) > 0), 0.25,'*','color',c(4,:),'MarkerSize',8)
% end
% if any(maxfr0_75(clstndx+8,1:10) < 0.05 & maxfr0_75(clstndx+8,1:10) > 0)
%     plot(y(maxfr0_75(clstndx+8,1:10) < 0.05 & maxfr0_75(clstndx+8,1:10) > 0),0.2,'*','color',c(5,:),'MarkerSize',8)
% end
% if any(maxfr0_5(clstndx+8,1:10) < 0.05 & maxfr0_5(clstndx+8,1:10) > 0)
%     plot(y(maxfr0_5(clstndx+8,1:10) < 0.05 & maxfr0_5(clstndx+8,1:10) > 0), 0.15,'*','color',c(6,:),'MarkerSize',8)
% end
% lga = legend({'5s','1.75s','1.25s','1s','0.75s','0.5s','baseline'},'FontSize',15,'Location','southeast');
% xlabel('Pulse #','FontSize',15)
% ylabel('Normalized \Delta from baseline','FontSize',15)
% xlim([0.5 10.5])
% ylim([-1.1 1.1])
% a=gca;
% a.YGrid = 'off';

xlabel('Inter Pulse Interval (s)','FontSize',15)
ylabel('Normalized response change from first to last pulse','FontSize',15)
xticks([1:6])
xticklabels([0.5 0.75 1 1.25 1.75 5])
xlim([0.9 6.1])
ylim([-1 1])
a=gca;
a.YGrid = 'off';
a.GridAlpha = .3;
%%


clstndx = 2;
figure();
hold on
title('Delayed Excitatory','FontSize',15)
% errorbar(maxfr5(clstndx,:),maxfr5(clstndx+4,:),'o','LineWidth',1,'CapSize',0,'MarkerSize',markersize,'MarkerFaceColor',c(1,:) ,'color',c(1,:))
% errorbar(maxfr1_75(clstndx,:),maxfr1_75(clstndx+4,:),'*','LineWidth',1,'CapSize',0,'MarkerSize',markersize2,'MarkerFaceColor',c(2,:),'color',c(2,:))
% errorbar(maxfr1_25(clstndx,:),maxfr1_25(clstndx+4,:),'x','LineWidth',1,'CapSize',0,'MarkerSize',markersize2,'MarkerFaceColor',c(3,:),'color',c(3,:))
% errorbar(maxfr1(clstndx,:),maxfr1(clstndx+4,:),'^','LineWidth',1,'CapSize',0,'MarkerSize',markersize,'MarkerFaceColor',c(4,:),'color',c(4,:))
% errorbar(maxfr0_75(clstndx,:),maxfr0_75(clstndx+4,:),'s','LineWidth',1,'CapSize',0,'MarkerSize',markersize,'MarkerFaceColor',c(5,:),'color',c(5,:))
% errorbar(maxfr0_5(clstndx,:),maxfr0_5(clstndx+4,:),'d','LineWidth',1,'CapSize',0,'MarkerSize',markersize,'MarkerFaceColor',c(6,:),'color',c(6,:))

data0_5 = frall0_5{clstndx};
data0_75 = frall0_75{clstndx};
data1 = frall1{clstndx};
data1_25 = frall1_25{clstndx};
data1_75 = frall1_75{clstndx};
data5 = frall5{clstndx};

data = [mean(data0_5(:,10)-data0_5(:,1)) mean(data0_75(:,10)-data0_75(:,1)) mean(data1(:,10)-data1(:,1)) mean(data1_25(:,10)-data1_25(:,1)) mean(data1_75(:,10)-data1_75(:,1)) mean(data5(:,10)-data5(:,1)) ];
datastd = [std(data0_5(:,10)-data0_5(:,1))/sqrt(size(data0_5,1)) std(data0_75(:,10)-data0_75(:,1))/sqrt(size(data0_75,1)) std(data1(:,10)-data1(:,1))/sqrt(size(data1,1)) std(data1_25(:,10)-data1_25(:,1))/sqrt(size(data1_25,1)) std(data1_75(:,10)-data1_75(:,1))/sqrt(size(data1_75,1)) std(data5(:,10)-data5(:,1))/sqrt(size(data5,1)) ];
errorbar(data,datastd,'Color',c2(2,:))

plot([0.5:10.5],zeros(11),'LineStyle','--','color',[ 211 211 211]./255,'linewidth',2);


% hold on
% plot([1:10],maxfr5(clstndx,:),'Linewidth',2,'color',c(1,:));
% plot([1:10],maxfr1_75(clstndx,:),'Linewidth',2,'color',c(2,:));
% plot([1:10],maxfr1_25(clstndx,:),'Linewidth',2,'color',c(3,:));
% plot([1:10],maxfr1(clstndx,:),'Linewidth',2,'color',c(4,:));
% plot([1:10],maxfr0_75(clstndx,:),'Linewidth',2,'color',c(5,:));
% plot([1:10],maxfr0_5(clstndx,:),'Linewidth',2,'color',c(6,:));


% violin(maxfr5(clstndx,:),'bw',maxfr5(clstndx+4,:)/2,'mc',[],'medc',[],'facecolor',c(1,:),'edgecolor','none','facealpha',0.3);
% violin(maxfr1_75(clstndx,:),'bw',maxfr1_75(clstndx+4,:)/2,'mc',[],'medc',[],'facecolor',c(2,:),'edgecolor','none','facealpha',0.3);
% violin(maxfr1_25(clstndx,:),'bw',maxfr1_25(clstndx+4,:)/2,'mc',[],'medc',[],'facecolor',c(3,:),'edgecolor','none','facealpha',0.3);
% violin(maxfr1(clstndx,:),'bw',maxfr1(clstndx+4,:)/2,'mc',[],'medc',[],'facecolor',c(4,:),'edgecolor','none','facealpha',0.3);
% violin(maxfr0_75(clstndx,:),'bw',maxfr0_75(clstndx+4,:)/2,'mc',[],'medc',[],'facecolor',c(5,:),'edgecolor','none','facealpha',0.3);
% violin(maxfr0_5(clstndx,:),'bw',maxfr0_5(clstndx+4,:)/2,'mc',[],'medc',[],'facecolor',c(6,:),'edgecolor','none','facealpha',0.3);


% plot([1:10],maxfr5(clstndx,:),'Linewidth',2,'color',c(1,:));
% plot([1:10],maxfr1_75(clstndx,:),'Linewidth',2,'color',c(2,:));
% plot([1:10],maxfr1_25(clstndx,:),'Linewidth',2,'color',c(3,:));
% plot([1:10],maxfr1(clstndx,:),'Linewidth',2,'color',c(4,:));
% plot([1:10],maxfr0_75(clstndx,:),'Linewidth',2,'color',c(5,:));
% plot([1:10],maxfr0_5(clstndx,:),'Linewidth',2,'color',c(6,:));
% 
% violin(maxfr5(clstndx,:),'bw',maxfr5(clstndx+4,:)/2,'mc',[],'medc',[],'facecolor','none','edgecolor',c(1,:));
% violin(maxfr1_75(clstndx,:),'bw',maxfr1_75(clstndx+4,:)/2,'mc',[],'medc',[],'facecolor','none','edgecolor',c(2,:));
% violin(maxfr1_25(clstndx,:),'bw',maxfr1_25(clstndx+4,:)/2,'mc',[],'medc',[],'facecolor','none','edgecolor',c(3,:));
% violin(maxfr1(clstndx,:),'bw',maxfr1(clstndx+4,:)/2,'mc',[],'medc',[],'facecolor','none','edgecolor',c(4,:));
% violin(maxfr0_75(clstndx,:),'bw',maxfr0_75(clstndx+4,:)/2,'mc',[],'medc',[],'facecolor','none','edgecolor',c(5,:));
% violin(maxfr0_5(clstndx,:),'bw',maxfr0_5(clstndx+4,:)/2,'mc',[],'medc',[],'facecolor','none','edgecolor',c(6,:));


% if any(maxfr5(clstndx+8,1:10) < 0.05 & maxfr5(clstndx+8,1:10) > 0)
%     plot(y(maxfr5(clstndx+8,1:10) < 0.05 & maxfr5(clstndx+8,1:10) > 0), 0.35,'*','color',c(1,:),'MarkerSize',8)
% end
% if any(maxfr1_75(clstndx+8,1:10) < 0.05 & maxfr1_75(clstndx+8,1:10) > 0)
%     plot(y(maxfr1_75(clstndx+8,1:10) < 0.05 & maxfr1_75(clstndx+8,1:10) > 0), 0.3,'*','color',c(2,:),'MarkerSize',8)
% end
% if any(maxfr1_25(clstndx+8,1:10) < 0.05 & maxfr1_25(clstndx+8,1:10) > 0)
%     plot(y(maxfr1_25(clstndx+8,1:10) < 0.05 & maxfr1_25(clstndx+8,1:10) > 0), 0.25,'*','color',c(3,:),'MarkerSize',8)
% end
% if any(maxfr1(clstndx+8,1:10) < 0.05 & maxfr1(clstndx+8,1:10) > 0)
%     plot(y(maxfr1(clstndx+8,1:10) < 0.05 & maxfr1(clstndx+8,1:10) > 0), 0.2,'*','color',c(4,:),'MarkerSize',8)
% end
% if any(maxfr0_75(clstndx+8,1:10) < 0.05 & maxfr0_75(clstndx+8,1:10) > 0)
%     plot(y(maxfr0_75(clstndx+8,1:10) < 0.05 & maxfr0_75(clstndx+8,1:10) > 0), 0.15,'*','color',c(5,:),'MarkerSize',8)
% end
% if any(maxfr0_5(clstndx+8,1:10) < 0.05 & maxfr0_5(clstndx+8,1:10) > 0)
%     plot(y(maxfr0_5(clstndx+8,1:10) < 0.05 & maxfr0_5(clstndx+8,1:10) > 0), 0.1,'*','color',c(6,:),'MarkerSize',8)
% end
% lgb = legend({'5s','1.75s','1.25s','1s','0.75s','0.5s','Baseline'},'FontSize',15,'Location','southwest');
% xlabel('Pulse #','FontSize',15)
% ylabel('Normalized \Delta from baseline','FontSize',15)
% xlim([0.5 10.5])
% ylim([-1.1 1.1])
% b=gca;
% b.YGrid = 'off';
% b.GridAlpha = .3;

xlabel('Inter Pulse Interval (s)','FontSize',15)
ylabel('Normalized response change from first to last pulse','FontSize',15)
xticks([1:6])
xticklabels([0.5 0.75 1 1.25 1.75 5])
xlim([0.9 6.1])
ylim([-1 1])
a=gca;
a.YGrid = 'off';
a.GridAlpha = .3;

%%

clstndx = 1;
figure();
hold on
title('Excitatory','FontSize',15)
% errorbar(maxfr5(clstndx,:),maxfr5(clstndx+4,:),'o','LineWidth',1,'CapSize',0,'MarkerSize',markersize,'MarkerFaceColor',c(1,:) ,'color',c(1,:))
% errorbar(maxfr1_75(clstndx,:),maxfr1_75(clstndx+4,:),'*','LineWidth',1,'CapSize',0,'MarkerSize',markersize2,'MarkerFaceColor',c(2,:),'color',c(2,:))
% errorbar(maxfr1_25(clstndx,:),maxfr1_25(clstndx+4,:),'x','LineWidth',1,'CapSize',0,'MarkerSize',markersize2,'MarkerFaceColor',c(3,:),'color',c(3,:))
% errorbar(maxfr1(clstndx,:),maxfr1(clstndx+4,:),'^','LineWidth',1,'CapSize',0,'MarkerSize',markersize,'MarkerFaceColor',c(4,:),'color',c(4,:))
% errorbar(maxfr0_75(clstndx,:),maxfr0_75(clstndx+4,:),'s','LineWidth',1,'CapSize',0,'MarkerSize',markersize,'MarkerFaceColor',c(5,:),'color',c(5,:))
% errorbar(maxfr0_5(clstndx,:),maxfr0_5(clstndx+4,:),'d','LineWidth',1,'CapSize',0,'MarkerSize',markersize,'MarkerFaceColor',c(6,:),'color',c(6,:))

data0_5 = frall0_5{clstndx};
data0_75 = frall0_75{clstndx};
data1 = frall1{clstndx};
data1_25 = frall1_25{clstndx};
data1_75 = frall1_75{clstndx};
data5 = frall5{clstndx};

data = [mean(data0_5(:,10)-data0_5(:,1)) mean(data0_75(:,10)-data0_75(:,1)) mean(data1(:,10)-data1(:,1)) mean(data1_25(:,10)-data1_25(:,1)) mean(data1_75(:,10)-data1_75(:,1)) mean(data5(:,10)-data5(:,1)) ];
datastd = [std(data0_5(:,10)-data0_5(:,1))/sqrt(size(data0_5,1)) std(data0_75(:,10)-data0_75(:,1))/sqrt(size(data0_75,1)) std(data1(:,10)-data1(:,1))/sqrt(size(data1,1)) std(data1_25(:,10)-data1_25(:,1))/sqrt(size(data1_25,1)) std(data1_75(:,10)-data1_75(:,1))/sqrt(size(data1_75,1)) std(data5(:,10)-data5(:,1))/sqrt(size(data5,1)) ];
errorbar(data,datastd,'Color',c2(1,:))

plot([0.5:10.5],zeros(11),'LineStyle','--','color',[ 211 211 211]./255,'linewidth',2);
% hold on
% plot([1:10],maxfr5(clstndx,:),'Linewidth',2,'color',c(1,:));
% plot([1:10],maxfr1_75(clstndx,:),'Linewidth',2,'color',c(2,:));
% plot([1:10],maxfr1_25(clstndx,:),'Linewidth',2,'color',c(3,:));
% plot([1:10],maxfr1(clstndx,:),'Linewidth',2,'color',c(4,:));
% plot([1:10],maxfr0_75(clstndx,:),'Linewidth',2,'color',c(5,:));
% plot([1:10],maxfr0_5(clstndx,:),'Linewidth',2,'color',c(6,:));
% 

% % violin(maxfr5(clstndx,:),'bw',maxfr5(clstndx+4,:)/2,'mc',[],'medc',[],'facecolor',c(1,:),'edgecolor','none','facealpha',0.3);
% % violin(maxfr1_75(clstndx,:),'bw',maxfr1_75(clstndx+4,:)/2,'mc',[],'medc',[],'facecolor',c(2,:),'edgecolor','none','facealpha',0.3);
% % violin(maxfr1_25(clstndx,:),'bw',maxfr1_25(clstndx+4,:)/2,'mc',[],'medc',[],'facecolor',c(3,:),'edgecolor','none','facealpha',0.3);
% % violin(maxfr1(clstndx,:),'bw',maxfr1(clstndx+4,:)/2,'mc',[],'medc',[],'facecolor',c(4,:),'edgecolor','none','facealpha',0.3);
% % violin(maxfr0_75(clstndx,:),'bw',maxfr0_75(clstndx+4,:)/2,'mc',[],'medc',[],'facecolor',c(5,:),'edgecolor','none','facealpha',0.3);
% % violin(maxfr0_5(clstndx,:),'bw',maxfr0_5(clstndx+4,:)/2,'mc',[],'medc',[],'facecolor',c(6,:),'edgecolor','none','facealpha',0.3);

% violin(maxfr5(clstndx,:),'bw',maxfr5(clstndx+4,:)/2,'mc',[],'medc',[],'facecolor','none','edgecolor',c(1,:));
% violin(maxfr1_75(clstndx,:),'bw',maxfr1_75(clstndx+4,:)/2,'mc',[],'medc',[],'facecolor','none','edgecolor',c(2,:));
% violin(maxfr1_25(clstndx,:),'bw',maxfr1_25(clstndx+4,:)/2,'mc',[],'medc',[],'facecolor','none','edgecolor',c(3,:));
% violin(maxfr1(clstndx,:),'bw',maxfr1(clstndx+4,:)/2,'mc',[],'medc',[],'facecolor','none','edgecolor',c(4,:));
% violin(maxfr0_75(clstndx,:),'bw',maxfr0_75(clstndx+4,:)/2,'mc',[],'medc',[],'facecolor','none','edgecolor',c(5,:));
% violin(maxfr0_5(clstndx,:),'bw',maxfr0_5(clstndx+4,:)/2,'mc',[],'medc',[],'facecolor','none','edgecolor',c(6,:));

% if any(maxfr5(clstndx+8,1:10) < 0.05 & maxfr5(clstndx+8,1:10) > 0)
%     plot(y(maxfr5(clstndx+8,1:10) < 0.05 & maxfr5(clstndx+8,1:10) > 0), 0.35,'*','color',c(1,:),'MarkerSize',8)
% end
% if any(maxfr1_75(clstndx+8,1:10) < 0.05 & maxfr1_75(clstndx+8,1:10) > 0)
%     plot(y(maxfr1_75(clstndx+8,1:10) < 0.05 & maxfr1_75(clstndx+8,1:10) > 0), 0.3,'*','color',c(2,:),'MarkerSize',8)
% end
% if any(maxfr1_25(clstndx+8,1:10) < 0.05 & maxfr1_25(clstndx+8,1:10) > 0)
%     plot(y(maxfr1_25(clstndx+8,1:10) < 0.05 & maxfr1_25(clstndx+8,1:10) > 0), 0.25,'*','color',c(3,:),'MarkerSize',8)
% end
% if any(maxfr1(clstndx+8,1:10) < 0.05 & maxfr1(clstndx+8,1:10) > 0)
%     plot(y(maxfr1(clstndx+8,1:10) < 0.05 & maxfr1(clstndx+8,1:10) > 0), 0.2,'*','color',c(4,:),'MarkerSize',8)
% end
% if any(maxfr0_75(clstndx+8,1:10) < 0.05 & maxfr0_75(clstndx+8,1:10) > 0)
%     plot(y(maxfr0_75(clstndx+8,1:10) < 0.05 & maxfr0_75(clstndx+8,1:10) > 0), 0.15,'*','color',c(5,:),'MarkerSize',8)
% end
% if any(maxfr0_5(clstndx+8,1:10) < 0.05 & maxfr0_5(clstndx+8,1:10) > 0)
%     plot(y(maxfr0_5(clstndx+8,1:10) < 0.05 & maxfr0_5(clstndx+8,1:10) > 0), 0.1,'*','color',c(6,:),'MarkerSize',8)
% end
% lgc = legend({'5s','1.75s','1.25s','1s','0.75s','0.5s','Baseline'},'FontSize',15,'Location','southwest');
% xlabel('Pulse #','FontSize',15)
% ylabel('Normalized \Delta from baseline','FontSize',15)
% xlim([0.5 10.5])
% ylim([-1.1 1.1])
% ck= gca;
% ck.YGrid = 'off';
% ck.GridAlpha = .3;

xlabel('Inter Pulse Interval (s)','FontSize',15)
ylabel('Normalized response change from first to last pulse','FontSize',15)
xticks([1:6])
xticklabels([0.5 0.75 1 1.25 1.75 5])
xlim([0.9 6.1])
ylim([-1 1])
a=gca;
a.YGrid = 'off';
a.GridAlpha = .3;
