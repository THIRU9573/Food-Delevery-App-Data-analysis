import pandas as pd
import numpy as np
import warnings
warnings.filterwarnings("ignore")

def read_data_from_csv():
    hotels=pd.read_csv('zomato.csv')
    return hotels


def remove_unwanted_columns():
    #DO NOT REMOVE FOLLOWING LINE
    #call read_data_from_csv() function to get dataframe
    hotels=read_data_from_csv()

    unwanted_columns = ['address','phone']
    hotels = hotels.drop(unwanted_columns,axis = 1)
    
    return hotels


def rename_columns():
    #DO NOT REMOVE FOLLOWING LINE
    #call remove_unwanted_columns() function to get dataframe
    hotels = remove_unwanted_columns()
    
    #task2: rename columns,  only these columns are allowed in the dataset
    # 1.	Id
    # 2.	Name
    # 3.	online_order
    # 4.	book_table
    # 5.	rating
    # 6.	votes
    # 7.	location
    # 8.	rest_type
    # 9.	dish_liked
    # 10.	cuisines
    # 11.	approx_cost
    # 12.	type
    column_names = {
        'name':'name', 
        'online_order':'online_order',
        'book_table':'book_table',
        'rate':'rating',
        'votes':'votes',
        'location':'location',
        'rest_type':'rest_type',
        'dish_liked':'dish_liked',
        'cuisines':'cuisines',
        'approx_cost(for two people)':'approx_cost',
        'listed_in(type)':'type'
          }
    hotels = hotels.rename(columns=column_names)
    return hotels


#task3: handle  null values of each column
def null_value_check():
    hotels = rename_columns()

    # drop null values in the 'Name' column
    hotels = hotels.dropna(subset=['name'])

    # replace null values of Online_order with 'NA'
    hotels['online_order'] = hotels['online_order'].fillna('NA')

    # replace null values of Book_table with 'NA'
    hotels['book_table'] = hotels['book_table'].fillna('NA')

    # replace null values of Rating with 0
    hotels['rating'] = hotels['rating'].fillna(0)

    # replace null values of Votes with 0
    hotels['votes'] = hotels['votes'].fillna(0)

    # replace null values of Location with 'NA'
    hotels['location'] = hotels['location'].fillna('NA')

    # replace null values of Rest_type with 'NA'
    hotels['rest_type'] = hotels['rest_type'].fillna('NA')

    # replace null values of Dish_liked with 'NA'
    hotels['dish_liked'] = hotels['dish_liked'].fillna('NA')

    # replace null values of Cuisines with 'NA'
    hotels['cuisines'] = hotels['cuisines'].fillna('NA')

    # replace null values of Approx_cost with 0
    hotels['approx_cost'] = hotels['approx_cost'].fillna(0)

    # replace null values of Type with 'NA'
    hotels['type'] = hotels['type'].fillna('NA')

    return hotels



#task4 #find duplicates in the dataset
def find_duplicates():
    #DO NOT REMOVE FOLLOWING LINE
    #call null_value_check() function to get dataframe
    hotels=null_value_check()
    
    #droping the duplicates value keeping the first
    hotels = hotels.drop_duplicates(keep = 'first')
    return hotels


#task5 removing irrelevant text from all the columns
def removing_irrelevant_text():
    #DO NOT REMOVE FOLLOWING LINE
    #call find_duplicates() function to get dataframe
    hotels = find_duplicates()

    hotels = hotels[hotels['name'].str.contains("RATED|Rated") == False]
    hotels = hotels[hotels['online_order'].str.contains("RATED|Rated") == False]
    hotels = hotels[hotels['book_table'].str.contains("RATED|Rated") == False]
    hotels = hotels[hotels['rating'].str.contains("RATED|Rated") == False]
    hotels = hotels[hotels['votes'].str.contains("RATED|Rated") == False]
    hotels = hotels[hotels['location'].str.contains("RATED|Rated") == False]
    hotels = hotels[hotels['rest_type'].str.contains("RATED|Rated") == False]
    hotels = hotels[hotels['dish_liked'].str.contains("RATED|Rated") == False]
    hotels = hotels[hotels['cuisines'].str.contains("RATED|Rated") == False]
    hotels = hotels[hotels['approx_cost'].str.contains("RATED|Rated") == False]
    hotels = hotels[hotels['type'].str.contains("RATED|Rated") == False]

    return hotels



#task6: check for unique values in each column and handle the irrelevant values
def check_for_unique_values():
    # DO NOT REMOVE FOLLOWING LINE
    # call removing_irrelevant_text() function to get dataframe
    hotels = removing_irrelevant_text()
    
    index = hotels[~hotels['online_order'].isin(['No', 'Yes'])].index
    hotels.drop(index, inplace = True)
    hotels['rating'] = hotels['rating'].replace({'/5': ''}, regex = True).replace('-', 0).replace('NEW', 0)
    
    return hotels   

#task7: remove the unknown character from the dataset and export it to "zomatocleaned.csv"
def remove_the_unknown_character():
    #DO NOT REMOVE FOLLOWING LINE
    #call check_for_unique_values() function to get dataframe
    dataframe=check_for_unique_values()


    #remove unknown character from dataset
    dataframe['name'] = dataframe['name'].str.replace('[Ãx][^A-Za-z]+', '')
    
    dataframe['approx_cost'] = dataframe['approx_cost'].str.replace(",","")
    dataframe['approx_cost'] = dataframe['approx_cost'].str.strip('"')
    dataframe.rename_axis('id')
    
    #export cleaned Dataset to newcsv file named "zomatocleaned.csv"
    dataframe.to_csv('zomatocleaned.csv')
    return dataframe


#check if mysql table is created using "zomatocleaned.csv"
#Use this final dataset and upload it on the provided database for performing analysis in  MySQL
#To Run this task first Run the appliation for Terminal to create table named 'Zomato' and then run test.
def start():
    remove_the_unknown_character()

def task_runner():
    start()
