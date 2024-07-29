import json
from IPython.display import display, HTML

config_path = 'resources/config.json'
with open(config_path, 'r') as config_file:
    config = json.load(config_file)

class HtmlUtil:
    @staticmethod
    def formatar_resultado_pesquisa(resultados):
        resposta = resultados[0]['text']
        arquivo = resultados[0]['arquivo']

        if 'host_referencia' in config and config['host_referencia']:
            referencia_arquivos = config['host_referencia'] + arquivo
        else:
            referencia_arquivos = [arquivo]
        
        return resposta, referencia_arquivos