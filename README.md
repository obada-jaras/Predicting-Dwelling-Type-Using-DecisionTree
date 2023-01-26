# **Predicting Dwelling Type Using DecisionTree**
This project aimed to predict the type of dwelling unit a Palestinian family lives in, based on various features in a dataset collected from the Palestinian Expenditure and Consumption Survey in 2011 and 2014. The dataset was preprocessed to standardize missing values, unify currency, and remove irrelevant features. A total of 20 features were carefully selected through the use of Extra Trees Classifier and Decision Tree algorithm to determine feature importance. A Decision Tree model was built using these selected features and the accuracy was evaluated using both training and testing data. The end goal of this project was to accurately predict the type of dwelling unit a Palestinian family lives in and help to understand the factors that influence the type of housing they live in.

<br>

---

<br>

## **Table of Contents**
- [**Overview**](#overview)
  - [**R Files**](#r-files)
    - [PreProcessing.R](#preprocessingr-this-file-contains-the-code-for-preprocessing-the-data-which-includes)
    - [DecisionTree.R](#decisiontreer-this-file-contains-the-code-for-building-the-decision-tree-using-the-c50-package-in-r)
  - [**Python File**](#python-file)
    - [ExtraTreesClassifier.py](#extratreesclassifierpy-this-file-contains-the-code-for-applying-the-extra-trees-classifier-algorithm-to-determine-the-most-important-features-which-are-then-used-to-build-the-decision-tree)
- [**Prerequisites**](#prerequisites)
- [**Usage**](#usage)

<br>

---

<br>

## **Overview**
This project includes 3 code files for preprocessing the data, selecting features, and building a decision tree.

<br>

### **R Files**
#### [PreProcessing.R](R/PreProcessing.R): This file contains the code for preprocessing the data, which includes:
- NULL Standardization.
- Features Merging.
- Currency Unification.
- Features Removal.
- Categorizing Numeric Data.

#### [DecisionTree.R](R/DecisionTree.R): This file contains the code for building the decision tree using the C50 package in R.

<br>

### **Python File**
#### [ExtraTreesClassifier.py](Python/ExtraTreesClassifier.py): This file contains the code for applying the Extra Trees Classifier algorithm to determine the most important features, which are then used to build the decision tree.

<br><br>

>For a comprehensive understanding of the project, refer to the [Report.pdf](Report.pdf) file which includes a thorough explanation of the methodology, outcomes, and conclusions. The [FeaturesDetails.xlsx](Dataset/FeaturesDetails.xlsx) file also provides a detailed description of all 840 features used in the project. Additionally, a sample from the dataset used in this project, the [SefSec_2014_HH_weightNew.sav](Dataset/SefSec_2014_HH_weightNew.sav) file, is also included in the repository.

<br>

---

<br>

## **Prerequisites**
- [R](https://cran.r-project.org/bin/windows/base/)
- [Python 3](https://www.python.org/downloads/)

<br>

---

<br>

## **Usage**
1. Clone or download the repository to your local machine.
2. Ensure that you have all the [prerequisites](#prerequisites) installed.
3. Install R needed packages by running this code `install.packages("haven", "tidyverse", "Hmisc", "C50")`.
4. Install python needed packages by running the command `pip install sklearn pandas`.
5. Execute the code in [PreProcessing.R](R/PreProcessing.R) line by line.
6. Run the [ExtraTreesClassifier.py](Python/ExtraTreesClassifier.py) code, and copy the best 30 features from the console output.
7. In [DecisionTree.R](R/DecisionTree.R), update the `features` to the ones you copied.
8. Execute the code in [DecisionTree.R](R/DecisionTree.R) line by line.