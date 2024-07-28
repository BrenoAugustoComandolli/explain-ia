from PyPDF2 import PdfReader

class PdfUtil:
    @staticmethod
    def extrair_conteudo(caminho):
        if caminho.endswith('.pdf'):
            return PdfUtil.extrair_pdf(caminho)
        elif caminho.endswith('.txt'):
            return PdfUtil.extrair_txt(caminho)
        else:
            raise ValueError(f"Tipo de arquivo nao suportado: {caminho}")

    @staticmethod
    def extrair_pdf(caminho):
        texto = ''
        with open(caminho, 'rb') as pdf:
            reader = PdfReader(pdf)
            for pagina in reader.pages:
                texto += pagina.extract_text()
        return texto

    @staticmethod
    def extrair_txt(caminho):
        with open(caminho, 'r', encoding='utf-8') as txt_file:
            return txt_file.read()
