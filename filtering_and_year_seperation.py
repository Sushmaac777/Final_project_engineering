
#removing unnecessary rows and seperation of data
import pandas as pd

# Load data
file_path = 'D:/final_year_project/data/preprocessing/collected_data.xlsx'
df = pd.read_excel(file_path)

# Remove rows where 'Do you have Instagram account?' column contains 'No'
df_filtered = df[df['Do you have Instagram account?'] != 'No']

# Split filtered data based on the 'Year' column
df_1st_year_filtered = df_filtered[df_filtered['Year'] == '1st year']
df_4th_year_filtered = df_filtered[df_filtered['Year'] == '4th year']
df_filtered_all = df[df['Do you have Instagram account?'] != 'No']

# Save the filtered data into two separate Excel files
df_1st_year_filtered.to_excel('D:/final_year_project/data/preprocessing/filtered_1st_year_students.xlsx', index=False)
df_4th_year_filtered.to_excel('D:/final_year_project/data/preprocessing/filtered_4th_year_students.xlsx', index=False)
df_filtered_all.to_excel('D:/final_year_project/data/preprocessing/filtered_all_students.xlsx', index=False)

print("Files successfully created.")



