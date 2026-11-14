import pandas as pd
from pathlib import Path
import psycopg2
import sklearn
from sklearn.model_selection import train_test_split
from sklearn.tree import DecisionTreeClassifier
from sklearn.metrics import accuracy_score
import joblib
conexion = psycopg2.connect(
    host="localhost",
    dbname="seniorsafe",
    user="postgres",
    password="1234",
    port="5432"
)

print ("¡Conectado por fin!")


query = """
SELECT 
    a.tipo_alerta,
    a.nivel_riesgo,
    a.estado,
    am.edad,
    dc.fase_etapa
FROM alerta a
JOIN hogar h ON a.id_hogar = h.id_hogar
JOIN adulto_mayor am ON h.id_adulto_mayor = am.id_adulto_mayor
JOIN padecer p ON am.id_adulto_mayor = p.id_adulto_mayor
JOIN diagnostico_cognitivo dc ON p.id_diagnostico = dc.id_diagnostico;
"""
print (query)

df = pd.read_sql(query, conexion)


df['nivel_num'] = df['nivel_riesgo'].apply(lambda x: 1 if str(x).lower() in ['critico', 'alto'] else 0)
df['fase_num'] = df['fase_etapa'].apply(lambda x: 10 if str(x).lower() in ['grave','moderada'] else 0)
total_alertas = len(df)
conteo_riesgos = df['nivel_riesgo'].value_counts()
porcentaje_riesgos = (conteo_riesgos / total_alertas) * 100

