library(readxl)
library(caret)
library(nnet) 

file_path <- "D:/final_year_project/data/operation/bayesian/train.xlsx"
train_data <- read_excel(file_path)

# Prepare features (X) and target (y)
# for relationship: ClusterSocialMediaUse -> ClusterSocialAnxiety
X <- train_data[, c("ClusterSocialMediaUse")]  # Feature
y <- as.factor(train_data$ClusterSocialAnxiety)  # Target

# Combine X and y into a single data frame for modeling
train_data <- data.frame(X, ClusterSocialAnxiety = y)

# 10-fold cross-validation setup
control <- trainControl(method = "cv", number = 10, savePredictions = TRUE)

# Trainining Logistic Regression model 
model <- train(
  ClusterSocialAnxiety ~ ClusterSocialMediaUse, 
  data = train_data,
  method = "multinom",  # logistic regression
  metric = "Accuracy",  # metric
  trControl = control
)

#Misclassification Error
predictions <- model$pred
misclassification_error <- mean(predictions$pred != predictions$obs)

# Results
print(model)
print(paste("Average Accuracy:", mean(model$results$Accuracy)))
print(paste("Misclassification Error:", misclassification_error))
