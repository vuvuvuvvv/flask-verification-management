import os

from app import create_app
from dotenv import load_dotenv

load_dotenv()

app = create_app()

if __name__ == '__main__':
    # Docker run:
    # app.run(host='0.0.0.0', port=5000)

    # Static IP run:
    app.run(host= '192.168.1.204', debug=True)

