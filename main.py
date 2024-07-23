from util.PdfUtil import PdfUtil
from util.StringUtil import StringUtil
from util.VetorialUtil import VetorialUtil
from util.HtmlUtil import HtmlUtil

def main():
    collection_name = "help"

    pdf = PdfUtil.extrair_pdf("./arquivo.pdf")
    pedacos = StringUtil.get_pedacos_texto(pdf)
    pontos = VetorialUtil.get_embedding(pedacos)

    VetorialUtil.cria_collection_vetorial(collection_name)
    VetorialUtil.inserir_dados(collection_name, pontos)

    pesquisa = "O uso de bancos de dados vetorial pode ser útil?"

    embedding = VetorialUtil.monta_pergunta(pesquisa)
    resposta = VetorialUtil.pesquisa_banco_vetorial(collection_name, embedding)
    HtmlUtil.formatar_resultado_pesquisa(resposta)

if __name__ == "__main__":
    main()
