disp('Loading data...')
load model_properties_data


disp('Rasters...')

hf = figure(3); clf
set(hf, 'Position', [235 195 855 490]);


STIM_BAR_WIDTH = 5;
cell_typ_str = {'Excitatory', 'Delayed', 'Offset', 'Inhibitory'};
NCell_disp = 20;
for i_t=1:4,
	subplot(2,4,i_t), hold on
	cnt = 1;
	%shade = fill([0 10000 10000 0],[0 0 NCell_disp*NTrials NCell_disp*NTrials],0.25*[1 1 1],'EdgeColor', 'none');
	%alpha(shade, .4);
	for i_cell=1:NCell_disp,
		for i_trial=1:NTrials,
			st = spiketimes{i_trial,i_t,i_cell};
			plot(st, cnt*ones(size(st)), '.', 'Color', 0.8*colors(i_t,:), 'MarkerSize', 4);
			cnt = cnt+1;
		end
		plot([0 14000], [cnt cnt]-0.5, 'k-');
	end

	plot([2000,10000], [0 0], 'k-', 'LineWidth', STIM_BAR_WIDTH)


	set(gca, 'XTick', [2000:2000:14000], 'XTickLabel', [0:1:6])
	xlabel('Time (s)')
	if i_t==1,
		ylabel('Model ORNs')
	end
	set(gca, 'YTick', []);
	title(sprintf('Model %s motif', cell_typ_str{i_t}))
	set(gca, 'YLim', [0 NTrials*NCell_disp]) 
	%set(gca, 'YLim', [0 NCell_disp]) 
end


disp('Motif-averages...')
t_act = [dt:dt:dt*NBins]-1; %shift to start stim at 0

rng(1);
NSubSample = 30;
%subplot(234)
subplot(245)
hold on
for i_typ=1:4,
	idx = hidx(t==i_typ);
	sub_smpl = randi(length(idx), 30);
	%sub_smpl = randperm(length(idx), 30);
	idx = idx(sub_smpl);
	y = squeeze(mean(actf(idx,:,1,:,1),[1,4]));
	y_sem = squeeze(std(mean(actf(idx,:,1,:,1), 4),[],1))/sqrt(length(idx));
	h(i_typ) = plot(t_act,y, 'Color', colors(i_typ,:), 'LineWidth', 2);
	xx = [t_act, t_act(end), fliplr(t_act)]; 
	yy = [y-y_sem, y(end)+y_sem(end), fliplr(y+y_sem)];
	shade = fill(xx,yy,colors(i_typ,:),'EdgeColor', 'none');
	alpha(shade, .4);
end
plot([0 4], [0 0], 'k-', 'LineWidth', STIM_BAR_WIDTH)
YLim = get(gca, 'YLim');
set(gca, 'YLim', [0 YLim(2)],'XLim', [-0.5 6])
ylabel('Firing rate (Hz)')
xlabel('Time (s)')
title({'Motif-averaged', 'model responses'})
hleg = legend(h, 'Excitatory', 'Delayed', 'Offset', 'Inhibitory');
set(hleg, 'Box', 'off', 'Position', [0.1550    0.3551    0.0998    0.0871]);


disp('Pulsed stim...')
%axes('Position', [0.3991 0.1100 0.3293 0.3412]), hold on
%subplot(2,6,[9,10,11]), 
subplot(2,4,6), hold on
title({'Adaptation to multiple', 'pulses: IPI 0.5s'})
cls_sw = [2,1,4,3];
i_ipi=1;
matp = mean(act_typ_pulse{i_ipi},3);
sem_atp = std(act_typ_pulse{i_ipi},[],3)/sqrt(NTrials);

Y_MAX = 12;
t_adp = [dt:dt:dt*size(matp,2)]-1; %shift to start stim at 0
for i_typ=1:4,
	y = matp(cls_sw(i_typ),:); y_sem = sem_atp(cls_sw(i_typ),:);
	plot(t_adp, y, '-', 'Color', colors(i_typ,:), 'LineWidth', 2)
        xx = [t_adp, t_adp(end), fliplr(t_adp)];
        yy = [y-y_sem, y(end)+y_sem(end), fliplr(y+y_sem)];
        shade = fill(xx,yy,colors(i_typ,:),'EdgeColor', 'none');
        alpha(shade, .4);

	for i_pulse=1:NPulses,
		%plot(dt*locs_mu(cls_sw(i_typ),i_pulse)-1,pks_mu(cls_sw(i_typ),i_pulse), '*', 'Color', colors(i_typ,:))
		x = dt*dw_save{i_pulse}-1;
        	xx = [x(1), x(end), x(end), x(1)];
        	yy = [0 0 Y_MAX Y_MAX];
        	shade = fill(xx,yy,0.5*[1 1 1],'EdgeColor', 'none');
        	alpha(shade, .05);
		st_on = t_adp(stim_on_times(i_ipi,i_pulse));
		st_off = t_adp(stim_off_times(i_ipi,i_pulse));
		plot([st_on st_off], [0 0], 'k-', 'LineWidth', STIM_BAR_WIDTH) 
	end
end
set(gca, 'YLim', [0 Y_MAX], 'XLim', [-0.5, 6])
xlabel('Time (s)')
ylabel('Firing rate (Hz)')




disp('Single neuron...')
%Find strongly responding neuron

%axes('Position', [0.7678 0.1100 0.1372 0.3412]), hold on
%subplot(2,6,12), hold on
subplot(2,4,8), hold on 
mu = squeeze(mean(actf(cell,:,:,:,:),4));
sem = squeeze(std(actf(cell,:,:,:,:),[],4)/sqrt(NTrials));
%one_cell_clrs = [[0 0 0]; 0.25*[1 1 1]; 0.5*[1 1 1]];
%one_cell_clrs = [[1 0 1]; 0.5*[1 0 1]; 0.25*[1 0 1]];
one_cell_clrs = [[0,0,0.4]; [0,0,1]; colors(3,:)];
od_idx = [1,2,1]; sw_idx = [1,1,2];
clear h
for i_cell=1:3,
	y = mu(:,od_idx(i_cell),sw_idx(i_cell))';
	y_sem = sem(:,od_idx(i_cell), sw_idx(i_cell))';
	h(i_cell) = plot(t_act,y, 'Color', one_cell_clrs(i_cell,:), 'LineWidth', 2);
	xx = [t_act, t_act(end), fliplr(t_act)]; 
	yy = [y-y_sem, y(end)+y_sem(end), fliplr(y+y_sem)];
	shade = fill(xx,yy,one_cell_clrs(i_cell,:),'EdgeColor', 'none');
	alpha(shade, .4);
end
YMIN = -5; XMIN = -0.5;
plot([0 4], [YMIN YMIN], 'k-', 'LineWidth', STIM_BAR_WIDTH)
set(gca, 'XLim', [-0.5 6])
plot([XMIN 6], [0 0], 'k--')
hleg=legend(h, 'Original', 'reduced magnitude', 'new motif');
set(hleg, 'Box', 'off')

set(gca, 'YLim', [YMIN 55]) 
xlabel('Time (s)')
ylabel('Single neuron firing rate (Hz)')
title({'Changing response', 'magnitude and motif'})


%%% PCA

load('bORN_pulse_0.mat');
NORN = 10000; NT = 100; Ntrials = 10;
i_od =1;
Types = load(sprintf('Classes_N10000_odor%d_0.out', i_od));
Types = Types(:,2)+1;
NTypes = length(unique(Types));

idx = find(Types==2);
exc_only = bORN_pulse(idx,:,:,1);
N_exc = size(exc_only,1);
all_motifs = bORN_pulse(randi(NORN,1,N_exc),:,:,1);

exc_only_use = reshape(exc_only, [N_exc, NT*Ntrials])';
[coeff,score,latent,tsquared,explained_exc,mu] = pca(exc_only_use);
dim_exc = sum(explained_exc).^2/sum(explained_exc.^2);
all_motifs_use = reshape(all_motifs, [N_exc, NT*Ntrials])';
[coeff,score,latent,tsquared,explained_all,mu] = pca(all_motifs_use);
dim_all = sum(explained_all).^2/sum(explained_all.^2);


subplot(2,4,7)
hold on;
NComp = 6;
p1 = plot(explained_exc(1:NComp),'LineWidth', 1.5, 'Color', [0 0 0.515625]);
scatter([1:NComp],explained_exc(1:NComp), [],[0 0 0.515625], 'filled')

p2 = plot(explained_all(1:NComp), 'LineWidth', 1.5, 'Color','r');
scatter([1:NComp],explained_all(1:NComp), [],'r', 'filled' )

set(gca, 'XLim', [0.5 NComp])

title({'Complexity', 'of ORN responses'});
xlabel('Principal Component');
ylabel('% Variance');
legend([p1,p2],{"Excitatory only", "All motifs"}, 'Box', 'off')
% legend
%save2pdf("Variance_exp",h,150)


hl = annotation('textbox', 'Position', [0.0794    0.9146    0.0500    0.0500], 'String', 'A', ...
		'FontSize', 14, 'FontWeight', 'bold', 'LineStyle', 'None');
hl = annotation('textbox', 'Position', [0.0794    0.4707    0.0500    0.0500], 'String', 'B', ...
		'FontSize', 14, 'FontWeight', 'bold', 'LineStyle', 'None');
hl = annotation('textbox', 'Position', [0.2988    0.4707    0.0500    0.0500], 'String', 'C', ...
		'FontSize', 14, 'FontWeight', 'bold', 'LineStyle', 'None');
hl = annotation('textbox', 'Position', [0.5067    0.4707    0.0500    0.0500], 'String', 'D', ...
		'FontSize', 14, 'FontWeight', 'bold', 'LineStyle', 'None');
hl = annotation('textbox', 'Position', [0.7074    0.4707    0.0500    0.0500], 'String', 'E', ...
		'FontSize', 14, 'FontWeight', 'bold', 'LineStyle', 'None');

set(gcf,'Renderer','painters')
