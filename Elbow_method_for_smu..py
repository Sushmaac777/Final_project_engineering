# -*- coding: utf-8 -*-
"""
Created on Mon Feb  3 17:15:23 2025

@author: Sushm
"""

from sklearn.cluster import KMeans
from yellowbrick.cluster import KElbowVisualizer
import pandas as pd


file_path = 'D:/final_year_project/data/preprocessing/encoded_separate_data_all_students.xlsx'
sheet_name = 'Social Media Use'


social_media_use_df = pd.read_excel(file_path, sheet_name=sheet_name)

# Convert columns to numeric and handle missing values
social_media_use_df = social_media_use_df.apply(pd.to_numeric, errors='coerce')
social_media_use_df.fillna(social_media_use_df.mean(), inplace=True)

X = social_media_use_df.values
km = KMeans(random_state=42)
visualizer = KElbowVisualizer(km, k=(1, 8))

# Fit the data to the visualizer
visualizer.fit(X)
visualizer.show()
