# -*- coding: utf-8 -*-
"""
Created on Sun Feb  2 20:51:16 2025

@author: Sushm
"""
import pandas as pd
import pingouin as pg

file_path = 'encoded_separate_data.xlsx'
df = pd.read_excel(file_path)
data = pd.read_excel(file_path)

#Happiness data
happiness_data = pd.read_excel(file_path, sheet_name='Happiness')
#social anxiety
social_anxiety_data = pd.read_excel(file_path, sheet_name='Social Anxiety')
#social media use
social_media_data = pd.read_excel(file_path, sheet_name='Social Media Use')
#loneliness
loneliness_data = pd.read_excel(file_path, sheet_name='Loneliness')


#cronbac calculation
cronbac_happiness = pg.cronbach_alpha(happiness_data)
cronbac_social_anxiety= pg.cronbach_alpha(social_anxiety_data)
cronbac_social_media_use = pg.cronbach_alpha(social_media_data)
cronbac_loneliness = pg.cronbach_alpha(loneliness_data)


print(cronbac_happiness)
print(cronbac_social_anxiety)
print(cronbac_social_media_use)
print(cronbac_loneliness)








