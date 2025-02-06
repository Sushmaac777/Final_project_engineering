library(bnlearn)
library(readxl)
library(Rgraphviz)  


file_path <- "D:/final_year_project/data/operation/bayesian/train.xlsx"
data <- read_excel(file_path, sheet = "Sheet1")

columns <- c("ClusterSocialMediaUse", "ClusterHappiness", "ClusterLoneliness", "ClusterSocialAnxiety")
data_subset <- data[ , columns]

# columns to factors 
data_subset <- data.frame(lapply(data_subset, as.factor))

model <- hc(data_subset, score = "aic") 

# Visualize 
graphviz.plot(model)



