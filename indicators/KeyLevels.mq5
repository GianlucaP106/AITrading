
#property indicator_chart_window

// zigzag
input int depth = 12;
input int deviation = 5;
input int backstep = 3;
double buffer[];
int handle;

// analysis parameters
input int minPipGap = 100;
input int sensitivity = 2;
input int lookBack = 50;

// Drawing
input string prefix = "keylvl-";
input color linecolor = clrRed;
input int lineWeight = 2;

// Levels
double levels[];


int OnInit()
  {
   handle = iCustom(Symbol(), Period(), "Examples\\ZigZag", depth, deviation, backstep);
   if (handle == INVALID_HANDLE) {
      Print("error loading zigzag");
      return(INIT_FAILED);
   }else {
      Print("good");
   }
   ArraySetAsSeries(buffer, true);
   
   ObjectsDeleteAll(0, prefix, 0, OBJ_HLINE);
   ChartRedraw(0);
   ArrayResize(levels, lookBack);
   
   return(INIT_SUCCEEDED);
  }
 void OnDeinit(const int reason)
   {
    IndicatorRelease(handle);
    ObjectsDeleteAll(0, prefix, 0, OBJ_HLINE); 
    ChartRedraw(0);
   }

int OnCalculate(const int rates_total,
                const int prev_calculated,
                const datetime &time[],
                const double &open[],
                const double &high[],
                const double &low[],
                const double &close[],
                const long &tick_volume[],
                const long &volume[],
                const int &spread[])
  {
   
   
   static double levelgap = minPipGap * SymbolInfoDouble(Symbol(), SYMBOL_POINT);
   
   if (rates_total == prev_calculated) return(rates_total);
   
   double zz = 0;
   double zzPeaks[];
   int zzCount = 0;
   ArrayResize(zzPeaks, lookBack);
   ArrayInitialize(zzPeaks, 0.0);
   
   int count = CopyBuffer(handle, 0, 0, rates_total, buffer);
   
   if (count < 0) {
      int err = GetLastError();
      return(0);
      
   }
   
   for (int i = 0; i < rates_total && zzCount < lookBack; i++) {
   
      zz = buffer[i];
      if (zz != 0 && zz != EMPTY_VALUE) {
         zzPeaks[zzCount] = zz;
         zzCount++;
      }
   }
   ArraySort(zzPeaks);
   
   int lvlCounter = 0;
   double price = 0;
   int priceCount = 0;
   ArrayInitialize(levels, 0.0);
   
   for (int i = lookBack - 1; i >= 0; i--) {
      price += zzPeaks[i];
      priceCount++;
      if (i == 0 || (zzPeaks[i] - zzPeaks[i - 1] > levelgap)) {
         if (priceCount >= sensitivity) {
            price = price / priceCount;
            levels[lvlCounter] = price;
            lvlCounter++;
         }
         price = 0;
         priceCount = 0;
      }
   }
   Drawlvls();
   return(rates_total);
  }
  
void Drawlvls() {
   for (int i = 0; i < lookBack; i++) {
      string name = prefix + IntegerToString(i);
      
      if (levels[i] == 0) {
         ObjectDelete(0, name);
         
      }else if(ObjectFind(0, name) < 0) {
         ObjectCreate(0, name, OBJ_HLINE, 0, 0, levels[i]);
         ObjectSetInteger(0, name, OBJPROP_COLOR, linecolor);
         ObjectSetInteger(0, name, OBJPROP_WIDTH, lineWeight);
         ObjectSetInteger(0, name, OBJPROP_SELECTABLE, true);
         
      }else {
         ObjectSetDouble(0, name, OBJPROP_PRICE, levels[i]);
      }
   }
   ChartRedraw(0);
}
  

