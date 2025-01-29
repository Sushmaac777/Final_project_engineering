
import pandas as pd


#####1.removing unnecessary columns 
# Load data
file_path = 'D:/final_year_project/data/preprocessing/collected_data.xlsx'
df = pd.read_excel(file_path)

# Remove rows where 'Do you have Instagram account?' column contains 'No'
df_filtered = df[df['Do you have Instagram account?'] != 'No']

####2. Split filtered data based on the 'Year' column on remaining data
df_1st_year_filtered = df_filtered[df_filtered['Year'] == '1st year']
df_4th_year_filtered = df_filtered[df_filtered['Year'] == '4th year']
df_filtered_all = df[df['Do you have Instagram account?'] != 'No']

# Save the filtered data into two separate Excel files
df_1st_year_filtered.to_excel('D:/final_year_project/data/preprocessing/filtered_1st_year_students.xlsx', index=False)
df_4th_year_filtered.to_excel('D:/final_year_project/data/preprocessing/filtered_4th_year_students.xlsx', index=False)
df_filtered_all.to_excel('D:/final_year_project/data/preprocessing/filtered_all_students.xlsx', index=False)





#3. removal of unnecessary columns for operation and save the file
def process_file(input_path, output_path):
    df = pd.read_excel(input_path)
    # Drop columns A to F (index 0 to 5)
    df_dropped = df.drop(df.columns[0:6], axis=1)
    # Save the updated DataFrame to a new Excel file
    df_dropped.to_excel(output_path, index=False)

input_1st_year = 'D:/final_year_project/data/preprocessing/filtered_1st_year_students.xlsx'
input_4th_year = 'D:/final_year_project/data/preprocessing/filtered_4th_year_students.xlsx'
input_all_year = 'D:/final_year_project/data/preprocessing/filtered_all_students.xlsx'

output_1st_year = 'D:/final_year_project/data/preprocessing/needed_data_1st_year.xlsx'
output_4th_year = 'D:/final_year_project/data/preprocessing/needed_data_4th_year.xlsx'
output_all_year = 'D:/final_year_project/data/preprocessing/needed_data_all_students.xlsx'

#fn call
process_file(input_1st_year, output_1st_year)
process_file(input_4th_year, output_4th_year)
process_file(input_all_year, output_all_year)




####4. Seperation of sheets social media use, Loneliless , Social Anxiety, happinesH

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
    

   
separate_output_all_year = 'D:/final_year_project/data/preprocessing/sheets_seperated_all_year.xlsx'
separate_output_1st_year = 'D:/final_year_project/data/preprocessing/sheets_seperated_1st_year.xlsx'
separate_output_4th_year = 'D:/final_year_project/data/preprocessing/sheets_seperated_4th_year.xlsx'

# calling the fn with file paths
process_and_save_data(output_all_year,separate_output_all_year)
process_and_save_data(output_1st_year,separate_output_1st_year)
process_and_save_data(output_4th_year,separate_output_4th_year)




######5. fn for encode data and save as a new file
def encode_data(input_path, output_path):
    df = pd.read_excel(input_path)

    # categoric variable to numeric codes using cat.codes whicg assigne value based on alphabetical order starting from 0
    suffix = "_codes"
    for col in df.columns:
        if col != 'Email' and col != 'Timestamp':
            df[col] = pd.Categorical(df[col])  # Convert Column to Categorical Data
            df[col] = df[col].cat.codes        
    df.to_excel(output_path, index=False)

encoded_output_1st_year = 'D:/final_year_project/data/preprocessing/encoded_data_1st_year.xlsx'
encoded_output_4th_year = 'D:/final_year_project/data/preprocessing/encoded_data_4th_year.xlsx'
encoded_output_all_year = 'D:/final_year_project/data/preprocessing/encoded_data_all_students.xlsx'

# Encode and save the needed data files
encode_data(output_1st_year, encoded_output_1st_year)
encode_data(output_4th_year, encoded_output_4th_year)
encode_data(output_all_year, encoded_output_all_year)





###6. Encoded data to seprate sheets
# Paths to the encoded files
encoded_output_1st_year = 'D:/final_year_project/data/preprocessing/encoded_data_1st_year.xlsx'
encoded_output_4th_year = 'D:/final_year_project/data/preprocessing/encoded_data_4th_year.xlsx'
encoded_output_all_year = 'D:/final_year_project/data/preprocessing/encoded_data_all_students.xlsx'

# Output paths for the separated data
encoded_separate_output_1st_year = 'D:/final_year_project/data/preprocessing/encoded_separate_data_1st_year.xlsx'
encoded_separate_output_4th_year = 'D:/final_year_project/data/preprocessing/encoded_separate_data_4th_year.xlsx'
encoded_separate_output_all_year = 'D:/final_year_project/data/preprocessing/encoded_separate_data_all_students.xlsx'

# Separate data for each encoded file
process_and_save_data(encoded_output_1st_year, encoded_separate_output_1st_year)
process_and_save_data(encoded_output_4th_year, encoded_separate_output_4th_year)
process_and_save_data(encoded_output_all_year, encoded_separate_output_all_year)

print("Files have been successfully created and encoded.")

