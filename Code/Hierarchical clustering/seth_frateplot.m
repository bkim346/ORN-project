function seth_frateplot(RORN,t,tv,NCLUST,xstim,subplotflag)

c=colormap('jet');
c2=c(floor(1:((length(c)-1)/(NCLUST-1)):length(c)),:);
h=zeros(1,NCLUST);
if length(xstim) > 2
tv2 = 1/1e4:1/1e4:tv(end);
end 
tv3 = linspace(0,max(tv),(length(tv)-3));
% c2(5,:) = c2(3,:);
% c2(3,:) = c2(4,:);
% c2(4,:) = c2(5,:);
% c2(5,:) = c2(1,:);
% c2(1,:) = c2(2,:);
% c2(2,:) = c2(5,:);
for k=1:NCLUST
    hold on
        yup = mean(RORN(t==k, :),1) + (1/sqrt(length(find(t==k))))...
        *std(RORN(t==k, :), [], 1);
    ydown = mean(RORN(t==k, :),1) - (1/sqrt(length(find(t==k))))...
        *std(RORN(t==k, :), [], 1) ;
    y =  mean(RORN(t==k, :),1);
    h(k) = plot(tv3,y(2:end-2), 'Color', c2(k,:), 'LineWidth', 2);
    plot(tv3, yup(2:end-2), 'Color', c2(k,:), 'LineWidth', 0.5)
    plot(tv3, ydown(2:end-2), 'Color', c2(k,:), 'LineWidth', 0.5)
%     

    yy = [yup(2:end-2) fliplr(ydown(2:end-2))];
    xx = [tv3 fliplr(tv3)];
    shade =  patch('XData',xx,'YData',yy,'FaceColor',c2(k,:),'EdgeColor','none','LineStyle','None');
    alpha(shade,.3)
    
end

yls1=get(gca, 'YLim');
% tv2 = 0.0001:1/1e4:tv(end);
%     xx2=find(diff(xstim)>1);
%     xx3=sort([xstim(1) xstim(xx2) xstim(xx2+1) xstim(end)]);
% plot(tv(reshape(xstim,2,length(xstim)/2)'), [yls1(1) yls1(1)], 'k', 'LineWidth', 6)
% h(k+1) = plot(tv, mean(RORN), 'k-', 'LineWidth', 2);
legsc=cell(NCLUST,1);
for ind=1:NCLUST, legsc{ind}=['Cluster ' num2str(ind) ' (' num2str(length(find(t==ind))) ' O-ORNs)']; end
legsc{end+1}=['Average (' num2str(size(RORN,1)) ' O-ORNs)'];
legend(h, legsc)
% legend(h, '0.1% Hexanol','1% Hexanol','10% Hexanol','100% Hexanol')
set(gca, 'FontSize', 12, 'FontWeight', 'bold')
xlabel('Time (s)')
ylabel('Firing Rate (Hz)')
title('Clustered O-ORN Firing')
axis tight
ylim(yls1)
box on
if subplotflag == 1

    for k = 1:NCLUST
        figure(4+k);
        hold on
            plot((tv)',RORN(t==k,:)','Color',[.3 .3 .3])
        plot(tv, mean(RORN(t==k, :),1), 'Color', c2(k,:), 'LineWidth', 2);
        yls=get(gca, 'YLim');
        plot(tv(reshape(xstim,2,length(xstim)/2)'), [yls(1) yls(1)], 'k', 'LineWidth', 10)
        title(['Cluster ',num2str(k), ' (', num2str(length(find(t==k))),' O-ORNs)' ])
        axis tight
        ylim(yls1)
    end
end