# XAI-visualization-using-IoU-metric
**Description**

Explainable Artificial Intelligence (XAI) is an evolving field focused on making AI models more interpretable and transparent. This is particularly significant in domains like agriculture, healthcare, and environmental science, where the outcomes of AI-driven decisions can directly impact critical aspects like safety, ethics, and human well-being. By providing insight into how complex models, especially deep neural networks, arrive at their predictions, XAI fosters a deeper level of trust between users and AI systems.

In the context of image classification, XAI tools offer intuitive visualizations that highlight the regions or features of an image that the model considers important when making predictions. For example, in the task of recognizing bird species, explainable models can identify and emphasize specific visual characteristics, such as the bird beak shape, demonstrating that the models decisions are grounded in relevant and logical features rather than noise or irrelevant data.

When evaluating different models, it is not sufficient to rely on accuracy metrics alone. While accuracy provides a measure of how often a model makes correct predictions, XAI visualizations give us critical insight into why a model makes those predictions. Understanding this reasoning process is key to ensuring that models align with human expectations and focus on meaningful features. Models that consistently focus on relevant features are more dependable, reducing the likelihood of errors or biases in critical applications.

However, qualitative analysis of XAI visualizations, which typically involves subjective human interpretation of visual outputs can be inconsistent and difficult to scale. A quantitative approach to analyzing these visualizations provides an objective and scalable framework for evaluating models. By automating the assessment process, large datasets and complex models can be systematically examined, enabling a more thorough and unbiased evaluation.

Our study introduces a quantitative approach to evaluating XAI models. This involves a three-step process: first, measuring the accuracy of each pretrained model to establish its prediction performance; second, assessing feature relevance using LIME to determine whether the model correctly identifies the key features influencing its decisions; and finally, using IoU scores to compare the LIME-generated explanations with the ground-truth regions of interest. By combining these findings—accuracy, LIME-based feature relevance, and IoU scores—we comprehensively evaluate the model’s overall performance and explanation quality. This methodology ensures that the models are both high-performing and transparent, essential for trust and successful deployment in real-world ecological applications.

**Purpose**

We developed MATLAB functions to create a quantitative evaluation framework for XAI methods, focusing on the classification performance and interpretability of deep learning models. This framework measures model accuracy, evaluates feature relevance using LIME, and calculates IoU scores for visual explanations. Designed for ease of use, the toolbox allows researchers to assess model transparency without extensive coding knowledge. It includes customizable metrics, automated analysis, and comprehensive tutorials to ensure consistent, scalable, and reproducible results for reliable XAI assessments in various applications.

**1. Installation Instructions**
1. Clone or download the Matlallb repository from GitHub (replace with the actual URL).
2. Open MATLAB.
3. Add the folder to your MATLAB path
4. Install_matlallb_dependencies
5. Verify the installation by checking the version
6. Refer to the documentation and examples in the Matlallb directory to get started.

**2.Features**

Here are the features provided by each script:
1. Accuracy Measurement: Calculate the classification accuracy of each model to assess its overall prediction performance on the bird species dataset.
2. LIME-based Feature Relevance: Use Local Interpretable Model-Agnostic Explanations (LIME) to generate visual explanations for each model’s predictions, identifying the key image features influencing those decisions.
3. IoU Calculation: Compute Intersection over Union (IoU) scores to quantitatively compare the LIME-generated visual explanations with ground-truth regions of interest, ensuring that the models are focusing on relevant features.

3. **Dependies**

Dependencies for Matlallb
1. MATLAB: Ensure you have MATLAB R2021a or later installed.

2. Deep Learning Toolbox: Required for working with neural networks and deep learning models.

3. Computer Vision Toolbox (optional): This toolbox is useful for image processing tasks, but it is not strictly necessary if you are only using basic functionalities.

4. Parallel Computing Toolbox (optional): If you intend to run computations in parallel for improved performance.

5. MATLAB Coder (optional): Required if you wish to generate C/C++ code from your MATLAB code.
   
4. **Instructions for Training and Evaluating a Deep Learning Model**

**Step 1: Prepare Your Dataset**

1. Load the Dataset:

   - Ensure your dataset is organized (e.g., images in folders based on their classes).
   - Load the dataset into MATLAB 

2. Split the Dataset:

   - Divide your dataset into training and validation sets

**Step 2: Define the Deep Learning Model**
1. Choose a Pretrained Model:

   - Select a suitable pretrained model from the available options (e.g., ResNet, EfficientNet).
   - Load the model, modifying the final layers for your classification task
2.  Set Training Options:
     - Define training options (e.g., learning rate, batch size)
