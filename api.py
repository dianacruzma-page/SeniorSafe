from fastapi import FastAPI
from pydantic import BaseModel
import joblib
import pandas as pd

print("Lista la fastAPI")

app = FastAPI ()
modelo_ia = joblib.load ("modelo_seniorsafe.pkl")

class adulto_mayor(BaseModel) :
    edad: int
    fase_etapa: str

@app.get("/")
def root():
    return {"mensaje": "API SeniorSafe activa"}

@app.post("/evaluar_riesgo")
def evaluar_riesgo (datos: adulto_mayor):
    
    df_ia = pd.DataFrame ({"edad" : [datos.edad], "fase_num" : [datos.fase_num]})

    prediccion = modelo_ia.predict (df_ia)
    if prediccion [0] == 1: 
        return {"estado":"CRITICO","accion": "Notificar a familiar"}
    else:
        return {"estado": "NORMAL", "accion":"solo registrar"}

