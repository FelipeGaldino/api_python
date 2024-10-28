from fastapi import FastAPI
from pydantic import BaseModel

app = FastAPI()

class Dados(BaseModel):
    nome: str
    idade: int

@app.post("/receber_dados")
async def receber_dados(dados: Dados):
    print("Dados recebidos:", dados)
    # Você pode processar os dados aqui
    return {"mensagem": dados }