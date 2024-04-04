from flask import Flask, jsonify
from keras.preprocessing import image
from lime import lime_image
from skimage.segmentation import mark_boundaries
import numpy as np
from onnxruntime import InferenceSession
from PIL import Image
import io
from sklearn.cluster import KMeans
from flask import Flask, jsonify, request , Response
from flask_cors import CORS

def rgb2hex(r, g, b):
    return "#{:02x}{:02x}{:02x}".format(int(r), int(g), int(b))

app = Flask(__name__)
CORS(app)

# Load the ONNX model
ort_session = InferenceSession('/Users/kavindudeshalsilva/Documents/GitHub/GemLens/gemlens_backend/onnx_model.onnx')

@app.route('/predict', methods=['POST'])
def predict():
    img = request.files['image']
    img = Image.open(io.BytesIO(img.read())).convert('RGB').resize((224, 224))  # Convert FileStorage to BytesIO and remove alpha channel
    x = image.img_to_array(img)
    x = np.expand_dims(x, axis=0)
    x = x/255.0

    # Make prediction
    input_name = ort_session.get_inputs()[0].name
    classes = ort_session.run(None, {input_name: x})[0]
    print("Shape of classes: ", classes.shape)
    predicted_class = str(np.argmax(classes))
    print("Predicted class: ", predicted_class)

    # Create a LIME explainer
    explainer = lime_image.LimeImageExplainer()
    explanation = explainer.explain_instance(x[0], lambda x: ort_session.run(None, {input_name: x})[0], top_labels=12, hide_color=0, num_samples=100)

    # Get the explanation for the top class
    top_class = np.argmax(classes)
    temp, mask = explanation.get_image_and_mask(top_class)

    # Overlay the mask on the original image
    explanation_img = mark_boundaries(temp / 2 + 0.5, mask)

    # Convert the explanation image to a PNG
    img_pil = Image.fromarray((explanation_img * 255).astype(np.uint8))
    buffer = io.BytesIO()
    img_pil.save(buffer, format='PNG')
    img_bytes = buffer.getvalue()

    return Response(img_bytes, mimetype='image/png')


    return jsonify({'predicted_class': predicted_class})

@app.route('/dominant_color', methods=['POST'])
def dominant_color():
    img = request.files['image']
    img = Image.open(io.BytesIO(img.read())).convert('RGB').resize((224, 224))  # Convert FileStorage to BytesIO and remove alpha channel

    # Reshape the image to be a list of RGB pixels
    img_pixels = np.array(img).reshape(-1, 3)

    # Use KMeans to find the most common color
    kmeans = KMeans(n_clusters=1)
    kmeans.fit(img_pixels)
    dominant_color = kmeans.cluster_centers_[0]

    # Convert the dominant color to hexadecimal
    dominant_color_hex = rgb2hex(dominant_color[0], dominant_color[1], dominant_color[2])

    return jsonify(dominant_color_hex)


@app.route('/predict_class', methods=['POST'])
def predict_class():
    img = request.files['image']
    img = Image.open(io.BytesIO(img.read())).convert('RGB').resize((224, 224))  # Convert FileStorage to BytesIO and remove alpha channel
    x = image.img_to_array(img)
    x = np.expand_dims(x, axis=0)
    x = x/255.0

    # Make prediction
    input_name = ort_session.get_inputs()[0].name
    classes = ort_session.run(None, {input_name: x})[0]
    predicted_class = str(np.argmax(classes))

    return jsonify(predicted_class)


@app.route('/predict_probabilities', methods=['POST'])
def predict_probabilities():
    img = request.files['image']
    img = Image.open(io.BytesIO(img.read())).convert('RGB').resize((224, 224))  # Convert FileStorage to BytesIO and remove alpha channel
    x = image.img_to_array(img)
    x = np.expand_dims(x, axis=0)
    x = x/255.0

    # Make prediction
    input_name = ort_session.get_inputs()[0].name
    classes = ort_session.run(None, {input_name: x})[0]

    # Convert numpy array to list
    probabilities = classes.tolist()[0]

    # Convert probabilities to percentages
    probabilities = [prob * 100 for prob in probabilities]

    return jsonify(probabilities)

@app.route('/image_analysis', methods=['POST'])
def image_analysis():
    img = request.files['image']
    img = Image.open(io.BytesIO(img.read())).convert('RGB').resize((224, 224))  # Convert FileStorage to BytesIO and remove alpha channel

    # Reshape the image to be a list of RGB pixels
    img_pixels = np.array(img).reshape(-1, 3)

    # Use KMeans to find the most common color
    kmeans = KMeans(n_clusters=1)
    kmeans.fit(img_pixels)
    dominant_color = kmeans.cluster_centers_[0]

    # Convert the dominant color to hexadecimal
    dominant_color_hex = rgb2hex(dominant_color[0], dominant_color[1], dominant_color[2])

    # Prepare image for prediction
    x = image.img_to_array(img)
    x = np.expand_dims(x, axis=0)
    x = x/255.0

    # Make prediction
    input_name = ort_session.get_inputs()[0].name
    classes = ort_session.run(None, {input_name: x})[0]

    # Get predicted class and its confidence score
    predicted_class = np.argmax(classes)
    confidence_score = classes[0][predicted_class]

    # Convert numpy array to list
    probabilities = classes.tolist()[0]

    # Convert probabilities to percentages
    probabilities = [prob * 100 for prob in probabilities]

    return jsonify({
        'dominant_color': dominant_color_hex,
        'predicted_class': str(predicted_class),
        'confidence_score': float(confidence_score),
        'probabilities': probabilities
    })




if __name__ == '__main__':
    app.run(debug=True)