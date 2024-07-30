import logging
import os
import re
from util.PdfUtil import PdfUtil
from util.StringUtil import StringUtil
from util.VetorialUtil import VetorialUtil
from util.HtmlUtil import HtmlUtil
import json

def insere_dados(caminho_arquivos, collection_name, host_refencia):
    try:
        VetorialUtil.cria_collection_vetorial(collection_name)
        logging.info(f"Vetor criado com sucesso: {collection_name}")
        
        for root, dirs, files in os.walk(caminho_arquivos):
            for file_name in files:
                if file_name.endswith('.pdf') or file_name.endswith('.txt'):
                    file_path = os.path.join(root, file_name)

                    file_referencia = None
                    if host_refencia:
                        file_referencia = formata_file_path_para_referencia(caminho_arquivos, collection_name, host_refencia, root, file_name)

                    processa_arquivo(file_path, collection_name, file_referencia)
    except Exception as e:
        logging.error(f"Erro ao processar os arquivos: {e}")

def formata_file_path_para_referencia(caminho_arquivos, collection_name, host_refencia, root, file_name):
    file_path = os.path.join(root, file_name)
    file_path = re.sub(r'^[\\/]+', '', file_path.replace(caminho_arquivos, ""))

    if (collection_name == 'help'):
        file_path = formata_file_path_para_help(file_path)

    return file_path

def formata_file_path_para_help(file_path):
    file_path = file_path.replace('\\', ':')
    file_path = file_path.replace('/', ':')
    file_path = file_path.replace('.txt', '')
    file_path = file_path.replace('.pdf', '')

    return file_path

def processa_arquivo(file_path, collection_name, file_referencia):
    try:
        logging.info(f"Processando arquivo: {file_path}")
        conteudo = PdfUtil.extrair_conteudo(file_path)
        text_chunks = StringUtil.get_pedacos_texto(conteudo)
        embeddings = VetorialUtil.get_embedding(text_chunks, file_referencia if file_referencia else file_path)
        VetorialUtil.inserir_dados(collection_name, embeddings)
        logging.info(f"Inserido o texto do arquivo {file_path} para a collection {collection_name}")
    except Exception as e:
        logging.error(f"Erro ao processar o arquivo {file_path}: {e}")

def realiza_pesquisa(query, collection_name, login):
    try:
        logging.info(f"Realizando pesquisa: {query}")
        query_embedding = VetorialUtil.monta_pergunta(query)
        search_results = VetorialUtil.pesquisa_banco_vetorial(collection_name, query_embedding)

        if not search_results: 
            return 'Resposta não encontrada'
        
        token = recupera_token_usuario(login)
        logging.info(f"O token para {login} recuperado com sucesso")

        if not token:
             return 'Usuário sem token do ChatGpt cadastrado no servidor'
    
        return HtmlUtil.formatar_resultado_pesquisa(search_results, query, token)
    except Exception as e:
        logging.error(f"Erro ao realizar a pesquisa '{query}': {e}")
        raise     

def recupera_token_usuario(login):
    with open('users.json', 'r') as file:
        data = json.load(file)
        return data.get(login)