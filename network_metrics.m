%load BCT package
% addpath('C:\MATLAB\2019_03_03_BCT');

% the graph can be found at:
% PDC = EEG.CAT.Conn.PDC;

% freq = 10;
% G = mean(PDC(:,:,freq,:), 4); %mean accross time

load('graph.mat');

sparsity = 0.2;
GS = threshold_proportional(G, sparsity);

c = graphconncomp(GS, 'weak',1); %if c==1, there is one connected component, else we need larger value of sparsity

%make it symmetric
A = (GS>0)|(GS'>0);
GS(A) = G(A);

CC = mean(clustering_coef_bu(GS));

Lengths = weight_conversion(GS,'lengths');
D = distance_bin(Lengths); 
[L,Eff_glob] = charpath(D, 0, 0); %min path length, global efficiency

Eff_loc = mean(efficiency_bin(GS, 2));   

BC = mean(betweenness_bin(GS));
