
import pandas as pd

# removal of unnecessary columns and save the file
def process_file(input_path, output_path):
    df = pd.read_excel(input_path)
    # Drop columns A to F (index 0 to 5)
    df_dropped = df.drop(df.columns[0:6], axis=1)
    # Save the updated DataFrame to a new Excel file
    df_dropped.to_excel(output_path, index=False)

input_1st_year = 'D:/4th year project/data/preprocessing/filtered_1st_year_students.xlsx'
input_4th_year = 'D:/4th year project/data/preprocessing/filtered_4th_year_students.xlsx'
input_all_year = 'D:/4th year project/data/preprocessing/filtered_all_students.xlsx'

output_1st_year = 'D:/4th year project/data/preprocessing/needed_data_1st_year.xlsx'
output_4th_year = 'D:/4th year project/data/preprocessing/needed_data_4th_year.xlsx'
output_all_year = 'D:/4th year project/data/preprocessing/needed_data_all_students.xlsx'

# Process 1st year, 4th year, and all year files
process_file(input_1st_year, output_1st_year)
process_file(input_4th_year, output_4th_year)
process_file(input_all_year, output_all_year)


#function for encode data and save as a new file
def encode_data(input_path, output_path):
    df = pd.read_excel(input_path)

    # Convert categorical variables to numeric codes
    suffix = "_codes"
    for col in df.columns:
        if col != 'Email' and col != 'Timestamp':
            df[col] = pd.Categorical(df[col])  # Convert Column to Categorical Data
            df[col] = df[col].cat.codes        # Convert Categorical Data to Numeric Codes starting from 0 alphabetically
    #The cat.codes attribute in pandas is used to encode categorical data as integer values, where each unique category is assigned a unique integer code. 
    # Save the updated DataFrame to a new Excel file
    df.to_excel(output_path, index=False)

encoded_output_1st_year = 'D:/4th year project/data/preprocessing/encoded_data_1st_year.xlsx'
encoded_output_4th_year = 'D:/4th year project/data/preprocessing/encoded_data_4th_year.xlsx'
encoded_output_all_year = 'D:/4th year project/data/preprocessing/encoded_data_all_students.xlsx'

# Encode and save the needed data files
encode_data(output_1st_year, encoded_output_1st_year)
encode_data(output_4th_year, encoded_output_4th_year)
encode_data(output_all_year, encoded_output_all_year)

print("Files have been successfully created and encoded.")

