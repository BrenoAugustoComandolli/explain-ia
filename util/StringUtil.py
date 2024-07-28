import json
from langchain.text_splitter import CharacterTextSplitter

config_path = 'resources/config.json'
with open(config_path, 'r') as config_file:
    config = json.load(config_file)

class StringUtil:
    @staticmethod
    def get_pedacos_texto(texto_pdf):
        divisor = CharacterTextSplitter(separator='\n', 
                                        chunk_size=config['qntd_caracteres_pesquisar'], 
                                        chunk_overlap=200, 
                                        length_function=len)
        pedacos = divisor.split_text(texto_pdf)
        return pedacos