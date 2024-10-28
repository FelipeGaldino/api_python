import requests

url = "http://127.0.0.1:8000/receber_dados"

for i in range(10):
    dados    = {"nome": "Felipe","idade": i}
    response = requests.post(url, json=dados)

    print("Status Code:", response.status_code)
    print("Resposta da API:", response.json())