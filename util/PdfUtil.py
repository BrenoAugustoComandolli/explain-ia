from PyPDF2 import PdfReader

class PdfUtil:
    @staticmethod
    def extrair_pdf(caminho):
        texto = ''
        with open(caminho, 'rb') as pdf:
            reader = PdfReader(pdf)
            for pagina in reader.pages:
                texto += pagina.extract_text()
        return texto
