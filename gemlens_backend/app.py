from flask import Flask, request, jsonify, render_template
from flask_wtf import FlaskForm
from wtforms import StringField, SubmitField

app = Flask(__name__)
app.config['SECRET_KEY']= 'mysecretkey'


@app.route('/', methods=['GET', 'POST'])
def index():
    return "Hello World!"
