from flask import Blueprint, request, jsonify, current_app
from ..services.ia_service import realiza_pesquisa

main = Blueprint('main', __name__)

@main.route('/explain/pergunta', methods=['POST'])
def pesquisa():
    try:
        query = request.json.get('pergunta')
        login = request.json.get('login')

        if not query:
            return jsonify({'Erro': 'Pergunta não informada.'}), 400

        resposta, referencia = realiza_pesquisa(query, current_app.config['collection_name'], login)
        justificativa = "Resposta montada com base na busca de prováveis respostas no Help da Edusoft, Depois melhorada com a utilização do Gemini da Google (Posteriormente uma outra IA irá mostrar nesse campo, o passo a passo que foi usado para encontrar a resposta)"

        response_body = {
            "resposta": resposta,
            "justificativa": justificativa,
            "referencias": referencia
        }
        return jsonify(response_body), 200
    except Exception as e:
        return jsonify({'Erro': str(e)}), 500
    