from sklearn.ensemble import ExtraTreesClassifier
import pandas as pd

# Read the .sav file and store it in the df dataframe
df = pd.read_spss("..\\Dataset\\PreprocessedData.sav")

# Drop the rows with missing values (as the ExtraTreesClassifier cannot handle missing values)
df = df.dropna()

# Define target and predictors
X = df.drop(columns=["H1"])
y = df["H1"]

# Convert the categorical variables to dummy variables
X = pd.get_dummies(X)

# fit the Extra Trees Classifier
clf = ExtraTreesClassifier()
clf = clf.fit(X, y)

# Get the feature importances
importances = clf.feature_importances_

# Get the feature names
feature_names = X.columns

# Zip the feature importances and names together
importances_with_names = list(zip(importances, feature_names))

# Sort the features by importance
importances_with_names = sorted(
    importances_with_names, key=lambda x: x[0], reverse=True)



# Create an empty list to store the column names that match the words in the file
matched_columns = []

# Read the original .sav file to get the column names
df_original = pd.read_spss("..\\Dataset\\SefSec_2014_HH_weightNew.sav")
columns_names = df_original.columns.tolist()

index = 1   # index to print the features
for importance, feature_name in importances_with_names:
    if feature_name in columns_names and feature_name not in matched_columns:
        matched_columns.append(feature_name)
        print(f"[{index}]{feature_name}: {importance}")
        index += 1

    else:
        last_underscore_index = feature_name.rindex("_")
        feature_name = feature_name[:last_underscore_index]
        if feature_name in columns_names and feature_name not in matched_columns:
            matched_columns.append(feature_name)
            print(f"[{index}] {feature_name}: {importance}")
            index += 1


top_30 = matched_columns[:30]
print('"', end='')
print('", "'.join(top_30), end='"')
