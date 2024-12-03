import json
from typing import Optional
from io import BytesIO
import requests
from openai import OpenAI
from PIL import Image


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
        messages=[{"role": "user", "content": prompt}],
        response_format={"type": "json_object"},
    )

    # Extract and print the generated JSON schema
    schema = response.choices[0].message.content

    obj_response = json.loads(schema)

    # Possible because of unique key
    first_key = list(obj_response.keys())[0]

    return obj_response[first_key]

def download_and_optimize(
        image_url: str, 
        output_path: str, 
        max_size: tuple = (1792,1024)
    ) -> str:
        """
        Download and optimize image for web
        
        Args:
            image_url (str): Source image URL
            output_path (str): Local save path
            max_size (tuple): Maximum image dimensions
        
        Returns:
            bool: Success status
        """
        try:
            response = requests.get(image_url)
            img = Image.open(BytesIO(response.content))
            
            # Resize maintaining aspect ratio
            img.thumbnail(max_size, Image.LANCZOS)
            
            # Convert to web-friendly format
            img = img.convert('RGB')
            img.save(output_path, 'webp', optimize=True, quality=80)
            
            return output_path
        
        except Exception as e:
            print(f"Image optimization error: {e}")
            return ""

def fetch_image(
    topic: str, index:int, size: Optional[str] = "1792x1024", quality: Optional[str] = "standard"
) -> str:
    """
    Generate a web-friendly image for a given topic

    Args:
        topic (str): Description of image content
        size (str, optional): Image dimensions
        quality (str, optional): Image quality

    Returns:
        str: URL of generated image
    """
    try:
        prompt = f"""
            Professional news website image for {topic}:
            - Style: Semi-realistic 
            - Color Palette: Dark blue tones (navy, indigo, deep azure)
            - Design Approach: Minimalistic, clean, modern aesthetic
            - Composition: Balanced, uncluttered 
            - Visual Mood: Professional, contemporary, sleek
            - Technical Quality: High-resolution, crisp details
            - Lighting: Soft, subdued, creating depth
            - Texture: Smooth gradients, subtle depth
            """

        response = client.images.generate(
            model="dall-e-3",
            prompt=prompt,
            size=size,
            quality=quality,
            n=1,
        )
        
        local_url = download_and_optimize(response.data[0].url,topic.replace(" ","_")+index)
        print(response.data[0].url,end="\n\n")
        
        return local_url

    except Exception as e:
        print(f"Image generation error: {e}")
        return None


# Example usage
