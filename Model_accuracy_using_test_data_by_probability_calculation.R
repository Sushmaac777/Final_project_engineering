library(readxl)
library(dplyr)
library(writexl)

file_path <- "D:/final_year_project/data/operation/bayesian/test.xlsx"  # Original file path
output_file_path <- "D:/final_year_project/data/operation/bayesian/trialupdatedbycode.xlsx"  # New file path

test_data <- read_excel(file_path, sheet = "test")
smu_to_sa_data <- read_excel(file_path, sheet = "smu to sa")
sa_to_loneliness_data <- read_excel(file_path, sheet = "sa to loneliness")

# Ensure columns are numeric 
smu_to_sa_data <- smu_to_sa_data %>%
  mutate( #This function converts the values of these columns to a numeric data type.
    `High(Anxiety)` = as.numeric(`High(Anxiety)`),
    `Low(Anxiety)` = as.numeric(`Low(Anxiety)`)
  )
#salon
sa_to_loneliness_data <- sa_to_loneliness_data %>%
  mutate(
    `High (Loneliness)` = as.numeric(`High (Loneliness)`),
    `Low (Loneliness)` = as.numeric(`Low (Loneliness)`)
  )


# Step 1: Calculating Conditional Probabilities
smu_to_sa_data <- smu_to_sa_data %>%
  mutate(
    Total = `High(Anxiety)` + `Low(Anxiety)`,
    P_High_Anxiety = `High(Anxiety)` / Total,
    P_Low_Anxiety = `Low(Anxiety)` / Total
  )


sa_to_loneliness_data <- sa_to_loneliness_data %>%
  mutate(
    Total = `High (Loneliness)` + `Low (Loneliness)`,
    P_High_Loneliness = `High (Loneliness)` / Total,
    P_Low_Loneliness = `Low (Loneliness)` / Total
  )

# Step 2: Predict Social Anxiety based on Social Media Use
# Join Social Media Use to Social Anxiety probabilities with test_data

test_data <- test_data %>%
  left_join(smu_to_sa_data %>% select(`Cluster social media use`, P_High_Anxiety, P_Low_Anxiety),
            by = c("Clustersocial_media_use" = "Cluster social media use")) %>%
  mutate(
    Predicted_SocialAnxiety = ifelse(P_High_Anxiety > 0.5, "High", "Low")
  )


# Step 3: Predict Loneliness based on Predicted Social Anxiety
# Join Social Anxiety to Loneliness probabilities with test_data
test_data <- test_data %>%
  left_join(sa_to_loneliness_data %>% select(ClusterSocialAnxiety, P_High_Loneliness, P_Low_Loneliness),
            by = c("Predicted_SocialAnxiety" = "ClusterSocialAnxiety")) %>%
  mutate(
    Predicted_Loneliness = ifelse(P_High_Loneliness > 0.5, "High", "Low")
  )

# Step 4: Calculate Accuracy and Count TRUE/FALSE
# Compare the predicted values to actual values for accuracy calculations
test_data <- test_data %>%
  mutate(
    Correct_SocialAnxiety = (Predicted_SocialAnxiety == ClusterSocialAnxiety),
    Correct_Loneliness = (Predicted_Loneliness == ClusterLoneliness)
  )


# Count TRUE and FALSE for each prediction type
true_count_social_anxiety <- sum(test_data$Correct_SocialAnxiety, na.rm = TRUE)
false_count_social_anxiety <- sum(!test_data$Correct_SocialAnxiety, na.rm = TRUE)

true_count_loneliness <- sum(test_data$Correct_Loneliness, na.rm = TRUE)
false_count_loneliness <- sum(!test_data$Correct_Loneliness, na.rm = TRUE)

# Step 5: Add calculations and notes to Data Frame
# Create a data frame for summary with formulas and calculations, converting all columns to character type
summary_data <- data.frame(
  Clustersocial_media_use = c("Summary:", "Social Anxiety Accuracy", "Loneliness Accuracy"),
  ClusterSocialAnxiety = c(NA, paste("= TRUE count / Total"), paste("= TRUE count / Total")),
  ClusterLoneliness = as.character(c(NA,
                                     round((true_count_social_anxiety / (true_count_social_anxiety + false_count_social_anxiety)) * 100, 2),
                                     round((true_count_loneliness / (true_count_loneliness + false_count_loneliness)) * 100, 2))),
  Predicted_SocialAnxiety = as.character(c("Counts", true_count_social_anxiety, true_count_loneliness)),
  Predicted_Loneliness = as.character(c("Counts", false_count_social_anxiety, false_count_loneliness))
)

# Convert all columns in summary_data to character to match test_data
summary_data <- summary_data %>%
  mutate(across(everything(), as.character))

# Combine test_data with summary_data for export
final_data <- bind_rows(test_data, summary_data)

# Save the final data with summaries and formulas to the new Excel file
write_xlsx(final_data, path = output_file_path)

print("File saved with summary counts and accuracy calculations!")
