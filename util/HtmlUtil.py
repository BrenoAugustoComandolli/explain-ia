from IPython.display import display, HTML

class HtmlUtil:
    @staticmethod
    def formatar_resultado_pesquisa(resultados):
        resposta = resultados[0]['text']
        arquivo = resultados[0]['arquivo']

        #TODO: Montar url help
        referencia_arquivos = [arquivo]
        
        # Print the HTML content
        return resposta, referencia_arquivos