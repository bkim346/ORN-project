function [hz,t] = ORN_Cluster2(fname,NCLUST,hz,subplotflag,clusterorder)

if nargin<2||isempty(NCLUST), NCLUST=2; end
if nargin<4||isempty(subplotflag), subplotflag=0; end
load(fname)



%%%% ORN Data is (ORN#, Time (20Hz for 10s = 200), 5 Presentations)

% NT 	= 200;
% t	= linspace(0, 10, NT);
% i_stim_type = 1;

%AllORN = 	[al_ORN3d(:,:,1);
%		ap_ORN3d(:,:,1);
%		cg_ORN3d(:,:,1);
%		hc_ORN3d(:,:,1);
%		ib_ORN3d(:,:,1);
%		ol_ORN3d(:,:,1);
%		al_ORN3d(:,:,2);
%		ap_ORN3d(:,:,2);
%		cg_ORN3d(:,:,2);
%		hc_ORN3d(:,:,2);
%		ib_ORN3d(:,:,2);
%		ol_ORN3d(:,:,2);
%		];
if iscell(frates1)
    if any(size([frates1{:,2}],2)> length(frates1(1,2))) 
        
    end
    AllORN=cell2mat(frates1(:,2));
else
    AllORN = frates1;
end

%%% AllORN is concatenated across all odors to form a single
% Matrix of ORN responses. Dim 1 is ORN-Odor combo and Dim 2
% is Time (20Hz for 30s = 600).

%Calculation to find maximum length of pause and stimulation to compare and
%run t-test
xx1 = find(xstim>2);
xx2=find(diff(xx1)> 1);
xx3=sort([xx1(1) xx1(xx2) xx1(xx2+1) xx1(end)]);
if nargin<3||isempty(hz)
    %     if length(xstim) > 2
    %         k = reshape(xx3,2,length(xx3)/2);
    %         longeststim = max(diff(k));
    %         stimind = k(1,(diff(k) == longeststim));
    %         longestpause = max(k(1,2:end) - k(2,1:end-1));
    %         pauseind = k(2,k(1,2:end) - k(2,1:end-1) == longestpause);
    %         adddur = min([longestpause longeststim]);
    %         TTstat 	= (AllORN(:,pauseind:pauseind+adddur) - AllORN(:,stimind:stimind+adddur))';
    %     else
    TTstat 	= (AllORN(:,1:20) - AllORN(:,41:60))'; 
    %     end
    hz = ttest(TTstat);
end


%%% FIND ONLY ACTIVE CELLS by ttest before and during stim
RORN = AllORN(hz==1,:);	%Responsive ORN

%rejndx=[4 9 19 20 21];
%rejndx=[4 9 19 20];
%RORN = AllORN(setdiff(1:size(AllORN,1), rejndx),:); %Intersection of Brian's & Alex's eyeball test & T-Test

%%%%%%%%%% Implementing alternate test for responsiveness from Gupta & Stopfer 2012
%%- Is change greater than 3.5 SDs from spontaneous rate?
%spontrate=mean(AllORN(:,1:40),2); %spontaneous firing rate
%spontstd=std(AllORN(:,1:40),[],2); %standard deviation of spontaneous rate
%stimrate=mean(AllORN(:,41:80),2); %firing rate following stimulation
%z_rate=(stimrate-spontrate)./spontstd; %essentially a z-score
%
%RORN = AllORN(find(-3.5<z_rate&z_rate>3.5));

%Do the clustering - linkage finds distance matrix
 z = linkage(RORN,'complete', 'correlation');


% Only want 3 clusters ... there can be many more, but
% with 4 or more clusters you get small (~3 ORNs) clusters
% which are much less interpretable.

%Show dendrogram -Clustering tree- in figure 5
%NCLUST 	= 2;
%If cluster order is given, ignore dendogram
if nargin<5||isempty(clusterorder)
    figure(4), clf
    [h,t,c] = dendrogram(z,NCLUST);
    set(gca, 'FontSize', 12, 'FontWeight', 'bold')
    ydend = get(gca,'Ylim');
    title(sprintf('Dendrogram for %d level splitting', NCLUST))
    xlabel('Groups')
    ylabel('Aggregation Score')
else
    t = clusterorder ;
    figure(4), clf
%     dendrogram(z,NCLUST);
    set(gca, 'FontSize', 12, 'FontWeight', 'bold')
    ydend = get(gca,'Ylim');
    title(sprintf('Dendrogram for %d level splitting', NCLUST))
    xlabel('Groups')
    ylabel('Aggregation Score')
end

%Plot means +/- std for each class
figure(3), clf
seth_frateplot(RORN,t,tv,NCLUST,xx3,subplotflag)

%cstr = {'b-', 'r-', 'g-', 'm-', 'y-'};
% c=colormap('jet');
% c2=c(floor(1:((length(c)-1)/(NCLUST-1)):length(c)),:);
% % figure(3), clf
% for k=1:NCLUST,
% 	hold on
% %	h(k) = plot(mean(RORN(find(t==k), :),1), cstr{k}, 'LineWidth', 2);
% %	plot(mean(RORN(find(t==k), :),1) + (1/sqrt(length(find(t==k))))...
% %		*std(RORN(find(t==k), :), [], 1), cstr{k}, 'LineWidth', 1)
% %	plot(mean(RORN(find(t==k), :),1) - (1/sqrt(length(find(t==k))))...
% %		*std(RORN(find(t==k), :), [], 1), cstr{k}, 'LineWidth', 1)
%
% 	h(k) = plot(tv-2, mean(RORN(find(t==k), :),1), 'Color', c2(k,:), 'LineWidth', 2);
% 	plot(tv-2, mean(RORN(find(t==k), :),1) + (1/sqrt(length(find(t==k))))...
% 		*std(RORN(find(t==k), :), [], 1), 'Color', c2(k,:), 'LineWidth', 1)
% 	plot(tv-2, mean(RORN(find(t==k), :),1) - (1/sqrt(length(find(t==k))))...
% 		*std(RORN(find(t==k), :), [], 1), 'Color', c2(k,:), 'LineWidth', 1)
%
% % 	XMAX = 200;
% % 	set(gca, 'XLim', [1 XMAX])
% end
%
% %plot([120 120], [-0.5 3], 'k--')
% yls=get(gca, 'YLim');
% plot(tv(xstim')-2, [yls(1) yls(1)], 'k', 'LineWidth', 20)
% %plot([40 120], [yls(1) yls(1)], 'k', 'LineWidth', 20)
% h(k+1) = plot(tv-2, mean(RORN), 'k-', 'LineWidth', 2);
% for ind=1:NCLUST, legsc{ind}=['Cluster ' num2str(ind) ' (' num2str(length(find(t==ind))) ' ORNs)']; end
% legsc{end+1}=['Average (' num2str(size(RORN,1)) ' ORNs)'];
% legend(h, legsc)
% %legend(h, 'Early Responders (20%)', 'Late Responders (20%)', ...
% %	'Medium Responders (60%)', 'Average (176 ORNs)')
% set(gca, 'FontSize', 12, 'FontWeight', 'bold')
% % set(gca, 'XTick', [40:40:200], 'XTickLabel', [0:2:8])
% xlabel('Time (s)')
% ylabel('Firing Rate (Hz)')
% title('Clustered ORN Firing')
% box on


%Image ORN activity of each class
%tstrs = {'Early Responders (20%)', 'Late Responders (20%)', ...
%        'Medium Responders (60%)'};

figure(2), clf
for k=1:NCLUST
    subplot(NCLUST,1,k)
    imagesc(RORN(find(t==k), :))
    set(gca, 'XTick', [40:40:200], 'XTickLabel', [0:2:8])
    set(gca, 'FontSize', 12, 'FontWeight', 'bold')
    %	title(tstrs{k})
    ylabel('O-ORN Number')
end
xlabel('Time (s)')


%Full dendrogram colored so that we see 3 clusters
figure(1), clf
dendrogram(z,0, 'ColorThreshold', ydend(1),'Orientation','Left');
set(gca, 'FontSize', 12, 'FontWeight', 'bold')
title('Colored Full Dendrogram')
ylabel('Aggregation Score')
xlabel('Groups')



