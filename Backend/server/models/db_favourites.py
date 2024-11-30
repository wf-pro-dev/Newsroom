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
