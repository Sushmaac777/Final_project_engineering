library(bnlearn)
library(readxl)
file_path = 'D:/final_year_project/data/operation/clustered_data_sheets_seperated_all.xlsx'
#file_path <- "D:/final_year_project/data/operation/data_clustered_seperate_sheets_1st_year.xlsx"
#file_path <- "D:/final_year_project/data/operation/data_clustered_seperate_sheets_4th_year.xlsx"

data <- read_excel(file_path, sheet = "Social Media Use")

# Selecting relevant columns
columns <- c("Do you have Instagram account?",
             "How long you are using Instagram?",
             "Approximately, how many followers do you have on Instagram?",
             "Approximately, how many accounts do you follow on Instagram?",
             "What activity do you use the most on Instagram?",
             "What is your main reason for using Instagram?",
             "On average, how many days per week do you visit Instagram?",
             "On average, how often do you check Instagram in a single day?",
             "Approximately, how much time do you spend on Instagram daily?",
             "On average, how long do you typically spend on Instagram per visit?",
             "On average, how many photos, videos, stories or Reels do you post on Instagram a week?",
             "How frequently do you use Instagram for Direct Messaging to communicate with friends or followers?")


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


# ####renamed

# library(bnlearn)
# library(readxl)
# 
# file_path <- "D:/final_year_project/data/operation/bayesian/data_clustered_seperate_sheets_all_renamed.xlsx"
# data <- read_excel(file_path, sheet = "social_media_clusters")
# 
# 
# 
# # Selecting relevant columns
# columns <- c("followers_Instagram",
#              "follow_Instagram",
#              "time_spend_instagram_daily",
#              "Instagram_per_visit",
#              "how_many_post_week",
#              "check_likes/comments_on_your/others_posts")
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



# Learn the structure of the Bayesian Network using bnlearn
#model <- hc(data_subset) # Hill-Climbing algorithm

# Visualize the learned structure
#plot(model)
