import json
from IPython.display import display, HTML
import requests
from consts.prompts_consts import PromptsConsts

config_path = 'resources/config.json'
with open(config_path, 'r') as config_file:
    config = json.load(config_file)

class HtmlUtil:
    @staticmethod
    def formatar_resultado_pesquisa(resultados, pergunta, token):
        resposta = resultados[0]['text']
        arquivo = resultados[0]['arquivo']

        respostaChatGpt = trataRespostaChatGpt(token, pergunta, resposta)

        if 'host_referencia' in config and config['host_referencia']:
            referencia_arquivos = config['host_referencia'] + arquivo
        else:
            referencia_arquivos = [arquivo]
        
        return respostaChatGpt, referencia_arquivos
    
def trataRespostaChatGpt(token, pergunta, resposta):
    api_url = "https://api.openai.com/v1/chat/completions"
    headers = {
        "Authorization": f"Bearer {token}",
        "Content-Type": "application/json"
    }
    data = {
        "model": "gpt-3.5-turbo",
        "messages": [
            {"role": "system", "content": PromptsConsts.CONTEXTUALIZACAO},
            {"role": "user", "content": PromptsConsts.TITULO_PERGUNTA + pergunta + " " + PromptsConsts.TITULO_RESPOSTA + resposta}
        ]
    }

    response = requests.post(api_url, headers=headers, json=data)
    
    if response.status_code == 200:
        resposta_chatgpt = response.json()['choices'][0]['message']['content']
    else:
        resposta_chatgpt = "Houve um erro na comunicação com a API do ChatGPT."
    
    return resposta_chatgpt