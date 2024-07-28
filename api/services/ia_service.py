import logging
import os
from util.PdfUtil import PdfUtil
from util.StringUtil import StringUtil
from util.VetorialUtil import VetorialUtil
from util.HtmlUtil import HtmlUtil

def insere_dados(caminho_arquivos, collection_name):
    try:
        VetorialUtil.cria_collection_vetorial(collection_name)
        logging.info(f"Vetor criado com sucesso: {collection_name}")
        
        for file_name in os.listdir(caminho_arquivos):
            if file_name.endswith('.pdf') or file_name.endswith('.txt'):
                processa_arquivo(os.path.join(caminho_arquivos, file_name), collection_name)
    except Exception as e:
        logging.error(f"Erro ao processar os arquivos: {e}")

def processa_arquivo(file_name, collection_name):
    try:
        logging.info(f"Processando arquivo: {file_name}")
        conteudo = PdfUtil.extrair_conteudo(file_name)
        text_chunks = StringUtil.get_pedacos_texto(conteudo)
        embeddings = VetorialUtil.get_embedding(text_chunks, file_name)
        VetorialUtil.inserir_dados(collection_name, embeddings)
        logging.info(f"Inserido o texto do arquivo {file_name} para a collection {collection_name}")
    except Exception as e:
        logging.error(f"Erro ao processar o arquivo {file_name}: {e}")

def realiza_pesquisa(query, collection_name):
    try:
        logging.info(f"Realizando pesquisa: {query}")
        query_embedding = VetorialUtil.monta_pergunta(query)
        search_results = VetorialUtil.pesquisa_banco_vetorial(collection_name, query_embedding)
        return HtmlUtil.formatar_resultado_pesquisa(search_results)
    except Exception as e:
        logging.error(f"Erro ao realizar a pesquisa '{query}': {e}")
        raise        
