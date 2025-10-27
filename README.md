# MATLAB Code vs App: Emotion Analysis

A comprehensive comparison between manually coded MATLAB models and models generated using MATLAB's Classification Learner app for emotion analysis.

## 📋 Overview

This project demonstrates the differences in implementation, performance, and workflow between:

  - **Raw MATLAB Code**: A custom-written `fitctree` (Decision Tree) model.
  - **MATLAB Classification Learner App**: A GUI-based `Medium Tree` (Decision Tree) model.

The goal is to provide a direct, apples-to-apples performance benchmark on a high-dimensional dataset (**14,414 features**) which often poses a challenge for default script implementations.

## 🎯 Project Purpose

The goal is to analyze and compare both approaches for emotion classification tasks, helping researchers and developers understand:

  - **Performance (Speed)** differences between manual coding and app-based approaches.
  - **Accuracy & Reliability**: Whether both methods achieve the same result.
  - **Development Effort**: The trade-offs between coding flexibility and GUI efficiency.

## 🛠️ Technologies Used

  - **MATLAB** - Primary development environment
  - **Statistics and Machine Learning Toolbox**
  - **Text Analytics Toolbox** (For TF-IDF feature extraction)
  - **Classification Learner App**
  - **Decision Tree (`fitctree`)** - The algorithm used for the final, fair comparison.

## 🚀 Development Workflow & Stages

The project followed a structured development process to ensure a fair comparison.

1.  **Data Loading (`step1_data_loading.m`)**:

      * The raw `Combined Data.csv` (53,043 entries) was loaded into MATLAB.
      * Basic cleaning (removing missing values) was performed, resulting in 52,681 valid samples.

2.  **Preprocessing & Feature Extraction (`step2_text_preprocessing.m`)**:

      * Text data was processed using the Text Analytics Toolbox.
      * Steps included: tokenization, punctuation removal, stop-word removal, and normalization.
      * A **TF-IDF (Term Frequency-Inverse Document Frequency)** matrix was generated from the text.
      * This resulted in a high-dimensional feature matrix `X` of size `[52681 x 14414]`. The corresponding labels `Y` were also prepared.
      * These core variables (`X`, `Y`) were saved to `classification_data.mat` to ensure both methods used the *exact same* data.

3.  **Model Selection & Iteration (Raw Code)**:

      * **Attempt 1 (`SVM`)**: An `SVM` model was tested first. Due to the dataset's high dimensionality (14,414 features), the training time was impractical (over an hour without completing). Attempts to speed it up with `MaxIterations` failed due to version compatibility issues.
      * **Attempt 2 (`Naive Bayes`)**: `fitcnb` was tested. This also failed due to MATLAB version incompatibilities, specifically the inability to use the required `'multinomial'` distribution (which is standard for text data) or the `'normal'` distribution (which failed with zero-variance errors).
      * **Attempt 3 (`Decision Tree`)**: `fitctree` was chosen as the final algorithm. It proved to be **fast, robust, and compatible** with the available MATLAB version, making it the ideal candidate for the comparison.

4.  **Raw Code Analysis (`step3_model_training.m` & `step4...m`)**:

      * The `fitctree` model was trained on 100% of the `X` and `Y` data.
      * `tic` and `toc` commands were used to precisely measure the training and validation times.
      * A 5-fold cross-validation (`crossval`) was performed to get a reliable accuracy score.

5.  **App Analysis (`Classification Learner`)**:

      * The *exact same* `X` and `Y` variables were loaded into the Classification Learner App.
      * The *exact same* 5-fold cross-validation setting was used.
      * The *exact same* algorithm (`Medium Tree`, the App's equivalent of `fitctree`) was selected and trained.

6.  **Final Comparison**:

      * The resulting Accuracy and Training Time from both methods were collected and analyzed (see Results).

## 📊 Getting Started

### Prerequisites

  - MATLAB R20xx or later
  - **Statistics and Machine Learning Toolbox**
  - **Text Analytics Toolbox**

### Installation

1.  Clone the repository:

<!-- end list -->

```bash
git clone https://github.com/karsterr/MATLAB-Code-vs-App-Emotion_Analysis.git
```

2.  Open MATLAB and navigate to the project directory.

3.  **(Optional) Run the main script to generate results:**

      - Run `main_project_script.m` to re-generate the `classification_data.mat` file and run the raw-code analysis. **(Note: This may take 20-30 minutes)**.

4.  **(Recommended) Use the pre-computed data:**

      - Load the `classification_data.mat` file into your workspace:

    <!-- end list -->

    ```matlab
    load('classification_data.mat');
    ```

      - Launch the app to verify the App-based results:

    <!-- end list -->

    ```matlab
    classificationLearner
    ```

## 📈 Results

A fair comparison was conducted using **100% of the dataset** (52,681 samples) with a 14,414-feature TF-IDF matrix. Both methods used the same **Decision Tree** algorithm and the same **5-fold cross-validation** method.

The final results are as follows:

| Metric | Raw MATLAB Code (`fitctree`) | Classification Learner App (`Medium Tree`) |
| :--- | :--- | :--- |
| **Algorithm** | Decision Tree | Decision Tree |
| **Dataset** | 100% (52,681 samples) | 100% (52,681 samples) |
| **Features** | 14,414 (TF-IDF) | 14,414 (TF-IDF) |
| **Validation** | 5-fold Cross-Validation | 5-fold Cross-Validation |
| **Accuracy** | **\~65.04%** | **\~65.03%** |
| **Total Training Time** | **\~1359 sec (22.7 min)** | **\~286 sec (4.8 min)** |

-----

### Analysis & Key Takeaways

1.  **Speed: The App is \~4.7x Faster**
    The most significant finding is the performance difference. The **Classification Learner App was approximately 4.7 times faster** than the raw script implementation for the exact same task. This is likely due to the App's highly optimized backend, which handles memory management, parallel processing, and high-dimensional sparse matrices more efficiently than the default `fitctree` and `crossval` function calls in a standard script.

2.  **Accuracy: Identical Results**
    Both methods achieved a validation accuracy of **\~65.0%**. This confirms that the comparison was fair and that both the script and the App were executing the same core algorithm on the same data.

3.  **Note on Low Accuracy (\~65%)**
    The 65% accuracy is not a failure of either method, but rather highlights the difficulty of the problem. The dataset contains 7 very similar emotion classes (e.g., 'Anxiety', 'Stress', 'Depression') which are difficult to distinguish using only TF-IDF, as this method does not capture sentence context, order, or sarcasm.

4.  **Development Effort**
    The raw code development process was significantly hindered by MATLAB version incompatibilities, which caused failures when attempting to use `SVM` (due to unsupported parameters like `MaxIterations`) and `Naive Bayes` (due to unsupported distributions like `multinomial`). The Classification Learner App provided a stable, error-free environment that handled the 14,414-feature matrix without any issues.

**Conclusion: For high-dimensional datasets, the Classification Learner App provides the same accuracy as raw code in a fraction of the time and with significantly less development friction.**

## 🤝 Contributing

Contributions, issues, and feature requests are welcome\! Feel free to check the issues page.

## 👤 Author

**karsterr**

  - GitHub: [@karsterr](https://github.com/karsterr)

## 📝 License

This project is open source and available under the standard GitHub terms.

## 🙏 Acknowledgments

  - MATLAB and MathWorks for providing the Classification Learner App.
  - The machine learning community for inspiration and resources.

-----

*For questions or collaboration opportunities, please open an issue or contact the repository owner.*
