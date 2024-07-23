from langchain.text_splitter import CharacterTextSplitter

class StringUtil:
    @staticmethod
    def get_pedacos_texto(texto_pdf):
        divisor = CharacterTextSplitter(separator='\n', 
                                        chunk_size=1000, 
                                        chunk_overlap=200, 
                                        length_function=len)
        pedacos = divisor.split_text(texto_pdf)
        return pedacos