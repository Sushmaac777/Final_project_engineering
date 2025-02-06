library(bnlearn)
library(readxl)
file_path = 'D:/final_year_project/data/operation/clustered_data_sheets_seperated_all.xlsx'
#file_path <- "D:/final_year_project/data/operation/data_clustered_seperate_sheets_1st_year.xlsx"
#file_path <- "D:/final_year_project/data/operation/data_clustered_seperate_sheets_4th_year.xlsx"

data <- read_excel(file_path, sheet = "Loneliness")


# Selecting relevant columns
columns <- c("How frequently do you go for outing?",
             "Do you find friends easily when needed?",
             "How often do you feel alone due to lack of good friend?",
             "Do you find yourself alone when you need support?",
             "Do you ever experience feelings of being left out among your friends?",
             "Do you ever feel isolated from others?",
             "Do you notice people physically present but emotionally absent?",
             "Do you feel sad when you're distant from others?"
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

# 
# ####renamed
# library(bnlearn)
# library(readxl)
# 
# file_path <- "D:/final_year_project/data/operation/bayesian/data_clustered_seperate_sheets_all_renamed.xlsx"
# data <- read_excel(file_path, sheet = "loneliness_clusters")
# 
# # Selecting relevant columns
# columns <- c("find_friends_when_needed",
#              "feel_alone_due_to_lack_of_good_friend",
#              "experience_ left_out_among _friends",
#              "feel_isolated_from_others"
# )
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
# # Learn the structure of the Bayesian Network using bnlearn
# model <- hc(data_subset) # Hill-Climbing algorithm 
# 
# # Visualize the learned structure
# plot(model)
