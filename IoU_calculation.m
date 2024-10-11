% List of image names in the ground truth folder
image_names_A = {'A1GT.jpg', 'A2GT.jpg'};

% List of image names in the model extracted features folder
image_names_B = {'BW_SqueezeNet_A1_F16.jpg','BW_SqueezeNet_A2_F16.jpg'};

% Initialize total IoU value for accumulation
total_iou = 0;

% Loop through each pair of images
for i = 1:length(image_names_A)
    % Read the ground truth image (A) from the specified folder path
    path_A = fullfile('D:\Users\Ground truth\', image_names_A{i});
    A = imread(path_A);  % Read the image
    I1 = im2gray(A);  % Convert the image to grayscale
    BW1 = imresize(im2bw(I1, 0.1), [200, 200]);  % Binarize and resize the image to 200x200 pixels
    
    % Read the corresponding model extracted feature image (B) from the specified folder path
    path_B = fullfile('C:\Users\Model_extracted_features\', image_names_B{i});
    B = imread(path_B);  % Read the image
    I2 = im2gray(B);  % Convert the image to grayscale
    BW2 = imresize(im2bw(I2, 0.1), [200, 200]);  % Binarize and resize the image to 200x200 pixels

    % Calculate the Intersection over Union (IoU) for this image pair
    intersection = BW1 & BW2;  % Logical AND operation to find the intersection (common areas)
    union = BW1 | BW2;  % Logical OR operation to find the union (all areas combined)
    iou = nnz(intersection) / nnz(union);  % Calculate IoU by dividing the number of intersecting pixels by union pixels
    
    % Accumulate the IoU value
    total_iou = total_iou + iou;
end

% Calculate the average IoU across all image pairs
average_iou = total_iou / length(image_names_A);

% Display the average IoU value
disp(['Average IoU: ' num2str(average_iou)]);
