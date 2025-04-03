@echo off
setlocal enabledelayedexpansion

echo Creating fresh AI Recruitment System Project Structure...
echo.

REM Create base directories for backend
mkdir backend\app
mkdir backend\app\api
mkdir backend\app\api\routes
mkdir backend\app\core
mkdir backend\app\db
mkdir backend\app\db\repositories
mkdir backend\app\models
mkdir backend\app\schemas
mkdir backend\app\services
mkdir backend\app\utils

echo Creating backend files...

echo # AI Recruitment System Backend > backend\README.md
echo This is the FastAPI backend for the AI Recruitment System. >> backend\README.md

REM Create __init__.py files in all Python packages
echo # Package initialization > backend\app\__init__.py
echo # API package initialization > backend\app\api\__init__.py
echo # Routes package initialization > backend\app\api\routes\__init__.py
echo # Core package initialization > backend\app\core\__init__.py
echo # DB package initialization > backend\app\db\__init__.py
echo # DB repositories initialization > backend\app\db\repositories\__init__.py
echo # Models package initialization > backend\app\models\__init__.py
echo # Schemas package initialization > backend\app\schemas\__init__.py
echo # Services package initialization > backend\app\services\__init__.py
echo # Utils package initialization > backend\app\utils\__init__.py

REM Main FastAPI application
echo from fastapi import FastAPI > backend\main.py
echo from fastapi.middleware.cors import CORSMiddleware >> backend\main.py
echo from app.core.config import settings >> backend\main.py
echo. >> backend\main.py
echo app = FastAPI( >> backend\main.py
echo     title="AI Recruitment API", >> backend\main.py
echo     description="API for AI-powered recruitment system", >> backend\main.py
echo     version="0.1.0" >> backend\main.py
echo ) >> backend\main.py
echo. >> backend\main.py
echo # Configure CORS >> backend\main.py
echo app.add_middleware( >> backend\main.py
echo     CORSMiddleware, >> backend\main.py
echo     allow_origins=settings.CORS_ORIGINS, >> backend\main.py
echo     allow_credentials=True, >> backend\main.py
echo     allow_methods=["*"], >> backend\main.py
echo     allow_headers=["*"], >> backend\main.py
echo ) >> backend\main.py
echo. >> backend\main.py
echo @app.get("/") >> backend\main.py
echo async def root(): >> backend\main.py
echo     return {"message": "Welcome to AI Recruitment API"} >> backend\main.py
echo. >> backend\main.py
echo # Import and include routers here >> backend\main.py

REM Config
echo from pydantic import BaseSettings > backend\app\core\config.py
echo from typing import List >> backend\app\core\config.py
echo import os >> backend\app\core\config.py
echo. >> backend\app\core\config.py
echo class Settings(BaseSettings): >> backend\app\core\config.py
echo     # API settings >> backend\app\core\config.py
echo     API_V1_STR: str = "/api/v1" >> backend\app\core\config.py
echo     SECRET_KEY: str = os.getenv("SECRET_KEY", "development_secret_key") >> backend\app\core\config.py
echo     ALGORITHM: str = "HS256" >> backend\app\core\config.py
echo     ACCESS_TOKEN_EXPIRE_MINUTES: int = 30 >> backend\app\core\config.py
echo. >> backend\app\core\config.py
echo     # CORS settings >> backend\app\core\config.py
echo     CORS_ORIGINS: List[str] = ["http://localhost:3000", "http://localhost:8000"] >> backend\app\core\config.py
echo. >> backend\app\core\config.py
echo     # Database settings >> backend\app\core\config.py
echo     DATABASE_URL: str = os.getenv("DATABASE_URL", "postgresql://postgres:postgres@localhost:5432/recruitment") >> backend\app\core\config.py
echo. >> backend\app\core\config.py
echo     # AI settings >> backend\app\core\config.py
echo     OPENAI_API_KEY: str = os.getenv("OPENAI_API_KEY", "") >> backend\app\core\config.py
echo     AI_MODEL: str = "gpt-4" >> backend\app\core\config.py
echo. >> backend\app\core\config.py
echo     class Config: >> backend\app\core\config.py
echo         env_file = ".env" >> backend\app\core\config.py
echo. >> backend\app\core\config.py
echo settings = Settings() >> backend\app\core\config.py

REM Database Session
echo from sqlalchemy import create_engine > backend\app\db\session.py
echo from sqlalchemy.ext.declarative import declarative_base >> backend\app\db\session.py
echo from sqlalchemy.orm import sessionmaker >> backend\app\db\session.py
echo from app.core.config import settings >> backend\app\db\session.py
echo. >> backend\app\db\session.py
echo engine = create_engine(settings.DATABASE_URL) >> backend\app\db\session.py
echo SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine) >> backend\app\db\session.py
echo. >> backend\app\db\session.py
echo Base = declarative_base() >> backend\app\db\session.py
echo. >> backend\app\db\session.py
echo # Dependency for FastAPI >> backend\app\db\session.py
echo def get_db(): >> backend\app\db\session.py
echo     db = SessionLocal() >> backend\app\db\session.py
echo     try: >> backend\app\db\session.py
echo         yield db >> backend\app\db\session.py
echo     finally: >> backend\app\db\session.py
echo         db.close() >> backend\app\db\session.py

REM Models
echo from sqlalchemy import Column, Integer, String, DateTime, ForeignKey > backend\app\models\user.py
echo from sqlalchemy.sql import func >> backend\app\models\user.py
echo from app.db.session import Base >> backend\app\models\user.py
echo. >> backend\app\models\user.py
echo class User(Base): >> backend\app\models\user.py
echo     __tablename__ = "users" >> backend\app\models\user.py
echo. >> backend\app\models\user.py
echo     id = Column(Integer, primary_key=True, index=True) >> backend\app\models\user.py
echo     email = Column(String, unique=True, index=True) >> backend\app\models\user.py
echo     name = Column(String) >> backend\app\models\user.py
echo     hashed_password = Column(String) >> backend\app\models\user.py
echo     created_at = Column(DateTime(timezone=True), server_default=func.now()) >> backend\app\models\user.py
echo     updated_at = Column(DateTime(timezone=True), server_default=func.now(), onupdate=func.now()) >> backend\app\models\user.py

echo from sqlalchemy import Column, Integer, String, DateTime, ForeignKey, JSON > backend\app\models\profile.py
echo from sqlalchemy.sql import func >> backend\app\models\profile.py
echo from app.db.session import Base >> backend\app\models\profile.py
echo. >> backend\app\models\profile.py
echo class Profile(Base): >> backend\app\models\profile.py
echo     __tablename__ = "profiles" >> backend\app\models\profile.py
echo. >> backend\app\models\profile.py
echo     id = Column(Integer, primary_key=True, index=True) >> backend\app\models\profile.py
echo     user_id = Column(Integer, ForeignKey("users.id")) >> backend\app\models\profile.py
echo     profile_data = Column(JSON, nullable=False) >> backend\app\models\profile.py
echo     version = Column(Integer, default=1) >> backend\app\models\profile.py
echo     created_at = Column(DateTime(timezone=True), server_default=func.now()) >> backend\app\models\profile.py
echo     updated_at = Column(DateTime(timezone=True), server_default=func.now(), onupdate=func.now()) >> backend\app\models\profile.py

echo from sqlalchemy import Column, Integer, String, DateTime, JSON, Float > backend\app\models\job.py
echo from sqlalchemy.sql import func >> backend\app\models\job.py
echo from app.db.session import Base >> backend\app\models\job.py
echo. >> backend\app\models\job.py
echo class Job(Base): >> backend\app\models\job.py
echo     __tablename__ = "job_requirements" >> backend\app\models\job.py
echo. >> backend\app\models\job.py
echo     id = Column(Integer, primary_key=True, index=True) >> backend\app\models\job.py
echo     company_id = Column(Integer, nullable=False) >> backend\app\models\job.py
echo     title = Column(String, nullable=False) >> backend\app\models\job.py
echo     requirement_data = Column(JSON, nullable=False) >> backend\app\models\job.py
echo     status = Column(String, default="active") >> backend\app\models\job.py
echo     created_at = Column(DateTime(timezone=True), server_default=func.now()) >> backend\app\models\job.py
echo     updated_at = Column(DateTime(timezone=True), server_default=func.now(), onupdate=func.now()) >> backend\app\models\job.py

echo from sqlalchemy import Column, Integer, String, DateTime, JSON, Float, ForeignKey > backend\app\models\match.py
echo from sqlalchemy.sql import func >> backend\app\models\match.py
echo from app.db.session import Base >> backend\app\models\match.py
echo. >> backend\app\models\match.py
echo class Match(Base): >> backend\app\models\match.py
echo     __tablename__ = "matches" >> backend\app\models\match.py
echo. >> backend\app\models\match.py
echo     id = Column(Integer, primary_key=True, index=True) >> backend\app\models\match.py
echo     profile_id = Column(Integer, ForeignKey("profiles.id")) >> backend\app\models\match.py
echo     job_id = Column(Integer, ForeignKey("job_requirements.id")) >> backend\app\models\match.py
echo     match_score = Column(Float, nullable=False) >> backend\app\models\match.py
echo     match_details = Column(JSON) >> backend\app\models\match.py
echo     status = Column(String, default="pending") >> backend\app\models\match.py
echo     created_at = Column(DateTime(timezone=True), server_default=func.now()) >> backend\app\models\match.py
echo     updated_at = Column(DateTime(timezone=True), server_default=func.now(), onupdate=func.now()) >> backend\app\models\match.py

REM Schema files
echo from pydantic import BaseModel, Field > backend\app\schemas\chat.py
echo from typing import List, Dict, Any, Optional >> backend\app\schemas\chat.py
echo. >> backend\app\schemas\chat.py
echo class ChatMessage(BaseModel): >> backend\app\schemas\chat.py
echo     role: str = Field(..., description="The role of the message sender (user or assistant)") >> backend\app\schemas\chat.py
echo     content: str = Field(..., description="The content of the message") >> backend\app\schemas\chat.py
echo. >> backend\app\schemas\chat.py
echo class ChatInput(BaseModel): >> backend\app\schemas\chat.py
echo     user_id: Optional[int] = Field(None, description="The ID of the user sending the message") >> backend\app\schemas\chat.py
echo     messages: List[ChatMessage] = Field(..., description="The chat conversation history") >> backend\app\schemas\chat.py
echo. >> backend\app\schemas\chat.py
echo class ChatResponse(BaseModel): >> backend\app\schemas\chat.py
echo     ai_response: str = Field(..., description="The AI assistant's response") >> backend\app\schemas\chat.py
echo     profile_updated: bool = Field(..., description="Whether the profile was updated based on the conversation") >> backend\app\schemas\chat.py
echo     profile_id: Optional[int] = Field(None, description="The ID of the updated profile (if applicable)") >> backend\app\schemas\chat.py
echo     profile_data: Optional[Dict[str, Any]] = Field(None, description="The extracted profile data (if applicable)") >> backend\app\schemas\chat.py

REM Routes
echo from fastapi import APIRouter, Depends, HTTPException > backend\app\api\routes\chat.py
echo from sqlalchemy.orm import Session >> backend\app\api\routes\chat.py
echo from typing import List >> backend\app\api\routes\chat.py
echo. >> backend\app\api\routes\chat.py
echo from app.db.session import get_db >> backend\app\api\routes\chat.py
echo from app.schemas.chat import ChatInput, ChatResponse >> backend\app\api\routes\chat.py
echo from app.services.ai_chat import process_chat_message >> backend\app\api\routes\chat.py
echo from app.services.profile_extractor import extract_profile_from_chat >> backend\app\api\routes\chat.py
echo from app.db.repositories.profiles import ProfileRepository >> backend\app\api\routes\chat.py
echo. >> backend\app\api\routes\chat.py
echo router = APIRouter(prefix="/api/chat", tags=["chat"]) >> backend\app\api\routes\chat.py
echo. >> backend\app\api\routes\chat.py
echo @router.post("/message", response_model=ChatResponse) >> backend\app\api\routes\chat.py
echo async def handle_chat_message(input_data: ChatInput, db: Session = Depends(get_db)): >> backend\app\api\routes\chat.py
echo     # This endpoint will be implemented to process chat messages >> backend\app\api\routes\chat.py
echo     pass >> backend\app\api\routes\chat.py

REM Services
echo import openai > backend\app\services\ai_chat.py
echo from typing import List, Dict, Any >> backend\app\services\ai_chat.py
echo from app.core.config import settings >> backend\app\services\ai_chat.py
echo. >> backend\app\services\ai_chat.py
echo # Configure OpenAI API >> backend\app\services\ai_chat.py
echo openai.api_key = settings.OPENAI_API_KEY >> backend\app\services\ai_chat.py
echo. >> backend\app\services\ai_chat.py
echo async def process_chat_message(messages: List[Dict[str, str]]) -> str: >> backend\app\services\ai_chat.py
echo     # This function will be implemented to process chat messages with OpenAI >> backend\app\services\ai_chat.py
echo     pass >> backend\app\services\ai_chat.py

echo import openai > backend\app\services\profile_extractor.py
echo import json >> backend\app\services\profile_extractor.py
echo from typing import List, Dict, Any, Optional >> backend\app\services\profile_extractor.py
echo from app.core.config import settings >> backend\app\services\profile_extractor.py
echo. >> backend\app\services\profile_extractor.py
echo # Configure OpenAI API >> backend\app\services\profile_extractor.py
echo openai.api_key = settings.OPENAI_API_KEY >> backend\app\services\profile_extractor.py
echo. >> backend\app\services\profile_extractor.py
echo async def extract_profile_from_chat(messages: List[Dict[str, str]]) -> Optional[Dict[str, Any]]: >> backend\app\services\profile_extractor.py
echo     # This function will be implemented to extract profile information from chat history >> backend\app\services\profile_extractor.py
echo     pass >> backend\app\services\profile_extractor.py

REM Repositories
echo from sqlalchemy.orm import Session > backend\app\db\repositories\profiles.py
echo from sqlalchemy.exc import SQLAlchemyError >> backend\app\db\repositories\profiles.py
echo from typing import Dict, Any, Optional, List >> backend\app\db\repositories\profiles.py
echo. >> backend\app\db\repositories\profiles.py
echo from app.models.profile import Profile >> backend\app\db\repositories\profiles.py
echo from app.models.user import User >> backend\app\db\repositories\profiles.py
echo. >> backend\app\db\repositories\profiles.py
echo class ProfileRepository: >> backend\app\db\repositories\profiles.py
echo     def __init__(self, db: Session): >> backend\app\db\repositories\profiles.py
echo         self.db = db >> backend\app\db\repositories\profiles.py
echo. >> backend\app\db\repositories\profiles.py
echo     def save_profile(self, user_id: int, profile_data: Dict[str, Any]) -> int: >> backend\app\db\repositories\profiles.py
echo         # This method will be implemented to save profile data >> backend\app\db\repositories\profiles.py
echo         pass >> backend\app\db\repositories\profiles.py

REM Create .env.example
echo # Environment Variables > backend\.env.example
echo OPENAI_API_KEY=your_openai_api_key_here >> backend\.env.example
echo DATABASE_URL=postgresql://postgres:postgres@localhost:5432/recruitment >> backend\.env.example
echo SECRET_KEY=your_secret_key_here >> backend\.env.example
echo DEBUG=True >> backend\.env.example

REM Create frontend directories
mkdir frontend
mkdir frontend\src
mkdir frontend\src\components
mkdir frontend\src\components\Chat
mkdir frontend\src\components\Profile
mkdir frontend\src\components\Matches
mkdir frontend\src\components\Navigation
mkdir frontend\src\components\Common
mkdir frontend\src\pages
mkdir frontend\src\services
mkdir frontend\src\context
mkdir frontend\src\hooks
mkdir frontend\src\utils
mkdir frontend\src\styles

REM Create database setup directories and files
mkdir database
mkdir database\migrations
mkdir database\seed

echo -- Initialize recruitment database > database\init.sql
echo. >> database\init.sql
echo CREATE TABLE IF NOT EXISTS users ( >> database\init.sql
echo     id SERIAL PRIMARY KEY, >> database\init.sql
echo     email VARCHAR(255) UNIQUE NOT NULL, >> database\init.sql
echo     name VARCHAR(255) NOT NULL, >> database\init.sql
echo     hashed_password VARCHAR(255) NOT NULL, >> database\init.sql
echo     created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP, >> database\init.sql
echo     updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP >> database\init.sql
echo ); >> database\init.sql
echo. >> database\init.sql
echo CREATE TABLE IF NOT EXISTS profiles ( >> database\init.sql
echo     id SERIAL PRIMARY KEY, >> database\init.sql
echo     user_id INTEGER REFERENCES users(id), >> database\init.sql
echo     profile_data JSONB NOT NULL, >> database\init.sql
echo     version INTEGER DEFAULT 1, >> database\init.sql
echo     created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP, >> database\init.sql
echo     updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP >> database\init.sql
echo ); >> database\init.sql
echo. >> database\init.sql
echo CREATE TABLE IF NOT EXISTS job_requirements ( >> database\init.sql
echo     id SERIAL PRIMARY KEY, >> database\init.sql
echo     company_id INTEGER NOT NULL, >> database\init.sql
echo     title VARCHAR(255) NOT NULL, >> database\init.sql
echo     requirement_data JSONB NOT NULL, >> database\init.sql
echo     status VARCHAR(50) DEFAULT 'active', >> database\init.sql
echo     created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP, >> database\init.sql
echo     updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP >> database\init.sql
echo ); >> database\init.sql
echo. >> database\init.sql
echo CREATE TABLE IF NOT EXISTS matches ( >> database\init.sql
echo     id SERIAL PRIMARY KEY, >> database\init.sql
echo     profile_id INTEGER REFERENCES profiles(id), >> database\init.sql
echo     job_id INTEGER REFERENCES job_requirements(id), >> database\init.sql
echo     match_score FLOAT NOT NULL, >> database\init.sql
echo     match_details JSONB, >> database\init.sql
echo     status VARCHAR(50) DEFAULT 'pending', >> database\init.sql
echo     created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP, >> database\init.sql
echo     updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP >> database\init.sql
echo ); >> database\init.sql

REM Create Docker resources 
echo version: '3' > docker-compose.yml
echo services: >> docker-compose.yml
echo   backend: >> docker-compose.yml
echo     build: >> docker-compose.yml
echo       context: ./backend >> docker-compose.yml
echo     ports: >> docker-compose.yml
echo       - "8000:8000" >> docker-compose.yml
echo     volumes: >> docker-compose.yml
echo       - ./backend:/app >> docker-compose.yml
echo     environment: >> docker-compose.yml
echo       - DATABASE_URL=postgresql://postgres:postgres@db:5432/recruitment >> docker-compose.yml
echo     depends_on: >> docker-compose.yml
echo       - db >> docker-compose.yml
echo   db: >> docker-compose.yml
echo     image: postgres:14 >> docker-compose.yml
echo     volumes: >> docker-compose.yml
echo       - ./database/init.sql:/docker-entrypoint-initdb.d/init.sql >> docker-compose.yml
echo       - postgres_data:/var/lib/postgresql/data >> docker-compose.yml
echo     environment: >> docker-compose.yml
echo       - POSTGRES_USER=postgres >> docker-compose.yml
echo       - POSTGRES_PASSWORD=postgres >> docker-compose.yml
echo       - POSTGRES_DB=recruitment >> docker-compose.yml
echo     ports: >> docker-compose.yml
echo       - "5432:5432" >> docker-compose.yml
echo volumes: >> docker-compose.yml
echo   postgres_data: >> docker-compose.yml

echo FROM python:3.9-slim > backend\Dockerfile
echo. >> backend\Dockerfile
echo WORKDIR /app >> backend\Dockerfile
echo. >> backend\Dockerfile
echo COPY requirements.txt . >> backend\Dockerfile
echo RUN pip install --no-cache-dir -r requirements.txt >> backend\Dockerfile
echo. >> backend\Dockerfile
echo COPY . . >> backend\Dockerfile
echo. >> backend\Dockerfile
echo CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"] >> backend\Dockerfile

echo Project structure setup complete!
echo.
echo Now you can add your implementation to these files.
echo.
echo Next steps:
echo 1. Copy your .env.example to .env and add your OpenAI API key
echo 2. Implement the services and routes with the code provided earlier
echo 3. Set up your database (using Docker or local PostgreSQL)
echo 4. Start the backend server: uvicorn main:app --reload
echo.