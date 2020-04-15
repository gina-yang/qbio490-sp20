% This is an example for applying SoptSC to scRNA-seq data (Joost et al. 2016) to perform
%   - Clustering
%   - Marker genes identified for each cluster
%   - Cell lineage
%   - Pseudotime
%   - Cell-to-cell signaling network for given ligand-receptor pairs and
%     downstream target genes
%   - Cluster-to-cluster signaling network for given ligand-receptor pairs
%     and downstream target genes
%
%   All details of the function can be found in the corresponding function
%   files. Please refer to each M file of functions for the description of
%   input and output.
%
%   Results are save in the folder: Results
%
%   Contact: Shuxiong Wang (Email: shuxionw@uci.edu) if you have any
%   question.

clear;
clc;
echo on;
addpath('Data');
addpath('NNDSVD');
addpath('symnmf2');
addpath('Signaling');
addpath('vinlinplot');
addpath('Results')

Data_all = importdata('GSE111113_clean.csv');
data_matrix = Data_all.data;
allgenes = Data_all.textdata(2:end,1);


%% Log normalization
data = log10(data_matrix +1);

% %%
% data_small = data(:,1:1200);
% data = data_small;

%% Step 1: Run SoptSC to identify clusters and subpopulation composition
resfolder = 'Results/GSE111113_clean';     % all results are saved here
NC = [];    % NC is the number of clusters: can be specified by user, or
            % if not given (NC = []), it will be inferred
No_cells = size(data,2);
No_exc_cell = 0.03*No_cells;
No_features = 3000;

[W,No_cluster,cluster_label,H,eigenvalues] = SoptSC_cluster(data,NC,No_exc_cell,No_features,resfolder);

% %% Optional: set the number of cluster and get clustering results based on W in step 1 (No need to run step 1 again)
% % This is faster than set NC in step 1 and rerun SoptSC to cluster cells.
% No_cluster_by_usr = 7; % Specified by user
% [No_cluster,cluster_label,H] = SoptSC_cluster_reset(W,No_cluster_by_usr);
% 
% %% Plot Eigen-gap of truncated graph Laplacian of the consensus matrix (if NC = [])
% plot_eigengap(eigenvalues,resfolder);
% 
% 
%% Plot cluster on 2-dimensional space
method = 'tsne';        % set method as 'pca' or 'tsne'
latent = plot_cluster(W,cluster_label,No_cluster,method,resfolder);



%% Identification of marker genes and plots gene-cell heatmap of topn markers
topn = 100;
Gene_idx = GC_htmp_DE(data,allgenes,cluster_label,topn,resfolder);

%% Plot gene expression on the low-dimensional projection of cells
% Marker = {'VIL1','KRT20','CDH1','ENG','SPARC','COL14A1', 'CD38', 'MZB1', 'DERL3', 'TRBC2', 'CD3D', 'CD3E', 'CD3G', 'ITGAX', 'CD68', 'KIT', 'TPSB2'};
% Marker = {'SPARC','COL14A1', 'DCN'};
%%% Bottom crypt %%%
% Marker = {'ASCL2', 'LGR5', 'METTL3', 'STMN1', 'EZH2', 'DNMT3A', 'RNF43'};

%%% Enterocyte %%%
Marker = {'GUCA2B', 'CA1', 'SLC26A3'};
plot_marker(data,Marker,allgenes,latent,resfolder)


% %% Violin plot of marker genes along clusters
% plot_marker_violin(data,allgenes,Marker,cluster_label,No_cluster,resfolder)
% 
% 
% %% Bar plot of marker genes along clusters (optional)
% boxplot_marker(data,allgenes,Marker,cluster_label,No_cluster,resfolder);
% 
% 
% %% Pseudotime and lineage inference
% 
% root_cluster = 0;
% root_cell = 0;
% reverse = 1;
% [Lineage, pseudotime] = Lineage_Ptime(W,No_cluster,cluster_label,root_cluster,root_cell,latent,reverse);
% 
% 
% %% Plot cluster color and pseudotime color on the lineage tree
% plot_lineage(Lineage,No_cluster,cluster_label,pseudotime,resfolder);
% 
% 
% %% Plot pseudotime on latent space
% plot_pseudotime(latent,pseudotime,resfolder);
% 
% %% Plot marker gene on the lineage tree
% 
% plot_lineage_marker(data,Lineage,allgenes,No_cluster,cluster_label,Marker,resfolder)
% 


