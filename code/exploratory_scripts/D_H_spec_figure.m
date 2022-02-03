<<<<<<< HEAD
% script to loop through all sites and identify multiple H values
% and plot with their appropriate spectogram


clear

dir2process = readtable('prep_analysis/dir2calcH.xlsx');
load("pmHT_cells_09-17.mat");
load("trimmed_results_indices_09-17.mat");
load("metric_matfiles\H1024_lowcells.mat");

for k=1:size(dir2process,1)
    
    Site=char(dir2process.Site(k));   
    DirIn =char(dir2process.DirIn(k));             
    DirOut=char(dir2process.DirOut(k)); 
    Deployment=dir2process.Deployment(k);
    FS=dir2process.FS(k);
    nsec=dir2process.nsec(k); 
    cal=10^(dir2process.gain(k)/20);  
    NFFT = 2^10; %set equal to the NFFT used in H calc
    
    % generate file list, file names and diretories 
    if exist(DirOut,'dir') ~= 1; eval(['system(''mkdir '  DirOut ''')']); end %  make output directory if it does not exist 
    
    FILES=dir(strcat(DirIn,'*wav')); % list all the wav files in a directory 
    filelist=cat(1,FILES.name); 
    
    % find min, max, and median H
    minH = find(H1024_low{k} == min(H1024_low{k})); 
    [~,medianH] = min(abs(H1024_low{k}-median(H1024_low{k})));
    %medianH = find(H1024_low{k} == median(H1024_low{k})); %
    %doesn't work on even lengthed datasets
    maxH = find(H1024_low{k} == max(H1024_low{k}));
    
    minH_val = min(H1024_low{k});
    medianH_val = H1024_low{k}(medianH);
    %medianH_val = median(H1024_low{k});
    maxH_val = max(H1024_low{k});
    
    % find position in directory of min, max, median H
    n_file_min = (index1(k)+pmHT{k}(minH))-1;
    n_file_median = (index1(k)+pmHT{k}(medianH))-1;
    n_file_max = (index1(k)+pmHT{k}(maxH))-1;

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
    min_title = strcat(filelist(n_file_min,:),' H=', sprintf('%02.01f',minH_val)); 
    median_title = strcat(filelist(n_file_median,:),' H=', sprintf('%02.01f',medianH_val)); 
    max_title = strcat(filelist(n_file_max,:),' H=', sprintf('%02.01f',maxH_val)); 
  
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
    
    out_img_name=strcat(DirOut,'H1024_',Site, '_D',sprintf('%02.0f',Deployment),'.png' ); 
    saveas(h,out_img_name);
        
end
=======
% script to loop through all sites and identify multiple H values
% and plot with their appropriate spectogram


clear

dir2process = readtable('prep_analysis/dir2calcH.xlsx');
load("pmHT_cells_09-17.mat");
load("trimmed_results_indices_09-17.mat");
load("metric_matfiles\H1024_lowcells.mat");

for k=1:size(dir2process,1)
    
    Site=char(dir2process.Site(k));   
    DirIn =char(dir2process.DirIn(k));             
    DirOut=char(dir2process.DirOut(k)); 
    Deployment=dir2process.Deployment(k);
    FS=dir2process.FS(k);
    nsec=dir2process.nsec(k); 
    cal=10^(dir2process.gain(k)/20);  
    NFFT = 2^10; %set equal to the NFFT used in H calc
    
    % generate file list, file names and diretories 
    if exist(DirOut,'dir') ~= 1; eval(['system(''mkdir '  DirOut ''')']); end %  make output directory if it does not exist 
    
    FILES=dir(strcat(DirIn,'*wav')); % list all the wav files in a directory 
    filelist=cat(1,FILES.name); 
    
    % find min, max, and median H
    minH = find(H1024_low{k} == min(H1024_low{k})); 
    [~,medianH] = min(abs(H1024_low{k}-median(H1024_low{k})));
    %medianH = find(H1024_low{k} == median(H1024_low{k})); %
    %doesn't work on even lengthed datasets
    maxH = find(H1024_low{k} == max(H1024_low{k}));
    
    minH_val = min(H1024_low{k});
    medianH_val = H1024_low{k}(medianH);
    %medianH_val = median(H1024_low{k});
    maxH_val = max(H1024_low{k});
    
    % find position in directory of min, max, median H
    n_file_min = (index1(k)+pmHT{k}(minH))-1;
    n_file_median = (index1(k)+pmHT{k}(medianH))-1;
    n_file_max = (index1(k)+pmHT{k}(maxH))-1;

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
    min_title = strcat(filelist(n_file_min,:),' H=', sprintf('%02.01f',minH_val)); 
    median_title = strcat(filelist(n_file_median,:),' H=', sprintf('%02.01f',medianH_val)); 
    max_title = strcat(filelist(n_file_max,:),' H=', sprintf('%02.01f',maxH_val)); 
  
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
    
    out_img_name=strcat(DirOut,'H1024_',Site, '_D',sprintf('%02.0f',Deployment),'.png' ); 
    saveas(h,out_img_name);
        
end
>>>>>>> d69924ce5234437194dd03e3a9ca0fe3c6728deb
close all