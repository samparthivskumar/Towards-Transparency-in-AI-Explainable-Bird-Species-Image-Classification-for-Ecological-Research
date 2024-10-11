% Clear command window, close all figures, and clear workspace variables
clc; close all; clear;

% Load the dataset of bird images from a folder. Images are labeled based on folder names.
Dataset = imageDatastore('D:\Birds_Dataset', 'IncludeSubfolders', true, 'LabelSource', 'foldernames'); 

% Split the dataset into 60% training data and 40% validation data randomly
[Training_Data, Validation_Data] = splitEachLabel(Dataset, 0.6, 'randomized');

% Get the number of images in the training data
numTrainImages = numel(Training_Data.Labels);

% Randomly select 16 images from the training set for visualization
idx = randperm(numTrainImages, 16);
figure
for i = 1:16
    subplot(4,4,i)  % Create a 4x4 grid of subplots
    I = readimage(Training_Data, idx(i));  % Read the selected image
    imshow(I)  % Display the image
end

% Load a pre-trained EfficientNet-B0 model
net = efficientnetb0;

% Convert the network into a layer graph to modify layers
lgraph = layerGraph(net);
clear net;  % Clear the original network variable

% Count the number of categories (bird species) in the training data
numClasses = numel(categories(Training_Data.Labels));

% Create a new fully connected layer (learnable layer) for the number of classes (bird species)
newLearnableLayer = fullyConnectedLayer(numClasses, ...
    'Name', 'new_fc', ...  % Name the new layer
    'WeightLearnRateFactor', 30, ...  % Set higher learning rate for faster training
    'BiasLearnRateFactor', 30);  % Higher learning rate for bias as well

% Replace the original fully connected layer with the new layer
lgraph = replaceLayer(lgraph, 'efficientnet-b0|model|head|dense|MatMul', newLearnableLayer);

% Create a new softmax layer (converts outputs to probabilities)
newsoftmaxLayer = softmaxLayer('Name', 'new_softmax');
lgraph = replaceLayer(lgraph, 'Softmax', newsoftmaxLayer);

% Create a new classification output layer for the number of classes
newClassLayer = classificationLayer('Name', 'new_classoutput');
lgraph = replaceLayer(lgraph, 'classification', newClassLayer);

% Data augmentation (optional, commented out). Helps in improving model generalization.
% pixelRange = [-30 30];  % Random translation range in pixels for augmentation
% imageAugmenter = imageDataAugmenter( ...
%     'RandXReflection', true, ...  % Randomly reflect images on X-axis
%     'RandXTranslation', pixelRange, ...  % Random X translation
%     'RandYTranslation', pixelRange);  % Random Y translation

% Resize training and validation data images to 224x224 pixels (input size required by EfficientNet-B0)
Resized_Training_Data = augmentedImageDatastore([224 224], Training_Data);
Resized_Validation_Data = augmentedImageDatastore([224 224], Validation_Data);

% Set training options for the network
Training_Options = trainingOptions('adam', ...
    'MiniBatchSize', 32,  ...  % Batch size of 32 images
    'MaxEpochs', 30, ...  % Train for 30 epochs
    "InitialLearnRate", 1e-4, ...  % Set initial learning rate
    'Shuffle', 'every-epoch', ...  % Shuffle data every epoch
    'ValidationData', Resized_Validation_Data, ...  % Use validation data for checking performance
    'ValidationFrequency', 30, ...  % Validate every 30 iterations
    "ExecutionEnvironment", "gpu", ...  % Use GPU for faster training
    'Plots', 'training-progress', ...  % Display training progress plot
    'Verbose', false);  % Suppress detailed output

% Train the network with the resized training data and the modified layer graph
Trained_Network = trainNetwork(Resized_Training_Data, lgraph, Training_Options);

% Save the trained model to a .mat file
save('Bird_species_efficientnetb060.mat', 'Trained_Network');

% Classify the validation data using the trained network
YPred = classify(Trained_Network, Resized_Validation_Data);

% Display the confusion chart for predicted vs actual labels of the validation data
confusionchart(Validation_Data.Labels, YPred);
title('Efficientnetb0');

% Plot the confusion matrix for further analysis
figure, plotconfusion(Validation_Data.Labels, YPred);
title('Confusion Matrix: Efficientnetb0');

% Calculate the confusion matrix
cm = confusionmat(Validation_Data.Labels, YPred);

% Initialize arrays to store accuracy, precision, recall, and F1-score for each class
for i = 1:length(cm)
    TP = cm(i,i);  % True Positives
    TN = sum(cm(:)) - sum(cm(:,i)) - sum(cm(i,:)) + cm(i,i);  % True Negatives
    FP = sum(cm(:,i)) - cm(i,i);  % False Positives
    FN = sum(cm(i,:)) - cm(i,i);  % False Negatives
    
    % Calculate accuracy, precision, recall, and F1-score for each class
    Acc(i) = (TP + TN) / (TP + TN + FP + FN);
    Precision(i) = TP / (TP + FP);
    Recall(i) = TP / (TP + FN);
    F1_score(i) = 2 * TP / (2 * TP + FP + FN);
end

% Display performance metrics (mean of all classes)
disp('Accuracy ....');
sprintf('The Acc is : %2f', mean(Acc))
disp('Precision ....');
sprintf('The Precision is : %2f', mean(Precision))
disp('Recall ....');
sprintf('The Recall is : %2f', mean(Recall))
disp('F1-score ....');
sprintf('The F1-score is : %2f', mean(F1_score))
