
import pandas as pd
import functools

AUDCAD = pd.read_csv(r"data\AUDCAD_M1.csv", sep="\t" , parse_dates=["Time"],index_col="Time")
AUDCHF = pd.read_csv(r"data\AUDCHF_M1.csv", sep="\t" , parse_dates=["Time"],index_col="Time")
AUDJPY = pd.read_csv(r"data\AUDJPY_M1.csv", sep="\t" , parse_dates=["Time"],index_col="Time")
AUDNZD = pd.read_csv(r"data\AUDNZD_M1.csv", sep="\t" , parse_dates=["Time"],index_col="Time")
AUDUSD = pd.read_csv(r"data\AUDUSD_M1.csv", sep="\t" , parse_dates=["Time"],index_col="Time")
CADKPY = pd.read_csv(r"data\CADJPY_M1.csv", sep="\t" , parse_dates=["Time"],index_col="Time")
CHFJPY = pd.read_csv(r"data\CHFJPY_M1.csv", sep="\t" , parse_dates=["Time"],index_col="Time")
EURAUD = pd.read_csv(r"data\EURAUD_M1.csv", sep="\t" , parse_dates=["Time"],index_col="Time")
EURCAD = pd.read_csv(r"data\EURCAD_M1.csv", sep="\t" , parse_dates=["Time"],index_col="Time")
EURCHF = pd.read_csv(r"data\EURCHF_M1.csv", sep="\t" , parse_dates=["Time"],index_col="Time")
EURGBP = pd.read_csv(r"data\EURGBP_M1.csv", sep="\t" , parse_dates=["Time"],index_col="Time")
EURJPY = pd.read_csv(r"data\EURJPY_M1.csv", sep="\t" , parse_dates=["Time"],index_col="Time")
EURUSD = pd.read_csv(r"data\EURUSD_M1.csv", sep="\t" , parse_dates=["Time"],index_col="Time")
GBPAUD = pd.read_csv(r"data\GBPAUD_M1.csv", sep="\t" , parse_dates=["Time"],index_col="Time")
GBPJPY = pd.read_csv(r"data\GBPJPY_M1.csv", sep="\t" , parse_dates=["Time"],index_col="Time")
GBPUSD = pd.read_csv(r"data\GBPUSD_M1.csv", sep="\t" , parse_dates=["Time"],index_col="Time")
NZDUSD = pd.read_csv(r"data\NZDUSD_M1.csv", sep="\t" , parse_dates=["Time"],index_col="Time")
USDCAD = pd.read_csv(r"data\USDCAD_M1.csv", sep="\t" , parse_dates=["Time"],index_col="Time")
USDCHF = pd.read_csv(r"data\USDCHF_M1.csv", sep="\t" , parse_dates=["Time"],index_col="Time")
USDJPY = pd.read_csv(r"data\USDJPY_M1.csv", sep="\t" , parse_dates=["Time"],index_col="Time")


FOREX_PAIRS = [AUDCAD,AUDCHF,AUDJPY,AUDNZD,AUDUSD,CADKPY,CHFJPY,EURAUD,EURCAD,EURCHF,EURGBP,EURJPY,EURUSD,GBPAUD,GBPJPY,GBPUSD,NZDUSD,USDCAD,USDCHF,USDJPY]
df_merged = reduce(lambda  left,right: pd.merge(left,right,on=['DATE'],
                                            how='outer'), FOREX_PAIRS).fillna('void')
combined.head()





