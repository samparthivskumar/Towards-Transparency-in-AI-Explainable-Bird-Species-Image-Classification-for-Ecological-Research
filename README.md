# Towards Transparency in AI: Explainable Bird Species Image Classification for Ecological Research
**Description**

Explainable Artificial Intelligence (XAI) is a growing field that aims to make AI models easier to understand and more transparent. This is especially important in areas like agriculture, healthcare, and environmental science, where AI decisions can have serious consequences for safety, ethics, and people's well-being. XAI helps by explaining how complex models, such as deep neural networks, make their predictions. This builds trust between users and AI systems, making it easier for people to rely on these technologies.

In the context of image classification, XAI tools offer intuitive visualizations that highlight the regions or features of an image that the model considers important when making predictions. For example, in the task of recognizing bird species, explainable models can identify and emphasize specific visual characteristics, such as the bird beak shape, demonstrating that the models decisions are grounded in relevant and logical features rather than noise or irrelevant data.

When evaluating different models, it is not sufficient to rely on accuracy metrics alone. While accuracy provides a measure of how often a model makes correct predictions, XAI visualizations give us critical insight into why a model makes those predictions. Understanding this reasoning process is key to ensuring that models align with human expectations and focus on meaningful features. Models that consistently focus on relevant features are more dependable, reducing the likelihood of errors or biases in critical applications.

However, qualitative analysis of XAI visualizations, which typically involves subjective human interpretation of visual outputs can be inconsistent and difficult to scale. A quantitative approach to analyzing these visualizations provides an objective and scalable framework for evaluating models. By automating the assessment process, large datasets and complex models can be systematically examined, enabling a more thorough and unbiased evaluation.

Our study introduces a quantitative approach to evaluating XAI models. This involves a three-step process: first, measuring the accuracy of each pretrained model to establish its prediction performance; second, assessing feature relevance using LIME to determine whether the model correctly identifies the key features influencing its decisions; and finally, using IoU scores to compare the LIME-generated explanations with the ground-truth regions of interest. By combining these findings accuracy, LIME-based feature relevance, and IoU scores—we comprehensively evaluate the model’s overall performance and explanation quality. This methodology ensures that the models are both high-performing and transparent, essential for trust and successful deployment in real-world ecological applications.

**Purpose**

We developed MATLAB functions to create a quantitative evaluation framework for XAI methods, focusing on the classification performance and interpretability of deep learning models. This framework measures model accuracy, evaluates feature relevance using LIME, and calculates IoU scores for visual explanations. Designed for ease of use, the toolbox allows researchers to assess model transparency without extensive coding knowledge. It includes customizable metrics, automated analysis, and comprehensive tutorials to ensure consistent, scalable, and reproducible results for reliable XAI assessments in various applications.

**1. Installation Instructions**
1. Clone or download the Matlallb repository from GitHub (replace with the actual URL).
2. Open MATLAB.
3. Add the folder to your MATLAB path
4. Install_matlallb_dependencies
5. Verify the installation by checking the version
6. Refer to the documentation and examples in the Matlallb directory to get started.

**2. Features**

Here are the features provided by each script:
1. Accuracy Measurement: Calculate the classification accuracy of each model to assess its overall prediction performance on the bird species dataset.
2. LIME-based Feature Relevance: Use Local Interpretable Model-Agnostic Explanations (LIME) to generate visual explanations for each model’s predictions, identifying the key image features influencing those decisions.
3. IoU Calculation: Compute Intersection over Union (IoU) scores to quantitatively compare the LIME-generated visual explanations with ground-truth regions of interest, ensuring that the models are focusing on relevant features.

**3. Dependies**

Dependencies for Matlallb
1. MATLAB: Ensure you have MATLAB R2021a or later installed.

2. Deep Learning Toolbox: Required for working with neural networks and deep learning models.

3. Computer Vision Toolbox (optional): This toolbox is useful for image processing tasks, but it is not strictly necessary if you are only using basic functionalities.

4. Parallel Computing Toolbox (optional): If you intend to run computations in parallel for improved performance.

5. MATLAB Coder (optional): Required if you wish to generate C/C++ code from your MATLAB code.
   
**4. Instructions for Training and Evaluating a Deep Learning Model**

**Step 1: Prepare Your Dataset**
1. Load the Dataset:

- Ensure that your dataset is organized, with images placed in separate folders according to their respective classes. Each folder name should correspond to the class label of the images it contains.
2. Split the Dataset:

- Divide the dataset into training and validation sets. A common approach is to use 80% of the data for training and 20% for validation. Randomly shuffle the dataset to ensure a good mix of classes in both sets.
  
**Step 2: Define and Train the Deep Learning Model**
1. Choose a Pretrained Model:

- Select a pretrained model suitable for your classification task, such as EfficientNet, ResNet, or Inception. These models have been trained on large datasets and can be fine-tuned for specific tasks.
  
3. Modify the Model:

- Adjust the final layers of the pretrained model to fit the number of classes in your dataset. This typically involves replacing the last fully connected layer with a new layer that matches the number of classes in your training set, followed by a classification layer.
  
3. Set Training Options:

- Define the training options, including the optimization algorithm (e.g., Adam), mini-batch size, maximum number of epochs, initial learning rate, and validation data. These parameters help control the training process and ensure the model learns effectively.
  
4. Train the Model:

- Start the training process using your training data and the defined training options. Monitor the training progress and validation performance to ensure that the model is learning appropriately.
  
**Step 3: Evaluate Model Accuracy**
1. Predict on Validation Set:

- Once the model is trained, use it to predict classes for the images in the validation set. This will give you the model's output labels for the validation data.
  
2. Calculate Accuracy:

- Compare the predicted labels to the actual labels from the validation set. Calculate the accuracy by determining the percentage of correct predictions relative to the total number of predictions made.
  
**Step 4: Evaluate Feature Relevance Using LIME**

1. Install and Load LIME Library:

- Make sure that the LIME library is set up and accessible in your MATLAB environment. This library is used for generating interpretable explanations of model predictions.
  
2. Generate LIME Explanations:

- Select a specific image from the validation set to analyze. Use LIME to generate an explanation for the model's prediction on this image. This will provide insights into which features of the image the model relied on to make its prediction.
  
3. Visualize LIME Explanation:

- Create a visualization of the LIME explanation, overlaying the important features identified by LIME onto the original image. This helps in understanding how the model interprets the input data.
  
**Step 5: Calculate IoU Score**

1. Define Ground Truth Regions:

- Specify the ground truth mask or bounding box for the selected image. This is the reference against which you will compare the model's predictions.
  
2. Calculate IoU:

- Use the predicted mask generated from the LIME explanation and compare it to the ground truth mask. The IoU score is calculated as the area of intersection between the predicted mask and the ground truth mask divided by the area of their union. This metric helps assess how accurately the model's explanation aligns with the actual important features in the image.
  
**Step 6: Save the Model (Optional)**

1. Save the Trained Model:
- After training and evaluation, save the trained model for future use. This allows you to reuse the model without needing to retrain it.

**Authors**
1. Hari Kishan Kondaveeti, Ph.D
2. Samparthi V S Kumar (Ph.D)
