% script for setting up and attempting to train a classification network
% for the estuarine sounds images
%
% second version (full res) uses a very simple & not deep network; achieves ~84-89% on
% the validation sample
% source:
% https://www.mathworks.com/help/deeplearning/gs/create-simple-deep-learning-classification-network.html

% clear workspace
clear
out=[];
for pass=1:6 % create, train and test a net 6 times to see which images consistently create problems
    % create image datastore
    imds=imageDatastore('test_specs_224','includesubfolders',true,'labelsource','foldernames');
    [imds1,imds2] = splitEachLabel(imds,0.8,'randomized'); % 0.5 split initially, 0.8 later

    % number of categories
    numClasses=numel(unique(imds.Labels));

    % try a simple network
    inputSize = [168 224 3]; % could maybe get rid of color?

    layers = [
        imageInputLayer(inputSize)
        convolution2dLayer(5,20)
        batchNormalizationLayer
        reluLayer
        fullyConnectedLayer(numClasses)
        softmaxLayer
        classificationLayer];

    % training options
    maxEpochs = 12;
    epochIntervals = 1;
    initLearningRate = 1e-5;
    learningRateFactor = 0.1;
    l2reg = 0.0001;
    options3 = trainingOptions('adam', ...
        'ValidationFrequency',10,...
        'ValidationData',imds2,...
        'InitialLearnRate',initLearningRate, ...
        'LearnRateSchedule','piecewise', ...
        'LearnRateDropPeriod',10, ...
        'LearnRateDropFactor',learningRateFactor, ...
        'L2Regularization',l2reg, ...
        'MaxEpochs',maxEpochs ,...
        'MiniBatchSize',40, ...
        'GradientThresholdMethod','l2norm', ...
        'Plots','training-progress', ...
        'ExecutionEnvironment','auto', ... % 'auto' most of the time except for testing
        'GradientThreshold',0.01,'shuffle','never',...
        'Plots','none'); % turn off the fancy plot window


    % train that network!
    net = trainNetwork(imds1,layers,options3);

    % classify all outputs
    ts={'low_f_unk_purr_knocks' 'silverPerch' 'spottedSeatrout'  'spottedSeatroutSilverPerch'  'waterNoise'};
    cnt=1;
    for i=1:numel(ts)
        d=dir(['test_specs_224',filesep,ts{i},filesep,'*jpg']); % list all jpegs
        for j=1:numel(d)
            img=imread(['test_specs_224',filesep,ts{i},filesep,d(j).name]);
            [l,s]=classify(net,img);
            idx=find(s==max(s));
            out(cnt,:,pass)=[i,j,idx(1),s(idx(1))];
            cnt=cnt+1;
            fprintf('.')
        end
        fprintf('\n')
    end
    save myWork_pass3
    clear net

end

% image list
il={};
cnt=1;
for i=1:numel(ts)
  d=dir(['test_specs_224',filesep,ts{i},filesep,'*jpg']); % list all jpegs
  for j=1:numel(d)
    il{cnt,1}=([ts{i},filesep,d(j).name]);
    cnt=cnt+1;
  end
end

% find miss-classifications
for i=1:size(out,3)
  foo(:,i)=out(:,1,i)-out(:,3,i);
end
foo2=sum(foo~=0,2);

idx=find(foo2>0);
mc=[];
for i=1:numel(idx)
  mc{i,1}=il{idx(i),1};
  mc{i,2}=foo2(idx(i),1);
end

% write out report
fid=fopen(['miss_classifications_3_',datestr(now,'yyyy-mm-dd-HH-MM'),'.csv'],'w');
for i=1:size(mc,1)
  fprintf(fid,'%s,%.0f\n',mc{i,1},mc{i,2});
end
fclose(fid);


%% Attempting my own code to classify unlabelled images using trained network

clear
% Load network
load('myWork_pass3.mat');
clearvars -except net

% Classify unlabelled images
    cnt=1;
    labels = [];
        d=dir(['unlabelled_test',filesep,'*jpg']); % list all jpegs in folder
        for j=1:numel(d)
            img=imread(['unlabelled_test',filesep,d(j).name]); %load image
            [l,s]=classify(net,img); % classify image: l=label, s=scores
            labels = [labels;l];
            idx=find(s==max(s)); % finds max score
            out(cnt,:)=[j,idx(1),s(idx(1))]; % count, label index, score
            cnt=cnt+1;
            fprintf('.')
        end
        fprintf('\n')
    
        site = "M1";
    save test_classify_T1.mat
    
        