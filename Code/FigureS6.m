clear all
close all
load Figure7_data.mat
load act_typ.mat


mts = mean(ts_acc,2);
[~,isrt] = sort(mts);
NTyp = size(mts,1);
NCmp = NTyp*(NTyp-1)/2;

good_idx = isrt(end-3:end);
bad_idx = setdiff([1:15], good_idx);
good_pred = ts_acc(good_idx,:); good_pred = good_pred(:);
bad_pred = ts_acc(bad_idx,:); bad_pred = bad_pred(:);

[h,p,ci,stats] = ttest2(good_pred,bad_pred);


%%%ANOVA
load fig6c_lbls
[p,t,stats] = anova1(ts_acc(isrt,:)');
stats.gnames = str_labels;

Bonf_alpha = 0.05/NCmp;

[c,m,h,nms] = multcompare(stats, 'Alpha', Bonf_alpha);

p_tbl = zeros(NTyp);
for i_cmp=1:NCmp,
	p_tbl(c(i_cmp,1),c(i_cmp,2)) = log10(c(i_cmp,6));
	p_tbl(c(i_cmp,2),c(i_cmp,1)) = log10(c(i_cmp,6));
end


%Colormap
LBA = log10(Bonf_alpha);
lp_min = -15; lp_max = 0;
lp = linspace(lp_min,lp_max,64);
idx_LBA = find(lp>LBA,1);

N1 = idx_LBA; N2 = 64-idx_LBA;
x1 = linspace(0,1,N1)';
x2 = linspace(0,1,N2)';
cmap =[[ones(N1,1), 1-x1, 1-x1];...	%1-xx, 1-xx, ones(64,1)];...
	[zeros(N2,1), zeros(N2,1), 1-x2]];

close all
figure(99), clf, hold on
imagesc(p_tbl, [lp_min, lp_max])
h = colorbar;
ylabel(h, 'log10(p-value)')
colormap(cmap)
xlabel('Motifs included in classifiers')
ylabel('Motifs included in classifiers')

for i_typ1=1:NTyp, 
for i_typ2=1:NTyp,
	val = round(p_tbl(i_typ1,i_typ2),1);
	val = max(val,-15);
	%text(i_typ1,i_typ2, sprintf('%g', val))
end
end

dividers = [2.5 3.5 5.5 11.5];
NDiv = length(dividers);
for id=1:NDiv,
	plot([1,NTyp], [dividers(id), dividers(id)], 'k-')
	plot([dividers(id), dividers(id)], [1,NTyp], 'k-')
end

set(gca, 'XLim', [1 NTyp], 'YLim', [1 NTyp])
set(gca, 'XTick', [1:NTyp], 'XTickLabels', str_labels)
set(gca, 'YTick', [1:NTyp], 'YTickLabels', str_labels)
%title('Every group within a set is statistically distinct from a 
title('Color plot of log10(p-values) for comparisons in Figure 6C')
%annotation('line', [0.8482    0.8786], [0.7571 0.7571], 'LineWidth', 3)
text(16.3975, 12,{'Bonferoni', 'adjusted','threshold', 'alhpa = 0.05'})
text(16.2, 14, 'Not significant')
text(16.2, 4, 'Significant')

set(gcf,'Renderer','painters')

