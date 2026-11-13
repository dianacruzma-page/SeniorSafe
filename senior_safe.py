import pandas as pd
import psycopg2
import sklearn

# Piezas del "cerebro artificial" de Scikit-learn
from sklearn.model_selection import train_test_split
from sklearn.tree import DecisionTreeClassifier
from sklearn.metrics import accuracy_score
import joblib 

# 1. Definir la conexión
conexion = psycopg2.connect(
    host="localhost",
    dbname="seniorsafe",
    user="postgres",
    password="1234",
    port="5432"
)

# 2. Consulta con un JOIN seguro entre Alerta y Hogar
query = """
SELECT 
    a.tipo_alerta,
    a.nivel_riesgo,
    a.estado,
    am.edad,
    dc.fase_etapa
FROM alerta a
JOIN hogar h ON a.hogar_id = h.hogar_id
JOIN adulto_mayor am ON h.adulto_mayor_id = am.adulto_mayor_id
JOIN padecer p ON am.adulto_mayor_id = p.adulto_mayor_id
JOIN diagnostico_cognitivo dc ON p.diagnostico_id = dc.diagnostico_id
"""

df = pd.read_sql(query, conexion)


df['nivel_num'] = df['nivel_riesgo'].apply(lambda x: 1 if str(x).lower() in ['critico', 'alto'] else 0)
df['fase_num'] = df['fase_etapa'].apply(lambda x: 10 if str(x).lower() in ['grave','moderada'] else 0)

total_alertas = len(df)
conteo_riesgos = df['nivel_riesgo'].value_counts()
porcentaje_riesgos = (conteo_riesgos / total_alertas) * 100

df_porcentajes = pd.DataFrame({
    'Cantidad': conteo_riesgos,
    'Porcentaje (%)': porcentaje_riesgos.round(2)
})


print("=== TABLA GENERAL COMPLETÍSIMA DE SENIOR SAFE ===")
print(df)

print("\n=== RESUMEN DE PORCENTAJES POR NIVEL DE RIESGO ===")
print(df_porcentajes)



X = df[['edad', 'fase_num']]  
Y = df['nivel_num']  

X_train, X_test, Y_train, Y_test = train_test_split(X, Y, test_size=0.2, random_state=42)

modelo = DecisionTreeClassifier()
modelo.fit(X_train, Y_train)  

print("\n¡El modelo de Inteligencia Artificial de Senior Safe ha sido entrenado con éxito!")

predicciones = modelo.predict(X_test)
precision = accuracy_score(Y_test, predicciones)
print(f"Precisión del modelo: {precision * 100}%")


adulto_nuevo = pd.DataFrame({
    'edad': [78],
    'fase_num': [10]
})

prediccion_nuevo = modelo.predict(adulto_nuevo)

if prediccion_nuevo[0] == 1:
    print("\n🚨 Alerta: El modelo predice que este adulto tiene un nivel de riesgo CRITICO O ALTO.")
else:
    print("\n✅ El modelo predice que este adulto tiene un nivel de riesgo BAJO O NORMAL.")           


joblib.dump(modelo, 'modelo_seniorsafe.pkl')
print("📦 ¡Modelo exportado con éxito a 'modelo_seniorsafe.pkl'!")


conexion.close()