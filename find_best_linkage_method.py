import pandas as pd
import numpy as np
from sklearn.preprocessing import StandardScaler
from sklearn.cluster import AgglomerativeClustering
from sklearn.metrics import silhouette_score
import matplotlib.pyplot as plt

# Load the Excel file
file_path = 'D:/final_year_project/data/preprocessing/encoded_separate_data_all_students.xlsx'

# Load the data from the Excel file
xls = pd.ExcelFile(file_path)

# Function to process the data and perform agglomerative clustering analysis
def analyze_clusters(sheet_name):
    # Load data from the current sheet
    df = pd.read_excel(file_path, sheet_name=sheet_name)

    # Convert columns to numeric and fill missing values with column mean
    df = df.apply(pd.to_numeric, errors='coerce').fillna(df.mean()).dropna()

    # Extract the feature matrix
    X = df.values

    # Standardize the data
    scaler = StandardScaler()
    scaled_data = scaler.fit_transform(X)

    # List of linkage methods to evaluate
    linkage_methods = ['ward', 'complete', 'average', 'single']

    # Dictionary to store silhouette scores for each linkage method
    silhouette_scores = {}

    # Evaluate each linkage method
    for method in linkage_methods:
        # Perform Agglomerative Clustering
        clustering = AgglomerativeClustering(linkage=method)
        cluster_labels = clustering.fit_predict(scaled_data)
        
        # Calculate the silhouette score
        score = silhouette_score(scaled_data, cluster_labels)
        silhouette_scores[method] = score
        print(f"Silhouette Score for {method} linkage in {sheet_name}: {score}")

    # Find the best linkage method
    best_linkage_method = max(silhouette_scores, key=silhouette_scores.get)
    print(f"Best linkage method for {sheet_name}: {best_linkage_method} with a silhouette score of {silhouette_scores[best_linkage_method]}")

    # Plot the silhouette scores for each linkage method
    plt.figure(figsize=(10, 6))
    plt.bar(silhouette_scores.keys(), silhouette_scores.values(), color='skyblue')
    plt.title(f'Silhouette Scores for Different Linkage Methods in {sheet_name}')
    plt.xlabel('Linkage Method')
    plt.ylabel('Silhouette Score')
    plt.show()

# Get the sheet names
sheet_names = xls.sheet_names

# Analyze clusters for each sheet
for sheet in sheet_names:
    analyze_clusters(sheet)
