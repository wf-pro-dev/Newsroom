import json
from typing import Optional
from io import BytesIO
import requests
from openai import OpenAI
from PIL import Image


client = OpenAI()

def fetch_open_ai(prompt: str) -> list:
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
        try:
            response = requests.get(image_url)
            response.raise_for_status()  # Raise an exception for bad HTTP responses
            
            # Check content length
            if not response.content:
                print(f"Empty response content for URL: {image_url}")
                return ""
            
            # Additional debugging
            print(f"Response content length: {len(response.content)} bytes")
            
            img = Image.open(BytesIO(response.content))
            
            img.thumbnail(max_size, Image.LANCZOS)
            img = img.convert('RGB')
            img.save(output_path, 'webp', optimize=True, quality=80)
            
            return output_path
        
        except requests.RequestException as e:
            print(f"Request error: {e}")
        except Image.UnidentifiedImageError:
            print(f"Cannot identify image file from URL: {image_url}")
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
if __name__ == "__main__":
    img_url = "http://localhost:3000/_next/image?url=https%3A%2F%2Foaidalleapiprodscus.blob.core.windows.net%2Fprivate%2Forg-yVcmTAPuIb54vl0NMm0HIpXy%2Fuser-yzA7vaKPikoxEPKJ7jKgHkm4%2Fimg-gy74bcq19abG1JMcfiyfb5nU.png%3Fst%3D2024-12-02T16%253A46%253A54Z%26se%3D2024-12-02T18%253A46%253A54Z%26sp%3Dr%26sv%3D2024-08-04%26sr%3Db%26rscd%3Dinline%26rsct%3Dimage%2Fpng%26skoid%3Dd505667d-d6c1-4a0a-bac7-5c84a87759f8%26sktid%3Da48cca56-e6da-484e-a814-9c849652bcb3%26skt%3D2024-12-02T16%253A51%253A57Z%26ske%3D2024-12-03T16%253A51%253A57Z%26sks%3Db%26skv%3D2024-08-04%26sig%3D2koxNEdAiyeS3bsoftiZWPyN9O4hk8wbaERn6MZhs1I%253D&w=640&q=100"
    output_path = "/Users/williamfotso/Workspace/Newsroom/Backend/data/topic_img/img_0_0.webp"
    download_and_optimize(image_url=img_url,output_path=output_path)