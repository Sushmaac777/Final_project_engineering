library(readxl)
library(caret)

file_path <- "D:/final_year_project/data/operation/bayesian/train.xlsx"
train_data <- read_excel(file_path)

# Prepare features (X) and target (y)
# Dropping the target variable columns except for 'ClusterSocialMediaUse'
X <- train_data[, !names(train_data) %in% c("ClusterSocialMediaUse", 
                                            "ClusterHappiness", 
                                            "ClusterLoneliness", 
                                            "ClusterSocialAnxiety")]
y <- as.factor(train_data$ClusterSocialMediaUse)


X <- X[, sapply(X, function(col) length(unique(col)) > 1)]

X <- data.frame(lapply(X, as.factor))  

train_data <- cbind(X, ClusterSocialMediaUse = y)

#10-fold cross-validation
control <- trainControl(method = "cv", number = 10, 
                        savePredictions = TRUE) 

# Train a Logistic Regression model using cross-validation
model <- train(ClusterSocialMediaUse ~ ., data = train_data, 
               method = "multinom",  # Multinomial Logistic Regression for multi-class
               metric = "Accuracy",  # Use Accuracy as the evaluation metric
               trControl = control)

# Misclassification Error as evaluation metric
# Predictions from cross-validation
predictions <- model$pred
misclassification_error <- mean(predictions$pred != predictions$obs)


print(model)
print(paste("Average Accuracy:", mean(model$results$Accuracy)))
print(paste("Misclassification Error:", misclassification_error))
