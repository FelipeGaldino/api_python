//LOCAL FILE
// C:\Users\Felipe\AppData\Roaming\MetaQuotes\Tester\FB9A56D617EDDDFE29EE54EBEFFE96C1\Agent-127.0.0.1-3000\MQL5\Files
int filehandle;
int last_tick_bid = 0;
int last_tick_ask = 0;
int bid = 0;
int ask = 0;
datetime timestamp = 0;

// Variáveis para a função WebRequest
string headers;
uchar post[];
char result[];
int statusCode;
string responseHeaders;
string url = "http://127.0.0.1:8000/receber_dados";


int OnInit()

{
   ResetLastError();
   return(INIT_SUCCEEDED);   
}
    
void OnTick()
{
   MqlTick last_tick;
   
   if(SymbolInfoTick(Symbol(),last_tick))
     {
     bid       = int(last_tick.bid);
     ask       = int(last_tick.ask);
     timestamp = last_tick.time;
      
     if (bid != last_tick_bid || ask != last_tick_ask)
        {
        last_tick_bid = bid;
        last_tick_ask = ask;
          
        string jsonData = StringFormat("{\"bid\": %.5f, \"ask\": %.5f, \"timestamp\": \"%s\"}",bid,ask,TimeToString(timestamp, TIME_DATE | TIME_MINUTES));
        int jsonLength  = StringToCharArray(jsonData, post, 0, WHOLE_ARRAY, CP_UTF8); // Converter o corpo da requisição para array de bytes UTF-8

        // Remover o caractere nulo do final, se presente
        if(post[jsonLength - 1] == 0)
          {
            jsonLength--;
            ArrayResize(post, jsonLength);
          }
          
         ArrayResize(post, jsonLength); // Atualizar o tamanho do array de acordo com jsonLength
         headers = StringFormat("Content-Type: application/json\r\nContent-Length: %d\r\n", jsonLength); // Cabeçalhos HTTP com Content-Length
 
         // Fazer a requisição POST
         ResetLastError();
         statusCode = WebRequest("POST", url, headers, 8000, post, result, responseHeaders);

         if(statusCode == -1)
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
    }
   else Print("SymbolInfoTick() failed, error = ",GetLastError());
}
  