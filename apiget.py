from fastapi import FastAPI
import psycopg2
from psycopg2.extras import RealDictCursor

app = FastAPI()


@app.get("/adultos")
def listar_adultos():
    conexion = psycopg2.connect(
        host="localhost",
        dbname="seniorsafe",
        user="postgres",
        password="1234",
        port="5432",
        cursor_factory=RealDictCursor
    )
    cursor = conexion.cursor()
    cursor.execute("SELECT nombre, edad FROM adulto_mayor;")
    datos = cursor.fetchall()
    conexion.close()
    return datos