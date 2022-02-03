<<<<<<< HEAD
% trial script to loop through all sites and identify multiple ACI values
% and plot with their appropriate spectogram


clear

dir2process = readtable('prep_analysis/dir2calcACI.xlsx');
load("pmHT_cells_09-17.mat");
load("trimmed_results_indices_09-17.mat");
load("metric_matfiles\ACI1024_low_cells.mat");

for k=1:size(dir2process,1)
    
    Site=char(dir2process.Site(k));   
    DirIn =char(dir2process.DirIn(k));             
    DirOut=char(dir2process.DirOut(k)); 
    Deployment=dir2process.Deployment(k);
    FS=dir2process.FS(k);
    nsec=dir2process.nsec(k); 
    cal=10^(dir2process.gain(k)/20);  
    NFFT = 2^10; %set equal to the NFFT used in ACI calc
    
    % generate file list, file names and diretories 
    if exist(DirOut,'dir') ~= 1; eval(['system(''mkdir '  DirOut ''')']); end %  make output directory if it does not exist 
    
    FILES=dir(strcat(DirIn,'*wav')); % list all the wav files in a directory 
    filelist=cat(1,FILES.name); 
    
    % find min, max, and median ACI
    minACI = find(ACI1024_lowpmHT{k} == min(ACI1024_lowpmHT{k})); 
    [~,medianACI] = min(abs(ACI1024_lowpmHT{k}-median(ACI1024_lowpmHT{k})));
    %medianACI = find(ACI1024_lowpmHT{k} == median(ACI1024_lowpmHT{k})); %
    %doesn't work on even lengthed datasets
    maxACI = find(ACI1024_lowpmHT{k} == max(ACI1024_lowpmHT{k}));
    
    minACI_val = min(ACI1024_lowpmHT{k});
    medianACI_val = ACI1024_lowpmHT{k}(medianACI);
    %medianACI_val = median(ACI1024_lowpmHT{k});
    maxACI_val = max(ACI1024_lowpmHT{k});
    
    % find position in directory of min, max, median ACI
    n_file_min = (index1(k)+pmHT{k}(minACI))-1;
    n_file_median = (index1(k)+pmHT{k}(medianACI))-1;
    n_file_max = (index1(k)+pmHT{k}(maxACI))-1;

    % spectrogram calculations
    [y,fs] = audioread(strcat(DirIn,filelist(n_file_min,:)));
    y_min = (y-mean(y))*cal;
    [~,F_min,T_min,Pxx_min]=spectrogram(y_min,NFFT,0,[],fs);

    [y,fs] = audioread(strcat(DirIn,filelist(n_file_median,:)));
    y_median = (y-mean(y))*cal;
    [~,F_median,T_median,Pxx_median]=spectrogram(y_median,NFFT,0,[],fs);
    
    [y,fs] = audioread(strcat(DirIn,filelist(n_file_max,:)));
    y_max = (y-mean(y))*cal;
    [~,F_max,T_max,Pxx_max]=spectrogram(y_max,NFFT,0,[],fs);
        
    % titles and labels
    min_title = strcat(filelist(n_file_min,:),' ACI=', sprintf('%02.01f',minACI_val)); 
    median_title = strcat(filelist(n_file_median,:),' ACI=', sprintf('%02.01f',medianACI_val)); 
    max_title = strcat(filelist(n_file_max,:),' ACI=', sprintf('%02.01f',maxACI_val)); 
  
    % plotting
    h=figure('visible','off','Position',[500 900 1000 1300]);
    %figure; 
    subplot(3,1,1); 
    imagesc(T_min,F_min,10*log10(Pxx_min(:,:)));set(gca,'FontSize',12);   
    ylim([100 2000]); caxis([25 85]); colorbar("eastoutside"); 
    axis xy; xlabel('Time (sec)');ylabel('Frequency (Hz)');
    title(min_title);
    
    subplot(3,1,2); 
    imagesc(T_median,F_median,10*log10(Pxx_median(:,:)));set(gca,'FontSize',12);   
    ylim([100 2000]); caxis([25 85]); colorbar("eastoutside"); 
    axis xy; xlabel('Time (sec)');ylabel('Frequency (Hz)');
    title(median_title);
    
    subplot(3,1,3); 
    imagesc(T_max,F_max,10*log10(Pxx_max(:,:)));set(gca,'FontSize',12);   
    ylim([100 2000]); caxis([25 85]); colorbar("eastoutside"); 
    axis xy; xlabel('Time (sec)'); ylabel('Frequency (Hz)');
    title(max_title);
    
    figtitle = strcat(Site, '-D',sprintf('%01.0f',Deployment));
    mtit(figtitle, 'xoff',-0.5);
    
    out_img_name=strcat(DirOut,'ACI1024_',Site, '_D',sprintf('%02.0f',Deployment),'.png' ); 
    saveas(h,out_img_name);
        
end
=======
% trial script to loop through all sites and identify multiple ACI values
% and plot with their appropriate spectogram


clear

dir2process = readtable('prep_analysis/dir2calcACI.xlsx');
load("pmHT_cells_09-17.mat");
load("trimmed_results_indices_09-17.mat");
load("metric_matfiles\ACI1024_low_cells.mat");

for k=1:size(dir2process,1)
    
    Site=char(dir2process.Site(k));   
    DirIn =char(dir2process.DirIn(k));             
    DirOut=char(dir2process.DirOut(k)); 
    Deployment=dir2process.Deployment(k);
    FS=dir2process.FS(k);
    nsec=dir2process.nsec(k); 
    cal=10^(dir2process.gain(k)/20);  
    NFFT = 2^10; %set equal to the NFFT used in ACI calc
    
    % generate file list, file names and diretories 
    if exist(DirOut,'dir') ~= 1; eval(['system(''mkdir '  DirOut ''')']); end %  make output directory if it does not exist 
    
    FILES=dir(strcat(DirIn,'*wav')); % list all the wav files in a directory 
    filelist=cat(1,FILES.name); 
    
    % find min, max, and median ACI
    minACI = find(ACI1024_lowpmHT{k} == min(ACI1024_lowpmHT{k})); 
    [~,medianACI] = min(abs(ACI1024_lowpmHT{k}-median(ACI1024_lowpmHT{k})));
    %medianACI = find(ACI1024_lowpmHT{k} == median(ACI1024_lowpmHT{k})); %
    %doesn't work on even lengthed datasets
    maxACI = find(ACI1024_lowpmHT{k} == max(ACI1024_lowpmHT{k}));
    
    minACI_val = min(ACI1024_lowpmHT{k});
    medianACI_val = ACI1024_lowpmHT{k}(medianACI);
    %medianACI_val = median(ACI1024_lowpmHT{k});
    maxACI_val = max(ACI1024_lowpmHT{k});
    
    % find position in directory of min, max, median ACI
    n_file_min = (index1(k)+pmHT{k}(minACI))-1;
    n_file_median = (index1(k)+pmHT{k}(medianACI))-1;
    n_file_max = (index1(k)+pmHT{k}(maxACI))-1;

    % spectrogram calculations
    [y,fs] = audioread(strcat(DirIn,filelist(n_file_min,:)));
    y_min = (y-mean(y))*cal;
    [~,F_min,T_min,Pxx_min]=spectrogram(y_min,NFFT,0,[],fs);

    [y,fs] = audioread(strcat(DirIn,filelist(n_file_median,:)));
    y_median = (y-mean(y))*cal;
    [~,F_median,T_median,Pxx_median]=spectrogram(y_median,NFFT,0,[],fs);
    
    [y,fs] = audioread(strcat(DirIn,filelist(n_file_max,:)));
    y_max = (y-mean(y))*cal;
    [~,F_max,T_max,Pxx_max]=spectrogram(y_max,NFFT,0,[],fs);
        
    % titles and labels
    min_title = strcat(filelist(n_file_min,:),' ACI=', sprintf('%02.01f',minACI_val)); 
    median_title = strcat(filelist(n_file_median,:),' ACI=', sprintf('%02.01f',medianACI_val)); 
    max_title = strcat(filelist(n_file_max,:),' ACI=', sprintf('%02.01f',maxACI_val)); 
  
    % plotting
    h=figure('visible','off','Position',[500 900 1000 1300]);
    %figure; 
    subplot(3,1,1); 
    imagesc(T_min,F_min,10*log10(Pxx_min(:,:)));set(gca,'FontSize',12);   
    ylim([100 2000]); caxis([25 85]); colorbar("eastoutside"); 
    axis xy; xlabel('Time (sec)');ylabel('Frequency (Hz)');
    title(min_title);
    
    subplot(3,1,2); 
    imagesc(T_median,F_median,10*log10(Pxx_median(:,:)));set(gca,'FontSize',12);   
    ylim([100 2000]); caxis([25 85]); colorbar("eastoutside"); 
    axis xy; xlabel('Time (sec)');ylabel('Frequency (Hz)');
    title(median_title);
    
    subplot(3,1,3); 
    imagesc(T_max,F_max,10*log10(Pxx_max(:,:)));set(gca,'FontSize',12);   
    ylim([100 2000]); caxis([25 85]); colorbar("eastoutside"); 
    axis xy; xlabel('Time (sec)'); ylabel('Frequency (Hz)');
    title(max_title);
    
    figtitle = strcat(Site, '-D',sprintf('%01.0f',Deployment));
    mtit(figtitle, 'xoff',-0.5);
    
    out_img_name=strcat(DirOut,'ACI1024_',Site, '_D',sprintf('%02.0f',Deployment),'.png' ); 
    saveas(h,out_img_name);
        
end
>>>>>>> d69924ce5234437194dd03e3a9ca0fe3c6728deb
close all