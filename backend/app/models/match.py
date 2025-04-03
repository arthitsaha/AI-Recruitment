from sqlalchemy import Column, Integer, String, DateTime, JSON, Float, ForeignKey 
from sqlalchemy.sql import func 
from app.db.session import Base 
 
class Match(Base): 
    __tablename__ = "matches" 
 
    id = Column(Integer, primary_key=True, index=True) 
    profile_id = Column(Integer, ForeignKey("profiles.id")) 
    job_id = Column(Integer, ForeignKey("job_requirements.id")) 
    match_score = Column(Float, nullable=False) 
    match_details = Column(JSON) 
    status = Column(String, default="pending") 
    created_at = Column(DateTime(timezone=True), server_default=func.now()) 
    updated_at = Column(DateTime(timezone=True), server_default=func.now(), onupdate=func.now()) 
