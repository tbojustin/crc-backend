#inspiration: https://towardsdatascience.com/how-i-write-meaningful-tests-for-aws-lambda-functions-f009f0a9c587
#TODO: Learn how to install packages on AWS Lambda. I couldn't get moto working.

import boto3
import unittest
import os
import random 
import main 


def test_get_visitors_counter():
    #setup a mock database
    counter_table = os.environ['main_table']
    dynamodb = boto3.resource('dynamodb', 'us-east-1')
    counter_key = os.environ['main_table_key']
    
    #instead of the path value being a fixed string, I'm just going to use a random number
    random_path = str(random.randint(1, 1000))
    # Put default value into the table
    main.update_counts_table(counter_table, counter_key, random_path)
    print('Random Path Value: {}'.format(random_path))
    # That should be equal to one visit
    response = main.get_latest_count(counter_table, counter_key, random_path)
    print('Retreived value of {} from table'.format(response))
    assert response == 1
    #test update
    main.update_counts_table(counter_table, counter_key, random_path)
    update_response = main.get_latest_count(counter_table, counter_key, random_path)
    print('Retreived udpated value of {} from table'.format(update_response))
    assert update_response == response + 1 