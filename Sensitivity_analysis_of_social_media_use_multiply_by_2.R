library(bnlearn)
library(readxl)

file_path <- "D:/final_year_project/data/operation/bayesian/data_clustered_seperate_sheets_all_for_bayesian.xlsx"
data <- read_excel(file_path, sheet = "social_media_clusters")

# Selecting relevant columns
columns <- c("Have_Instagram_account",
             "Instagram_how_long",
             "followers_Instagram",
             "follow_Instagram",
             "activity_most_used_Instagram",
             "reason_using_Instagram",
             "day_per_week",
             "check_Instagram_single_day",
             "time_spend_instagram_daily",
             "Instagram_per_visit",
             "how_many_post_week",
             "Instagram_for_Direct Messaging",
             "check_likes/comments_on_your/others_posts")

data_subset <- data[, columns]

# Handle all missing values
missing_columns <- colSums(is.na(data_subset)) == nrow(data_subset)
cat("Columns with all missing values:\n")
print(names(data_subset)[missing_columns])
data_subset_cleaned <- data_subset[, !missing_columns]
# Ensure  no remaining missing values 
data_subset_cleaned <- na.omit(data_subset_cleaned)


#1 original

# Converting character columns to factors, as bnlearn requires categorical data to be factors
data_subset_cleaned <- as.data.frame(lapply(data_subset_cleaned, function(x) {
  if (is.character(x)) {
    return(as.factor(x))
  } else {
    return(x)
  }
}))

#Bayesian Network learning using the Hill-Climbing algorithm
model <- hc(data_subset_cleaned)

# Visualize str
plot(model)
title("Bayesian Network Structure for smu Data")
print(model)


#2 multiplied  by 2 time spent per visit
# Convert the column to numeric
data_subset_cleaned$`Instagram_per_visit` <- as.numeric(data_subset_cleaned$`Instagram_per_visit`)

# Multiply column 
data_subset_cleaned$`Instagram_per_visit` <-data_subset_cleaned$`Instagram_per_visit` * 2


# Convert remaining character columns to factors
data_subset_cleaned <- as.data.frame(lapply(data_subset_cleaned, function(x) {
  if(is.character(x)) {
    return(as.factor(x))
  } else {
    return(x)
  }
}))

# Learn the structure
model <- hc(data_subset_cleaned)  
plot(model)
title("Bayesian Network Structure for smu after multiplying time spent per visit  by 2")






#2 multiplied  by 2 time spent daily
# Convert  column to numeric
data_subset_cleaned$`time_spend_instagram_daily` <- as.numeric(data_subset_cleaned$`time_spend_instagram_daily`)

# Multiply column 
data_subset_cleaned$`time_spend_instagram_daily` <-data_subset_cleaned$`time_spend_instagram_daily` * 2

# Convert remaining character columns to factors
data_subset_cleaned <- as.data.frame(lapply(data_subset_cleaned, function(x) {
  if(is.character(x)) {
    return(as.factor(x))
  } else {
    return(x)
  }
}))

# Learn the structure 
model <- hc(data_subset_cleaned) 

# Visualize structure
plot(model)
title("Bayesian Network Structure for smu after multiplying time spent daily  by 2")


