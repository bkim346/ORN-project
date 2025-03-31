clear all

%load encoder_filters_exp_data

%load encoder_filters_mod_data
load Figure6_data
stim = norm_PID_full;

SF = 100;
bMINIMAL_PANEL_B = 0;

%switch cluster order
typ_sw = [2 1 4 3];
t_mod = switch_cluster_labels(t_mod, typ_sw);
t_exp = switch_cluster_labels(t_exp, typ_sw);

colors = [[0 0.843750000000000 1]; [0 0 0.515625000000000]; [1 0.828125000000000 0]; [0.500000000000000 0 0]];
colors = colors(typ_sw,:);
figure(1), clf

%%% TEXT SIZES
txt_ax_sz = 14;
txt_lbl_sz = 16;
txt_acc_sz = 12;
txt_pnl_lbl_sz = 18;


%%% A: Stimulus and Plume responses
axes('Position', [0.1300    0.8906    0.7750    0.0501]), hold on
%subplot(12,1,1), hold on
NBr = size(pl,1); Y_MAX = 1.2;
for i_b=1:NBr,
	h2 = plot([pl(i_b,1), sum(pl(i_b,:))]/1000, [Y_MAX Y_MAX], 'k-', 'LineWidth', 3);
end
h1 = plot(time, stim', '-', 'Color', 0.3*[1 1 1], 'LineWidth', 2);
set(gca, 'XTickLabels', [], 'YTick', [])
set(gca, 'FontSize', txt_ax_sz)
hl = legend([h2, h1], 'Valve', 'PID', 'Box', 'off');
set(hl, 'Position', [0.7103    0.9070    0.2033    0.0376])
%title('Stimulus: 2.5m artificial plume')

em_str = {'exp', 'mod'};
idxs = {[2:3], [4:5]};

for i_em=1:2,
	t=eval(sprintf('t_%s', em_str{i_em}));
	mact=eval(sprintf('mact_full_%s', em_str{i_em}));
	subplot(12,1,idxs{i_em}), hold on
	max_act = max(mact_exp(:));
	for i_clu=1:4,
		plot(time, SF*mean(mact(t==i_clu,:),1), 'Color', colors(i_clu,:), 'LineWidth', 2)
	end
	set(gca, 'YLim', [0 15])
	set(gca, 'FontSize', txt_ax_sz)
	if i_em==1, 
		set(gca, 'XTickLabels', []), 
	end
end
xlabel('Time (s)', 'FontSize', txt_lbl_sz)
hl = legend('Excitatory', 'Delayed', 'Offset', 'Inhibitory');
set(hl, 'EdgeColor', 'None', 'Position', [0.7775    0.6291    0.1256    0.0855])
text(1.5,13.5, sprintf('Model: %d cells', size(FF_mod,2)), 'FontSize', txt_acc_sz)
text(-2.5,9.5, 'Firing rate (Hz)', 'FontSize', txt_lbl_sz, 'Rotation', 90)
subplot(12,1,[2,3])
ht = text(1.5,13.5, '\it{In vivo}:' , 'FontSize', txt_acc_sz); pos = get(ht, 'Extent');
text(pos(1)+1.05*pos(3),13.5, sprintf('%d cells', size(FF_exp,2)), 'FontSize', txt_acc_sz)


%%% B: L-NL Filter in vivo cell

%Most active cell
[~,isrt] = sort(sum(mact_exp,2));
i_cell = isrt(end);

subplot(6,6,[19,20]), hold on
plot(time(ts_bins),stim(ts_bins)', 'k-')

h1 = plot(time(ts_bins), stim(ts_bins)', '-', 'Color', 0.3*[1 1 1]);
NBr = size(pl,1); Y_MAX = 1.2;
for i_b=1:NBr,
	if pl(i_b,1)/1000>=ts_bins(1)/SF;
		h2 = plot([pl(i_b,1), sum(pl(i_b,:))]/1000, [Y_MAX Y_MAX], 'k-', 'LineWidth', 3);
	end
end
set(gca, 'XTick', [16:5:32], 'XTickLabel', [0:5:15], 'YTick', [], 'XLim', [16 32])
set(gca, 'FontSize', txt_ax_sz)
xlabel('Time(s)', 'FontSize', txt_lbl_sz)
title('Stimulus: s(t)', 'FontWeight', 'normal', 'FontSize', txt_acc_sz)

if bMINIMAL_PANEL_B,
	text(20, 1.35, 'Stimulus: s(t)', 'FontWeight', 'normal', 'FontSize', txt_acc_sz)
	set(gca, 'visible', 'off')
end


annotation('textbox', 'Position', [0.2603    0.5210    0.5000    0.0250], 'String', ...
	'L-NL prediction of sample excitatory cell {\it in vivo}', ...
	'LineStyle', 'None', 'FontSize', 12, 'HorizontalAlignment', 'center');
%axes('Position', [0.3917    0.4091    0.0846    0.0597])
subplot(6,6,21)
plot(ftime, FF_exp(:,i_cell), '-', 'Color', colors(t_exp(i_cell),:), 'LineWidth', 1.5)
ylabel('A.U.', 'FontSize', txt_acc_sz)
xlabel('Delay (s)', 'FontSize', txt_acc_sz)
set(gca, 'YTick', [])

if bMINIMAL_PANEL_B,
	text(0.8,2.4,'Filter: f(t)', 'FontWeight', 'normal', 'FontSize', txt_acc_sz)
	set(gca, 'visible', 'off')
else
	title('Filter: f(t)', 'FontWeight', 'normal', 'FontSize', txt_acc_sz)
end

subplot(6,6,22)
plot(g_exp.x(:,i_cell), g_exp.y(:,i_cell), '-', 'Color', colors(t_exp(i_cell),:), 'LineWidth', 1.5)
xlabel({'Convolved', 'stimulus rate'}, 'FontSize', txt_acc_sz)
ylabel({'Predicted', 'rate'}, 'FontSize', txt_acc_sz)
set(gca, 'XTick', [], 'YTick', [])
title('Threshold: g(x)', 'FontWeight', 'normal', 'FontSize', txt_acc_sz)

if bMINIMAL_PANEL_B,
	text(-0.1,0.6745,'Threshold: g(x)', 'FontWeight', 'normal', 'FontSize', txt_acc_sz)
	set(gca, 'visible', 'off')
end

subplot(6,6,[23,24]), hold on
plot(time(ts_bins)-time(ts_bins(1)), SF*pred_exp(:,i_cell), ...
		'Color', [0 0 1], 'LineWidth', 1.5)
plot(time(ts_bins)-time(ts_bins(1)), SF*mact_exp(i_cell,ts_bins), 'k', 'LineWidth', 1.5)
set(gca, 'FontSize', txt_ax_sz)
set(gca, 'YLim', [0 80], 'YAxisLocation', 'Right')%, 'XLim', [16,32])
title('Predicted rate: r(t) = g[s(t)*f(t)]', 'FontWeight', 'normal', 'FontSize', txt_acc_sz)
xlabel('Time (s)', 'FontSize', txt_lbl_sz)
ylabel('Firing rate (Hz)', 'FontSize', txt_lbl_sz)
hl = legend('Predicted rate', 'True rate');
set(hl, 'EdgeColor', 'None', 'box', 'off', 'orientation', 'horizontal', 'Position', [0.6609    0.4674    0.2653    0.0248], ...
	'FontSize', 10)

if bMINIMAL_PANEL_B,
	text(1.3073,89,'Predicted rate: r(t) = g[s(t)*f(t)]', 'FontWeight', 'normal', 'FontSize', txt_acc_sz)
	set(gca, 'visible', 'off')
end



%%% C: Filter averages across motifs
filt_iv_ax = axes('Position', [0.1300    0.1970    0.3347    0.1026]); hold on
%subplot(6,2,9), hold on
%subplot(11,9,[[79:81],[88:90],[97:99]]), hold on
for i_typ=1:4,
	plot(ftime, nanmean(FF_exp(:,t_exp==i_typ),2), '-', 'Color', colors(i_typ,:), 'LineWidth', 1.5)
end
set(gca, 'XTickLabel', [], 'YTick', [], 'YLim', [-1.25, 1.5])
ylabel('A.U.', 'FontSize', txt_lbl_sz)
title('Motif-averaged filters: f(t)', 'FontWeight', 'normal', 'FontSize', txt_lbl_sz)
text(0, 1.4, '{\it In vivo}', 'FontSize', txt_acc_sz)


axes('Position', [0.1300    0.0645    0.3347    0.1026]), cla, hold on
%subplot(6,2,11), hold on
for i_typ=1:4,
	plot(ftime, nanmean(FF_mod(:,t_mod==i_typ),2), '-', 'Color', colors(i_typ,:), 'LineWidth', 1.5)
end
set(gca, 'YTick', [], 'YLim', [-1.8, 2])
ylabel('A.U.', 'FontSize', txt_lbl_sz)
xlabel('Delay (s)', 'FontSize', txt_lbl_sz)
set(gca, 'FontSize', txt_ax_sz)
text(0, 1.844,'Model', 'FontSize', txt_acc_sz)

%%% D: PCA 
FF_merg = [FF_mod, FF_exp];
[c,s,l] = pca(FF_merg');
var_pca = 100*(l/sum(l));

NCells_mod = size(mact_mod,1);

axes('Position', [0.5724    0.1811    0.3326    0.1308]), hold on
%subplot(11,9,[[78:81],[87:90]]), hold on
for i_typ=1:4,
	idx_exp = NCells_mod + find(t_exp==i_typ);
	plot(s(t_mod==i_typ,1), s(t_mod==i_typ,2), '.', 'Color', colors(i_typ,:))
	plot(s(idx_exp,1), s(idx_exp,2),'*', 'Color', 0.7*colors(i_typ,:))
end
hp(1) = plot(-1000,-1000, 'k*');
hp(2) = plot(-1000,-1000, 'k.');
set(gca, 'XLim', [-10, 15], 'YLim', [-10,15])
set(gca, 'XTick', [], 'YTick', [])
xlabel(sprintf('PC 1 - %g%% of variance', round(var_pca(1))), 'FontSize', txt_lbl_sz)
ylabel(sprintf('PC 2\n%g%% of variance', round(var_pca(2))), 'FontSize', txt_lbl_sz)
title('Space of filters', 'FontWeight', 'normal', 'FontSize', txt_lbl_sz)
hl = legend(hp, '\it{In vivo}', 'Model');
set(hl, 'EdgeColor', 'None', 'FontSize', txt_acc_sz)


axes('Position', [0.5724    0.0645    0.3326    0.0777])
%subplot(11,9,[96:99])
hold on
plot(ftime,c(:,1), 'k-', 'LineWidth', 2)
plot(ftime,c(:,2), '-', 'Color', 0.7*[1 1 1], 'LineWidth', 2)
ylabel('A.U.', 'FontSize', txt_lbl_sz)
xlabel('Delay (s)', 'FontSize', txt_lbl_sz)
set(gca, 'FontSize', txt_ax_sz)
set(gca,'YTick', [], 'YLim', [-0.1, 0.3])
hl = legend('PC 1', 'PC 2', 'Box', 'off', 'orientation', 'horizontal'); 
set(hl, 'Position',[0.7260    0.1165    0.1699    0.0215]);




%%% LABELS
hl = annotation('textbox', 'Position', [0.1009    0.9146    0.0500    0.0500], 'String', 'A', ...
	                'FontSize', txt_pnl_lbl_sz, 'LineStyle', 'None');
hl = annotation('textbox', 'Position', [0.1009    0.5000    0.0500    0.0500], 'String', 'B', ...
	                'FontSize', txt_pnl_lbl_sz, 'LineStyle', 'None');
hl = annotation('textbox', 'Position', [0.1009    0.2989    0.0500    0.0500], 'String', 'C', ...
	                'FontSize', txt_pnl_lbl_sz, 'LineStyle', 'None');
hl = annotation('textbox', 'Position', [0.4928    0.2989    0.0500    0.0500], 'String', 'D', ...
	                'FontSize', txt_pnl_lbl_sz, 'LineStyle', 'None');

set(gcf, 'Position', [272     1   776   796])
set(gcf,'Renderer','painters')
