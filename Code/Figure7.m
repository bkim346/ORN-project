clear all 


load Figure7_data.mat
load act_typ.mat

d_clrs = [[0 0 0]; 0.25*[0,1,0]; 0.5*[0,1,0]; 0.75*[0 1 0]]; 
t_clrs = [[0 0.843750000000000 1]; [0 0 0.515625000000000]; [1 0.828125000000000 0]; [0.500000000000000 0 0]];

h_fig = figure(6); clf
set(h_fig, 'Position', [195    12   825   693], 'DefaultAxesFontName', 'Arial', 'DefaultAxesFontSize', 9)


%%TIME COURSES OF DIST PLUMES
i_t = 1;
SF=20;
time = [1/SF:(1/SF):size(act_typ,2)/SF];

ds = [4 3 2 1];
Y_STIM_DISP = 25;
sw = [2 1 4 3];
mod_resp_pos = [[0.1300    0.8817    0.7750    0.0433];[0.1300    0.8201    0.7750    0.0433];...
		[0.1300    0.7543    0.7750    0.0433];[0.1300    0.6885    0.7750    0.0433]];

for i_d=1:NDists,
	h_mod_resp(i_d) = axes('Position', mod_resp_pos(i_d,:)); hold on
	%subplot(8,1,i_d), hold on
	pl = pls{ds(i_d),i_t};
	NBursts = size(pl,1);
	for i_b=1:NBursts,
		plot([pl(i_b,1), sum(pl(i_b,:))]/1000, Y_STIM_DISP*[1 1],...
				'-', 'LineWidth', 5, 'Color', d_clrs(ds(i_d), :))
	end
	for i_typ=1:4,
		a_plt = act_typ(i_typ,:,ds(i_d));
		if i_d==1,
			hp(sw(i_typ)) = plot(time, a_plt, '-', 'Color', t_clrs(i_typ,:), 'LineWidth', 2);
		else
			plot(time, a_plt, '-', 'Color', t_clrs(i_typ,:), 'LineWidth', 2);
		end
	end
	text(50, 0.85*Y_STIM_DISP, sprintf('d = %gm', dists(ds(i_d))), 'Color', d_clrs(ds(i_d),:))
	%text(60.5, 0.01*Y_STIM_DISP, sprintf('d = %gm', dists(ds(i_d))), 'Color', d_clrs(ds(i_d),:), ...
			%'Rotation',90)
	set(gca, 'XLim', [0 60], 'YLim', [0 Y_STIM_DISP])
	if i_d<NDists, set(gca, 'XTickLabel', []), end
end
text(-2.5974, 4.2335, 'Motif-averaged firing rate (Hz)', 'Rotation', 90)
xlabel('Time (s)')

set(get(h_mod_resp(1), 'Title'), 'String', 'Model responses to distance-dependent odor plumes')
hl = legend(hp, 'Excitatory', 'Delayed', 'Offset', 'Inhibitory', 'Orientation', 'horizontal');
set(hl, 'Position', [0.5450    0.8895    0.3636    0.0250], 'Box', 'off')




%%% CLASSIFICATION OF PLUMES 
%subplot(4,2,5),hold on
ha_stim_class = axes('Position', [0.1300    0.3925    0.3347    0.2251]); hold on
NDisp = 30;
cnt=1;
tr_shifts = [-1:0.2:1];
NTrials = min(NTrials,10);
for i_d=1:NDists,
	for i_t=1:NTrials,
		pl = pls{i_d,i_t};
		NBursts = size(pl,1);
		d = dists(i_d) + tr_shifts(i_t);
		for i_b=1:NBursts,
			%plot([pl(i_b,1), sum(pl(i_b,:))]/1000, [d d], ...
			%	'-', 'LineWidth', 3, 'Color', d_clrs(i_d,:))
			plot([pl(i_b,1), sum(pl(i_b,:))]/1000, [cnt cnt], ...
				'-', 'LineWidth', 3, 'Color', d_clrs(i_d,:))
		end
		cnt = cnt+1;
	end
	plot([0 60], [cnt, cnt]-0.25, 'k-')
	text(-1.435,2 + (i_d-1)*NTrials, sprintf('d=%gm', dists(i_d)), 'Rotation', 90, 'Color', d_clrs(i_d,:))
end
set(gca, 'YTickLabel', [], 'XLim', [0 15], 'YLim', [0 NTrials*NDists])
xlabel('Time (s)')
title('Stimulus classification problem')
save Fig6B_data NTrials NDists pls dists tr_shifts


hold on
[mts_acc_s,sidx] = sort(mts_acc);
for i_typ=1:NTyps,
end

%%% SVM SUCCESS
%subplot(4,2,6)
ha_SVM = axes('Position', [0.5703    0.3925    0.3347    0.2251]); 
hold on
NTyps = length(inclu_idxs);
str_labels=cell(NTyps,1);
typ_str = {'D', 'E', 'I', 'O'};
for i_typs=1:NTyps,
	idx = inclu_idxs{sidx(i_typs)};
	idx = sort(idx);
	str_labels{i_typs} = '';
	for i_ele=1:length(idx),
		str_labels{i_typs} = strcat(str_labels{i_typs}, typ_str{idx(i_ele)});
	end
	xx = i_typs+0.25*(rand(svm_opts.NReps,1)-0.5);
        plot(xx, 100*ts_acc(sidx(i_typs),:), '.', 'Color', mean(t_clrs([idx],:),1))

end
title({'SVM Classification accuracy of distance', 'discrimination based on motif inclusion'})
ylabel('Classificaiton success (%)')
set(gca, 'XTick', [1:NTyps], 'XTickLabel', str_labels, 'XTickLabelRotation', 45)
YL = get(gca, 'YLim');

dividers = [2.5 3.5 5.5 11.5];
%dividers = [11.5];
NDiv = length(dividers);
for i_div=1:NDiv,
	plot([dividers(i_div) dividers(i_div)], [YL(1), YL(2)], 'k-')
end
xlabel('Motifs included in classifier')


%%% Correlation 
W_SIZE = 15*opts.sf;
NWnds = NBins/W_SIZE;
symb = {'.', '*', '^', 's'};
motif = {'Del', 'Inh', 'Off'};
Y_MIN = [0.35, 0.6662, 0.2289];
typs = [1, 3, 4]; NTrials = size(X,3);


corr_ax_pos = [[0.1300    0.1100    0.1566    0.1887];[0.3361    0.1100    0.1566    0.1887];...
		[0.5422    0.1100    0.1566    0.1887];];
text_pos = [[0.5756    1.1510];[0.7364    0.6896]; [0.7378    0.2289]];

for i_comb = 1:NCombs,

	h_corr(i_comb) = axes('Position', corr_ax_pos(i_comb,:)); hold on
        %subplot(4,4,12+i_comb), hold on
        for i_dist=1:NDists,
                plot(ss(1,:,i_dist,i_comb), ss(2,:,i_dist,i_comb), symb{i_dist}, 'Color', d_clrs(i_dist,:))
        end
        tmp = corrcoef(reshape(ss(:,:,:,i_comb), [2, NWnds*NTrials*NDists])');
        xlabel('Mean Exc. activity (Hz)', 'Color', t_clrs(2,:))
        ylabel(sprintf('Mean %s. activity (Hz)', motif{i_comb}), 'Color', 0.8*t_clrs(typs(i_comb),:))
        c = tmp(1,2)^2;
        text(text_pos(i_comb,1), text_pos(i_comb,2), sprintf('Correlation: r^2 = %g', round(c,2)), 'FontWeight', 'bold')
end
%subplot(4,4,13)
hl_corr = legend('d=2.5m', 'd=5m', 'd=10m', 'd=20m', 'FontSize', 6);
set(hl_corr, 'Position', [0.5473    0.2400    0.0752    0.0541])

subplot(8,4,28), hold on                                                                                                            
for i_typ=1:3,                                                                                                                   
        plot(wnds, corr_coef(:,i_typ), '-', 'Color', t_clrs(typs(i_typ),:), 'LineWidth', 2)                                      
end                       
%set(gca, 'YAxisLocation', 'Right')
ylabel('Correlation')
hl_corr_clu = legend('Del', 'Inh', 'Off', 'FontSize', 6, 'Box', 'off');
set(hl_corr_clu, 'Position', [0.8394    0.2309    0.0618    0.0418])
title('Correlation w/ Exc motif')

subplot(8,4,32)
hold on

mts_acc_wnd = 100*mean(ts_acc_wnd,2);
sem_ts_acc_wnd = 100*std(ts_acc_wnd,[],2)/sqrt(svm_opts.NReps);

h_plt = plot_with_shaded_sem(wnds, mts_acc_wnd', sem_ts_acc_wnd');
%set(gca, 'YAxisLocation', 'Right')
xlabel('Trial length (s)')
ylabel({'Classification','(%)'})






hl = annotation('textbox', 'Position', [0.0900    0.9146    0.0500    0.0500], 'String', 'A', ...
	                'FontSize', 12, 'FontWeight', 'bold', 'LineStyle', 'None');
hl = annotation('textbox', 'Position', [0.0900    0.6000    0.0500    0.0500], 'String', 'B', ...
	                'FontSize', 12, 'FontWeight', 'bold', 'LineStyle', 'None');
hl = annotation('textbox', 'Position', [0.4985    0.6000    0.0500    0.0500], 'String', 'C', ...
	                'FontSize', 12, 'FontWeight', 'bold', 'LineStyle', 'None');
hl = annotation('textbox', 'Position', [0.0900    0.2856    0.0500    0.0500], 'String', 'D', ...
	                'FontSize', 12, 'FontWeight', 'bold', 'LineStyle', 'None');
hl = annotation('textbox', 'Position', [0.7121    0.2697    0.0500    0.0500], 'String', 'E', ...
	                'FontSize', 12, 'FontWeight', 'bold', 'LineStyle', 'None');

set(gcf,'Renderer','painters')
