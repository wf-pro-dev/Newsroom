import os
from sys import path
import json
from google import genai
from google.genai import types
from io import BytesIO

current_dir = os.path.dirname(os.path.abspath(__file__))
project_root = os.path.abspath(os.path.join(current_dir, "../../../"))
backend_root = project_root + "/Backend"
path.append(backend_root)

from api.aws.client import upload_to_s3

# Create the model
client = genai.Client(api_key="AIzaSyDJZHtPKR7HiGBVOf2e6Pnq0cADvM3ddWc")

EXAMPLE = ( 'Create a semi-realistic image for a professional news website about Climate Change, focusing on the transition to renewable energy.'
          'The scene should depict wind turbines or solar panels in a visually appealing landscape, perhaps with a city skyline in the background.'
          'Use a dark blue color palette, incorporating navy, indigo, and deep azure tones for the sky and landscape elements.'
          'The design should be minimalistic, clean, and modern, with a balanced and uncluttered composition'
          '. Aim for a professional, contemporary, and sleek visual mood.'
          'Ensure high-resolution and crisp details. The lighting should be soft and subdued to create depth,'
          'emphasizing the scale and importance of renewable energy infrastructure.'
          'Use smooth gradients to add subtle depth.'
          'The image should convey a sense of hope and progress in combating climate change through sustainable solutions.' )


def fetch_gen_ai(prompt: str) -> list:
    """
    This function sends a prompt to the GenAI API and returns the ONLY key's value from the JSON response.

    Parameters:
    prompt (str): The prompt to be sent to the GenAI API for generating a response.

    Returns:
    list: The value of the ONLY key from the JSON response.
    """
    
    generation_config = types.GenerateContentConfig(
      temperature = 1,
      top_p = 0.95,
      top_k = 40,
      max_output_tokens = 8192,
      response_mime_type = "application/json",
    )
    
    response = client.models.generate_content(
        model="gemini-2.0-flash",
        config=generation_config,
        contents=prompt
    )
    # Extract and print the generated JSON schema
    schema = response.text

    obj_response = json.loads(schema)


    return obj_response

def fetch_prompt_image_gen_ai(topic: str) -> list:
    """
    This function sends a prompt to the GenAI API and returns the ONLY key's value from the JSON response.

    Parameters:
    prompt (str): The prompt to be sent to the GenAI API for generating a response.

    Returns:
    list: The value of the ONLY key from the JSON response.
    """
    
    prompt = f"""
            Generate prompts for image generation models that follows those requirements :
            'Professional news website image for {topic}:
            - Style: Semi-realistic 
            - Color Palette: Dark blue tones (navy, indigo, deep azure)
            - Design Approach: Minimalistic, clean, modern aesthetic
            - Composition: Balanced, uncluttered 
            - Visual Mood: Professional, contemporary, sleek
            - Technical Quality: High-resolution, crisp details
            - Lighting: Soft, subdued, creating depth
            - Texture: Smooth gradients, subtle depth'
            - Negative Prompt: No Text,
            Focus on creating 3 detailed and clear scenes that reflects the topic and meet the requirements.
            Format: Only inclue a list of the scene in the response.
            Example of scene : {EXAMPLE}
            """
    
    
    response = client.models.generate_content(
        model="gemini-2.0-flash",
        contents=prompt
    )

    
    list_prompts = list(filter(lambda x : x != '',response.text.split('\n')))

    return list_prompts
  

def fetch_image_gen_ai(prompt: str,topic_id: int,index: int) -> str:
    """
    Generates an image based on the given prompt using Gemini API and upload it to a s3 bucket.
    
    Parameters:
    prompt (str): The prompt describing the image to generate.
    
    Returns:
    str: Path to the saved image file or None if generation failed.
    """
    image_url = ""  

    try:
      response = client.models.generate_content(
        model="gemini-2.0-flash-exp-image-generation",
        contents="Only include Image in your response ."+prompt,
        config=types.GenerateContentConfig(
          response_modalities=["Text",'Image']
        )
      )
      for part in response.candidates[0].content.parts:
        if part.text is not None:
          print(part.text)
        elif part.inline_data is not None:
          image_data = BytesIO(part.inline_data.data)
              # Upload to S3 and get UR
          image_url = upload_to_s3(image_data, topic_id, index)
      
    except Exception as e:
      print("Error fetching images :",e)
       
    return image_url
        

    

if __name__ == "__main__" :

  
  list_prompts = fetch_prompt_image_gen_ai("Education")
  for i ,prompt in enumerate(list_prompts):
    fetch_image_gen_ai(prompt=prompt, topic_id=5, index=i)