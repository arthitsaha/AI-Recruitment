from sqlalchemy import Column, Integer, String, DateTime, ForeignKey, JSON 
from sqlalchemy.sql import func 
from app.db.session import Base 
 
class Profile(Base): 
    __tablename__ = "profiles" 
 
    id = Column(Integer, primary_key=True, index=True) 
    user_id = Column(Integer, ForeignKey("users.id")) 
    profile_data = Column(JSON, nullable=False) 
    version = Column(Integer, default=1) 
    created_at = Column(DateTime(timezone=True), server_default=func.now()) 
    updated_at = Column(DateTime(timezone=True), server_default=func.now(), onupdate=func.now()) 
