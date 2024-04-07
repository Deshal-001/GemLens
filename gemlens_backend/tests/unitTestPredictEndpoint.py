import unittest
from PIL import Image
import io
from app import app


#to run this : python3 -m tests.unitTestPredictEndpoint 

class UnitTestPredictEndpoint(unittest.TestCase):

    def setUp(self):
        self.app = app.test_client()

    def test_predict(self):
        #opening the image file
        with open('../gemlens_backend/Emerald_Test_200.jpg', 'rb') as img_file:
            img_bytes = img_file.read()
        #creating the data dictionary
        data = {
            'image': (io.BytesIO(img_bytes), 'image.jpg')
        }
        response = self.app.post('/predict', content_type='multipart/form-data', data=data)

        # Check that the status code 
        self.assertEqual(response.status_code, 200)
        # Check response if it is an image
        try:
            Image.open(io.BytesIO(response.data))
        except IOError:
            self.fail("Response is not an image")
            

    def test_image_analysis(self):
        tester = app.test_client(self)
        #opening the image file
        with open('../gemlens_backend/Emerald_Test_200.jpg', 'rb') as img:
            img_io = io.BytesIO(img.read())
            data = {
                'image': (img_io, 'test_image.jpg')
            }
            response = tester.post('/image_analysis', content_type='multipart/form-data', data=data)
            self.assertEqual(response.status_code, 200)

if __name__ == '__main__':
    unittest.main()