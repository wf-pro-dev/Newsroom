import json
from google import genai
from google.genai import types


# Create the model
generation_config = types.GenerateContentConfig(
  temperature = 1,
  top_p = 0.95,
  top_k = 40,
  max_output_tokens = 8192,
  response_mime_type = "application/json",
)

client = genai.Client(api_key="AIzaSyDJZHtPKR7HiGBVOf2e6Pnq0cADvM3ddWc")


def fetch_gen_ai(prompt: str) -> list:
    """
    This function sends a prompt to the GenAI API and returns the ONLY key's value from the JSON response.

    Parameters:
    prompt (str): The prompt to be sent to the GenAI API for generating a response.

    Returns:
    list: The value of the ONLY key from the JSON response.
    """
    
    response = client.models.generate_content(
        model="gemini-2.0-flash",
        config=generation_config,
        contents=prompt
    )
    # Extract and print the generated JSON schema
    schema = response.text

    obj_response = json.loads(schema)


    return obj_response
    
