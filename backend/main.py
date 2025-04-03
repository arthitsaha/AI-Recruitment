from fastapi import FastAPI 
from fastapi.middleware.cors import CORSMiddleware 
from app.core.config import settings 
 
app = FastAPI( 
    title="AI Recruitment API", 
    description="API for AI-powered recruitment system", 
    version="0.1.0" 
) 
 
# Configure CORS 
app.add_middleware( 
    CORSMiddleware, 
    allow_origins=settings.CORS_ORIGINS, 
    allow_credentials=True, 
    allow_methods=["*"], 
    allow_headers=["*"], 
) 
 
@app.get("/") 
async def root(): 
    return {"message": "Welcome to AI Recruitment API"} 
 
# Import and include routers here 
