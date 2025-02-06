library(bnlearn)
library(readxl)
file_path = 'D:/final_year_project/data/operation/clustered_data_sheets_seperated_all.xlsx'
#file_path <- "D:/final_year_project/data/operation/data_clustered_seperate_sheets_1st_year.xlsx"
#file_path <- "D:/final_year_project/data/operation/data_clustered_seperate_sheets_4th_year.xlsx"

data <- read_excel(file_path, sheet = "Happiness")



# Selecting relevant columns
columns <- c("Life is satisfying.",
             "I am satisfied with my overall life.",
             "Things around me are beautiful.",
             "I often remember happy moments from the past.",
             "I am highly energized throughout day.",
             "I am mentally alert.",
             "I manage needs of my life properly.",
             "I am confident about my physical appearance."
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


# #renamed
# library(bnlearn)
# library(readxl)
# 
# file_path <- "D:/final_year_project/data/operation/bayesian/data_clustered_seperate_sheets_all_renamed.xlsx"
#data <- read_excel(file_path, sheet = "happiness_clusters")
# 
# 
# 
# # Selecting relevant columns
# columns <- c("Life_is_satisfying.",
#              "satisfied with_life.",
#              "Things_around_beautiful",
#              "mentally_alert"
#              )
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
