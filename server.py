from fastapi import FastAPI, Request
import uvicorn

app = FastAPI()

@app.post("/receber_dados")
async def receber_dados(request: Request):
    body = await request.body()
    print("Corpo da requisição bruto:", body)
    try:
        data = await request.json()
        print("JSON decodificado:", data)
        return {"mensagem": data}
    except Exception as e:
        print("Erro ao decodificar JSON:", e)
        return {"erro": str(e)}