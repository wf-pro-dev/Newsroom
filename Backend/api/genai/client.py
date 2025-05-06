import os
from sys import path
import json
from google import genai
from google.genai import types
from io import BytesIO
import ast

current_dir = os.path.dirname(os.path.abspath(__file__))
project_root = os.path.abspath(os.path.join(current_dir, "../../../"))
backend_root = project_root + "/Backend"
path.append(backend_root)

from api.aws.client import upload_to_s3
from config.constants import GEMINI_KEY

# Create the model
client = genai.Client(api_key=GEMINI_KEY)

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
    Generates space-themed professional image prompts aligned with news website aesthetics.
    Returns 3 prompt strings optimized against abstraction and educational style.
    """
    
    prompt = f"""
    Create 3 image prompts for '{topic}' news articles with these requirements:

1. **Core Elements**:
   - Identify 3 literal, symbolic objects from the topic (prioritize recognizable real-world items)
   - Render as ultra-detailed 3D models with one of: 
     * Holographic edges
     * Metallic nano-textures
     * Glass-diffraction surfaces
   - Forbidden: Abstract shapes, cartoon elements, vague symbolism

2. **Cyber-Cosmic Palette**:
   - Base (70%): Void_black (#000000), Obsidian (#0A0B21), Starship_gray (#232538)
   - Accent (25%): Pulsing gradients of Quantum_blue (#00F7FF) to Void_teal (#003A40)
   - Glow (5%): Neon_cyan (#00FFE5) rim lighting

3. **Technical Composition**:
   - Aspect Ratio: 16:9 (website header optimized)
   - Depth: Shallow depth of field (f/2.8 equivalent)
   - Lighting: Three-point system with volumetric nebula accents
   - Lens Style: Wide-angle (24mm) with subtle anamorphic flare
   - Focus Stacking: Sharp foreground elements, soft bokeh data patterns

4. **Scene Requirements**:
   - Primary Object: Centered, occupying 40% frame height
   - Secondary Elements: Floating holographic UI elements related to topic
   - Background: Hexagonal grid pattern with low-opacity circuit board textures
   - Ground: Reflective black marble surface with accent color glitches

    **Output Format**:
    [
        "Ultra-detailed [object1] with [holographic/metallic/glass] finish, integrated with [topic-related element]. [Foreground action] under [specific lighting type]. Background: [technical pattern] with [lens effect] -- Aspect Ratio: 16:9, Focus: f/2.8, Lighting: Tri-point neonsphere, Lens: 24mm anamorphic",
        ...
    ]

    **Example for "AI Ethics"**:
    ````python
    [
        "Crystalline brain neural network with quantum_blue data streams, ethical guardrails forming hexagonal forcefield. Cyber-rain falling in midground under nebula backlighting -- Aspect Ratio: 16:9, Focus: Sharp neurons with bokeh droplets, Lighting: Bio-luminescent UI glow, Lens: Cinematic wide-angle",
        "Futuristic courtroom scene with floating holographic gavel judging circuit board defendant. Neon-red tension sparks vs quantum_blue justice beams -- Aspect Ratio: 16:9, Focus: Depth-stacked courtroom, Lighting: Dramatic noir-cyberpunk, Lens: Forensic detail macro",
        "Titanium scale balancing data cubes vs human heart monitor. Background: Binary rain falling on obsidian columns -- Aspect Ratio: 16:9, Focus: Foreground balance, Lighting: Clinical UV highlights, Lens: Surveillance cam aesthetic"
    ]
    ```
    """
    
    response = client.models.generate_content(
        model="gemini-2.0-flash-lite",
        contents=prompt
    )


    # Clean and parse response
    cleaned = response.text.strip() \
        .removeprefix("```python") \
        .removesuffix("```") \
        .strip()


    return ast.literal_eval(cleaned)


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
         # print(part.text)
         pass
        elif part.inline_data is not None:
          image_data = BytesIO(part.inline_data.data)            
          image_url = upload_to_s3(image_data, topic_id, index, prompt)  # Upload to S3 and get UR
      
    except Exception as e:
      print("Error fetching images :",e)
       
    return image_url
        

    

if __name__ == "__main__" :
    
    list_prompts = fetch_prompt_image_gen_ai("Education")
    for i ,prompt in enumerate(list_prompts):
        fetch_image_gen_ai(prompt=prompt, topic_id=6, index=i)
