"""I remembered how I did this with the cdk exercise and reconstruced the code from there
https://cdkworkshop.com/30-python/40-hit-counter/200-handler.html

Also, this StackOverflow entry was clutch!
https://stackoverflow.com/questions/37053595/how-do-i-conditionally-insert-an-item-into-a-dynamodb-table-using-boto3
"""

from pprint import pprint
import json
import os
import test

import boto3
from botocore.exceptions import ClientError

ddb = boto3.resource('dynamodb')

def update_counts_table(table_name, key_name, path_value):
    table=ddb.Table(table_name)
    #put if the path doesn't exist and set the counts value to 0
    ConditionStatement='attribute_not_exists(' +str(key_name)+ ')'
    try:
        table.put_item(
            Item={key_name:path_value, 'counts': 0, },
            ConditionExpression=ConditionStatement
            )
    except ClientError as e:
        # Ignore the ConditionalCheckFailedException, bubble up
        # other exceptions.
        if e.response['Error']['Code'] != 'ConditionalCheckFailedException': 
            raise
    table.update_item(
        Key={key_name:path_value,}, 
        UpdateExpression='ADD counts :incr', 
        ExpressionAttributeValues={':incr': 1})

def get_latest_count(table_name, key_name, path_value):
    table=ddb.Table(table_name)
    try:
        count_item=table.get_item (
        Key={key_name:path_value,}, 
        )
    except ClientError as e:
        raise
    return(count_item['Item']['counts'])
def lambda_handler(event, context):
    
    #setup for unit_test
    #test.test_get_visitors_counter()
    
    update_counts_table('justinthibault.xyz-counterdb', 'URL_path', '/')
    
    return {
    'statusCode': 200,
    'headers': {
            'Content-Type': 'text/plain',
            'Access-Control-Allow-Headers': '*',
            'Access-Control-Allow-Origin': 'https://www.justinthibault.xyz',
            'Access-Control-Allow-Methods': '*'
        },
        # counts_table & counts_table_key are set up as variables when the lambda function was made
        'body': get_latest_count(os.environ['main_table'], os.environ['main_table_key'], '/')
    }