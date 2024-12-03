from sys import path
import os

current_dir = os.path.dirname(os.path.abspath(__file__))
project_root = os.path.abspath(os.path.join(current_dir, "../../../"))
backend_root = project_root + "/Backend"
path.append(backend_root)

from database.connection import db


class favourites(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    entity_id = db.Column(db.Integer, nullable=False)
    entity_type = db.Column(
        db.Enum("article", "video", name="entity_type"), nullable=False
    )

    def to_dict(self):
        return {
            "id": self.id,
            "entity_id": self.entity_id,
            "entity_type": self.entity_type,
        }
