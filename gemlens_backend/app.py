import numpy as np
import onnxruntime as ort
from flask import Flask, request
from keras.preprocessing import image


app = Flask(__name__)
sess = ort.InferenceSession('/Users/kavindudeshalsilva/Documents/GitHub/GemLens/gemlens_backend/onnx_model.onnx')

@app.route('/predict', methods=['GET'])
def predict():
    img_path = '/Users/kavindudeshalsilva/Documents/GitHub/GemLens/gemlens_backend/Amethyst_Test_106.jpg'
    img = image.load_img(img_path, target_size=(224, 224))
    x = image.img_to_array(img)
    x = np.expand_dims(x, axis=0)
    x = x/255.0
    input_name = sess.get_inputs()[0].name
    classes = sess.run(None, {input_name: x})
    return str(np.argmax(classes[0]))

if __name__ == '__main__':
    app.run(debug=True)