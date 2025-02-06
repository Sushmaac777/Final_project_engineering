library(bnlearn)
library(readxl)
library(Rgraphviz)


file_path <- "D:/final_year_project/data/operation/bayesian/train.xlsx"
data <- read_excel(file_path, sheet = "Sheet1")

# Select relevant columns
columns <- c("ClusterSocialMediaUse", "ClusterHappiness", "ClusterLoneliness", "ClusterSocialAnxiety")
data_subset <- data[, columns]

# Convert columns to factors
data_subset <- data.frame(lapply(data_subset, as.factor))

# Train the Bayesian Network model
model <- hc(data_subset, score = "aic")
fitted_model <- bn.fit(model, data_subset)

# Visualize the Bayesian Network
graphviz.plot(fitted_model, main = "Bayesian Network")



# Probability calculations for "High Loneliness" (ClusterLoneliness = 2)
high_loneliness_value <- 2

# Conditional probabilities when Loneliness is "High"
prob_high_anxiety_given_high_loneliness <- cpquery(
  fitted = fitted_model,
  event = (ClusterSocialAnxiety == 2),  # High Social Anxiety
  evidence = (ClusterLoneliness == high_loneliness_value),  # High Loneliness
  method = "ls",
  n = 100000
)
cat("P(High Social Anxiety | ClusterLoneliness = High):", prob_high_anxiety_given_high_loneliness, "\n")

prob_high_happiness_given_high_loneliness <- cpquery(
  fitted = fitted_model,
  event = (ClusterHappiness == 2),  # High Happiness
  evidence = (ClusterLoneliness == high_loneliness_value),  # High Loneliness
  method = "ls",
  n = 100000
)
cat("P(High Happiness | ClusterLoneliness = High):", prob_high_happiness_given_high_loneliness, "\n")

prob_high_smu_given_high_loneliness <- cpquery(
  fitted = fitted_model,
  event = (ClusterSocialMediaUse == 2),  # High Social Media Use
  evidence = (ClusterLoneliness == high_loneliness_value),  # High Loneliness
  method = "ls",
  n = 100000
)
cat("P(High Social Media Use | ClusterLoneliness = High):", prob_high_smu_given_high_loneliness, "\n")






# Probability calculations for "Low Loneliness" (ClusterLoneliness = 1)
low_loneliness_value <- 1

# Conditional probabilities when Loneliness is "Low"
prob_high_anxiety_given_low_loneliness <- cpquery(
  fitted = fitted_model,
  event = (ClusterSocialAnxiety == 2),  # High Social Anxiety
  evidence = (ClusterLoneliness == low_loneliness_value),  # Low Loneliness
  method = "ls",
  n = 100000
)
cat("P(High Social Anxiety | ClusterLoneliness = Low):", prob_high_anxiety_given_low_loneliness, "\n")

prob_high_happiness_given_low_loneliness <- cpquery(
  fitted = fitted_model,
  event = (ClusterHappiness == 2),  # High Happiness
  evidence = (ClusterLoneliness == low_loneliness_value),  # Low Loneliness
  method = "ls",
  n = 100000
)
cat("P(High Happiness | ClusterLoneliness = Low):", prob_high_happiness_given_low_loneliness, "\n")

prob_high_smu_given_low_loneliness <- cpquery(
  fitted = fitted_model,
  event = (ClusterSocialMediaUse == 2),  # High Social Media Use
  evidence = (ClusterLoneliness == low_loneliness_value),  # Low Loneliness
  method = "ls",
  n = 100000
)
cat("P(High Social Media Use | ClusterLoneliness = Low):", prob_high_smu_given_low_loneliness, "\n")




# Baseline probabilities (calculated without specific evidence or intervention)
baseline_loneliness <- cpquery(
  fitted = fitted_model,
  event = (ClusterLoneliness == 2),  # High Loneliness
  evidence = TRUE,
  method = "ls",
  n = 100000
)
cat("Baseline P(High Loneliness):", baseline_loneliness, "\n")

baseline_anxiety <- cpquery(
  fitted = fitted_model,
  event = (ClusterSocialAnxiety == 2),  # High Social Anxiety
  evidence = TRUE,
  method = "ls",
  n = 100000
)
cat("Baseline P(High Social Anxiety):", baseline_anxiety, "\n")

baseline_happiness <- cpquery(
  fitted = fitted_model,
  event = (ClusterHappiness == 2),  # High Happiness
  evidence = TRUE,
  method = "ls",
  n = 100000
)
cat("Baseline P(High Happiness):", baseline_happiness, "\n")

baseline_smu <- cpquery(
  fitted = fitted_model,
  event = (ClusterSocialMediaUse == 2),  # High Social Media Use
  evidence = TRUE,
  method = "ls",
  n = 100000
)
cat("Baseline P(High Social Media Use):", baseline_smu, "\n")




# Impact of interventions
cat("Change in P(High Social Anxiety | High Loneliness):", prob_high_anxiety_given_high_loneliness - baseline_anxiety, "\n")
cat("Change in P(High Happiness | High Loneliness):", prob_high_happiness_given_high_loneliness - baseline_happiness, "\n")
cat("Change in P(High Social Media Use | High Loneliness):", prob_high_smu_given_high_loneliness - baseline_smu, "\n")

cat("Change in P(High Social Anxiety | Low Loneliness):", prob_high_anxiety_given_low_loneliness - baseline_anxiety, "\n")
cat("Change in P(High Happiness | Low Loneliness):", prob_high_happiness_given_low_loneliness - baseline_happiness, "\n")
cat("Change in P(High Social Media Use | Low Loneliness):", prob_high_smu_given_low_loneliness - baseline_smu, "\n")
