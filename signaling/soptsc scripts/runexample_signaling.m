% Example for using SoptSC for cell-cell and cluster-cluster
% signaling network inference from single cell data.
%
% After running example (data in example is from Joost paper), 
% run this script for signaling network inference for given pathways
% Tgfb, Wnt and Bmp.


%% Setup  
% save cluster labels to sigfolder
resfolder = 'Results/20200228';
sigfolder = [resfolder '/Signaling'];
dlmwrite('Data/Li_cluster_labels.txt', cluster_label)


% Run each section separately or run them all 
%% Tgfb: ligand-receptor pairs and their target genes
Lig = {{'TGFB1'},{'TGFB1'},{'TGFB2'},{'TGFB2'}};
Rec = {{'TGFBR1'},{'TGFBR2'},{'TGFBR1'},{'TGFBR2'}};
Target = {{'MYC','SMAD6','BMP5','MMP3','IL11','SMAD2'},...
          {'MYC','SMAD6','BMP5','MMP3','IL11','SMAD2'},...
          {'MYC','SMAD6','BMP5','MMP3','IL11','SMAD2'},...
          {'MYC','SMAD6','BMP5','MMP3','IL11','SMAD2'}};

% Computing cell-cell interaction probability for given ligand-receptor pairs
[Pidv, Pall] = LR_Interaction(data, allgenes, Lig, Rec, Target);


%% Plot the (cell-cell and cluster-cluster) signaling network for Tgfb.
% Set the threshold such that the probability between cells or clusters
% less than the value of threshold is set to be zero. 
% Save the result figurs in folder Results\Signaling
threshold = 0.05;

plot_sig_network(Pidv,Pall,cluster_label,Lig,Rec,threshold,sigfolder)

%% Write P matrices to file
P_write = Pall;
dlmwrite([sigfolder '/P_all_' Lig{1}{1} '.txt'], P_write, 'delimiter','\t')

for i = 1:size(Pidv,1)
    dlmwrite([sigfolder '/P_' Lig{i}{1} '_' Rec{i}{1} '.txt'], Pidv{i}, 'delimiter','\t')
end

close all;







%% Wnt: ligand-receptor pairs and their target genes 
Lig = {{'WNT3'},{'WNT4'},{'WNT5A'},{'WNT6'},{'WNT10A'}};
Rec = {{'FZD1'},{'FZD1'},{'FZD1'},{'FZD1'},{'FZD1'}};
Target = {{'CTNNB1','LGR5','RUNX1','APC','MMP7','DKK1','CCND1'},...
        {'CTNNB1','LGR5','RUNX1','APC','MMP7','DKK1','CCND1'},...
        {'CTNNB1','LGR5','RUNX1','APC','MMP7','DKK1','CCND1'},...
        {'CTNNB1','LGR5','RUNX1','APC','MMP7','DKK1','CCND1'},...
        {'CTNNB1','LGR5','RUNX1','APC','MMP7','DKK1','CCND1'}};

% Computing cell-cell interaction probability for given ligand-receptor pairs
[Pidv, Pall] = LR_Interaction(data, allgenes, Lig, Rec, Target);


%%
threshold = 0.0;

plot_sig_network(Pidv,Pall,cluster_label,Lig,Rec,threshold,sigfolder)

%% Write P matrices to file
P_write = Pall;
dlmwrite([sigfolder '/P_all_' Lig{1}{1} '.txt'], P_write, 'delimiter','\t')

for i = 1:size(Pidv,1)
    dlmwrite([sigfolder '/P_' Lig{i}{1} '_' Rec{i}{1} '.txt'], Pidv{i}, 'delimiter','\t')
end

close all;







%% Bmp: ligand-receptor pairs and their target genes
Lig = {{'BMP1'},{'BMP2'},{'BMP4'},{'BMP7'}};
Rec = {{'BMPR2'},{'BMPR2'},{'BMPR2'},{'BMPR2'}};
Target = {{'CREBBP','FOS','ID1','JUN','RUNX1','SMAD1','SMAD5','CDH1'}, ...
          {'CREBBP','FOS','ID1','JUN','RUNX1','SMAD1','SMAD5','CDH1'}, ...
          {'CREBBP','FOS','ID1','JUN','RUNX1','SMAD1','SMAD5','CDH1'}, ...
          {'CREBBP','FOS','ID1','JUN','RUNX1','SMAD1','SMAD5','CDH1'}};

% Computing cell-cell interaction probability for given ligand-receptor pairs
[Pidv, Pall] = LR_Interaction(data, allgenes, Lig, Rec, Target);


%%
threshold = 0.05;

plot_sig_network(Pidv,Pall,cluster_label,Lig,Rec,threshold,sigfolder)

%% Write P matrices to file
P_write = Pall;
dlmwrite([sigfolder '/P_all_' Lig{1}{1} '.txt'], P_write, 'delimiter','\t')

for i = 1:size(Pidv,1)
    dlmwrite([sigfolder '/P_' Lig{i}{1} '_' Rec{i}{1} '.txt'], Pidv{i}, 'delimiter','\t')
end

close all;
