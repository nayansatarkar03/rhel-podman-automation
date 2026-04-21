from flask import Flask
import os

app = Flask(__name__)

@app.route('/')
def hello():
    return f"Container is running on {os.uname()[1]} | Managed by systemd"

if __name__ == "__main__":
    app.run(host='0.0.0.0', port=8080)

