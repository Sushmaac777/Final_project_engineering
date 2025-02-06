# the goal is to assess the predictive performance of a model 
#using cross-validation to ensure that the results are 
#generalizable to unseen data

library(readxl)
library(caret)
library(randomForest)


file_path <- "D:/final_year_project/data/operation/bayesian/train.xlsx"
train_data <- read_excel(file_path)

# Prepare features (X) and target (y)
# Dropping the target variable columns except for 'ClusterSocialMediaUse'
X <- train_data[, !names(train_data) %in% c("ClusterSocialMediaUse", 
                                            "ClusterHappiness", 
                                            "ClusterLoneliness", 
                                            "ClusterSocialAnxiety")]

y <- as.factor(train_data$ClusterSocialMediaUse)

# Check for columns with only one unique value and remove them
X <- X[, sapply(X, function(col) length(unique(col)) > 1)]

X <- data.frame(lapply(X, as.factor))  

#  Combine X and y for cross-validation
train_data <- cbind(X, ClusterSocialMediaUse = y)

# Define 10-fold cross-validation
control <- trainControl(method = "cv", number = 10)

# Train a Random Forest model using cross-validation
model <- train(ClusterSocialMediaUse ~ ., data = train_data, 
               method = "rf", 
               trControl = control)

#  Output of cross-validation results
print(model)
print(paste("Average Accuracy:", mean(model$results$Accuracy)))
