//LOCAL FILE
// C:\Users\Felipe\AppData\Roaming\MetaQuotes\Tester\FB9A56D617EDDDFE29EE54EBEFFE96C1\Agent-127.0.0.1-3000\MQL5\Files
int filehandle;
int last_tick_bid = 0;
int last_tick_ask = 0;
int bid = 0;
int ask = 0;
datetime timestamp = 0;

int OnInit()

{
   ResetLastError();
   
   // NAME FILE
   filehandle=FileOpen("18_12_TICK_"+Symbol()+".csv",FILE_WRITE|FILE_CSV);
   if(filehandle!=INVALID_HANDLE)
     {      
      FileWrite(filehandle,"timestamp bid ask");
     }
     
   else Print("Error in opening file,",GetLastError());
   
   PrintFormat("Caminho para do arquivo: %s\\Files\\",TerminalInfoString(TERMINAL_DATA_PATH)); 
   
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
       //Print("DATE TIME : ",timestamp," Tick Bid : ",int(last_tick.bid)," ASK : ",int(last_tick.ask));
       FileWrite(filehandle,last_tick.time,bid,ask);
       last_tick_bid = bid;
       last_tick_ask = ask;
      }
      }
     
   else Print("SymbolInfoTick() failed, error = ",GetLastError());
}
  
void OnDeinit(const int reason)
{

 FileClose(filehandle);
 
}
