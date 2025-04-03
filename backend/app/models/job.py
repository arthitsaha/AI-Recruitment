from sqlalchemy import Column, Integer, String, DateTime, JSON, Float 
from sqlalchemy.sql import func 
from app.db.session import Base 
 
class Job(Base): 
    __tablename__ = "job_requirements" 
 
    id = Column(Integer, primary_key=True, index=True) 
    company_id = Column(Integer, nullable=False) 
    title = Column(String, nullable=False) 
    requirement_data = Column(JSON, nullable=False) 
    status = Column(String, default="active") 
    created_at = Column(DateTime(timezone=True), server_default=func.now()) 
    updated_at = Column(DateTime(timezone=True), server_default=func.now(), onupdate=func.now()) 
