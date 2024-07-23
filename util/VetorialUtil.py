from sentence_transformers import SentenceTransformer
from qdrant_client import QdrantClient
from qdrant_client.http.models import PointStruct, models
import uuid

# Usa o modelo de linguagem BERT que é da Google para ter um pré-treinamento em entendimento de textos
# O modelo usado no tranformer é um modelo em português e irá usar a GPU para melhor desempenho na busca de sentenças que
# atendem as necessidades do usuário
tranformer = SentenceTransformer("neuralmind/bert-large-portuguese-cased", device="cpu", token="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")

# Cria um banco de dados em memória pelo qdrant
# rant que posteriormente pode ser consultado para buscas pelo modelo de linguagem
qdrant_client = QdrantClient(":memory:")

class VetorialUtil:

    # Cria pedaços de sentenças de texto, refenreciando um id para identificar a sentença, um vetor para utilizar 
    # na busca pelo modelo neural e o conteúdoo original para utilização na montagem da respota
    @staticmethod
    def get_embedding(pedacos_texto):
        pontos = []
        for idx, pedaco in enumerate(pedacos_texto):
            ponto_id = str(uuid.uuid4())
            embedding = tranformer.encode(pedaco).tolist()
            pontos.append(PointStruct(id=ponto_id, vector=embedding, payload={'text': pedaco}))
        return pontos
    
    # Cria uma coleção de vetores dentro do banco qdrant para posterior busca pelo modelo de linguagem
    @staticmethod
    def cria_collection_vetorial(collection_name):
        qdrant_client.recreate_collection(
            collection_name=collection_name,
            vectors_config=models.VectorParams(
                size=tranformer.get_sentence_embedding_dimension(),
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
        return tranformer.encode(pergunta).tolist()
    
    # Busca em uma colletion a partir de um embedding resultados possíveis para a pergunta, trazendo em uma lista
    @staticmethod
    def pesquisa_banco_vetorial(collection_name, embedding):
        search_result = qdrant_client.search(
            collection_name=collection_name,
            query_vector=embedding,
            limit=3
        )
        prompt = []
        for resultado in search_result:
            prompt.append({"score": resultado.score, "text": resultado.payload["text"].replace("\n", " ")})
        return prompt
    
    