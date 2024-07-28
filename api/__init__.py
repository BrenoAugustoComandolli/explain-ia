import json
import logging
from flask import Flask
from .routes.routes import main as main_blueprint
from .services.ia_service import insere_dados

def load_config(config_file):
    with open(config_file, 'r') as f:
        return json.load(f)

def inicializa_ia(app):
    path_arquivos = app.config['caminho_arquivos']
    collection_name = app.config['collection_name']

    logging.info(f"Iniciando treinamento da IA com os arquivos na pasta {path_arquivos}.\nEsse processo pode demorar alguns minutos... ")
    
    insere_dados(path_arquivos, collection_name)

def create_app():
    app = Flask(__name__)
    
    config = load_config('resources/config.json')
    app.config.update(config)

    app.register_blueprint(main_blueprint)

    with app.app_context():
        # Inicializa a IA, lendo os arquivos e populando os vetores
        inicializa_ia(app)

    return app
