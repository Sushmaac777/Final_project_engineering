# -*- coding: utf-8 -*-
"""
Created on Fri Jun 28 12:59:19 2024

@author: Sushm
"""

from sklearn.cluster import KMeans
import pandas as pd
from sklearn.preprocessing import StandardScaler
import matplotlib.pyplot as plt
import os

# Function to process data and perform elbow method analysis
def analyze_clusters(file_path, sheet_name, num_threads=2):
    num_threads=2
    os.environ['OMP_NUM_THREADS'] = str(num_threads)

    # Load data 
    df = pd.read_excel(file_path, sheet_name=sheet_name)

    # Convert columns to numeric and fill missing values with column mean
    df = df.apply(pd.to_numeric, errors='coerce').fillna(df.mean()).dropna()

    # Extract the feature matrix
    X = df.values

    # Standardize the data
    scaled_data = StandardScaler().fit_transform(X)

    # Elbow method to find the optimal number of clusters
    wcss = [KMeans(n_clusters=i, init='k-means++', max_iter=100000, n_init=10, random_state=0).fit(scaled_data).inertia_ for i in range(1, 11)]

    # Plot results
    plt.figure(figsize=(10, 6))
    plt.plot(range(1, 11), wcss, marker='o', linestyle='--')
    plt.title(f'Elbow Method for {sheet_name}')
    plt.xlabel(f'Number of clusters for {sheet_name}')
    plt.ylabel('WCSS')
    plt.grid(True)
    plt.show()

    # Determine optimal number of clusters
    optimal_clusters = 1 + min(range(1, len(wcss)), key=lambda i: wcss[i] - wcss[i-1])
    print(f"Optimal number of clusters for {sheet_name}: {optimal_clusters}")

# File path 
file_path = 'D:/final_year_project/data/preprocessing/encoded_separate_data_all_students.xlsx'

#sheet names 
sheet_names = ['Loneliness', 'Happiness', 'Social Anxiety', 'Social Media Use']

# Analyze each sheet
for sheet_name in sheet_names:
    analyze_clusters(file_path, sheet_name, num_threads=2)
