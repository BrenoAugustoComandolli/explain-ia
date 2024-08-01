import json
import torch
from transformers import AutoTokenizer, AutoModel
from qdrant_client import QdrantClient
from qdrant_client.http.models import PointStruct, models
import uuid

config_path = 'resources/config.json'
with open(config_path, 'r') as config_file:
    config = json.load(config_file)

# Load the pre-trained BERT model and tokenizer
tokenizer = AutoTokenizer.from_pretrained('neuralmind/bert-base-portuguese-cased', do_lower_case=False)
model = AutoModel.from_pretrained('neuralmind/bert-base-portuguese-cased')

# Cria um banco de dados em memória pelo qdrant
# rant que posteriormente pode ser consultado para buscas pelo modelo de linguagem
if 'modo_armazenamento_database' in config and config['modo_armazenamento_database'] == 'memory':
    qdrant_client = QdrantClient(":memory:")
else:
    qdrant_client = QdrantClient(path="C:/Bertimbau AI/database")

class VetorialUtil:

    # Cria pedaços de sentenças de texto, refenreciando um id para identificar a sentença, um vetor para utilizar 
    # na busca pelo modelo neural e o conteúdoo original para utilização na montagem da respota
    @staticmethod
    def get_embedding(pedacos_texto, file_referencia):
        pontos = []
        for pedaco in pedacos_texto:
            ponto_id = str(uuid.uuid4())
            inputs = tokenizer(pedaco, return_tensors='pt')
            with torch.no_grad():
                outputs = model(**inputs)
                embedding = outputs.last_hidden_state[:, 0, :].squeeze().tolist()  # Use [CLS] token's embedding
            pontos.append(PointStruct(id=ponto_id, vector=embedding, payload={"filename": file_referencia, 'text': pedaco}))
        return pontos

    @staticmethod
    def cria_collection_vetorial(collection_name):
        qdrant_client.recreate_collection(
            collection_name=collection_name,
            vectors_config=models.VectorParams(
                size=model.config.hidden_size,
                distance=models.Distance.COSINE
            )
        )

    # Insere pontos dentro de uma coleção no qdrant (Síncrono)
    @staticmethod
    def inserir_dados(collection_name, pontos):
        qdrant_client.upsert(collection_name=collection_name, points=pontos, wait=True)

    # Monta uma pergunta para posterior consulta ao modelo de linguagem, montando um embedding
    @staticmethod
    def monta_pergunta(pergunta):
        inputs = tokenizer(pergunta, return_tensors='pt')
        with torch.no_grad():
            outputs = model(**inputs)
            embedding = outputs.last_hidden_state[:, 0, :].squeeze().tolist()  # Use [CLS] token's embedding
        return embedding
    
    @staticmethod
    def pesquisa_banco_vetorial(collection_name, embedding):
        search_result = qdrant_client.search(
            collection_name=collection_name,
            query_vector=embedding,
            limit=config['qntd_respostas']
        )
        prompt = []
        for resultado in search_result:
            prompt.append({"score": resultado.score, "text": resultado.payload["text"].replace("\n", " "), "arquivo": resultado.payload["filename"]})
        return prompt
