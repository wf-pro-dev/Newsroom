from sys import path
import os
import boto3
from botocore.exceptions import NoCredentialsError
from botocore.config import Config


current_dir = os.path.dirname(os.path.abspath(__file__))
project_root = os.path.abspath(os.path.join(current_dir, "../../../"))
backend_root = project_root + "/Backend"
path.append(backend_root)

from config.constants import AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEY, AWS_SESSION_TOKEN



def upload_to_s3(image_data, topic_id, index):
    """Upload image to AWS S3 and return public URL"""
    
    print("SECRET",AWS_ACCESS_KEY_ID)
    
    # AWS credentials - use environment variables in production
    session = boto3.Session(
    aws_access_key_id=AWS_ACCESS_KEY_ID,
        aws_secret_access_key=AWS_SECRET_ACCESS_KEY,
        aws_session_token=AWS_SESSION_TOKEN  
    )
    
    s3_config = Config(
        signature_version='s3v4',
        region_name='us-east-2'  # Match your bucket's region
    )
    
    
    s3_client = session.client('s3',config=s3_config)

    
    bucket_name = 'newsroom.bucket'
    object_name = f"topic_{topic_id}_{index}.webp"
    
    try:
        # Upload the file
        image_data.seek(0)
        s3_client.upload_fileobj(
            image_data, 
            bucket_name, 
            object_name, 
            ExtraArgs={'ContentType': 'image/webp'}
        )
        
         # Generate a presigned URL that expires in 7 days
        url = s3_client.generate_presigned_url(
            ClientMethod='get_object',
            Params={
                'Bucket': bucket_name,
                'Key': object_name
            },
            ExpiresIn=604800,  # 7 days in seconds
        )

        return url
    except NoCredentialsError:
        print("AWS credentials not available")
        return None