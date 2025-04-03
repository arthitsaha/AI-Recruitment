from pydantic import BaseModel, Field 
from typing import List, Dict, Any, Optional 
 
class ChatMessage(BaseModel): 
    role: str = Field(..., description="The role of the message sender (user or assistant)") 
    content: str = Field(..., description="The content of the message") 
 
class ChatInput(BaseModel): 
    user_id: Optional[int] = Field(None, description="The ID of the user sending the message") 
    messages: List[ChatMessage] = Field(..., description="The chat conversation history") 
 
class ChatResponse(BaseModel): 
    ai_response: str = Field(..., description="The AI assistant's response") 
    profile_updated: bool = Field(..., description="Whether the profile was updated based on the conversation") 
    profile_id: Optional[int] = Field(None, description="The ID of the updated profile (if applicable)") 
    profile_data: Optional[Dict[str, Any]] = Field(None, description="The extracted profile data (if applicable)") 
