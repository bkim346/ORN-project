%% Load model data

pulse0_s = load("Data/1s_sim/bORN_pulse_binsize10_0.mat"); 
pulse10_s = load("Data/1s_sim/bORN_pulse_binsize10_10.mat"); 
pulse50_s = load("Data/1s_sim/bORN_pulse_binsize10_50.mat"); 


NORN=43;
off =900;
ORN_ind = [1+off:NORN+off];

mat = load("Data/4s_sim/class_all.mat");
mat2 = mat.class_matrix_all_pulse;


[H,P,ci,stats] = ttest2(mat2(2,2,:), mat2(2,1,:));


load("Data/1s_sim/pca.mat")

pulse0_od1 = pulse0_s.bORN_pulse(ORN_ind,:,1,1);
pulse0 = pulse0_s.bORN_pulse(ORN_ind,:,1,2); 
pulse10 = pulse10_s.bORN_pulse(ORN_ind,:,1,2); 
pulse50 = pulse50_s.bORN_pulse(ORN_ind,:,1,2); 

 % Exchange 1-2 and 3-4
Types0_od1 = load(sprintf('Data/1s_sim/Classes_N10000_odor1_0.out')); 
Types0_od1 = Types0_od1(ORN_ind,2)+1; 

tmp = find(Types0_od1 == 1);
Types0_od1(find(Types0_od1 == 2)) = 1;
Types0_od1(tmp) = 2;

tmp2 = find(Types0_od1 == 3);
Types0_od1(find(Types0_od1 == 4)) = 3;
Types0_od1(tmp2) = 4; 
 
 
Types0 = load(sprintf('Data/1s_sim/Classes_N10000_odor2_0.out')); 
Types0 = Types0(ORN_ind,2)+1; 

tmp = find(Types0 == 1);
Types0(find(Types0 == 2)) = 1;
Types0(tmp) = 2;

tmp2 = find(Types0 == 3);
Types0(find(Types0 == 4)) = 3;
Types0(tmp2) = 4;



Types10 = load(sprintf('Data/1s_sim/Classes_N10000_odor2_10.out')); 
Types10 = Types10(ORN_ind,2)+1; 

tmp = find(Types10 == 1);
Types10(find(Types10 == 2)) = 1;
Types10(tmp) = 2;

tmp2 = find(Types10 == 3);
Types10(find(Types10 == 4)) = 3;
Types10(tmp2) = 4;

Types50 = load(sprintf('Data/1s_sim/Classes_N10000_odor2_50.out')); 
Types50 = Types50(ORN_ind,2)+1; 


tmp = find(Types50 == 1);
Types50(find(Types50 == 2)) = 1;
Types50(tmp) = 2;

tmp2 = find(Types50 == 3);
Types50(find(Types50 == 4)) = 3;
Types50(tmp2) = 4;


NTypes = 4; 
[sorted,sort_idx] = sort(Types0); 

p0 = pulse0(sort_idx,:); 
p10 = pulse10(sort_idx,:); 
p50 = pulse50(sort_idx,:); 
p0_od1 = pulse0_od1(sort_idx,:);

Types0_sorted = Types0(sort_idx); 
Types10_sorted = Types10(sort_idx); 
Types50_sorted = Types50(sort_idx); 

Ntime = size(p0,2); 

cnt0_od1=1;
cnt0=1; 
cnt10=1; 
cnt50=1; 
for i = 1:NORN 
 for j = 1:Ntime 
     if p0(i,j)>0 
         r0(cnt0,1) = j; 
         r0(cnt0, 2) = i; 
         cnt0=cnt0+1; 
     end 
     if p0_od1(i,j)>0 
         r0_od1(cnt0_od1,1) = j; 
         r0_od1(cnt0_od1, 2) = i; 
         cnt0_od1=cnt0_od1+1; 
     end 
     if p10(i,j)>0 
         r10(cnt10,1) = j; 
         r10(cnt10, 2) = i; 
         cnt10=cnt10+1; 
     end 
     if p50(i,j)>0 
         r50(cnt50,1) = j; 
         r50(cnt50, 2) = i; 
         cnt50=cnt50+1; 
     end 
end 
end 

for i_orn = 1:NORN 
    ind = find(r0(:,2) == i_orn); 
    if ~isempty(ind) 
        typ = Types0_sorted(i_orn,1); 
        r0(ind,3) = typ; 
    end 
end


for i_orn = 1:NORN 
    ind = find(r0_od1(:,2) == i_orn); 
    if ~isempty(ind) 
        typ = Types0_sorted(i_orn,1); 
        r0_od1(ind,3) = typ; 
    end 
end


for i_orn = 1:NORN
ind = find(r10(:,2) == i_orn); 
if ~isempty(ind) 
    typ = Types10_sorted(i_orn,1); 
    r10(ind,3) = typ; 
end 
end 

for i_orn = 1:NORN 
ind = find(r50(:,2) == i_orn); 
 if ~isempty(ind) 
    typ = Types50_sorted(i_orn,1); 
    r50(ind,3) = typ; 
 end 
end


%% Load exp data
load Data/exp_hex_oct_1s_class_data
load Data/mean_switch_p.mat
mORN = squeeze(mean(ORN_data,3));
[~,sort_idx_exp] = sortrows(id_clu(:,1));
id_clu_sorted = id_clu(sort_idx_exp,:);
mORN_sorted = mORN(sort_idx_exp,:);
NCells = size(mORN,1);
NTime = size(mORN,2);
spiketimes_sorted = spiketimes(sort_idx_exp,:,:);

cnt1=1;
cnt2=2;

for i=1:NCells
    for j = 1:length(spiketimes_sorted{i,1,1})
        od1_to_plot(cnt1,1) = spiketimes_sorted{i,1,1}(j);
        od1_to_plot(cnt1,2) = i;
        cnt1=cnt1+1;
    end
    for j = 1:length(spiketimes_sorted{i,1,2})
        od2_to_plot(cnt2,1) = spiketimes_sorted{i,1,2}(j);
        od2_to_plot(cnt2,2) = i;
        cnt2=cnt2+1;
    end
end

for i_orn = 1:NCells
    ind = find(od1_to_plot(:,2) == i_orn);
    if ~isempty(ind)
        typ = id_clu_sorted(i_orn,1);
        od1_to_plot(ind,3) = typ;
    end
end

for i_orn = 1:NCells
    ind = find(od2_to_plot(:,2) == i_orn);
    if ~isempty(ind)
        typ = id_clu_sorted(i_orn,2);
        od2_to_plot(ind,3) = typ;
    end
end
it_cls = [41:70];
mmORN = squeeze(sum(mORN(:,it_cls,:),2));
cc = corrcoef(mmORN);

it_cls = [41:70];

mmORN = squeeze(sum(mORN(:,it_cls,:),2));
cc = corrcoef(mmORN);
mcor = cc(1,2);
mclass = mean(pred_labels(it_cls));
p_clu = c_clu./sum(c_clu,1);




%% Figure Final 
c_g = [linspace(0.4,1,256).' 1*ones(256,1) linspace(0.4,1,256).'];
colormap(c_g)

c_r = [linspace(0.7,1,256).' linspace(0.35,1,256).' linspace(0.35,1,256).'];
colormap(c_r)

c_b = [linspace(0.15,1,256).' linspace(0.5,1,256).' linspace(0.8,1,256).'];
colormap(c_b)


cmap = [linspace(0.2,1,256).' linspace(0.4,1,256).' linspace(0.8,1,256).'];
colormap(cmap)

% Exc, Del, Off, Inh
col = {[0 0 0.515625],[0 0.84375 1],[0.5 0 0],[1 0.828125 0 ]}; % Colors for different motifs

% h=figure();
colors = {[0 0 0.515625],[0 0.84375 1],[0.5 0 0],[1 0.828125 0]};
subplot(3,4,1);
%hex
for i_typ = 1:4
    ind = find(od1_to_plot(:,3)==i_typ);
    p = plot(od1_to_plot(ind,1)/10000-0.153, od1_to_plot(ind,2), '.');
    hold on;
    p.Color = colors{i_typ};
%     p.MarkerSize = 9;
end
xlim([1, 5])
ylim([0,43])
xticks([1 2 3 4 5])
xticklabels({'-1','0','1','2','3'})
ylabel("ORN index")
xlabel("Time (s)")
title("Hexanol Response")


map = [0 0 0
    0 0 0.25
    0 0 0.5
    0 0 0.75
    0 0 1];


subplot(3,4,2);
%cyclohex
for i_typ = 1:4
    ind = find(od2_to_plot(:,3)==i_typ);
    p = plot(od2_to_plot(ind,1)/10000, od2_to_plot(ind,2), '.');
    hold on;
    p.Color = colors{i_typ};
%     p.MarkerSize = 9;
end
title("Cyclohexanol Response")
ylabel("ORN index")
xlabel("Time (s)")
xlim([1,5])
xticks([1 2 3 4 5])
xticklabels({'-1','0','1','2','3'})
ylim([0,43])

ax1 = subplot(3,4,3);
%switching prob
imagesc(ax1,p_clu)
colormap(ax1,c_b)
% cc = colorbar('east');
% set(cc,'position',[.695 .717 0.01 .209]);

col_matrix = {[0 0 0],[0 0 0],[1 1 1],[0 0 0],[1 1 1],[1 1 1],[1 1 1],[1 1 1],[1 1 1],[1 1 1],[0 0 0],[0 0 0],[1 1 1],[1 1 1],[1 1 1], [1 1 1]};
cnt = 0;
for i_cl1 = 1:4
    for i_cl2=1:4
        cnt = cnt+1;
        text(i_cl2,i_cl1, sprintf('%0.2g',p_clu(i_cl1,i_cl2)), 'HorizontalAlignment', 'center', 'Color', 'k')
    end
end

% set(gca, 'XTickLabel', {'Exc.', 'Del.', 'Off.', 'Inh.'},...
% 'YTickLabel', {'Exc.', 'Del.', 'Off.', 'Inh.'})
xticks([1,2,3,4])
yticks([1 2 3 4])
xticklabels({'Exc.', 'Del.', 'Off.', 'Inh.'})
yticklabels({'Exc.', 'Del.', 'Off.', 'Inh.'})
title('Probability of Switching Between Motifs')
xlabel('Cyclohexanol cluster')
ylabel('Hexanol cluster')

subplot(3,4,4)
% Bar plot
X = categorical({'hex:cyc', 'hex:oct', 'oct:cyc', 'pet:hex', 'pet:cyc', 'pet:oct'});
% mean_switch_prob = [0.3186, 0.4083, 0.5842, 0.3261, 0.4615, 0.3721];
b = bar(X,mean_switch_prob, 0.6);
b.FaceColor= [0.15 0.65 0.8];
xlabel("Odor Pairs")
ylabel("Switching prob")
ylim([0 0.7])
title("Switching Probability")
% axis off;

subplot(3,4,5);
%no switch
for i_typ = 1:4
    ind = find(r0_od1(:,3)==i_typ);
    p = plot(r0_od1(ind,1)/200, r0_od1(ind,2), '.');
    hold on;
    p.Color = col{i_typ};
%     p.MarkerSize = 9;
end
ylabel("ORN index")
xlabel("Time (s)")
xlim([0, 4])
xticks([0 1 2 3 4])
xticklabels({'-1','0','1','2','3'})
ylim([0,43])
title("Odor 1 Response")
[~,icons,plots,legend_text] = legend({"Exc","Del","Off","Inh"}, 'Position', [0.2286 0.566 0.05 0.05]);
for i=5:12
   icons(i).MarkerSize = 12;
    
end

subplot(3,4,6);
%no switch
for i_typ = 1:4
    ind = find(r0(:,3)==i_typ);
    p = plot(r0(ind,1)/200, r0(ind,2), '.');
    hold on;
    p.Color = col{i_typ};
%     p.MarkerSize = 9;
end
ylabel("ORN index")
xlabel("Time (s)")
xlim([0, 4])
xticks([0 1 2 3 4])
xticklabels({'-1','0','1','2','3'})
ylim([0,43])
title("Odor 2a Response: 0% Switching")


subplot(3,4,7);
%10 switch
for i_typ = 1:4
    ind = find(r10(:,3)==i_typ);
    p = plot(r10(ind,1)/200, r10(ind,2), '.');
    hold on;
    p.Color = col{i_typ};
%     p.MarkerSize = 9;
end
ylabel("ORN index")
xlabel("Time (s)")
xlim([0, 4])
xticks([0 1 2 3 4])
xticklabels({'-1','0','1','2','3'})
title("Odor 2b Response: 10% Switching")
ylim([0,43])

subplot(3,4,8);
%50 switch
for i_typ = 1:4
    ind = find(r50(:,3)==i_typ);
    p = plot(r50(ind,1)/200, r50(ind,2), '.');
    hold on;
    p.Color = col{i_typ};
end
ylabel("ORN index")
xlabel("Time (s)")
xlim([0, 4])
ylim([0,43])
xticks([0 1 2 3 4])
xticklabels({'-1','0','1','2','3'})
title("Odor 2c Response: 50% Switching")

ax2 = subplot(3,4,9);

% Surface plot
surf(pi/20*[1:9]*57.296,[0:0.1:1.0],100*mean(mat2(2:end,1:11,:),3)')
colormap(ax2,c_r)
cb = colorbar('south'); 
set(cb,'position',[.122 .055 0.152 .015]);
xlabel("Angle between odors (deg)");
ylabel("Switching prob")
zlabel("Accuracy (%)")
title("Classification Between Odor Pairs")
zlim([90 100])

subplot(3,4,10);
%PCA 0
i_tr = 1; i_od = 1;
plot(ldg_00(1,:,i_tr,i_od), ldg_00(2,:,i_tr,i_od), 'b', 'LineWidth', 1.5)
hold on;
i_od = 2;
plot(ldg_00(1,:,i_tr,i_od), ldg_00(2,:,i_tr,i_od),'Color', [1 0 0, 0.78], 'LineWidth', 1.5)
legend(["Odor1","Odor2a"])
legend('boxoff')
title("PCA Trajectory: 0% Switching")
xlabel(['PC 1'])
ylabel(['PC 2'])
zlabel(['PC 3'])
xlim([-20,40])
ylim([-10,15])

subplot(3,4,11);
% PCA 10
i_tr = 1; i_od = 1;

plot(ldg_01(1,:,i_tr,i_od), ldg_01(2,:,i_tr,i_od), 'b', 'LineWidth', 1.5)
hold on;
i_od = 2;
plot(ldg_01(1,:,i_tr,i_od), ldg_01(2,:,i_tr,i_od),'Color', [0.65, 0, 0, 0.85], 'LineWidth', 1.5)
legend(["Odor1","Odor2b"])
legend('boxoff')
title("PCA Trajectory: 10% Switching")
xlabel(['PC 1'])
ylabel(['PC 2'])
zlabel(['PC 3'])
xlim([-20,40])
ylim([-10,15])
% set(gca,'fontname','times')


subplot(3,4,12);
% PCA 50
i_tr = 1; i_od = 1;

plot(ldg_09(1,:,i_tr,i_od), ldg_09(2,:,i_tr,i_od), 'b', 'LineWidth', 1.5)
hold on;
i_od = 2;
plot(ldg_09(1,:,i_tr,i_od), ldg_09(2,:,i_tr,i_od), 'Color', [0.3, 0, 0, 0.85], 'LineWidth', 1.5)
legend(["Odor1","Odor2c"])
legend('boxoff')
xlabel(['PC 1'])
ylabel(['PC 2'])
zlabel(['PC 3'])
xlim([-20,40])
ylim([-10,15])
title("PCA Trajectory: 50% Switching")


t = annotation('textbox', 'Position',[0.09 0.9 0.05 0.05]);
t.FontSize = 18;
t.String = "A";
t.LineStyle = 'none';


t = annotation('textbox', 'Position',[0.505 0.9 0.05 0.05]);
t.FontSize = 18;
t.String = "B";
t.LineStyle = 'none';

t = annotation('textbox', 'Position',[0.715 0.9 0.05 0.05]);
t.FontSize = 18;
t.String = "C";
t.LineStyle = 'none';


t = annotation('textbox', 'Position',[0.09 0.6 0.05 0.05]);
t.FontSize = 18;
t.String = "D";
t.LineStyle = 'none';

t = annotation('textbox', 'Position',[0.09 0.33 0.05 0.05]);
t.FontSize = 18;
t.String = "E";
t.LineStyle = 'none';

t = annotation('textbox', 'Position',[0.30 0.33 0.05 0.05]);
t.FontSize = 18;
t.String = "F";
t.LineStyle = 'none';

t = annotation('textbox', 'Position',[0.5 0.935 0.05 0.05]);
t.FontSize = 18;
t.String = "{\it In vivo}";
t.LineStyle = 'none';

t = annotation('textbox', 'Position',[0.5 0.63 0.05 0.05]);
t.FontSize = 18;
t.String = "Model";
t.LineStyle = 'none';


set(gca,'fontname','arial');
    
set(gcf,'renderer','painters');

% save2pdf("Figure_final",h,600,'-dsvg')



