library(bnlearn)
library(readxl)
library(Rgraphviz)

# Load the data
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

# Probability calculations for "High Happiness" (ClusterHappiness = 2)
high_happiness_value <- 2

# Conditional probabilities when Happiness is "High"
prob_high_loneliness_given_high_happiness <- cpquery(
  fitted = fitted_model,
  event = (ClusterLoneliness == 2),  # High Loneliness
  evidence = (ClusterHappiness == high_happiness_value),  # High Happiness
  method = "ls",
  n = 100000
)
cat("P(High Loneliness | ClusterHappiness = High):", prob_high_loneliness_given_high_happiness, "\n")

prob_high_anxiety_given_high_happiness <- cpquery(
  fitted = fitted_model,
  event = (ClusterSocialAnxiety == 2),  # High Social Anxiety
  evidence = (ClusterHappiness == high_happiness_value),  # High Happiness
  method = "ls",
  n = 100000
)
cat("P(High Social Anxiety | ClusterHappiness = High):", prob_high_anxiety_given_high_happiness, "\n")

prob_high_smu_given_high_happiness <- cpquery(
  fitted = fitted_model,
  event = (ClusterSocialMediaUse == 2),  # High Social Media Use
  evidence = (ClusterHappiness == high_happiness_value),  # High Happiness
  method = "ls",
  n = 100000
)
cat("P(High Social Media Use | ClusterHappiness = High):", prob_high_smu_given_high_happiness, "\n")








# Probability calculations for "Low Happiness" (ClusterHappiness = 1)
low_happiness_value <- 1

# Conditional probabilities when Happiness is "Low" clusterhappiness=1
prob_high_loneliness_given_low_happiness <- cpquery(
  fitted = fitted_model,
  event = (ClusterLoneliness == 2),  # High Loneliness
  evidence = (ClusterHappiness == low_happiness_value),  # Low Happiness
  method = "ls",
  n = 100000
)
cat("P(High Loneliness | ClusterHappiness = Low):", prob_high_loneliness_given_low_happiness, "\n")

prob_high_anxiety_given_low_happiness <- cpquery(
  fitted = fitted_model,
  event = (ClusterSocialAnxiety == 2),  # High Social Anxiety
  evidence = (ClusterHappiness == low_happiness_value),  # Low Happiness
  method = "ls",
  n = 100000
)
cat("P(High Social Anxiety | ClusterHappiness = Low):", prob_high_anxiety_given_low_happiness, "\n")

prob_high_smu_given_low_happiness <- cpquery(
  fitted = fitted_model,
  event = (ClusterSocialMediaUse == 2),  # High Social Media Use
  evidence = (ClusterHappiness == low_happiness_value),  # Low Happiness
  method = "ls",
  n = 100000
)
cat("P(High Social Media Use | ClusterHappiness = Low):", prob_high_smu_given_low_happiness, "\n")





# Baseline probabilities (calculated without specific evidence or intervention)
baseline_happiness <- cpquery(
  fitted = fitted_model,
  event = (ClusterHappiness == 2),  # High Happiness
  evidence = TRUE,
  method = "ls",
  n = 100000
)
cat("Baseline P(High Happiness):", baseline_happiness, "\n")

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

baseline_smu <- cpquery(
  fitted = fitted_model,
  event = (ClusterSocialMediaUse == 2),  # High Social Media Use
  evidence = TRUE,
  method = "ls",
  n = 100000
)
cat("Baseline P(High Social Media Use):", baseline_smu, "\n")




# Impact of interventions i.e after changing hppiness to high or low 
cat("Change in P(High Loneliness | High Happiness):", prob_high_loneliness_given_high_happiness - baseline_loneliness, "\n")
cat("Change in P(High Social Anxiety | High Happiness):", prob_high_anxiety_given_high_happiness - baseline_anxiety, "\n")
cat("Change in P(High Social Media Use | High Happiness):", prob_high_smu_given_high_happiness - baseline_smu, "\n")

cat("Change in P(High Loneliness | Low Happiness):", prob_high_loneliness_given_low_happiness - baseline_loneliness, "\n")
cat("Change in P(High Social Anxiety | Low Happiness):", prob_high_anxiety_given_low_happiness - baseline_anxiety, "\n")
cat("Change in P(High Social Media Use | Low Happiness):", prob_high_smu_given_low_happiness - baseline_smu, "\n")
