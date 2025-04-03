import openai 
import json 
from typing import List, Dict, Any, Optional 
from app.core.config import settings 
 
# Configure OpenAI API 
openai.api_key = settings.OPENAI_API_KEY 
 
async def extract_profile_from_chat(messages: List[Dict[str, str]]) -, Any]]: 
    # This function will be implemented to extract profile information from chat history 
    pass 
