from fastapi import FastAPI, Request
from pydantic import BaseModel

app = FastAPI()

class Dados(BaseModel):
    bid: int
    ask: int
    timestamp: str

@app.post("/receber_dados")
async def receber_dados(request: Request):
    body_bytes = await request.body()
    print("Corpo da requisição bruto:", body_bytes)
    try:
        dados = Dados.parse_raw(body_bytes)
        print("Dados recebidos:", dados)
        return {"mensagem": dados.dict()}
    except Exception as e:
        print("Erro ao decodificar JSON:", e)
        return {"erro": str(e)}
