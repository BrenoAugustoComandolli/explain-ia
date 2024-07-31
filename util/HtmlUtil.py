import json
from IPython.display import display, HTML
import requests
from .consts.prompts_consts import PromptsConsts

config_path = 'resources/config.json'
with open(config_path, 'r') as config_file:
    config = json.load(config_file)

class HtmlUtil:
    @staticmethod
    def formatar_resultado_pesquisa(resultados, pergunta, token):
        resposta = resultados[0]['text']
        arquivo = resultados[0]['arquivo']

        respostaGemini = trataRespostaGemini(token, pergunta, resposta)

        if 'host_referencia' in config and config['host_referencia']:
            referencia_arquivos = config['host_referencia'] + arquivo
        else:
            referencia_arquivos = [arquivo]
        
        return respostaGemini, [referencia_arquivos]
    
def trataRespostaGemini(token, pergunta, resposta):
    api_url = "https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash-latest:generateContent?key="
    headers = {
        "Content-Type": "application/json"
    }
    data = {
        "contents": [{
            "parts": [
                {"text": PromptsConsts.CONTEXTUALIZACAO},
                {"text": PromptsConsts.TITULO_PERGUNTA + pergunta + " / " + PromptsConsts.TITULO_RESPOSTA + resposta}
            ]
        }]
    }

    response = requests.post(api_url+token, headers=headers, json=data)
    
    if response.status_code == 200:
        resposta_gemini = response.json()['candidates'][0]['content']['parts'][0]['text']
    else:
        resposta_gemini = "Houve um erro na comunicação com a API do Gemini."
    
    return resposta_gemini