import logging
from api import create_app

logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')

app = create_app()

if __name__ == '__main__':
    app.run(host='127.0.0.1', port=5000)
