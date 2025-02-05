# Load the necessary libraries
library(readxl)
library(cluster)
library(dendextend)
library(dplyr)
library(tidyr)
library(writexl)

combine_and_cluster <- function(input_file, output_file) {
  # Read data from the provided path
  data <- read_excel(input_file)
  
  # Remove rows with NA values
  data <- na.omit(data)
  
  ######### Process social_media_use Data #########
  data_social_media_use <- subset(data, select = -c(14:35))
  data_to_convert <- subset(data_social_media_use, select = -c(7))
  data_converted <- lapply(data_to_convert, function(x) as.factor(x))
  data_social_media_use[, names(data_to_convert)] <- data_converted
  
  ######### Process Happiness Data #########
  data_happiness <- subset(data, select = -c(1:13, 22:35))
  data_happiness[] <- lapply(data_happiness, function(x) if(is.character(x)) as.factor(x) else x)
  
  ######### Process Loneliness Data #########
  data_loneliness <- subset(data, select = -c(1:21, 30:35))
  data_loneliness[] <- lapply(data_loneliness, function(x) if(is.character(x)) as.factor(x) else x)
  
  ######### Process Social Anxiety Data #########
  data_social_anxiety <- subset(data, select = -c(1:29))
  data_social_anxiety[] <- lapply(data_social_anxiety, function(x) if(is.character(x)) as.factor(x) else x)
  
  #### Clustering Function ####
  perform_clustering <- function(data, num_clusters) {
    gower_dist <- daisy(data, metric = "gower")
    hclust_gower <- hclust(gower_dist, method = "ward.D2")
    clusters <- cutree(hclust_gower, k = num_clusters)
    return(clusters)
  }
  
  # Clustering for social media use (4 clusters)
  clusters_social_media_use <- perform_clustering(data_social_media_use, num_clusters = 4)
  data$Clustersocial_media_use <- clusters_social_media_use
  
  # Clustering for Happiness, Loneliness, and Social Anxiety (2 clusters each)
  clusters_happiness <- perform_clustering(data_happiness, num_clusters = 2)
  data$ClusterHappiness <- clusters_happiness
  
  clusters_loneliness <- perform_clustering(data_loneliness, num_clusters = 2)
  data$ClusterLoneliness <- clusters_loneliness
  
  clusters_social_anxiety <- perform_clustering(data_social_anxiety, num_clusters = 2)
  data$ClusterSocialAnxiety <- clusters_social_anxiety
  
  #### Cross-Tabulations ####
  cross_tab_social_loneliness <- data %>%
    group_by(Clustersocial_media_use, ClusterLoneliness) %>%
    tally() %>%
    spread(ClusterLoneliness, n, fill = 0)
  
  cross_tab_social_happiness <- data %>%
    group_by(Clustersocial_media_use, ClusterHappiness) %>%
    tally() %>%
    spread(ClusterHappiness, n, fill = 0)
  
  cross_tab_social_anxiety <- data %>%
    group_by(Clustersocial_media_use, ClusterSocialAnxiety) %>%
    tally() %>%
    spread(ClusterSocialAnxiety, n, fill = 0)
  
  # Print the cross-tabulation results
  print(cross_tab_social_loneliness)
  print(cross_tab_social_happiness)
  print(cross_tab_social_anxiety)
  
  # Write clustered data and cross-tabulation results to the output file
  write_xlsx(data, output_file)
}

#reading both files.
input_file_path_all = 'D:/final_year_project/data/preprocessing/needed_data_all_students.xlsx'
input_file_path_1st_year='D:/final_year_project/data/preprocessing/needed_data_1st_year.xlsx'
input_file_path_4th_year='D:/final_year_project/data/preprocessing/needed_data_1st_year.xlsx'


output_file_path_all = 'D:/final_year_project/data/operation/alldata_clustered_and_crosstable.xlsx'
output_file_path_1st_year='D:/final_year_project/data/operation/1st_year_data_needed_clustered.xlsx'
output_file_path_4th_year='D:/final_year_project/data/operation/4th_year_data_needed_clustered.xlsx'


# Call the function for each file
combine_and_cluster(input_file_path_all, output_file_path_all)
combine_and_cluster(input_file_path_1st_year, output_file_path_1st_year)
combine_and_cluster(input_file_path_4th_year, output_file_path_4th_year)