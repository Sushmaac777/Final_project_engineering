
import pandas as pd

# Function to load, extract data by column ranges, and save to separate sheets
def separate_encoded_data(file_path, output_file_path):
    # Load the data from the provided path
    data = pd.read_excel(file_path)

    # Define the column ranges for each construct
    if data.shape[1] >= 35:  # Check if the DataFrame has at least 41 columns
        # Define the column ranges for each construct
        social_media_use_cols = data.columns[0:13]   # 13 columns (1 to 13)
        happiness_cols = data.columns[13:21]         # 8 columns (14 to 21)
        loneliness_cols = data.columns[21:29]        # 8 columns (22 to 29)
        social_anxiety_cols = data.columns[29:35]    # 6 columns (30 to 35)

        # Extract the data for each construct
        social_media_use_data = data[social_media_use_cols]
        happiness_data = data[happiness_cols]
        loneliness_data = data[loneliness_cols]
        social_anxiety_data = data[social_anxiety_cols]

        # Save the extracted data to separate sheets in a new Excel file
        with pd.ExcelWriter(output_file_path) as writer:
            social_media_use_data.to_excel(writer, sheet_name='Social Media Use', index=False)
            happiness_data.to_excel(writer, sheet_name='Happiness', index=False)
            loneliness_data.to_excel(writer, sheet_name='Loneliness', index=False)
            social_anxiety_data.to_excel(writer, sheet_name='Social Anxiety', index=False)

        print(f"Data saved to {output_file_path}")
    else:
        print("Error: The DataFrame does not contain enough columns for the specified ranges.")
        



# Paths to the encoded files
encoded_1st_year = 'D:/final_year_project/data/preprocessing/encoded_data_1st_year.xlsx'
encoded_4th_year = 'D:/final_year_project/data/preprocessing/encoded_data_4th_year.xlsx'
encoded_all_year = 'D:/final_year_project/data/preprocessing/encoded_data_all_students.xlsx'

# Output paths for the separated data
output_1st_year = 'D:/final_year_project/data/preprocessing/encoded_separate_data_1st_year.xlsx'
output_4th_year = 'D:/final_year_project/data/preprocessing/encoded_separate_data_4th_year.xlsx'
output_all_year = 'D:/final_year_project/data/preprocessing/encoded_separate_data_all_students.xlsx'

# Separate data for each encoded file
separate_encoded_data(encoded_1st_year, output_1st_year)
separate_encoded_data(encoded_4th_year, output_4th_year)
separate_encoded_data(encoded_all_year, output_all_year)
