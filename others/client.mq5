void OnStart()
  {
   // URL do endpoint da API
   string url = "http://127.0.0.1:8000/receber_dados";

   // Dados em formato JSON
   string jsonData = "{\"nome\": \"Maria\", \"idade\": 25}";

   // Cabeçalhos HTTP
   string headers = "Content-Type: application/json\r\n";

   // Variáveis para a função WebRequest
   uchar post[];
   char result[];
   string responseHeaders;
   int statusCode;

   // Converter o corpo da requisição para array de bytes UTF-8
   int jsonLength = StringToCharArray(jsonData, post, 0, WHOLE_ARRAY, CP_UTF8);

   // Remover o caractere nulo do final, se presente
   if(post[jsonLength - 1] == 0)
     {
      jsonLength--;
      ArrayResize(post, jsonLength);
     }

   // Atualizar o tamanho do array de acordo com jsonLength
   ArrayResize(post, jsonLength);

   // Cabeçalhos HTTP com Content-Length
   headers = StringFormat("Content-Type: application/json\r\nContent-Length: %d\r\n", jsonLength);

   // Fazer a requisição POST
   ResetLastError();
   int res = WebRequest("POST", url, headers, 8000, post, result, responseHeaders);
   statusCode = res;

   if(res == -1)
     {
      int erro = GetLastError();
      PrintFormat("Erro na WebRequest. Código do erro: %d", erro);
      return;
     }

   // Converter a resposta para string
   string responseText = CharArrayToString(result);

   // Exibir o código de status e a resposta
   Print("Status Code: ", statusCode);
   Print("Resposta da API: ", responseText);
  }
