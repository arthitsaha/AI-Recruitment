from sqlalchemy.orm import Session 
from sqlalchemy.exc import SQLAlchemyError 
from typing import Dict, Any, Optional, List 
 
from app.models.profile import Profile 
from app.models.user import User 
 
class ProfileRepository: 
    def __init__(self, db: Session): 
        self.db = db 
 
    def save_profile(self, user_id: int, profile_data: Dict[str, Any]) -
        # This method will be implemented to save profile data 
        pass 
