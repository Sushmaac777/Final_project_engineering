
import pandas as pd

# Function to load, drop columns, and save the file
def process_file(input_path, output_path):
    # Load the Excel file
    df = pd.read_excel(input_path)
    
    # Drop columns A to F (index 0 to 5)
    df_dropped = df.drop(df.columns[0:6], axis=1)
    
    # Save the updated DataFrame to a new Excel file
    df_dropped.to_excel(output_path, index=False)

# Paths to the files
input_1st_year = 'D:/final_year_project/data/preprocessing/filtered_1st_year_students.xlsx'
input_4th_year = 'D:/final_year_project/data/preprocessing/filtered_4th_year_students.xlsx'
input_all_year = 'D:/final_year_project/data/preprocessing/filtered_all_students.xlsx'


output_1st_year = 'D:/final_year_project/data/preprocessing/needed_data_1st_year.xlsx'
output_4th_year = 'D:/final_year_project/data/preprocessing/needed_data_4th_year.xlsx'
output_all_year = 'D:/final_year_project/data/preprocessing/needed_data_all_students.xlsx'

# Process 1st year and 4th year files
process_file(input_1st_year, output_1st_year)
process_file(input_4th_year, output_4th_year)
process_file(input_all_year, output_all_year)


print("Files successfully created.")

