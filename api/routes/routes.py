from flask import Blueprint, request, jsonify, current_app
from ..services.ia_service import realiza_pesquisa

main = Blueprint('main', __name__)

@main.route('/explain/pergunta', methods=['POST'])
def pesquisa():
    try:
        query = request.json.get('pergunta')
        if not query:
            return jsonify({'Erro': 'Pergunta não informada.'}), 400

        resposta, referencia = realiza_pesquisa(query, current_app.config['collection_name'])
        justificativa = "TODO"

        response_body = {
            "resposta": resposta,
            "justificativa": justificativa,
            "referencias": referencia
        }
        return jsonify({'body': response_body}), 200
    except Exception as e:
        return jsonify({'Erro': str(e)}), 400
