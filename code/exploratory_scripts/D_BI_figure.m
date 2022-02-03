<<<<<<< HEAD
% trial script to loop through all sites and identify multiple ACI values
% and plot with their appropriate spectogram


clear

dir2process = readtable('prep_analysis/dir2calcACI.xlsx');
load("pmHT_cells_09-17.mat");
%load("trimmed_results_indices_09-17.mat");
load("metric_matfiles\bioacoustic_indices_04-21.mat");

for k=1:size(pmHT_poavg,2)
    
    Site=char(dir2process.Site(k));   
    DirIn =char(dir2process.DirIn(k));             
    DirOut=char(dir2process.DirOut(k)); 
    Deployment=dir2process.Deployment(k);
    %FS=dir2process.FS(k);
    %nsec=dir2process.nsec(k); 
    %cal=10^(dir2process.gain(k)/20);  
    %NFFT = 2^10; %set equal to the NFFT used in ACI calc
    
    % generate file list, file names and diretories 
    %if exist(DirOut,'dir') ~= 1; eval(['system(''mkdir '  DirOut ''')']); end %  make output directory if it does not exist 
    
    %FILES=dir(strcat(DirIn,'*wav')); % list all the wav files in a directory 
    %filelist=cat(1,FILES.name); 
    
    % find min, max, and median ACI
    minBI = find(bioacousticIndex_lowInd{k} == min(bioacousticIndex_lowInd{k})); 
    [~,medianBI] = min(abs(bioacousticIndex_lowInd{k}-median(bioacousticIndex_lowInd{k})));
    %medianACI = find(ACI1024_lowpmHT{k} == median(ACI1024_lowpmHT{k})); %
    %doesn't work on even lengthed datasets
    maxBI = find(bioacousticIndex_lowInd{k} == max(bioacousticIndex_lowInd{k}));
    
    minBI_val = min(bioacousticIndex_lowInd{k});
    medianBI_val = bioacousticIndex_lowInd{k}(medianBI);
    %medianACI_val = median(ACI1024_lowpmHT{k});
    maxBI_val = max(bioacousticIndex_lowInd{k});
    
    % index correct poavg and standardize to the minimum
    thispoavg = pmHT_poavg{k};
    
    min_poavg = 10*log10(thispoavg(flim_low,minBI));
    min_poavgstd = min_poavg-min(min_poavg);
    
    median_poavg = 10*log10(thispoavg(flim_low,medianBI));
    median_poavgstd = median_poavg-min(median_poavg);
    
    max_poavg = 10*log10(thispoavg(flim_low,maxBI));
    max_poavgstd = max_poavg-min(max_poavg);
    
    % titles and labels
    min_title = strcat('BI=', sprintf('%02.01f',minBI_val)); 
    median_title = strcat('BI=', sprintf('%02.01f',medianBI_val)); 
    max_title = strcat('BI=', sprintf('%02.01f',maxBI_val)); 
  
    % plotting
    h=figure('visible','on','Position',[500 900 1000 1300]);
    %figure; 
    subplot(3,1,1); 
    plot(f(flim_low), min_poavgstd); 
    xlabel('Frequency (Hz)');ylabel('PSD (dB re 1 uPa^2/Hz)');
    title(min_title);
    
    subplot(3,1,2); 
    plot(f(flim_low), median_poavgstd); 
    xlabel('Frequency (Hz)');ylabel('PSD (dB re 1 uPa^2/Hz)');
    title(median_title);
    
    subplot(3,1,3); 
    plot(f(flim_low), max_poavgstd); 
    xlabel('Frequency (Hz)');ylabel('PSD (dB re 1 uPa^2/Hz)');
    title(max_title);
    
    figtitle = strcat(Site, '-D',sprintf('%01.0f',Deployment));
    mtit(figtitle, 'xoff',-0.5);
    
    out_img_name=strcat(DirOut,'BI_',Site, '_D',sprintf('%02.0f',Deployment),'.png' ); 
    saveas(h,out_img_name);
        
end
=======
% trial script to loop through all sites and identify multiple ACI values
% and plot with their appropriate spectogram


clear

dir2process = readtable('prep_analysis/dir2calcACI.xlsx');
load("pmHT_cells_09-17.mat");
%load("trimmed_results_indices_09-17.mat");
load("metric_matfiles\bioacoustic_indices_04-21.mat");

for k=1:size(pmHT_poavg,2)
    
    Site=char(dir2process.Site(k));   
    DirIn =char(dir2process.DirIn(k));             
    DirOut=char(dir2process.DirOut(k)); 
    Deployment=dir2process.Deployment(k);
    %FS=dir2process.FS(k);
    %nsec=dir2process.nsec(k); 
    %cal=10^(dir2process.gain(k)/20);  
    %NFFT = 2^10; %set equal to the NFFT used in ACI calc
    
    % generate file list, file names and diretories 
    %if exist(DirOut,'dir') ~= 1; eval(['system(''mkdir '  DirOut ''')']); end %  make output directory if it does not exist 
    
    %FILES=dir(strcat(DirIn,'*wav')); % list all the wav files in a directory 
    %filelist=cat(1,FILES.name); 
    
    % find min, max, and median ACI
    minBI = find(bioacousticIndex_lowInd{k} == min(bioacousticIndex_lowInd{k})); 
    [~,medianBI] = min(abs(bioacousticIndex_lowInd{k}-median(bioacousticIndex_lowInd{k})));
    %medianACI = find(ACI1024_lowpmHT{k} == median(ACI1024_lowpmHT{k})); %
    %doesn't work on even lengthed datasets
    maxBI = find(bioacousticIndex_lowInd{k} == max(bioacousticIndex_lowInd{k}));
    
    minBI_val = min(bioacousticIndex_lowInd{k});
    medianBI_val = bioacousticIndex_lowInd{k}(medianBI);
    %medianACI_val = median(ACI1024_lowpmHT{k});
    maxBI_val = max(bioacousticIndex_lowInd{k});
    
    % index correct poavg and standardize to the minimum
    thispoavg = pmHT_poavg{k};
    
    min_poavg = 10*log10(thispoavg(flim_low,minBI));
    min_poavgstd = min_poavg-min(min_poavg);
    
    median_poavg = 10*log10(thispoavg(flim_low,medianBI));
    median_poavgstd = median_poavg-min(median_poavg);
    
    max_poavg = 10*log10(thispoavg(flim_low,maxBI));
    max_poavgstd = max_poavg-min(max_poavg);
    
    % titles and labels
    min_title = strcat('BI=', sprintf('%02.01f',minBI_val)); 
    median_title = strcat('BI=', sprintf('%02.01f',medianBI_val)); 
    max_title = strcat('BI=', sprintf('%02.01f',maxBI_val)); 
  
    % plotting
    h=figure('visible','on','Position',[500 900 1000 1300]);
    %figure; 
    subplot(3,1,1); 
    plot(f(flim_low), min_poavgstd); 
    xlabel('Frequency (Hz)');ylabel('PSD (dB re 1 uPa^2/Hz)');
    title(min_title);
    
    subplot(3,1,2); 
    plot(f(flim_low), median_poavgstd); 
    xlabel('Frequency (Hz)');ylabel('PSD (dB re 1 uPa^2/Hz)');
    title(median_title);
    
    subplot(3,1,3); 
    plot(f(flim_low), max_poavgstd); 
    xlabel('Frequency (Hz)');ylabel('PSD (dB re 1 uPa^2/Hz)');
    title(max_title);
    
    figtitle = strcat(Site, '-D',sprintf('%01.0f',Deployment));
    mtit(figtitle, 'xoff',-0.5);
    
    out_img_name=strcat(DirOut,'BI_',Site, '_D',sprintf('%02.0f',Deployment),'.png' ); 
    saveas(h,out_img_name);
        
end
>>>>>>> d69924ce5234437194dd03e3a9ca0fe3c6728deb
close all