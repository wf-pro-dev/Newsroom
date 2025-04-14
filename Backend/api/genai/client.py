import json
from google import genai
from google.genai import types
from PIL import Image
from io import BytesIO
import base64


# Create the model
client = genai.Client(api_key="AIzaSyDJZHtPKR7HiGBVOf2e6Pnq0cADvM3ddWc")


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
            Focus on creating 3 detailed and clear scenes that reflects the topic and meet the requirements.
            Format: Only inclue a list of the scene in the response.
            """
    
    
    response = client.models.generate_content(
        model="gemini-2.0-flash",
        contents=prompt
    )

    
    list_prompts = list(filter(lambda x : x != '',response.text.split('\n')))

    return list_prompts
  

def fetch_image_gen_ai(prompt: str,topic_id: int,index: int) -> list:
    """
      Generates an image based on the given prompt using Gemini API and saves it to a file.
      
      Parameters:
      prompt (str): The prompt describing the image to generate.
      
      Returns:
      str: Path to the saved image file or None if generation failed.
      """
      
    output_path=f"/home/will/Newsroom/public/topic_img/topic_{topic_id}_{index}.webp"

    response = client.models.generate_content(
      model="gemini-2.0-flash-exp-image-generation",
      contents=prompt,
      config=types.GenerateContentConfig(
        response_modalities=['Text', 'Image']
      )
    )

    for part in response.candidates[0].content.parts:
      if part.text is not None:
        print(part.text)
      elif part.inline_data is not None:
        image = Image.open(BytesIO((part.inline_data.data)))
        image = image.convert('RGB')
        image.save(output_path, 'webp', optimize=True, quality=80)

        return output_path
        

    

if __name__ == "__main__" :
  prompt = ( 'Create a semi-realistic image for a professional news website about Climate Change, focusing on the transition to renewable energy.'
            'The scene should depict wind turbines or solar panels in a visually appealing landscape, perhaps with a city skyline in the background.'
            'Use a dark blue color palette, incorporating navy, indigo, and deep azure tones for the sky and landscape elements.'
            'The design should be minimalistic, clean, and modern, with a balanced and uncluttered composition'
            '. Aim for a professional, contemporary, and sleek visual mood.'
            'Ensure high-resolution and crisp details. The lighting should be soft and subdued to create depth,'
            'emphasizing the scale and importance of renewable energy infrastructure.'
            'Use smooth gradients to add subtle depth.'
            'The image should convey a sense of hope and progress in combating climate change through sustainable solutions.' )
  
  list_prompts = fetch_prompt_image_gen_ai("Climate Change")
  for i ,prompt in enumerate(list_prompts):
    fetch_image_gen_ai(prompt=prompt, topic_id=1, index=i)