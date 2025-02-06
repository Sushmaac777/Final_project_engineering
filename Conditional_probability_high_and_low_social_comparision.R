library(bnlearn)
library(readxl)
library(Rgraphviz)


file_path <- "D:/4th year project/data/operation/bayesianoutput/train.xlsx"
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




# Probability calculations for "High Social Anxiety" (ClusterSocialAnxiety = 2)
high_anxiety_value <- 2

# Conditional probabilities when Social Anxiety is "High"
prob_high_loneliness_given_high_anxiety <- cpquery(
  fitted = fitted_model,
  event = (ClusterLoneliness == 2),  # High Loneliness
  evidence = (ClusterSocialAnxiety == high_anxiety_value),  # High Social Anxiety
  method = "ls",
  n = 100000
)
cat("P(High Loneliness | ClusterSocialAnxiety = High):", prob_high_loneliness_given_high_anxiety, "\n")

prob_high_happiness_given_high_anxiety <- cpquery(
  fitted = fitted_model,
  event = (ClusterHappiness == 2),  # High Happiness
  evidence = (ClusterSocialAnxiety == high_anxiety_value),  # High Social Anxiety
  method = "ls",
  n = 100000
)
cat("P(High Happiness | ClusterSocialAnxiety = High):", prob_high_happiness_given_high_anxiety, "\n")

prob_high_smu_given_high_anxiety <- cpquery(
  fitted = fitted_model,
  event = (ClusterSocialMediaUse == 2),  # High Social Media Use
  evidence = (ClusterSocialAnxiety == high_anxiety_value),  # High Social Anxiety
  method = "ls",
  n = 100000
)
cat("P(High Social Media Use | ClusterSocialAnxiety = High):", prob_high_smu_given_high_anxiety, "\n")




# Probability calculations for "Low Social Anxiety" (ClusterSocialAnxiety = 1)
low_anxiety_value <- 1

# Conditional probabilities when Social Anxiety is "Low"
prob_high_loneliness_given_low_anxiety <- cpquery(
  fitted = fitted_model,
  event = (ClusterLoneliness == 2),  # High Loneliness
  evidence = (ClusterSocialAnxiety == low_anxiety_value),  # Low Social Anxiety
  method = "ls",
  n = 100000
)
cat("P(High Loneliness | ClusterSocialAnxiety = Low):", prob_high_loneliness_given_low_anxiety, "\n")

prob_high_happiness_given_low_anxiety <- cpquery(
  fitted = fitted_model,
  event = (ClusterHappiness == 2),  # High Happiness
  evidence = (ClusterSocialAnxiety == low_anxiety_value),  # Low Social Anxiety
  method = "ls",
  n = 100000
)
cat("P(High Happiness | ClusterSocialAnxiety = Low):", prob_high_happiness_given_low_anxiety, "\n")

prob_high_smu_given_low_anxiety <- cpquery(
  fitted = fitted_model,
  event = (ClusterSocialMediaUse == 2),  # High Social Media Use
  evidence = (ClusterSocialAnxiety == low_anxiety_value),  # Low Social Anxiety
  method = "ls",
  n = 100000
)
cat("P(High Social Media Use | ClusterSocialAnxiety = Low):", prob_high_smu_given_low_anxiety, "\n")




# Baseline probabilities (calculated without specific evidence or intervention)
baseline_anxiety <- cpquery(
  fitted = fitted_model,
  event = (ClusterSocialAnxiety == 2),  # High Social Anxiety
  evidence = TRUE,
  method = "ls",
  n = 100000
)
cat("Baseline P(High Social Anxiety):", baseline_anxiety, "\n")

baseline_loneliness <- cpquery(
  fitted = fitted_model,
  event = (ClusterLoneliness == 2),  # High Loneliness
  evidence = TRUE,
  method = "ls",
  n = 100000
)
cat("Baseline P(High Loneliness):", baseline_loneliness, "\n")

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




# Impact of interventions when high social anxiety
cat("Change in P(High Loneliness | High Social Anxiety):", prob_high_loneliness_given_high_anxiety - baseline_loneliness, "\n")
cat("Change in P(High Happiness | High Social Anxiety):", prob_high_happiness_given_high_anxiety - baseline_happiness, "\n")
cat("Change in P(High Social Media Use | High Social Anxiety):", prob_high_smu_given_high_anxiety - baseline_smu, "\n")


# low social anxiety
cat("Change in P(High Loneliness | Low Social Anxiety):", prob_high_loneliness_given_low_anxiety - baseline_loneliness, "\n")
cat("Change in P(High Happiness | Low Social Anxiety):", prob_high_happiness_given_low_anxiety - baseline_happiness, "\n")
cat("Change in P(High Social Media Use | Low Social Anxiety):", prob_high_smu_given_low_anxiety - baseline_smu, "\n")
