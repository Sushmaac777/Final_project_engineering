library(bnlearn)
library(readxl)
file_path = 'D:/final_year_project/data/operation/clustered_data_sheets_seperated_all.xlsx'
#file_path <- "D:/final_year_project/data/operation/data_clustered_seperate_sheets_1st_year.xlsx"
#file_path <- "D:/final_year_project/data/operation/data_clustered_seperate_sheets_4th_year.xlsx"

data <- read_excel(file_path, sheet = "Social Anxiety")



# Selecting relevant columns
columns <- c("I often compare my work with others.",
             "I often compare my social status with others?",
             "I often compare myself with others.",
             "I often try to find out what others think who face similar problems as I face.",
             "I always like to know what others would do when similar situation occurs.",
             "When I want to learn more about something, I often look for other opinions."
)


data_subset <- data[ , columns]

# Convert character columns to factors
data_subset <- as.data.frame(lapply(data_subset, function(x) {
  if(is.character(x)) {
    return(as.factor(x))
  } else {
    return(x)
  }
}))

# Learn the structure of the Bayesian Network using bnlearn
model <- hc(data_subset) # Hill-Climbing algorithm

# Visualize the learned structure
plot(model)


#renamed
# library(bnlearn)
# library(readxl)
# 
# file_path <- "D:/final_year_project/data/operation/bayesian/data_clustered_seperate_sheets_all_renamed.xlsx"
# data <- read_excel(file_path, sheet = "social_anxiety_clusters")
# 
# 
# 
# # Selecting relevant columns
# columns <- c("compare_my_work_with_others",
#              "compare_my_social_status_with_ others",
#              "compare_myself_with_ others",
#              "try_find_what_others_think_who_ face_similar_problems",
#              "like_to_know_what_others_do"
# )  
# 
# 
# data_subset <- data[ , columns]
# 
#
# # Convert character columns to factors
# data_subset <- as.data.frame(lapply(data_subset, function(x) {
#   if(is.character(x)) {
#     return(as.factor(x))
#   } else {
#     return(x)
#   }
# }))
# 
# 
# 
# # Learn the structure of the Bayesian Network using bnlearn
# model <- hc(data_subset) # Hill-Climbing algorithm 
# 
# # Visualize the learned structure
# plot(model)
# 
