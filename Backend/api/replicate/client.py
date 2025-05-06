import os 
from sys import path
from io import BytesIO
import replicate, requests

current_dir = os.path.dirname(os.path.abspath(__file__))
project_root = os.path.abspath(os.path.join(current_dir, "../../../"))
backend_root = project_root + "/Backend"
path.append(backend_root)

from api.aws.client import upload_to_s3
from api.genai.client import fetch_prompt_image_gen_ai
from config.constants import REPLICATE_API_TOKEN

def generate_image_replicate(prompt: str,topic_id: int,index: int) -> str:
    """
    Generates an image based on the given prompt using Gemini API and upload it to a s3 bucket.
    
    Parameters:
    prompt (str): The prompt describing the image to generate.
    
    Returns:
    str: Path to the saved image file or None if generation failed.
    """

    public_url=""
    try :

        input = {
            "prompt": prompt,
            "guidance": 3.5,
            "negative_prompt": "cartoon, painting, blurry, low contrast, vintage, grainy",
            "width": 1024,
            "height": 576,  # 16:9 aspect ratio
            "num_inference_steps": 4,  # More steps = better quality
            "guidance_scale": 9.0,  # Strict prompt adherence
            "scheduler": "K_DPMPP_2M",  # Best for technical details
            "high_noise_frac": 0.8,  # Better for dark gradients
            "apply_watermark": False,
            "disable_safety_checker": True  # For corporate use
        }

        output = replicate.run(
            "black-forest-labs/flux-schnell",
            input=input
        )
       
        # Download image directly to memory
        image_url = output[0]
        response = requests.get(image_url)
        response.raise_for_status()

        # Get content type from response headers
        content_type = response.headers.get('Content-Type', 'image/png')

        # Upload to S3
        with BytesIO(response.content) as image_buffer:
            public_url = upload_to_s3(image_buffer, topic_id, index, prompt)
    
    except replicate.exceptions.ModelError as e:
        print(f"Replicate error : {e}")

    except Exception as e:
        print(f"Error fetching images : {e}")

    return public_url

if __name__ == "__main__" :
    list_prompts = fetch_prompt_image_gen_ai("Artificial intelligence")
    for i ,prompt in enumerate(list_prompts):
        result = generate_image_replicate(prompt=prompt, topic_id=6, index=i)
        print(result)
