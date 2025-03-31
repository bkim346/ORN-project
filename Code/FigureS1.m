clear all
close all

load FigureS1_data

d = large1s_data.cluster_distances;
t = large1s_data.clusters;

%Restrict to unique responses
d = d(large1s_data.unique_idx,large1s_data.unique_idx);
t = t(large1s_data.unique_idx);

NORN = length(t);

tt = t; 
t_sw = [2,1]; NSw = length(t_sw);
for i_sw=1:NSw,
	tt(t==i_sw) = t_sw(i_sw);
end
t = tt;

[cl_srted, idx] = sort(t);

d = d(idx,idx); t = t(idx);

cl_str = {'Exc.', 'Del.', 'Inh.', 'Off.'};
colors = [[0 0.843750000000000 1]; [0 0 0.515625000000000]; [1 0.828125000000000 0]; [0.500000000000000 0 0]];
color_sw = [2 1 3 4]; colors = colors(color_sw,:);

i_ex1 = 20;
i_ex2 = 180;
idx_bdy = find(diff(cl_srted))+1;
hf = figure(1); clf
set(hf, 'Position', [344.0000  262.0000  824.0000  535.0000])



%%%% DISTANCE COLORPLOT
subplot(3,5,[1,2,3,6,7,8,11,12,13]), hold on
%subplot(3,3,[1,2,4,5,7,8]), hold on
imagesc(d)
set(gca, 'XLim', [1 NORN], 'YLim', [1 NORN])
h = colorbar;
h.Label.String = 'Distance (A.U.)'; h.Label.FontSize=14;
for ibd = [1:length(idx_bdy)],
	plot([1 NORN], [idx_bdy(ibd) idx_bdy(ibd)], 'k-', 'LineWidth', 2)
	plot([idx_bdy(ibd) idx_bdy(ibd)], [1 NORN], 'k-', 'LineWidth', 2)
end
text(-0.055*NORN, 0.45*NORN, 'Responses', 'Clipping', 'off', 'FontSize', 14, 'FontWeight', 'bold', 'Rotation', 90)
text(0.45*NORN, -0.055*NORN, 'Responses', 'Clipping', 'off', 'FontSize', 14, 'FontWeight', 'bold')
%ylabel('Responses')
title('Distance between responses', 'FontSize', 14)
set(gca, 'XTick', [], 'YTick', [])
set(gca, 'YAxisLocation', 'right')


%Cluster sizes
for i_c=1:NCLUST,
	num_c(i_c) = sum(t==i_c);
end
cs_nc = cumsum(num_c); cs_nc = [0 cs_nc];

%Rectangles
for i_c=1:NCLUST,
	rectangle('Position', [-10,0.5+cs_nc(i_c),5,num_c(i_c)+1], 'Clipping', 'off', 'FaceColor', colors(i_c,:))
	text(-0.025*NORN,mean(cs_nc([i_c,i_c+1])), cl_str{i_c}, 'Color', colors(i_c,:), 'Rotation', 90, 'FontSize', 14)
	rectangle('Position', [0.5+cs_nc(i_c),-10,num_c(i_c)+1,5], 'Clipping', 'off', 'FaceColor', colors(i_c,:))
end

%%%% EXAMPLE OF TEST1: Statistically meaningful subset

NBins = 40; bins = linspace(min(d(:)), max(d(:)),NBins); 

exs = [60]; idx_plt = [4,-1];
XT = [0:0.5:2];
for i_ex=1:1,
	ex = exs(i_ex);
	typ = t(ex);
	idx_intra = find(t==typ); idx_inter = setdiff([1:length(t)],idx_intra);
	n_intra = ksdensity(d(ex,idx_intra), bins);
	%n_inter = ksdensity(d(ex,idx_inter), bins);
	[n_inter,bb] = ksdensity(cluster_stats.bs_means);
	subplot(3,5,idx_plt(i_ex)), hold on, box on
	plot(bins, n_intra/max(n_intra), '-', 'Color', colors(typ,:), 'LineWidth', 2)
	plot(bb, n_inter/max(n_inter), 'k-', 'LineWidth', 2)
	YL = get(gca, 'YLim'); set(gca, 'YLim', [0 1.2*YL(2)]);
	%set(gca, 'XLim', [0 2])
	set(gca, 'YTick', [])
	ylabel('Frequency')
	legend('Intra-cluster distance', 'Random subsets', 'box', 'off','Position', [0.6195    0.8902    0.0909    0.0333]);
	xlabel('Distance (a.u.)')
end
%title('Histogram of pair-wise responses')

%%% All means and hist of bsmeans
subplot(355), hold on, box on
[bs, bb] = ksdensity(cluster_stats.bs_means);
plot(bb,bs, 'k-', 'LineWidth', 2)
YL = get(gca, 'YLim');
for i_cl=1:NCLUST,
	mu = mean(cluster_stats.intra_cl_dists{i_cl});
	plot([mu mu], YL, '--', 'LineWidth', 2, 'Color', colors(i_cl,:))
end
plot([], [], 'k--', 'LineWidth', 2)
set(gca, 'YTick', [])
xlabel('Distance (a.u.)')
ylabel('Frequency')
legend('Random subsets', 'Intra-cluster means')

%%% P-values for intra- vs inter-
subplot(359), 
imagesc(cluster_stats.p_ttest)
set(gca, 'XTick', [1:4], 'XTickLabel', cl_str)
set(gca, 'YTick', [1:4], 'YTickLabel', cl_str)
for i_cl1=1:NCLUST,
	for i_cl2=1:NCLUST,
		text(i_cl2, i_cl1, sprintf('%g', round(cluster_stats.p_ttest(i_cl1,i_cl2), 2)))
	end
end 
text(4,3, sprintf('%g', round(cluster_stats.p_ttest(3,4), 2)), 'Color', 'w')
colormap(flipud(bone))
title('p-values for distinction')


%%% Example intra-inter comparisons.
inter = cluster_stats.inter_cl_dists;
intra = cluster_stats.intra_cl_dists;
p = round(cluster_stats.p_ttest,2);

plt_idxs = [10,14,15]; wo_idxs = [[1,2];[3,4];[3,4]]; wi_idxs = [1,3,4]; YMAXs = [0.15,0.30,0.30];
for i_ex = 1:3,
	subplot(3,5,plt_idxs(i_ex)), hold on, box on
	pdf_inter = ksdensity(inter{wo_idxs(i_ex,1),wo_idxs(i_ex,2)},bins);
	pdf_intra = ksdensity(intra{wi_idxs(i_ex)},bins);
	plot(bins, pdf_intra, '-', 'Color', colors(wi_idxs(i_ex),:), 'LineWidth', 2)
	plot(bins, pdf_inter, '-', 'Color', mean(colors([wo_idxs(i_ex,1),wo_idxs(i_ex,2)],:),1), 'LineWidth', 2)
	ylabel('Frequency')
	xlabel('Distance (a.u.)')
	set(gca, 'YLim', [0 YMAXs(i_ex)], 'YTick', [])
	legend(sprintf('%s intra-cluster distances', cl_str{wi_idxs(i_ex)}),...
		sprintf('%s-%s inter-cluster distances', cl_str{wo_idxs(i_ex,1)},cl_str{wo_idxs(i_ex,2)}), 'box', 'off')
	if i_ex==3,
		text(1.5,YMAXs(3)/2,sprintf('p=%g',p(wo_idxs(3,2),wo_idxs(3,1))))
	else
		text(1.5,YMAXs(i_ex)/2,sprintf('p=%g',p(wo_idxs(i_ex,1),wo_idxs(i_ex,2))))
	end
end

annotation('rectangle', [0.6 0.67 0.31 0.315], 'LineWidth',2)
annotation('rectangle', [0.6 0.05 0.31 0.62], 'LineWidth',2)
annotation('textbox', [0.6629    0.9510    0.2019    0.0437], 'String', 'Clusters are significant subsets', 'LineStyle', 'None',...
	'FontSize', 14, 'FontWeight', 'bold', 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle')
annotation('textbox', [0.6363    0.6357    0.2519    0.0437], 'String', 'Clusters are distinct from each other', 'LineStyle', 'None',...
	'FontSize', 14, 'FontWeight', 'bold', 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle')

annotation('textbox', [0.077 0.939 0.05 0.05], 'String', 'A', 'LineStyle', 'None',...
	'FontSize', 16, 'FontWeight', 'bold', 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle')
annotation('textbox', [0.5856    0.9390    0.0500    0.0500], 'String', 'B', 'LineStyle', 'None',...
	'FontSize', 16, 'FontWeight', 'bold', 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle')
annotation('textbox', [0.5856 0.6236 0.05 0.05], 'String', 'C', 'LineStyle', 'None',...
	'FontSize', 16, 'FontWeight', 'bold', 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle')


set(gcf,'Renderer','painters')
set(gcf, 'Position', [28           1        1413         796])
