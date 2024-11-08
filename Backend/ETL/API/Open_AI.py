from openai import OpenAI
import json

client = OpenAI()

def fetch_open_AI(prompt: str) -> list:
    """
    This function sends a prompt to the OpenAI API and returns the ONLY key's value from the JSON response.
    
    Parameters:
    prompt (str): The prompt to be sent to the OpenAI API for generating a response.
    
    Returns:
    list: The value of the ONLY key from the JSON response.
    """
    # Make the API call
    response = client.chat.completions.create(
        model="gpt-4o-mini",
        messages=[
        {"role": "user", "content": prompt}
        ],
        response_format={ "type": "json_object" }
    )

    # Extract and print the generated JSON schema
    schema = response.choices[0].message.content
    
    obj_response = json.loads(schema)
    # Possible because of unique key
    first_key = list(obj_response.keys())[0]
    
    return obj_response[first_key]