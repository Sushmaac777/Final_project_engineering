library(bnlearn)
library(readxl)
library(Rgraphviz)


file_path <- "D:/final_year_project/data/operation/bayesian/train.xlsx"
data <- read_excel(file_path, sheet = "Sheet1")

columns <- c("ClusterSocialMediaUse", "ClusterHappiness", "ClusterLoneliness", "ClusterSocialAnxiety")
data_subset <- data[, columns]

data_subset <- data.frame(lapply(data_subset, as.factor))
model <- hc(data_subset, score = "aic")
fitted_model <- bn.fit(model, data_subset)


graphviz.plot(fitted_model, main = "Bayesian Network")



# Probability calculations given High Social Media Use (ClusterSocialMediaUse = 2)
high_smu_value <- 2

prob_high_anxiety_given_high_smu <- cpquery(
  fitted = fitted_model,
  event = (ClusterSocialAnxiety == 2),
  evidence = (ClusterSocialMediaUse == high_smu_value),
  method = "ls",
  n = 100000
)
cat("P(High Social Anxiety | High Social Media Use):", prob_high_anxiety_given_high_smu, "\n")

prob_high_happiness_given_high_smu <- cpquery(
  fitted = fitted_model,
  event = (ClusterHappiness == 2),
  evidence = (ClusterSocialMediaUse == high_smu_value),
  method = "ls",
  n = 100000
)
cat("P(High Happiness | High Social Media Use):", prob_high_happiness_given_high_smu, "\n")

prob_high_loneliness_given_high_smu <- cpquery(
  fitted = fitted_model,
  event = (ClusterLoneliness == 2),
  evidence = (ClusterSocialMediaUse == high_smu_value),
  method = "ls",
  n = 100000
)
cat("P(High Loneliness | High Social Media Use):", prob_high_loneliness_given_high_smu, "\n")



# Probability calculations given Low Social Media Use (ClusterSocialMediaUse = 4)
low_smu_value <- 4

prob_high_anxiety_given_low_smu <- cpquery(
  fitted = fitted_model,
  event = (ClusterSocialAnxiety == 2),
  evidence = (ClusterSocialMediaUse == low_smu_value),
  method = "ls",
  n = 100000
)
cat("P(High Social Anxiety | Low Social Media Use):", prob_high_anxiety_given_low_smu, "\n")

prob_high_happiness_given_low_smu <- cpquery(
  fitted = fitted_model,
  event = (ClusterHappiness == 2),
  evidence = (ClusterSocialMediaUse == low_smu_value),
  method = "ls",
  n = 100000
)
cat("P(High Happiness | Low Social Media Use):", prob_high_happiness_given_low_smu, "\n")

prob_high_loneliness_given_low_smu <- cpquery(
  fitted = fitted_model,
  event = (ClusterLoneliness == 2),
  evidence = (ClusterSocialMediaUse == low_smu_value),
  method = "ls",
  n = 100000
)
cat("P(High Loneliness | Low Social Media Use):", prob_high_loneliness_given_low_smu, "\n")



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
cat("Change in P(High Loneliness | High smu):", prob_high_loneliness_given_high_smu - baseline_loneliness, "\n")
cat("Change in P(High Happiness | High smu):", prob_high_happiness_given_high_smu - baseline_happiness, "\n")
cat("Change in P(High Social Comparision | High smu):", prob_high_anxiety_given_high_smu -baseline_anxiety, "\n")


# low social anxiety
cat("Change in P(High Loneliness | Low smu):", prob_high_loneliness_given_low_smu - baseline_loneliness, "\n")
cat("Change in P(High Happiness | Low smu):", prob_high_happiness_given_low_smu - baseline_happiness, "\n")
cat("Change in P(High anxiety | Low smu):", prob_high_anxiety_given_low_smu - baseline_anxiety, "\n")

