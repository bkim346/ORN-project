%%%%%%
%
% Plots the distributions of peaks and times to peak in
% model and experimental data
%
%%%%%%

%
% Format data - exp and model data
%

SF = 20;

colors = [
            [0 0.843750000000000 1]; ...
            [0 0 0.515625000000000]; ...
            [1 0.828125000000000 0]; ...
            [0.500000000000000 0 0] ...
         ];

%MODEL
model = [];
%load data
load model_figure4_1s_responses

%Act - we take odor 1
i_odor=1;
x = model_1s_responses(i_odor).responses;

% filter model data for Responsive cells
pre = x(:,1:SF); post = x(:,SF+1:2*SF);
idx_resp = ttest((pre-post)')';
model.data = x(idx_resp==1,:);
% model.data = x;
t = model_1s_responses(i_odor).clusters;
t = t(idx_resp==1);

model.sizes = size(model.data);

%Clusters
model.clusters = t;
NCLUSTERS = length(unique(model.clusters));


%Calculate peaks 
% 1 - Delayed, 2 - Excitatory, 3 - Inhibitory, 4 - Offset
model.i_stim_onset = SF;
model.pks = zeros(model.sizes(1),1);
model.i_pks = zeros(model.sizes(1),1);
model.avg_act = mean(model.data(:,1:SF),2);
for i=1:4
   ind = find(model.clusters == i)';
   if i == 1 || i == 2 || i == 4
       [model.pks(ind),model.i_pks(ind)] = max(model.data(ind,SF:end), [], 2);
   end
   if i == 3
       [model.pks(ind),model.i_pks(ind)] = min(model.data(ind,SF:end), [], 2);
   end
end
model.t_pks = 50*(model.i_pks);%-model.i_stim_onset);
model.pks = 20*(model.pks-model.avg_act);


load large1s_in_vivo_data.mat;

%Act, clusters, sizes
exper.data = large1s_data.responses;
clusters_tmp = large1s_data.clusters;

%Switch clusters - to agree model experiment
figure(99), clf
% cl_sw = [2 1 4 3];
cl_sw = [1 2 3 4];
for i_cl=1:NCLUSTERS
	exper.clusters(clusters_tmp==i_cl) = cl_sw(i_cl);
end
for i_cl=1:NCLUSTERS
	subplot(211), hold on
	plot(mean(model.data(model.clusters==i_cl,:),1),'Color', colors(i_cl,:))
    title('Model')
    legend('Delayed', 'Excitatory', 'Inhibitory', 'Offset')
	subplot(212), hold on
	plot(mean(exper.data(exper.clusters==i_cl,:),1),'Color', colors(i_cl,:))
    title('Exp')
end

exper.sizes = size(exper.data);

exper.i_stim_onset = 2*SF;
exper.pks = zeros(exper.sizes(1),1);
exper.i_pks = zeros(exper.sizes(1),1);
exper.avg_act = mean(exper.data(:,1:2*SF),2);
for i=1:4
   ind = find(exper.clusters == i)';
   if i == 1 || i == 2 || i == 4
       [exper.pks(ind),exper.i_pks(ind)] = max(exper.data(ind,2*SF:end), [], 2);
   end
   if i == 3 
       [exper.pks(ind),exper.i_pks(ind)] = min(exper.data(ind,2*SF:end), [], 2);
   end
end
exper.t_pks = 25*(exper.i_pks);%-exper.i_stim_onset);
exper.pks = exper.pks - exper.avg_act;
% model.pks = 20*model.pks;

h=figure(1);
% clf;

%Create figure
titles = {'Delayed', 'Excitatory', 'Inhibitory', 'Offset'};

%Loop over both metrics - pks and t_pks
plt_idx=0;
for i_metric=1:2

	%%Select which metric to plot
	if i_metric==1
		plt_idx=0;
		m_metric = model.pks;
		e_metric = exper.pks;
		X_MAX = 80;
        
	else
		%%Increment the plotting index if on second metric
		plt_idx=plt_idx+NCLUSTERS;
		m_metric = model.t_pks;
		e_metric = exper.t_pks;
		X_MAX = 4000;
        
	end

	for i_cluster=1:NCLUSTERS
		opts = [];
		opts.color=colors(i_cluster,:);
		opts.title=titles{i_cluster};
        if i_metric == 1
            opts.xlabel = 'Firing rate (Hz)';
        end 
        if i_metric == 2
            opts.xlabel = 'Time to reach peak response (ms)';
        end
        
		ax = subplot(NCLUSTERS, 2, i_cluster+plt_idx);
		plot_histograms(m_metric(model.clusters==i_cluster), e_metric(exper.clusters==i_cluster), ax, opts)
		set(gca, 'XLim', [-10, X_MAX])
	end
end	
annotation('textbox',[.45 .66 .3 .3], 'String','Histogram of Peak Responses','EdgeColor','none', 'FontSize',17)
annotation('textbox',[.45 .225 .3 .3], 'String','Histogram of Response Latencies','EdgeColor','none', 'FontSize',17)
annotation('textbox',[.1 .66 .3 .3], 'String','A','EdgeColor','none', 'FontSize',17)
annotation('textbox',[.1 .225 .3 .3], 'String','B','EdgeColor','none', 'FontSize',17)
		


subplot(NCLUSTERS, 2, 2)
p1 = plot(nan, nan, 'k-', 'DisplayName','Model');
p2 = plot(nan, nan, 'k.-', 'DisplayName','Experiment');
legend([p1, p2], 'Model', 'Experiment')

save2pdf("Figures/Supplementary_fig",h,300,'-dpdf');

