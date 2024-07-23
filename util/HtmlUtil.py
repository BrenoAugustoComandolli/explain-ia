from IPython.display import display, HTML

class HtmlUtil:
    @staticmethod
    def formatar_resultado_pesquisa(resultados):
        html_content = "<h2>Resultados<h2><ol>"
        for umResultado in resultados:
            html_content += f"<li><strong>Score:</strong> {umResultado['score']}<br><strong>Texto:</strong> {umResultado['text']}</li><br>"
        html_content += "</ol>"
        display(HTML(html_content))