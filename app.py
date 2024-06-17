import sqlite3
import requests
import os
import json
from flask import Flask, request, jsonify, render_template

app = Flask(__name__)
DATABASE = 'uploaded.db'

# Set your new API key and base URL
API_KEY = 'pk-gydFkPtuNbLLolXEJxxgTkXFiWMOggZCYVcwrfCUpuJpGWNq'
API_URL = 'https://api.pawan.krd/v1/chat/completions'

def init_db(db_file):
    try:
        with sqlite3.connect(DATABASE) as conn:
            with open(db_file, 'r') as f:
                script = f.read()
                conn.executescript(script)
    except sqlite3.Error as e:
        print(f"An error occurred: {e}")

def db_to_json():
    db_json = {}
    try:
        with sqlite3.connect(DATABASE) as conn:
            cursor = conn.cursor()
            cursor.execute("SELECT name FROM sqlite_master WHERE type='table';")
            tables = cursor.fetchall()
            for table in tables:
                table_name = table[0]
                cursor.execute(f"SELECT * FROM {table_name}")
                rows = cursor.fetchall()
                cursor.execute(f"PRAGMA table_info({table_name})")
                columns = [col[1] for col in cursor.fetchall()]
                db_json[table_name] = [dict(zip(columns, row)) for row in rows]
    except sqlite3.Error as e:
        print(f"An error occurred: {e}")
    return db_json

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/upload', methods=['POST'])
def upload_file():
    if 'databaseFile' not in request.files:
        return 'No file part', 400
    file = request.files['databaseFile']
    if file.filename == '':
        return 'No selected file', 400
    if file and file.filename.endswith('.sql'):
        file.save(os.path.join(os.getcwd(), 'uploaded.sql'))
        init_db('uploaded.sql')
        return 'File uploaded and database initialized', 200
    return 'Invalid file type', 400

@app.route('/query', methods=['POST'])
def query_db():
    user_query = request.json.get('query', '')
    if not user_query:
        return jsonify({'error': 'Query is required'}), 400

    db_json = db_to_json()

    try:
        # Generate response using the new API
        headers = {
            'Authorization': f'Bearer {API_KEY}',
            'Content-Type': 'application/json'
        }
        payload = {
            "model": "pai-001",  # Update this to the correct model if different
            "messages": [
                {"role": "system", "content": "You are an assistant that answers questions based on the provided database."},
                {"role": "user", "content": f"Database: {json.dumps(db_json)}"},
                {"role": "user", "content": user_query}
            ]
        }
        
        response = requests.post(API_URL, headers=headers, json=payload)
        response_json = response.json()

        # Log the full response for debugging
        print("OpenAI API response:", response_json)

        if 'choices' not in response_json or not response_json['choices']:
            raise ValueError("Response from API does not contain 'choices'")
        
        answer = response_json['choices'][0]['message']['content'].strip()
        return jsonify({'answer': answer}), 200
    except requests.exceptions.RequestException as e:
        print(f"RequestException: {e}")
        return jsonify({'error': 'Error with API request'}), 500
    except sqlite3.Error as e:
        print(f"SQLite Error: {e}")
        return jsonify({'error': str(e)}), 500
    except ValueError as e:
        print(f"ValueError: {e}")
        return jsonify({'error': str(e)}), 500
    except Exception as e:
        print(f"Unexpected Error: {e}")
        return jsonify({'error': 'An unexpected error occurred'}), 500

if __name__ == '__main__':
    app.run(debug=True)
