import os

from app import create_app
from dotenv import load_dotenv

load_dotenv()

app = create_app()

if __name__ == '__main__':
    # app.run(debug=True)
    app.run(host= '192.168.1.204', debug=True)
    # app.run(host= '192.168.0.116', debug=True)
