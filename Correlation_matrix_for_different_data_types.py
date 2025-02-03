# -*- coding: utf-8 -*-
"""
Created on Mon Feb  3 16:13:23 2025

@author: Sushm
"""

#for all data and smu vs sa
import pandas as pd
import numpy as np
import seaborn as sns
import matplotlib.pyplot as plt
from scipy.stats import pearsonr, pointbiserialr, chi2_contingency

# Load data according to all data 1st year data or 4th year data
non_encoded_file_path = 'D:/final_year_project/data/preprocessing/sheets_seperated_all_year.xlsx'  # Path for non-encoded file
encoded_file_path = 'D:/final_year_project/data/preprocessing/encoded_separate_data_all_students.xlsx' # Path for encoded file

sheet_names = ['Social Media Use', 'Social Anxiety'] # for smu and loneliness or happiness pull different sheet

# Loading data from the non-encoded file to identify data types
with pd.ExcelFile(non_encoded_file_path) as xls:
    non_encoded_dfs = [pd.read_excel(xls, sheet_name=sheet) for sheet in sheet_names]

# Loading data from the encoded file for correlation calculation
with pd.ExcelFile(encoded_file_path) as xls:
    encoded_dfs = [pd.read_excel(xls, sheet_name=sheet) for sheet in sheet_names]

# Combine data into a single DataFrame i.e smu and sa
non_encoded_combined_df = pd.concat(non_encoded_dfs, axis=1)
encoded_combined_df = pd.concat(encoded_dfs, axis=1)

# Determine data types from the non-encoded file
#carries entire column
data_types = non_encoded_combined_df.dtypes.apply(lambda x: 'numeric' if np.issubdtype(x, np.number) else 'categorical')

# Remove columns that have only missing values or are constant
encoded_combined_df = encoded_combined_df.dropna(axis=1, how='all')  # Drop columns with all missing values
encoded_combined_df = encoded_combined_df.loc[:, encoded_combined_df.nunique() > 1]  # Drop columns with a single unique value

# Ensure encoded data is filled properly
encoded_combined_df.fillna(encoded_combined_df.mean(), inplace=True)

# functions for different types of correlations
def pearson_corr(x, y):
    """Calculate Pearson correlation for two numeric variables."""
    return pearsonr(x, y)[0]

def cramers_v(x, y):
    """Calculate Cramér's V for two categorical variables."""
    confusion_matrix = pd.crosstab(x, y)
    chi2 = chi2_contingency(confusion_matrix)[0]
    n = confusion_matrix.sum().sum()
    return np.sqrt(chi2 / (n * (min(confusion_matrix.shape) - 1)))

def point_biserial_corr(x, y):
    """Calculate Point-Biserial correlation for a numeric and a binary categorical variable."""
    if len(np.unique(y)) == 2:  # Ensure that y is binary
        return pointbiserialr(x, y)[0]
    elif len(np.unique(x)) == 2:  # Ensure that x is binary
        return pointbiserialr(y, x)[0]
    else:
        return np.nan

# Calculate the correlation matrix dynamically
columns = encoded_combined_df.columns
n_cols = len(columns)
correlation_matrix = np.zeros((n_cols, n_cols))

for i in range(n_cols):
    for j in range(n_cols):
        if i == j:
            correlation_matrix[i, j] = 1  # Perfect correlation with itself
        else:
            x = encoded_combined_df.iloc[:, i]
            y = encoded_combined_df.iloc[:, j]
            type_x = data_types[i]
            type_y = data_types[j]

            if type_x == 'numeric' and type_y == 'numeric':
                # Both are numeric, use Pearson's correlation
                correlation_matrix[i, j] = pearson_corr(x, y)
            elif type_x == 'categorical' and type_y == 'categorical':
                # Both are categorical, use Cramér's V
                correlation_matrix[i, j] = cramers_v(x, y)
            else:
                # One is numeric and the other is categorical, use Point-Biserial correlation
                correlation_matrix[i, j] = point_biserial_corr(x, y)

# Convert the correlation matrix to a DataFrame for easy display
correlation_matrix_df = pd.DataFrame(correlation_matrix, index=columns, columns=columns)

# Print correlation matrix
print("\nCorrelation Matrix:")
print(correlation_matrix_df)

# Visualize the correlation matrix
plt.figure(figsize=(12, 10))
sns.heatmap(correlation_matrix_df, annot=True, cmap='coolwarm', linewidths=0.5)
plt.title('Correlation Matrix of Social Media Use and Social Anxiety')
plt.show()
