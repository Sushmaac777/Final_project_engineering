# -*- coding: utf-8 -*-
"""
Created on Mon Feb  3 19:33:52 2025
@author: Sushm
"""

import pandas as pd
from sklearn.tree import DecisionTreeClassifier
from sklearn import tree
import graphviz
from sklearn.model_selection import cross_val_score

#n 10-fold cross-validation, the dataset is split into 10 subsets. The model is trained on 9 subsets and tested on the remaining 1 subset. 
def create_decision_tree(file_path, sheet_name, target_column, max_depth=5, cv=5, output_name=None,tree_title=None):
   
  
    data = pd.read_excel(file_path, sheet_name=sheet_name)

    # Prepare data
    X = data.drop(target_column, axis=1)  # Features
    y = data[target_column]  # Target

    # Convert categorical features into dummy/indicator variables
    X = pd.get_dummies(X)

    # Train the Decision Tree Classifier
    clf = DecisionTreeClassifier(random_state=42, max_depth=max_depth)

    # Perform cross-validation
    scores = cross_val_score(clf, X, y, cv=cv)
    print(f"Cross-validation scores for {sheet_name}: {scores}")
    print(f"Mean cross-validation score for {sheet_name}: {scores.mean()}")

    # Fit the model on the entire dataset
    clf.fit(X, y)

    # Export the tree to Graphviz format with cluster labels
    dot_data = tree.export_graphviz(clf, out_file=None,
                                    feature_names=X.columns,
                                    class_names=[f'Cluster {c}' for c in clf.classes_],
                                    filled=True, rounded=True,
                                    special_characters=True)


    # Create graph from dot_data
    graph = graphviz.Source(dot_data)


    # Determine output file name
    if output_name is None:
        output_name = sheet_name


    # Save graph as a PNG file
    output_path = f"{output_name}_tree"

    graph.render(output_path, format="png")

    # Display tree
    graph.view()

    print(f"Decision tree for {sheet_name} saved as {output_name}_tree.png")
file_path = 'D:/final_year_project/data/operation/clustered_data_sheets_seperated_all.xlsx'
create_decision_tree(file_path, sheet_name='Social Media Use', target_column='Clustersocial_media_use')
create_decision_tree(file_path, sheet_name='Happiness', target_column='ClusterHappiness')
create_decision_tree(file_path, sheet_name='Loneliness', target_column='ClusterLoneliness')
create_decision_tree(file_path, sheet_name='Social Anxiety', target_column='ClusterSocialAnxiety')