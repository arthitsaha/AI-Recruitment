from pydantic import BaseSettings 
from typing import List 
import os 
 
class Settings(BaseSettings): 
    # API settings 
    API_V1_STR: str = "/api/v1" 
    SECRET_KEY: str = os.getenv("SECRET_KEY", "development_secret_key") 
    ALGORITHM: str = "HS256" 
    ACCESS_TOKEN_EXPIRE_MINUTES: int = 30 
 
    # CORS settings 
    CORS_ORIGINS: List[str] = ["http://localhost:3000", "http://localhost:8000"] 
 
    # Database settings 
    DATABASE_URL: str = os.getenv("DATABASE_URL", "postgresql://postgres:postgres@localhost:5432/recruitment") 
 
    # AI settings 
    OPENAI_API_KEY: str = os.getenv("OPENAI_API_KEY", "") 
    AI_MODEL: str = "gpt-4" 
 
    class Config: 
        env_file = ".env" 
 
settings = Settings() 
