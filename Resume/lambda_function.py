import json
import boto3
import os

dynamodb = boto3.resource("dynamodb")
table = dynamodb.Table(os.environ["DYNAMODB_TABLE_NAME"])

def lambda_handler(event,context):
    response = table.update_item(
        Key={"id" : "resume"},
        UpdateExpression=("SET visitors = if_not_exists(visitors, :zero) + :inc"),
        ExpressionAttributeValues={
            ":zero":0,
            ":inc":1,
                                   },
        ReturnValues="UPDATED_NEW"
)

    new_count = int(response['Attributes']['visitors'])

    return {
    "statusCode": 200,
    "headers":{
        "Content-Type": "application/json",
    },
    "body": json.dumps({
        "count": new_count
    })
}