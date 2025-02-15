import json
import logging
from flask import Flask
from flask_cors import CORS

from .routes.routes import main as main_blueprint
from .services.ia_service import insere_dados

def load_config(config_file):
    with open(config_file, 'r') as f:
        return json.load(f)

def inicializa_ia(app):
    path_arquivos = app.config.get('caminho_arquivos')
    collection_name = app.config.get('collection_name')
    host_refencia = app.config.get('host_referencia')
    is_treina_ia = app.config.get('is_treina_ai')


    logging.info(f"Iniciando treinamento da IA com os arquivos na pasta {path_arquivos}.\nEsse processo pode demorar alguns minutos... ")
    
    if is_treina_ia:
        insere_dados(path_arquivos, collection_name, host_refencia)

def create_app():
    app = Flask(__name__)
    
    config = load_config('resources/config.json')
    app.config.update(config)

    CORS(app, resources={r"/*": {"origins": "*"}})  # Adjust the origins as needed

    app.register_blueprint(main_blueprint)

    with app.app_context():
        # Inicializa a IA, lendo os arquivos e populando os vetores
        inicializa_ia(app)

    return app
