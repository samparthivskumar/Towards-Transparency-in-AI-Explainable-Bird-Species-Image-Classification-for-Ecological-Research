% Load the trained network into the variable 'net'
net = Trained_Network;

% Read the input image from the specified file path
X = imread("C:\Users\P2.jpg");

% Resize the image to match the input size of the network's first layer
inputSize = net.Layers(1).InputSize(1:2);
X = imresize(X, inputSize);

% Classify the image using the trained network
label = classify(net, X);  % Get the predicted label
disp(['class name:', char(label)]);  % Display the predicted class name

% Generate LIME (Local Interpretable Model-agnostic Explanations) for the image
[scoreMap, featureMap, featureImportance] = imageLIME(net, X, label, ... 
    'Segmentation', 'superpixels', ...  % Use superpixels for segmentation
    'NumFeatures', 64, ...  % Number of superpixel regions to analyze
    'NumSamples', 3072);  % Number of samples to generate for LIME explanations

% Different values of 'numTopFeatures' (number of important features to highlight)
numTopFeatures_values = [6, 8, 10, 12];

% Specify the folder path to save the generated figures
savePath = 'C:\Users\BW\';

% Loop through each value of 'numTopFeatures'
for i = 1:length(numTopFeatures_values)
    % Set the current value of 'numTopFeatures'
    numTopFeatures = numTopFeatures_values(i);
    
    % Display the original image with LIME heatmap overlay
    figure;  % Create a new figure window
    imshow(X);  % Display the original input image
    hold on;  % Keep the image open to overlay additional elements
    imagesc(scoreMap, 'AlphaData', 0.5);  % Overlay the LIME score map with transparency
    colormap jet;  % Apply a 'jet' colormap (for color representation)
    colorbar;  % Display a colorbar showing the score scale

    % Save the heatmap figure as a PDF with the current 'numTopFeatures' value
    figName = sprintf('%sEFF_P22_%dHM.pdf', savePath, numTopFeatures);
    saveas(gcf, figName);  % Save the current figure to the specified path

    % Find the top 'numTopFeatures' most important feature regions
    [~, idx] = maxk(featureImportance, numTopFeatures);  % Get indices of the top features

    % Create a mask that highlights only the top features in the image
    mask = ismember(featureMap, idx);  % Create a binary mask with top features
    maskedImg = uint8(mask) .* X;  % Apply the mask to the original image

    % Display the masked image showing the top features
    figure;  % Create a new figure window
    imshow(maskedImg);  % Display the masked image
    title(['Top ', num2str(numTopFeatures), ' features']);  % Add a title indicating the number of top features

    % Save the masked feature image as a PDF
    figName = sprintf('%sEFF_P22_F%d.pdf', savePath, numTopFeatures);
    saveas(gcf, figName);  % Save the figure to the specified path
end
