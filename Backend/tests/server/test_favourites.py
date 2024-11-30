from sys import path
path.append("/Users/williamfotso/Workspace/Newsroom/Backend/")

import unittest
from server.app import create_app
from database.connection import db
from server.models.db_favourites import favourites

class FavouritesRoutesTestCase(unittest.TestCase):
    def setUp(self):
        self.app = create_app()
        self.app.config['TESTING'] = True
        self.client = self.app.test_client()
        with self.app.app_context():
            db.create_all()

    def tearDown(self):
        with self.app.app_context():
            db.session.remove()
            db.drop_all()

    def test_get_favourites(self):
        response = self.client.get('/favourites')
        self.assertEqual(response.status_code, 200)

    def test_add_favourite(self):
        response = self.client.post('/favourites', json={'entity_id': 1, 'entity_type': 'article'})
        self.assertEqual(response.status_code, 201)
        self.assertIn('article', str(response.data))

    def test_add_favourite_invalid(self):
        response = self.client.post('/favourites', json={})
        self.assertEqual(response.status_code, 400)
        self.assertIn('error', str(response.data))

    def test_delete_favourite(self):
        with self.app.app_context():
            favourite = favourites(entity_id=1, entity_type='article')
            db.session.add(favourite)
            db.session.commit()
            fav_id = favourite.id
        response = self.client.delete(f'/favourites/article/1')
        self.assertEqual(response.status_code, 200)
        self.assertIn('deleted successfully', str(response.data))

    def test_delete_favourite_not_found(self):
        response = self.client.delete('/favourites/article/999')
        self.assertEqual(response.status_code, 404)
        self.assertIn('Item not found', str(response.data))

if __name__ == '__main__':
    unittest.main()