
import pandas as pd
    # Load the data
input_all_year = 'D:/final_year_project/data/preprocessing/needed_data_all_students.xlsx'
input_1st_year = 'D:/final_year_project/data/preprocessing/needed_data_1st_year.xlsx'
input_4th_year = 'D:/final_year_project/data/preprocessing/needed_data_4th_year.xlsx'

def process_and_save_data(file_path, output_file_path):
    data = pd.read_excel(file_path)

    # Check columns
    if data.shape[1] < 35:
        print("Error: The DataFrame does not contain enough columns for the specified ranges.")
        return

    # Column ranges
    social_media_use_cols = data.columns[0:13]
    happiness_cols = data.columns[13:21]
    loneliness_cols = data.columns[21:29]
    social_anxiety_cols = data.columns[29:35]

    # Extract the data for each construct
    social_media_use_data = data[social_media_use_cols]
    happiness_data = data[happiness_cols]
    loneliness_data = data[loneliness_cols]
    social_anxiety_data = data[social_anxiety_cols]

    # Save in new file and seperate sheets
    with pd.ExcelWriter(output_file_path) as writer:
        social_media_use_data.to_excel(writer, sheet_name='Social Media Use', index=False)
        happiness_data.to_excel(writer, sheet_name='Happiness', index=False)
        loneliness_data.to_excel(writer, sheet_name='Loneliness', index=False)
        social_anxiety_data.to_excel(writer, sheet_name='Social Anxiety', index=False)

    print(f"Data saved to {output_file_path}")
    

   
output_all_year = 'D:/final_year_project/data/preprocessing/sheets_seperated_all_year.xlsx'
output_1st_year = 'D:/final_year_project/data/preprocessing/sheets_seperated_1st_year.xlsx'
output_4th_year = 'D:/final_year_project/data/preprocessing/sheets_seperated_4th_year.xlsx'

# calling the fn with file paths
process_and_save_data(input_all_year,output_all_year)
process_and_save_data(input_1st_year,output_1st_year)
process_and_save_data(input_4th_year,output_4th_year)
