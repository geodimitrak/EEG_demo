%% preprocess
% Author: Georgios N. Dimitrakopoulos

eeglab; %start gui
EEG = pop_loadset('EEG_data_demo.set');
EEG = pop_chanedit(EEG, 'load',{'chan_locs.ced', 'filetype', 'autodetect'});

sampling_rate = 256;
EEG = pop_resample(EEG,sampling_rate);

filter_low = 1;
filter_high = 45;
EEG = pop_eegfiltnew(EEG, filter_low, filter_high);

ref= {'A1', 'A2'}; %[] for average reference
EEG = pop_reref(EEG, ref);

events = {'30'};
timelimits = [-1, 3];
EEG = pop_epoch(EEG, events, timelimits);

timerange = [-1000 0]; %in msec
EEG = pop_rmbase( EEG, timerange);

EEG = pop_select(EEG, 'trial', 1:10);

eeglab redraw; %refresh gui

EEG = pop_runica(EEG, 'icatype', 'runica');

%plot top 20 components
pop_topoplot( EEG, 0, 1:20); %0 components, 1 erp

%inspect and select some for rejection.
rej=1:2;

EEG = pop_subcomp(EEG, rej, 0);


pop_saveset( EEG, 'filename', 'clean_EEG.set');